<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/mypage.css" type="text/css" rel="stylesheet">
<style>
	
	section{
		 margin: 0 auto;
		 height: calc(100vh - 190px - 130px);
	}
	section form{
		margin-top: 300px;
	}
</style>

</head>
<body>
<%@ include file="/include/header.jsp" %>
	<section>
		<form name="frm" method="post" action="mypageDelOk.jsp" onsubmit="return false">
			<input type="password" id="mypagePwinput" name="checkmpw" placeholder="비밀번호를 입력하세요.">
			<button id="mypagePwbutton" onclick="confirmFn()">회원 탈퇴</button>
		</form>
	</section>
<%@ include file="/include/footer.jsp" %>
<script>
	function confirmFn(){
		if(confirm("정말 탈퇴하시겠습니까?")){
			document.frm.submit();	
		}
	}
</script>
</body>
</html>