<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/join.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js">
	
</script>
</head>
<body>
<%@ include file="/semantic/joinSemantic.jsp" %>
	<section>
		<article>
			<h2>회원가입</h2>
			<form name="frm" action="joinOk.jsp" method="post">
				<table>
					<tr>
						<th align="right">아이디: </th>
						<td>
							<input type="text" name="mid">
							<button type="button">중복확인</button>
						</td>
					</tr>
					<tr>
						<th align="right">비밀번호: </th>
						<td><input type="text" name="mpw"></td>
					</tr>
					<tr>
						<th align="right">비밀번호 확인: </th>
						<td><input type="text" name="mpwRe"></td>
					</tr>
					<tr>
						<th align="right">닉네임: </th>
						<td><input type="text" name="mnickNm"></td>
					</tr>
					<tr>
						<th align="right">이름: </th>
						<td><input type="text" name="mname"></td>
					</tr>
					<tr>
						<th align="right">생년월일: </th>
						<td><input type="text" name="mbirth"></td>
					</tr>
					<tr>
						<th align="right">휴대전화번호: </th>
						<td>
							<input type="text" name="mphone" maxlength="3" class="phone">-
							<input type="text" name="mphone2" maxlength="4" class="phone">-
							<input type="text" name="mphone3" maxlength="4" class="phone">
						</td>
					</tr>
					<tr>
						<th align="right">성별: </th>
						<td>
							<input type="radio" name="mgender" >남
							<input type="radio" name="mgender" >여
						</td>
					</tr>
					<tr>
						<th align="right">이메일: </th>
						<td><input type="text" name="memail"></td>
					</tr>
				</table>
				<div>
				<button type="button" onclick="clickjoin()">제출하기</button>
				</div>
			</form>
		</article>
	</section>
	
	
</body>
</html>