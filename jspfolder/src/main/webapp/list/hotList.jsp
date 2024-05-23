<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Vo.*" %>
<%@ page import="paging.PagingVO" %>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//(등록버튼)
	Member member = (Member)session.getAttribute("login");
	
	
	
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
						+"  WHERE (btype = '자유게시판' or btype LIKE '캠핑장비%' or  btype LIKE '캠핑지역%') ";
		
		
		
		psmt = conn.prepareStatement(totalSql);
		
		
		rs = psmt.executeQuery();
		
		int totalCnt =0;
		if(rs.next()){
			totalCnt = rs.getInt("cnt");
		}
		
		if(rs !=null)rs.close();
		if(psmt !=null)psmt.close();
		
		pagingVO = new PagingVO(nowPage, totalCnt, 10); 
		
		rs=null;
		
		//2. [게시글]
			
		String sql = " select b.*, m.mnickNm , (select count(*) from reply r where r.bno = b.bno) as rcnt "
				 +" from board b inner join member m on b.mno = m.mno "
				 +" WHERE (btype = '자유게시판' or btype LIKE '캠핑장비%' or  btype LIKE '캠핑지역%') order by bhit desc ";
		
		
		sql += " limit ?,? ";
		
 		psmt = conn.prepareStatement(sql);
		
		psmt.setInt(1, pagingVO.getStart()-1);
		psmt.setInt(2, pagingVO.getPerPage());
		
		rs = psmt.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인기글 목록</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/mypage.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@ include file="/include/header.jsp" %>
	<div class="container">
	<%@ include file="/include/nav.jsp" %>
	<section>
		<div id="boardname">인기글</div>
		
		
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
								<td id="td3">
									<a href="<%=request.getContextPath() %>/board/view.jsp?bno=<%=rs.getInt("bno")%>&blist=hot"><%=rs.getString("btitle") %></a>
									<span id="replyspan">[<%=rs.getInt("rcnt") %>]</span>
								</td>
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
		
		
	<%
	if(member != null){
	%>
		<div class="btnDiv">
			<button class="writeBtn" onclick="location.href='<%=request.getContextPath()%>/board/write.jsp?blist=hot';">글쓰기</button>
		</div>
	<%	
		}
	%>
		
		<!-- 페이징 영역 -->
		 
	
		
	<div class="mainpaging">
	<%	//페이징영역
		if(pagingVO.getStartPage()>pagingVO.getCntPage()){
	%>
			<span class="paging">
		 		<a href="hotList.jsp?nowPage=<%=pagingVO.getStartPage()-1%> ">이전</a>
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
					<span class="pagingnum"><a href="hotList.jsp?nowPage=<%=i%>"> <%=i %></a></span>
				<%
			}
		}
		if(pagingVO.getEndPage()<pagingVO.getLastPage()){
		%>
			<span class="paging">
			<a href="hotList.jsp?nowPage=<%=pagingVO.getEndPage()+1%>">다음</a>
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