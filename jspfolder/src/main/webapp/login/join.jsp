<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/join.css" type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
</head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<body>
<%@ include file="/include/joinHeader.jsp" %>
	<section>
		<article>
<!-- 회원가입 폼 -->
			<div>
			<h2>회원가입</h2>
			<form name="frm" action="joinOk.jsp" method="post" onsubmit="return false;" >
				<table class="joinTable">
<!-- 아이디 -->
					<tr id="trTitle">
						<th>아이디</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="mid" id="mid" oninput="checkId(this);resetIdFn();" class="textbox">
							<button type="button" onclick="checkIdFn()">중복확인</button>
						</td>
					</tr>
					<tr class="blur">
    					<td colspan="2"><a id="midTd"></a></td>
					</tr>
<!-- 비밀번호 -->
					<tr id="trTitle">
						<th>비밀번호</th>
					</tr>
					<tr>
						<td>
							<input type="password" name="mpw" oninput="checkPw(this);checkPwRe();" class="textbox">
						</td>
					</tr>
					<tr class="blur">
    					<td colspan="2"><a id="mpwTd"></a></td>
					</tr>
<!-- 비밀번호 확인 -->
					<tr id="trTitle">
						<th>비밀번호 확인</th>
					</tr>
					<tr>
						<td>
							<input type="password" name="mpwRe" oninput="checkPwRe()" class="textbox">
						</td>
					</tr>
					<tr class="blur">
    					<td colspan="2"><a id="mpwReTd"></a></td>
					</tr>
<!-- 닉네임 -->
					<tr id="trTitle">
						<th>닉네임</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="mnickNm" oninput="checkNickNm(this);resetNickFn();" class="textbox">
							<button type="button" onclick="checkNickFn()">중복확인</button>
						</td>
					</tr>
					<tr class="blur">
    					<td colspan="2"><a id="mnickNmTd"></a></td>
					</tr>
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
    					<td colspan="2"><a id="mnameTd"></a></td>
					</tr>
<!-- 생년월일 -->
					<tr id="trTitle">
						<th>생년월일</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="mbirth" oninput="checkBirth(this)" maxlength="8" class="textbox">
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
<!-- 성별 -->
					<tr id="trTitle">
						<th>성별</th>
					</tr>
					<tr>
						<td>
							<input type="radio" name="mgender" onclick="checkGender(this)" value="M">남
							<input type="radio" name="mgender" onclick="checkGender(this)" value="F">여
						</td>
					</tr>
					<tr class="blur">
    					<td colspan="2"><a id="mgenderTd"></a></td>
					</tr>
<!-- 이메일 -->
					<tr id="trTitle">
						<th>이메일</th>
					</tr>
					<tr>
						<td>
							<input type="email" name="memail" oninput="checkEmail(this)" class="textbox">
						</td>
					</tr>
					<tr class="blur">
    					<td colspan="2"><a id="memailTd"></a></td>
					</tr>
				</table>
				<input type="submit" id="joinButton" onclick="validation();" value="가입하기">
			</form>
			</div>
			<div id="loginbutton">
				<p>계정이 있나요?</p>
				<a href="login.jsp">로그인</a>
			</div>
		</article>
	</section>
	<%@ include file="/include/footer.jsp" %>
<script src="<%=request.getContextPath()%>/js/join.js"></script>
</body>
</html>