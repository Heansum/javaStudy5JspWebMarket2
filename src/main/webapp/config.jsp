<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%!
	String WELCOME_PAGE_URL = "/WebMarket/welcome.jsp?active=welcome";
	String PRODUCTS_PAGE_URL = "/WebMarket/product/list?active=products";
	String PRODUCT_ADD_PAGE_URL = "/WebMarket/product/add.jsp?active=addProduct";
	String PRODUCT_PAGE_URL = "/WebMarket/product/info?active=products";
	String PRODUCT_ADD_PROCESS_PAGE_URL = "/WebMarket/processAddProduct.jsp";
	String PRODUCT_ADD_PROCESS_URL = "/WebMarket/product/add";
	
	String DUPLICATE_PRODUCT_PAGE_URL = "/WebMarket/error/duplicate.jsp?active=addProduct";
	String CART_PAGE_URL = "/WebMarket/cart.jsp?active=cart";
	
	String ADD_TO_CART_PROCESS_URL = "/WebMarket/cart/add";
	
	
	String adminIP = "192.168.2.30";
%>