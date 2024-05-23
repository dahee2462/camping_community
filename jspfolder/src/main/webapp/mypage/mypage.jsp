<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Vo.*" %>
<%@ page import="paging.PagingVO" %> 
<!DOCTYPE html>
<html>
<head>
<%
	request.setCharacterEncoding("UTF-8");
	
	
	
	
	int mno=0;
	Member member = (Member)session.getAttribute("login");
	if(member != null){
		mno = member.getMno();
	}
	if(mno ==0){
		%>
		<script>
			alert("로그인을 하고 마이페이지를 접속해주세요.");
			location.href="/jspfolder/index.jsp";
		</script>
		<%
	}
	
	
	
	//[검색]
	String searchAlign = request.getParameter("searchAlign");
	String searchValue = request.getParameter("searchValue");
	if(searchAlign ==null ){
		searchAlign = "late";
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
		
		//[totalCnt 구하기]
		String totalSql = "SELECT count(*) as cnt"
						+" FROM board b"
						+" INNER JOIN member m "
						+" ON b.mno = m.mno"
						+" where m.mno=? ";
		

		//[검색]
		if(searchValue != null){
			totalSql += " and btitle like concat('%',?,'%') ";		
		}
		
		psmt = conn.prepareStatement(totalSql);
		psmt.setInt(1,mno);
		if(searchValue != null ){
			psmt.setString(2,searchValue);
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
		
		//2. [게시글]
		String sql = "select b.*, m.mnickNm , (select count(*) from reply r where r.bno = b.bno) as rcnt "
		+" from board b inner join member m on b.mno = m.mno where m.mno = ? ";
	
		//[검색]
		if(searchValue != null){
			sql += " and btitle like concat('%',?,'%')";		
		}
		
		if(searchAlign != null){
			if(searchAlign.equals("late")){
				sql += " order by bno desc ";
			}else if(searchAlign.equals("hit")){
				sql += " order by bhit desc ";
			}
		}
		
		sql += " limit ?,? ";
		
		

		
 		psmt = conn.prepareStatement(sql);
 		
 		psmt.setInt(1,mno);
		if(searchValue != null){
			psmt.setString(2,searchValue);
			psmt.setInt(3, pagingVO.getStart()-1);
			psmt.setInt(4, pagingVO.getPerPage());
		}else{
			psmt.setInt(2, pagingVO.getStart()-1);
			psmt.setInt(3, pagingVO.getPerPage());
		}
		
		rs = psmt.executeQuery();
		

		
	
%>



<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/mypage.css" type="text/css" rel="stylesheet">
<style>
	#span{
		font-weight:bold; text-decoration: underline;
	}
</style>
</head>
<body>
	

	<%@ include file="/include/header.jsp" %>
	<div class="container">
	<nav>
		<div id="mypagewelcome">
			<span id="mypagenickname"><%if(member != null) out.print(member.getMnickNm()); %></span>
			<span id="mypagename"><%if(member != null) out.print(member.getMname()); %></span>
		</div>
		<div>
			<span id="span" class="mypagelist"><a href="mypage.jsp">내가 쓴 게시글</a></span>
			<span class="mypagelist"><a href="mypagePw.jsp">회원 정보 수정</a></span>
			<span class="mypagelist"><a href="mypageDel.jsp">회원 탈퇴</a></span>
		</div>
		
	</nav>
	<section>
		<div id="boardname">내가 쓴 게시글</div>
			<form name="frm" action="mypage.jsp" method="get">
				<select id="select" name="searchAlign" onchange="document.frm.submit()">
					<option value="late" <%if(searchAlign != null 
						&& searchAlign.equals("late")) out.print("selected"); %>>최신순</option>
					<option value="hit" <%if(searchAlign != null 
						&& searchAlign.equals("hit")) out.print("selected"); %>>인기순</option>
				</select>
				
				<div id="search">
					<input type="text" id="title" name="searchValue">
					<button id="button"> 검색</button>
				</div>
			</form>
			
		<table id="mypagetable">
			<thead id="mypagethead">
				<tr>
					<th id="td1">번호</th>
					<th id="td2">카테고리</th>
					<th id="th3">제목</th>
					<th id="td4">작성자</th>
					<th id="td5">작성일시</th>
					<th id="td6">조회수</th>				
				</tr>
			</thead>
			
			<tbody id="mypagetbody">
				<%
					if(!rs.next()){
				%>		
						
						<tr> <td id="td" colspan="6"> 아무것도 검색되지 않았습니다. </td> </tr>
				<%
					}else{
				
						int num =0;
						while(true){
							
							%>
							<tr id ="tr">
								<td id="td1"><%=pagingVO.getStart()+num %></td>
								<td id="td2"><%=rs.getString("btype") %></td>
								<td id="td3"><a href="<%=request.getContextPath() %>/board/view.jsp?bno=<%=rs.getInt("bno")%>&blist=all">
								<%=rs.getString("btitle") %></a><span id="replyspan">[<%=rs.getInt("rcnt") %>]</span></td>
								<td id="td4"><%=rs.getString("mnickNm") %></td>
								<td id="td5"><%=rs.getString("brdate") %></td>
								<td id="td6"><%=rs.getInt("bhit") %></td>
							</tr>
							<%
							if(!rs.next()){
								break;
							}
							num++;
						}
					}
	
				%> 
				
			</tbody>
		</table>
		
		
		<!-- 페이징 영역 -->
		 
	<%
	if(member != null){
	%>
		<div class="btnDiv">
			<button class="writeBtn" onclick="location.href='<%=request.getContextPath()%>/board/write.jsp?blist=all'">글쓰기</button>
		</div>
	<%	
		}
	%>
	
		
	<div class="mainpaging">
	<%	//페이징영역
		if(pagingVO.getStartPage()>pagingVO.getCntPage()){
	%>
			<span class="paging">
		 		<a href="mypage.jsp?nowPage=<%=pagingVO.getStartPage()-1%>
				<%if(searchAlign!=null && !searchAlign.equals("")) out.print("&searchAlign="+searchAlign);
						if(searchValue!=null && !searchAlign.equals("")) out.print("&searchValue="+searchValue);
						%>">이전</a>
			</span>
	<%
		 }
		
		for(int i = pagingVO.getStartPage(); i<=pagingVO.getEndPage(); i++){
			 		
			if(nowPage == i){	
			 %>
			 	<b><%=i %></b>
			 <%
			 }else{
				 		
				 %>
					<span class="pagingnum"><a href="mypage.jsp?nowPage=<%=i%>
						<%if(searchAlign!=null && !searchAlign.equals("")) out.print("&searchAlign="+searchAlign);
						if(searchValue!=null && !searchAlign.equals("")) out.print("&searchValue="+searchValue);
						%>"><%=i %></a></span>
				 <%
				
			}
			 	
		}
		
		if(pagingVO.getEndPage()<pagingVO.getLastPage()){
		%>
			<span class="paging">
			<a href="mypage.jsp?nowPage=<%=pagingVO.getEndPage()+1%>
				<%if(searchAlign!=null && !searchAlign.equals("")) out.print("&searchAlign="+searchAlign);
						if(searchValue!=null && !searchAlign.equals("")) out.print("&searchValue="+searchValue);
						%>">다음</a>
			</span>
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

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
%>