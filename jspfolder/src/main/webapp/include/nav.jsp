<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Vo.*" %>
<%@ page import="java.sql.*"%>
<%
	Member memberNav = (Member)session.getAttribute("login");
	
 	//[검색]
	String navValue = request.getParameter("searchValue");
 
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<nav>
		<div id="welcome">
	<%
		if(memberNav != null){	//로그인이 돼있다면
	%>
			<p><%=memberNav.getMname() %>님, <span class="block">환영합니다.</span></p>
			<a href="<%=request.getContextPath()%>/mypage/mypage.jsp">마이페이지</a>
	<%		
		}else{
	%>
			<p>로그인 및 회원가입을 <span class="block">해주세요</span></p>
	<%	
		}
	%>	
		</div>
		<div class=searchMain>
			<form name="navFrm" action="<%=request.getContextPath()%>/list/allList.jsp" method="get">
				<input type="hidden" name="searchType" value="title">
				<input type="text" name="searchValue"> 
				<button>검색</button>
			</form>
		</div>
		<ul class="menu">
			<li><a href="<%=request.getContextPath()%>/list/allList.jsp">전체글보기</a></li>
			<li><a href="<%=request.getContextPath()%>/list/noticeList.jsp">공지사항</a></li>
			<li><a href="<%=request.getContextPath()%>/list/hotList.jsp">인기글</a></li>
			<li><a href="<%=request.getContextPath()%>/list/freeList.jsp">자유게시판</a></li>
			<li>
				<a href="<%=request.getContextPath()%>/list/zoneList.jsp">캠핑지역 소개/리뷰</a>
				<ul class="submenu">
					<li><a href="<%=request.getContextPath()%>/list/zone_SeoulList.jsp">서울</a></li>
					<li><a href="<%=request.getContextPath()%>/list/zone_GGList.jsp">경기권</a></li>
					<li><a href="<%=request.getContextPath()%>/list/zone_GWList.jsp">강원권</a></li>
					<li><a href="<%=request.getContextPath()%>/list/zone_CCList.jsp">충청권</a></li>
					<li><a href="<%=request.getContextPath()%>/list/zone_YNList.jsp">영남권</a></li>
					<li><a href="<%=request.getContextPath()%>/list/zone_HNList.jsp">호남권</a></li>
					<li><a href="<%=request.getContextPath()%>/list/zone_JJList.jsp">제주</a></li>			
				</ul>
			</li>
			<li>
				<a href="<%=request.getContextPath()%>/list/gearList.jsp">캠핑장비 소개/리뷰</a>
				<ul class="submenu">
					<li><a href="<%=request.getContextPath()%>/list/gear_TentList.jsp">텐트/타프</a></li>
					<li><a href="<%=request.getContextPath()%>/list/gear_BadList.jsp">침낭/매트</a></li>
					<li><a href="<%=request.getContextPath()%>/list/gear_ChairList.jsp">의자/테이블</a></li>
					<li><a href="<%=request.getContextPath()%>/list/gear_FireList.jsp">화기/기타</a></li>
					<li><a href="<%=request.getContextPath()%>/list/gear_CarList.jsp">차박</a></li>
				</ul>
			</li>
			<li><a href="<%=request.getContextPath()%>/list/attendList.jsp">출석체크</a></li>
			<li><a href="<%=request.getContextPath()%>/list/QnAList.jsp">Q&A</a></li>
		</ul>
		<!-- <div id="thecheat">더치트</div> -->
	</nav>
	
	
</body>
</html>