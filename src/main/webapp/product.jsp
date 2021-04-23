<%@page import="DTO.Product"%>
<%@page import="DAO.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
					<a href="#" class="btn btn-info">상품 주문 &raquo;</a>
					<a href="<%= PRODUCTS_PAGE_URL %>" class="btn btn-secndary">상품 목록 &raquo;</a>
				</p>
			</div>
		</div>
		`
		<hr>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>