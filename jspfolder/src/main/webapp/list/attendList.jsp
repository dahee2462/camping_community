<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Vo.*" %>
<%@ page import="paging.PagingVO" %>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//(등록버튼)
	Member member = (Member)session.getAttribute("login");
	
	//[검색]
	String searchAlign = request.getParameter("searchAlign");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	//searchAlign이 null일때 초기값 최신순으로 고정하기
	if(searchAlign==null){
		searchAlign="late";
	}
	
	//[페이징]
	String nowPageParam = request.getParameter("nowPage");
	
	int nowPage = 1;	
	if(nowPageParam !=null && !nowPageParam.equals("")){
		nowPage = Integer.parseInt(nowPageParam);
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	
	//[페이징]
	PagingVO pagingVO = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		
		//1. [페이징]
		String totalSql = "SELECT count(*) as cnt"
						+" FROM board b"
						+" INNER JOIN member m "
						+" ON b.mno = m.mno"
						+" WHERE btype = '출석체크'";
		
		//[검색]
		if(searchType != null){
			if(searchType.equals("title")){
				totalSql += " AND btitle LIKE CONCAT('%',?,'%')";
			}else if(searchType.equals("writer")){
				totalSql += " AND m.mnickNm LIKE CONCAT('%',?,'%')";
			}
		}
		psmt = conn.prepareStatement(totalSql);
		
		//[검색]
		if(searchType != null 
			&& ( searchType.equals("title") || searchType.equals("writer"))){
			psmt.setString(1, searchValue);
		}
		
		rs = psmt.executeQuery();
		
		//[페이징] 
		int totalCnt =0;
		if(rs.next()){
			totalCnt = rs.getInt("cnt");
		}
		
		if(rs !=null)rs.close();
		if(psmt !=null)psmt.close();
		
		//[페이징]
		pagingVO = new PagingVO(nowPage, totalCnt, 10); 
		
		rs=null;
		
		//2. [게시글] [댓글]
			String sql = "SELECT b.bno, btitle, b.mno, m.mnickNm, brdate ,bhit, btype"
					+" , (select count(*) from reply r where r.bno = b.bno) as rcnt"
					+" FROM board b "
					+" INNER JOIN member m "
					+" ON b.mno = m.mno"
					+" WHERE btype = '출석체크'";
		
		//[검색]
		if(searchType != null){
			
			if(searchType.equals("title")){
				sql += " AND btitle LIKE CONCAT('%',?,'%')";
			}else if(searchType.equals("writer")){
				sql += " AND m.mnickNm LIKE CONCAT('%',?,'%')";
			}
			
					
		}
		
		//[인기순 최신순 정렬]
		if(searchAlign != null){
			if(searchAlign.equals("late")){
				sql += " order by bno desc ";
			}else if(searchAlign.equals("hit")){
				sql += " order by bhit desc ";
			}
		}
		
		//[페이징]
		sql +=" LIMIT ?, ?";
		
		psmt = conn.prepareStatement(sql);
		
		//[검색][페이징]
		if(searchType != null 
				&&(searchType.equals("title") 
						||searchType.equals("writer"))){
			psmt.setString(1,searchValue);
			psmt.setInt(2, pagingVO.getStart()-1);
			psmt.setInt(3, pagingVO.getPerPage());
		}else{
			psmt.setInt(1, pagingVO.getStart()-1);
			psmt.setInt(2, pagingVO.getPerPage());
		}
		
		rs = psmt.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석체크게시판 목록</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/list.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@ include file="/include/header.jsp" %>
	<div class="container">
	<%@ include file="/include/nav.jsp" %>
	<section>
		<h2>출석체크</h2>
		<div class="frms">
			<form name ="frm1" action ="attendList.jsp" method="get" id="frm1">
				<select name="searchAlign" onchange="document.frm1.submit()">
					<option value="late" <%if(searchAlign != null 
						&& searchAlign.equals("late")) out.print("selected"); %>>최신순</option>
					<option value="hit"<%if(searchAlign != null 
						&& searchAlign.equals("hit")) out.print("selected"); %>>인기순</option>
				</select>
			</form>
			<form name ="frm2" action ="attendList.jsp" method="get" id="frm2">
				<select name="searchType">
					<option value="title" <%if(searchType != null 
						&& searchType.equals("title")) out.print("selected"); %>>제목</option>
					<option value="writer"<%if(searchType != null 
						&& searchType.equals("writer")) out.print("selected"); %>>작성자</option>
				</select>
				<input type="text" name="searchValue" 
				  value="<%if(searchValue!=null) out.print(searchValue); %>">
				<input type="hidden" name="searchAlign" value="<%if(searchAlign!=null) out.print(searchAlign); %>">
				<button class="searchBtn">검색</button>
			</form>
		</div>
		<table class="listTable">
			<thead>
				<tr>
					<th>번호</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일시</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
			<% 
				while (rs.next()) { 
					int bno = rs.getInt("bno");
					String btype = rs.getString("btype");
					String btitle = rs.getString("btitle");
					String mnickNm = rs.getString("mnickNm");
					String brdate = rs.getString("brdate");
					int bhit = rs.getInt("bhit");
			%>
				<tr>
					<td><%=bno %></td>
					<td><%=btype %></td>
					<td>
						<a href="<%=request.getContextPath()%>/board/view.jsp?bno=<%=bno%>&blist=attend"><%=btitle %></a>
						<span id="replyspan">[<%=rs.getInt("rcnt") %>]</span>
					</td>
					<td><%=mnickNm %></td>
					<td><%=brdate %></td>
					<td><%=bhit %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	<%
	if(member != null){
	%>
		<div class="btnDiv">
			<button class="writeBtn" 
				onclick="location.href='<%=request.getContextPath()%>/board/write.jsp?blist=attend'">글쓰기</button>
		</div>
	<%	
		}
	%>
		
	<div class="paging">
	<%	//페이징영역
		if(pagingVO.getStartPage()>pagingVO.getCntPage()){
	%>
			<a href="attendList.jsp?nowPage=<%=pagingVO.getStartPage()-1%>&searchAlign=<%=searchAlign%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>" class="pluspage">이전</a>
	<%
		 }
		
		for(int i = pagingVO.getStartPage(); i<=pagingVO.getEndPage(); i++){
			 		
			if(nowPage == i){	
			 %>
			 	<b><%=i %></b>
			 <%
			 }else{
				 		
				 if(searchType != null){
				 %>
					<a href="attendList.jsp?nowPage=<%=i%>&searchAlign=<%=searchAlign%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i %></a>
				 <%
				 }else{
				 %>
					<a href="attendList.jsp?nowPage=<%=i%>&searchAlign=<%=searchAlign%>"><%=i  %></a>
				<%
				 }
			}
			 	
		}
		
		if(pagingVO.getEndPage()<pagingVO.getLastPage()){
		%>
			<a href="attendList.jsp?nowPage=<%=pagingVO.getEndPage()+1%>&searchAlign=<%=searchAlign%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>" class="pluspage">다음</a>
		<%
		}
		%>
		 </div>
	</section>
	</div>
	<%@ include file="/include/footer.jsp" %>
</body>
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