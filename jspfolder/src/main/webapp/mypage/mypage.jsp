<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="tableVo.Member" %>
<%
	Member member = (Member)session.getAttribute("member");
	

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@ include file="/include/header.jsp" %>
	<%@ include file="/include/mypageNav.jsp" %>
	<section>
		안녕하세요
	</section>
	<%@ include file="/include/footer.jsp" %>
</body>
</html>