<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="exception.DuplicateProductException"%>
<%@page import="java.util.Calendar"%>
<%@page import="DAO.ProductRepository"%>
<%@page import="DTO.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/config.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	String filename = "";
	// 프로젝트의 절대 경로
	String realFolder = "C:\\Users\\ITPS\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WebMarket\\images";
	// 업로드될 파일의 최대 크기 5MB
	int maxSize = 15 * 1024 * 1024;
	// 인코딩 유형
	String encType = "UTF-8";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String productId = multi.getParameter("productId");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String description = multi.getParameter("description");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");
	String conditon = multi.getParameter("condition");
	
	Enumeration files = multi.getFileNames();
	String fileName = (String) files.nextElement();
	fileName = multi.getFilesystemName(fileName);
	
	Product product = new Product(productId, name, unitPrice, description, manufacturer
			,category, unitsInStock, conditon, fileName);
	
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





