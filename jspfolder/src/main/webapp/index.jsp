<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Vo.*" %>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass = "ezen";
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		//공지사항
		String sql = "SELECT b.*"
				+" FROM board b "
				+" INNER JOIN member m "
				+" ON b.mno = m.mno"
				+" WHERE btype = '공지사항'"
				+" ORDER BY bno desc "
				+" LIMIT 6";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑 여행 커뮤니티</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/main.css" type="text/css" rel="stylesheet">
</head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<body>
	<%@ include file="/include/header.jsp" %>
	<div class="container">
		<%@ include file="/include/nav.jsp" %>
		<section>
			<div id="location">위치 
				<span></span>
			</div>
			<div id="temp">기온 
				<span></span>
			</div>
			<div id="weather">
         		<span id="weatherIcon"></span>
				<span></span>
			</div>
			<div id="youtube">
				<iframe width="440" height="250" src="https://www.youtube.com/embed/YvgKD1VfA6E?si=Cr2fSTvCdzgS42eN" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
				<iframe width="440" height="250" src="https://www.youtube.com/embed/QNBHV2_e9-A?si=LbOXFALWzT4ZP2UD" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
			</div>
			<div id="adbanner">
				<a href="https://www.nordisk.co.kr/">
					<img src="<%=request.getContextPath()%>/images/캠핑배너사진.png" alt="캠핑광고배너">
				</a>
			</div>
			<div class="mainboard">
				<div id="mboard1">
					<div class="mboardmn clearfix">
						<h3>공지사항</h3>
						<a href="<%=request.getContextPath()%>/list/noticeList.jsp" 
							class="mainmore">더보기 +</a>
					</div>
					<ul class="mainlist">
					<% 
						while (rs.next()) { 
							int bno = rs.getInt("bno");
							String btitle = rs.getString("btitle");
							String brdate = rs.getString("brdate");
					%>
						<li>
							<a href="<%=request.getContextPath()%>/board/view.jsp?bno=<%=bno%>&blist=notice"><%=btitle %></a>
							<span class="mlistdate"><%=brdate %></span>
						</li>
					<%
						}
						if(rs !=null)rs.close();
						if(psmt !=null)psmt.close();
						
						rs=null;
	
					%>	
					</ul>
				</div>
				<div id="mboard2">
					<div class="mboardmn clearfix">
						<h3>전체게시글</h3>
						<a href="<%=request.getContextPath()%>/list/allList.jsp" class="mainmore">더보기 +</a>
					</div>
					<ul class="mainlist">
					<% //전체게시판
						sql = " SELECT b.* "
								+" FROM board b INNER JOIN member m "
								+" ON b.mno = m.mno "
								+" WHERE (btype = '자유게시판' or btype like '캠핑지역%' "
								+" or btype like '캠핑장비%' or btype='공지사항') "
								+" ORDER BY bno desc "
								+" LIMIT 6";
							
							psmt = conn.prepareStatement(sql);
							rs = psmt.executeQuery();
						
						while (rs.next()) { 
							int bno = rs.getInt("bno");
							String btitle = rs.getString("btitle");
							String brdate = rs.getString("brdate");
					%>
						<li>
							<a href="<%=request.getContextPath()%>/board/view.jsp?bno=<%=bno%>&blist=all"><%=btitle %></a>
							<span class="mlistdate"><%=brdate %></span>
						</li>
					<%
						}
					%>
					</ul>
				</div>
			</div>
	</section>
	</div>
	<%@ include file="/include/footer.jsp" %>
</body>
<script src="<%=request.getContextPath()%>/js/weather.js"></script>
</html>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) conn.close();
			if (psmt != null) psmt.close();
			if (rs != null) rs.close();
		}
	%>