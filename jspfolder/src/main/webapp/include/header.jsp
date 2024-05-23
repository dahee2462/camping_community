<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Vo.Member" %>
<%
	Member memberHeader = (Member)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<header>
		<div id="top_banner" class="clearfix">
			<div class="right">
				<a href="<%=request.getContextPath()%>/login/join.jsp">회원가입</a> | 
		<%
			if(memberHeader == null){ //로그인이 되어있지 않은 경우 출력
		%>
				<a href="<%=request.getContextPath()%>/login/login.jsp">로그인</a>
		<%
			}else{ //로그인이 되어있는 경우 출력
		%>
				<a href="<%=request.getContextPath()%>/login/logout.jsp">로그아웃</a>
		<%
			}
		%>
			</div>
		</div>
		<h1 id="logo">
			<a href="<%=request.getContextPath()%>/index.jsp">캠핑 여행 커뮤니티</a>
		</h1>
		<div class="clearfix">
			<div id="top_menu" class="left">
				<a href="<%=request.getContextPath()%>/list/allList.jsp">전체글보기</a> | 
				<a href="<%=request.getContextPath()%>/list/hotList.jsp">인기글</a> | 
				<a href="<%=request.getContextPath()%>/list/zoneList.jsp">캠핑지역</a> | 
				<a href="<%=request.getContextPath()%>/list/gearList.jsp">캠핑장비</a>
			</div>
			<div id="websearch" class="right">
				<form name="googleForm" method="get" target="_blank">
					<input type="text" name="googleText" value="검색어를 입력하세요" onclick="this.value='';">
					<a href="#" target="_blank" onclick="googleFn()">
						<img src="<%=request.getContextPath()%>/images/google.jpeg" alt="구글검색사진" width="50">
					</a>
				</form>
			</div>
		</div>
	</header>
		<script>
		function googleFn(){
			
			let googleValue =  document.googleForm.googleText.value;
			
			location.href="https://www.google.co.kr/search?q="+googleValue;
		}		
	</script>
</body>
</html>