<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link href="<%=request.getContextPath()%>/css/findPw.css" type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
</head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<body>
<!-- 로그인 헤더 -->
<%@ include file="/include/header.jsp" %>
<section>
		<div id="formDiv">
    	<div id="hello"><h2>비밀번호 찾기</h2></div>
    	<form name="frm" action="findPwOk.jsp" method="post" onsubmit="return false;">
    		<table>
<!-- 아이디 -->
    			<tr id="trTitle">
					<th>아이디</th>
				</tr>
    			<tr>
    				<td>
    					<input type="text" name="mid" oninput="checkId(this)" class="textbox">
    				</td>
    			</tr>
    			<tr class="blur">
    				<td colspan="2"><a id="midTd"></a></td>
				</tr>
<!-- 이름 -->
    			<tr id="trTitle">
					<th>이름</th>
				</tr>
    			<tr>
    				<td>
    					<input type="text" name="mname"  oninput="checkName(this)" class="textbox">
    				</td>
    			</tr>
    			<tr class="blur">
    				<td colspan="2"><a id="mnameTd"></a></td>
				</tr>
<!-- 생년월일 -->
    			<tr id="trTitle">
					<th>생년월일</th>
				</tr>
    			<tr>
    				<td>
    					<input type="text" name="mbirth"  oninput="checkBirth(this)" class="textbox">
    				</td>
    			</tr>
    			<tr class="blur">
    				<td colspan="2" id="mbirthTd"></td>
				</tr>
<!-- 연락처 -->
    			<tr id="trTitle">
					<th>연락처</th>
				</tr>
    			<tr>
    				<td>
						<input type="text" name="mphone1" oninput="checkPhone1(this)" maxlength="3" class="phone"> -
						<input type="text" name="mphone2" oninput="checkPhone2(this)" maxlength="4" class="phone"> -
						<input type="text" name="mphone3" oninput="checkPhone3(this)" maxlength="4" class="phone">
					</td>
    			</tr>
    			<tr class="blur">
    				<td colspan="2" align="right"><a id="mphoneTd"></a></td>
				</tr>
    		</table>
    		<input type="submit" onclick="searchPw()" id="pwSearchButton" value="비밀번호 찾기">
    	</form>
    	</div>
<!-- 비밀번호 찾기 -->
    	<div id="loginQus">로그인 하시겠어요?</div>
    	<div id="loginButton"><a href="login.jsp">로그인</a></div>
	</section>
<script src="<%=request.getContextPath()%>/js/findPw.js"></script>
<%@ include file="/include/footer.jsp" %>
</body>
</html>