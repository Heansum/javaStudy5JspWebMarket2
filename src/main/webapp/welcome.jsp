<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
	String greeting = "웹 쇼핑몰에 오신것을 환영합니다";
	String tagline = "Welcome to Web Market!";
%>
<%
	LocalDateTime nowDateTime = LocalDateTime.now();
	String am_pm;
	int hour = nowDateTime.getHour();
	int minute = nowDateTime.getMinute();
	int second = nowDateTime.getSecond();
	
	if(hour / 12 == 0) {
		am_pm = "AM";
	} else {
		am_pm = "PM";
		hour = hour - 12;
	}
	
	String s_hour = (hour < 10 ? "0" : "") + hour;
	String s_minute = (minute < 10 ? "0" : "") + minute;
	String s_second = (second < 10 ? "0" : "") + second;
	
	String CT = s_hour + ":" + s_minute + ":" + s_second + " " + am_pm;
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Welcome</title>
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
			<h1 class="display-3"><%=greeting %></h1>
		</div>
	</div>
	
	<main role="main">
		<div class="container">
			<div class="text-center">
				<h3><%=tagline %></h3>
				<%="<p>현재 접속 시각 " + CT + "</p>"%>
			</div>
		</div>
	</main>
	
	<%@ include file="footer.jsp" %>
</body>
</html>




