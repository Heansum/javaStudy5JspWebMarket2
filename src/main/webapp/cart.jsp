<%@page import="DTO.Product"%>
<%@page import="DAO.ProductRepository"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>장바구니</title>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<!-- 부트스트랩을 위한 jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</head>
<body>
	<jsp:include page="header.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left">
						<a href="/WebMarket/cart/delete.jsp" class="btn btn-danger">삭제하기</a>
					</td>
					<td align="right">
						<a href="/WebMarket/cart/order.jsp" class="btn btn-success">주문하기</a>
					</td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px;">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				
				<%
					ProductRepository pr = ProductRepository.getInstance();
					
					ArrayList<String> elementList = (ArrayList<String>) session.getAttribute("goodsList");
					if(elementList == null){
						elementList = new ArrayList<String>();
					}
					
					// 장바구니에 넣은 상품의 가격 합계
					int total = 0;
					
					if(elementList.size() == 0){
				%>
					<tr>
						<th colspan="4" style="text-align: center;">장바구니에 담긴 상품이 없습니다.</th>
					</tr>
				<%		
					}
				
					for(String productId : elementList) {
						// 장바구니에 넣은 n번째 상품의 정보
						Product product = pr.getProduct(productId);
				
						total += product.getUnitPrice();
				%>
				<tr>
					<td><%=product.getName() %></td>
					<td><%=product.getUnitPrice() %></td>
					<td>1 X <%=product.getUnitPrice() %></td>
					<td>
						<a href="#" onclick="removeCart('<%=product.getProductId()%>')" class="badge badge-danger">삭제</a>
					</td>
				</tr>
				<%
					}
				%>
				<tr>
					<th colspan="3">총액 : </th>
					<th colspan="2"><%=total %></th>
				</tr>
			</table>
		</div>
	</div>
	
	<jsp:include page="footer.jsp" />

	<script>
		function removeCart(productId) {
			$.ajax({
				url: "http://192.168.2.30:8081/WebMarket/cart/delete",
				data: "productId="+productId,
				success: function(){
					alert("상품을 삭제했습니다.");
					
					// 자바스크립트 코드 -> 페이지 새로고침
					location.reload();
				},
				error: function() {
					alert("상품을 삭제하지 못했습니다.\n잠시 후 다시 시도해주세요.");
				}
			})
		}
	</script>
</body>
</html>