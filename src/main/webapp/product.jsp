<%@page import="DTO.Product"%>
<%@page import="DAO.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="exceptionNoProductId.jsp" %>

<%@ include file="/config.jsp" %>

<%
	String productId = request.getParameter("productId");
	// 보여줘야할 상품의 상세 정보를 찾기
	ProductRepository pr = ProductRepository.getInstance();
	Product product = pr.getProduct(productId);
	
	// 찾은 상품의 상세 정보를 body 태그 내 표현문을 사용해서 상세 정보를 출력하기 
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 상세 정보</title>
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
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="./images/<%=product.getImagePath() %>">
			</div>
		
			<div class="col-md-6">
				<!-- 상품의 상세 정보를 보여주는 영역 -->
				<h3><%=product.getName()%></h3>
				<p><%=product.getDescription() %></p>
				<p>
					<b>상품 코드 : </b>
					<span class="badge badge-danger"><%=product.getProductId() %></span>	
				</p>
				<p><b>제조사</b> : <%=product.getManufacturer() %></p>
				<p><b>분류</b> : <%=product.getCategory() %></p>
				<p><b>재고 수</b> : <%=product.getUnitsInStock() %></p>
				<h4><%=product.getUnitPrice() %>(원)</h4>
				<p>
					<a href="#" class="btn btn-info" onclick="addToCart()">상품 주문 &raquo;</a>
					<a href="<%= ADD_TO_CART_PROCESS_URL %>?productId=<%=productId %>" class="btn btn-warning">장바구니 &raquo;</a>
					<a href="<%= PRODUCTS_PAGE_URL %>" class="btn btn-secndary">상품 목록 &raquo;</a>
				</p>
			</div>
		</div>
		<hr>
	</div>
	
	<jsp:include page="footer.jsp" />
	
	<script>
		var productId = "<%=productId %>";
		
		function addToCart(){
			if(confirm("상품을 장바구니에 추가하시겠습니까?")){
				// 상품을 장바구니에 추가하는 코드
				jQuery.ajax({
					url: "http://192.168.2.30:8081/WebMarket/cart/add",
					data: "productId= "+productId,
					success: function() {
						var isMove = confirm("해당 상품을 장바구니에 추가했습니다. \n[장바구니로 이동하시겠습니까?]");
						if(isMove){
							alert("장바구니로 이동합니다.");
						} 
					},
					error: function(){
						alert("장바구니에 상품을 추가하지 못했습니다.");
						alert("잠시 후 다시 시도해주세요.");
					}
				})
				// 상품을 장바구니에 성공적으로 추가했다면
				// [장바구니로 이동] | [쇼핑계속하기] 버튼 출력
			} else{
				// 상품을 장바구니에 추가하지 않는다면은
				// 아무것도 하지 않음
			}
		}
	</script>
</body>
</html>