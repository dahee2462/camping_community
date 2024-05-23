<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="<%=request.getContextPath()%>/css/login.css" type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
</head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<body>
<!-- 로그인 헤더 -->
<%@ include file="/include/joinHeader.jsp" %>
<!-- 섹션 -->
	<section>
		<div>
		<h2>반갑습니다!</h2>
    	<form name="frm" action="loginOk.jsp" method="post">
<!-- 아이디 -->
			<div id="loginfrm">
    		<input type="text" name="mid" id="id" placeholder="아이디">
<!-- 비밀번호 -->
    		<input type="password" name="mpw" id="pw" placeholder="비밀번호">
    		<button id="loginbutton">로그인</button>
    		</div>
    	</form>
    	</div>
<!-- 계정찾기 버튼 -->
    	<div id="idpwFind">
    		<a href="findId.jsp">아이디 찾기</a><a href="findPw.jsp">비밀번호 찾기</a>
    	</div>
<!-- 회원가입 버튼 -->
    	<div id="joinQus">아직도 계정이 없나요?</div>
    	<div id="joinbutton"><a href="join.jsp">회원가입</a></div>
	</section>
<%@ include file="/include/footer.jsp" %>
</body>
</html>