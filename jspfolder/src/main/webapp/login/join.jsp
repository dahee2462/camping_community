<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/join.css" type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js">
	function clickjoin(){ // 회원가입 미입력 값 있을 시 false;
		const mid = document.frm.mid.value;
		const mpw = document.frm.mpw.value;
	}
</script>
</head>
<body>
<%@ include file="/include/joinSemantic.jsp" %>
	<section>
<!-- 회원가입 폼 -->
		<article>
			<h2>회원가입</h2>
			<form name="frm" action="joinOk.jsp" method="post">
				<table>
<!-- 아이디 -->
					<tr>
						<th align="right">아이디: </th>
						<td>
							<input type="text" name="mid">
							<button type="button">중복확인</button>
						</td>
					</tr>
<!-- 비밀번호 -->
					<tr>
						<th align="right">비밀번호: </th>
						<td><input type="password" name="mpw"></td>
					</tr>
<!-- 비밀번호 확인 -->
					<tr>
						<th align="right">비밀번호 확인: </th>
						<td><input type="password" name="mpwRe"></td>
					</tr>
<!-- 닉네임 -->
					<tr>
						<th align="right">닉네임: </th>
						<td><input type="text" name="mnickNm"></td>
					</tr>
<!-- 사용자 이름 -->
					<tr>
						<th align="right">이름: </th>
						<td><input type="text" name="mname"></td>
					</tr>
<!-- 생년월일 -->
					<tr>
						<th align="right">생년월일: </th>
						<td><input type="text" name="mbirth" maxlength="8"></td>
					</tr>
<!-- 연락처 -->
					<tr>
						<th align="right">연락처: </th>
						<td class="mphone">
							<input type="text" name="mphone1" maxlength="3" class="phone">-
							<input type="text" name="mphone2" maxlength="4" class="phone">-
							<input type="text" name="mphone3" maxlength="4" class="phone">
						</td>
					</tr>
<!-- 성별 -->
					<tr>
						<th align="right">성별: </th>
						<td>
							<input type="radio" name="mgender" value="M">남
							<input type="radio" name="mgender" value="W">여
						</td>
					</tr>
<!-- 이메일 -->
					<tr>
						<th align="right">이메일: </th>
						<td><input type="email" name="memail"></td>
					</tr>
				</table>
<!-- 회원가입 버튼 -->
				<div>
				<button type="button" onclick="clickjoin()">제출하기</button>
				</div>
			</form>
		</article>
	</section>
</body>
</html>