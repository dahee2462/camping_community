<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="<%=request.getContextPath()%>/css/findId.css" type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
</head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<body>
<!-- 로그인 헤더 -->
<%@ include file="/include/header.jsp" %>
<section>
    	<div id="formDiv">
    	<div id="hello"><h2>아이디 찾기</h2></div>
    	<form name="frm" action="findIdOk.jsp" method="post" onsubmit="return false;">
    		<table>
<!-- 이름 -->
    			<tr id="trTitle">
					<th>이름</th>
				</tr>
    			<tr>
    				<td>
    					<input type="text" name="mname" oninput="checkName(this)" class="textbox">
    				</td>
    			</tr>
    			<tr class="blur">
    				<td colspan="2" align="right"><a id="mnameTd"></a></td>
				</tr>
<!-- 생년월일 -->
    			<tr id="trTitle">
					<th>생년월일</th>
				</tr>
    			<tr>
    				<td>
    					<input type="text" name="mbirth" oninput="checkBirth(this)" class="textbox">
    				</td>
    			</tr>
    			<tr class="blur">
    					<td colspan="2" align="right"><a id="mbirthTd"></a></td>
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
    		<input type="submit" id="idSearchButton" onclick="searchId();" value="아이디 조회하기">
    	</form>
    	</div>
<!-- 비밀번호 찾기 -->
    	<div id="findPwQus">비밀번호를 찾으시나요?</div>
    	<div id="findPwButton"><a href="findPw.jsp">비밀번호 찾기</a></div>
	</section>
<script src="<%=request.getContextPath()%>/js/findId.js"></script>
<%@ include file="/include/footer.jsp" %>
</body>
</html>