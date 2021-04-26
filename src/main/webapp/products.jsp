<%@page import="DAO.ProductRepository"%>
<%@page import="DTO.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ProductRepository pr = ProductRepository.getInstance();
	List<Product> listOfProducts = pr.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 목록</title>
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
	<%@ include file="header.jsp" %>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row" align="center">
			<!-- 상품을 하나씩 보여줌 -->
			<%
				for(int i=0; i<listOfProducts.size(); i++) {
					Product product = listOfProducts.get(i);
			%>
				<div class="col-md-4">
					<img src="./images/<%=product.getImagePath()%>">
					<h3><%=product.getName() %></h3>
					<p><%=product.getDescription() %></p>
					<p><%=product.getUnitPrice() %></p>
					<p><a href="<%= PRODUCT_PAGE_URL %>&productId=<%=product.getProductId()%>" class="btn btn-secondary" role="button">상세 정보&raquo;</a></p>
				</div>
			<%
				}
			%>
		</div>
		
		<hr>
	</div>
	
	<%@ include file="footer.jsp" %>
</body>
</html>






