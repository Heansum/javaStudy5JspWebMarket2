<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/config.jsp" %>

<% 
	String language = request.getParameter("language");
	if(language == null || language.length() == 0){
		// 요청 파라미터로 language가 전달되지 않았을 경우
		language = "ko";
	} else if(language.equals("ko") || language.equals("en")){
		// 아무것도 하지 않음
	} else {
		language = "ko";
	}
%>

<fmt:setLocale value="<%= language %>"/>
<fmt:setBundle basename="properties.message" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><fmt:message key="title"/></title>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<!-- 부트스트랩을 위한 jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script type = "text/javascript" src="/WebMarket/js/validation.js"></script>
</head>
<body>
	<jsp:include page="../header.jsp" />

	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><fmt:message key="title"/></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-right">
			<a href="?language=ko">Korean</a> | <a href="?language=en">English</a>
		</div>
	
	
		<form action="<%= PRODUCT_ADD_PROCESS_URL %>" name="newProduct" class="form-horizontal" method="POST" enctype="multipart/form-data">
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="productId"/></label>
				<div class="col-sm-3">
					<input type="text" name="productId" id="productId" class="form-control" maxlength="5" size="5">
				</div>
			</div>
		
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="name"/></label>
				<div class="col-sm-3">
					<input type="text" name="name" id = "name" class="form-control" maxlength="255" size="255">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="unitPrice"/></label>
				<div class="col-sm-3">
					 <input type="number" name="unitPrice" id = "unitPrice" class="form-control" min="0" max="10000000">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="description"/></label>
				<div class="col-sm-5">
					<textarea name="description" rows="10" cols="50" class="form-control"></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="manufacturer"/></label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="category"/></label>
				<div class="col-sm-3">
					<input type="text" name="category" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="unitsInStock"/></label>
				<div class="col-sm-3">
					<input type="range" name="unitsInStock" id="unitsInStock" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="condition"/></label>
				<div class="col-sm-5">
					<label><input type="radio" name="condition" value="new">새제품</label>
					<label><input type="radio" name="condition" value="old">중고제품</label>
					<label><input type="radio" name="condition" value="refurbished">리퍼제품</label>
				</div>
			</div>
			
			<div class="form-group row">
				<label class = "col-sm-2"><fmt:message key="productImage"/></label>
				<div class = "col-sm-5">
					<input type = "file" name = "productImage" class = "form-control">
				</div>
				
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="submit" class="btn btn-primary" value='<fmt:message key="button"/>' onclick ="checkAddProduct()">
					<input type="reset" class="btn btn-danger" value="초기화">
				</div>
			</div>
		</form>
	</div>
	
	<hr>
	<jsp:include page="../footer.jsp" />
</body>
</html>




