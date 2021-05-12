<%@page import="DTO.Product"%>
<%@page import="DAO.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="exceptionNoProductId.jsp" %>

<%@ include file="/config.jsp" %>

<%
	String p_id = request.getParameter("p_id");
	Product product = (Product) request.getAttribute("product");
	
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
	<jsp:include page="../header.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="../images/<%=product.getImagePath() %>">
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
					<a href="#" class="btn btn-warning" onclick="addToCart()">장바구니 &raquo;</a>
					<a href="<%= PRODUCTS_PAGE_URL %>" class="btn btn-secndary">상품 목록 &raquo;</a>
				</p>
			</div>
		</div>
		<hr>
	</div>
	
	<jsp:include page="../footer.jsp" />
	
	<script>
		// 사용자가 이 페이지로 접근하기 위해 주소표시줄에 입력한 프로토콜 명
		// http 또는 https
		var protocol = location.protocol;
		// 사용자가 이 페이지로 접근하기 위해 주소 표시줄에 입력한 도메인 명
		var domain = location.hostname;
		// 사용자가 이 페이지로 접근하기 위해 주소 표시줄에 입력한 포트 번호
		// 단, 포트번호는 없을 수 있음 / 포트번호가 없다는건 프로토콜의 기본 포트 번호를 사용했다는 것
		// 기본 포트 번호 - http의 경우 80번이 기본 포트 번호 / https의 경우 443번이 기본 포트 번호
		var port = location.port;
		
		// http://192.168.2.101:8081
		// http://localhost:8081
		// http://127.0.0.1:8081
		
		var THIS_SITE_FULL_DOMAIN = protocol + "//" + domain;
		if(port.length != 0){
			// 포트 번호를 입력하고 이 페이지에 접근했다면
			THIS_SITE_FULL_DOMAIN += (":" + port);
		}
		
		var productId = "<%=p_id %>";
		var CART_PAGE_URL = "<%=CART_PAGE_URL%>";
		
		function addToCart(){
			if(confirm("상품을 장바구니에 추가하시겠습니까?")){
				// 상품을 장바구니에 추가하는 코드
				jQuery.ajax({
					url: THIS_SITE_FULL_DOMAIN+"/WebMarket/cart/add",
					data: "productId="+productId,
					success: function() {
						var isMove = confirm("해당 상품을 장바구니에 추가했습니다. \n[장바구니로 이동하시겠습니까?]");
						if(isMove){
							alert("장바구니로 이동합니다.");
						
							location.href = CART_PAGE_URL;
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