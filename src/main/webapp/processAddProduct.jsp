<%@page import="exception.DuplicateProductException"%>
<%@page import="java.util.Calendar"%>
<%@page import="DAO.ProductRepository"%>
<%@page import="DTO.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/config.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	String productId = request.getParameter("productId");
	String name = request.getParameter("name");
	String unitPrice = request.getParameter("unitPrice");
	String description = request.getParameter("description");
	String manufacturer = request.getParameter("manufacturer");
	String category = request.getParameter("category");
	String unitsInStock = request.getParameter("unitsInStock");
	String conditon = request.getParameter("condition");
	
	Product product = new Product(
						productId, name, unitPrice, description, manufacturer,
						category, unitsInStock, conditon
					);
	
	// 상품 정보 저장
	// ProductRepository 객체의 생성을 제한 (싱글턴 패턴)
	ProductRepository pr = ProductRepository.getInstance();
	try {
		pr.addProduct(product);
		
		// 상품 코드가 중복되지 않아서 성공적으로 상품 정보를 저장했다면
		response.sendRedirect(PRODUCTS_PAGE_URL);
	} catch(DuplicateProductException e) {
		// 상품 코드가 중복됬다면
		response.sendRedirect(DUPLICATE_PRODUCT_PAGE_URL);
	}
%>





