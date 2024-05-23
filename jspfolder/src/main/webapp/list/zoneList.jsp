<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Vo.*" %>
<%@ page import="paging.PagingVO" %>
<%@ page import="java.sql.*"%>
<%
//	페이지 인코딩
	request.setCharacterEncoding("UTF-8");

//	login 사용자 정보 세션
	Member member = (Member)session.getAttribute("login");

//	검색
	String searchAlign = request.getParameter("searchAlign");
	String subSearchAlign = request.getParameter("subSearchAlign");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");

//	화면 초기값 고정
	if(searchAlign == null){
		searchAlign = "late";
	}
	if(subSearchAlign == null){
		subSearchAlign = "zone_Seoul";
	}

//	페이징
	String nowPageParam = request.getParameter("nowPage"); // nowPage 파라미터 생성

	int nowPage = 1;
	if(nowPageParam != null && !nowPageParam.equals("")){
		nowPage = Integer.parseInt(nowPageParam); // 페이지 번호를 현재페이지로 변경
	}

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	
	PagingVO pagingVO = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,pass);
		
//		페이징 쿼리문
		String totalSql = " SELECT COUNT(*) AS cnt "
						+ "   FROM board b "
						+ "  INNER JOIN member m "
						+ "     ON b.mno = m.mno "
						+ "  WHERE btype LIKE '캠핑지역%'";
		
//		제목, 작성자 검색
		if(searchType != null){
			if(searchType.equals("title")){
				totalSql += " AND btitle LIKE CONCAT('%',?,'%')";
			}else if(searchType.equals("writer")){
				totalSql += " AND m.mnickNm LIKE CONCAT('%',?,'%')";
			}
		}

		if(subSearchAlign != null){
			if(subSearchAlign.equals("zone_Seoul")){
				totalSql += " AND btype = '캠핑지역_서울' ";
			}else if(subSearchAlign.equals("zone_GG")){
				totalSql += " AND btype = '캠핑지역_경기권' ";
			}else if(subSearchAlign.equals("zone_GW")){
				totalSql += " AND btype = '캠핑지역_강원권' ";
			}else if(subSearchAlign.equals("zone_CC")){
				totalSql += " AND btype = '캠핑지역_충청권' ";
			}else if(subSearchAlign.equals("zone_YN")){
				totalSql += " AND btype = '캠핑지역_영남권' ";
			}else if(subSearchAlign.equals("zone_HN")){
				totalSql += " AND btype = '캠핑지역_호남권' ";
			}else if(subSearchAlign.equals("zone_JJ")){
				totalSql += " AND btype = '캠핑지역_제주' ";
			}
		}

		psmt = conn.prepareStatement(totalSql);
		
		if(searchType != null && (searchType.equals("title") || searchType.equals("writer"))){
			psmt.setString(1, searchValue);
		}
		
		rs = psmt.executeQuery();
		
//		페이징
		int totalCnt = 0;
		if(rs.next()){
			totalCnt = rs.getInt("cnt");
		}
		
		if(rs != null) rs.close();
		if(psmt != null) psmt.close();
		
//		페이징VO 생성
		pagingVO = new PagingVO(nowPage, totalCnt, 10);
		
		rs = null;
		
//		게시글 list 쿼리문
		String sql = " SELECT b.*, m.mnickNm, "
				   + " (SELECT COUNT(*) FROM reply r WHERE r.bno = b.bno) AS rcnt"
				   + "   FROM board b"
				   + "  INNER JOIN member m"
				   + "     ON b.mno = m.mno"
				   + "  WHERE btype LIKE '캠핑지역%'";
		
		if(subSearchAlign != null){
			if(subSearchAlign.equals("zone_Seoul")){
				sql += " AND btype = '캠핑지역_서울' ";
			}else if(subSearchAlign.equals("zone_GG")){
				sql += " AND btype = '캠핑지역_경기권' ";
			}else if(subSearchAlign.equals("zone_GW")){
				sql += " AND btype = '캠핑지역_강원권' ";
			}else if(subSearchAlign.equals("zone_CC")){
				sql += " AND btype = '캠핑지역_충청권' ";
			}else if(subSearchAlign.equals("zone_YN")){
				sql += " AND btype = '캠핑지역_영남권' ";
			}else if(subSearchAlign.equals("zone_HN")){
				sql += " AND btype = '캠핑지역_호남권' ";
			}else if(subSearchAlign.equals("zone_JJ")){
				sql += " AND btype = '캠핑지역_제주' ";
			}
		}
		

//		제목, 작성자 검색
		if(searchType != null){
			if(searchType.equals("title")){
				sql += " AND btitle LIKE CONCAT('%',?,'%') ";
			}else if(searchType.equals("writer")){
				sql += " AND m.mnickNm LIKE CONCAT('%',?,'%') ";
			}
		}

//		option value별 게시글 정렬
		if(searchAlign != null){
			if(searchAlign.equals("late")){
				sql += " ORDER BY bno DESC ";
			}else if(searchAlign.equals("hit")){
				sql += " ORDER BY bhit DESC ";
			}
		}

		sql += " LIMIT ?, ? ";
		
		psmt = conn.prepareStatement(sql);
		
		if(searchType != null && (searchType.equals("title") || searchType.equals("writer"))){
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
<title>캠핑지역 게시판</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/list.css" type="text/css" rel="stylesheet">
</head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<body>
<%@ include file="/include/header.jsp" %>
	<div class="container">
<%@ include file="/include/nav.jsp" %>
	<section>
<!-- 게시판페이지 이름 -->
		<h2>캠핑지역 게시판</h2>
		<div class="frms">
<!-- 게시글 정렬폼 -->
		<form name="frm1" action="zoneList.jsp" method="get" id="frm1">
<!-- 게시글 정렬종류 -->
			<select name="searchAlign" onchange="document.frm1.submit()" id="select">
				<option value="late" 
					<%if(searchAlign != null && 
						searchAlign.equals("late"))out.print("selected"); 
					%>>최신순
				</option>
				<option value="hit"
					<%if(searchAlign != null && 
						searchAlign.equals("hit"))out.print("selected"); 
					%>>인기순
				</option>

			</select>
			<select name="subSearchAlign" onchange="document.frm1.submit()">
				<option value="zone_Seoul" 
					<%if(subSearchAlign != null && 
							subSearchAlign.equals("zone_Seoul"))out.print("selected"); 
					%>>서울
				</option>
				<option value="zone_GG" 
					<%if(subSearchAlign != null && 
							subSearchAlign.equals("zone_GG"))out.print("selected"); 
					%>>경기권
				</option>
				<option value="zone_GW" 
					<%if(searchAlign != null && 
							subSearchAlign.equals("zone_GW"))out.print("selected"); 
					%>>강원권
				</option>
				<option value="zone_CC" 
					<%if(subSearchAlign != null && 
							subSearchAlign.equals("zone_CC"))out.print("selected"); 
					%>>충청권
				</option>
				<option value="zone_YN" 
					<%if(subSearchAlign != null && 
							subSearchAlign.equals("zone_YN"))out.print("selected"); 
					%>>영남권</option>
				<option value="zone_HN" 
					<%if(subSearchAlign != null && 
							subSearchAlign.equals("zone_HN"))out.print("selected"); 
					%>>호남권</option>
				<option value="zone_JJ" 
					<%if(subSearchAlign != null && 
							subSearchAlign.equals("zone_JJ"))out.print("selected"); 
					%>>제주
				</option>
			</select>
		</form>
<!-- 게시글 검색폼 -->
		<form name="frm2" action="zoneList.jsp" method="get" id="frm2">
			<select name="searchType">
				<option value="title" 
					<%if(searchType != null && 
						searchType.equals("title")) out.print("selected"); 
					%>>제목
				</option>
				<option value="writer" 
					<%if(searchType != null && 
						searchType.equals("writer")) out.print("selected"); 
					%>>작성자
				</option>
			</select>
<!-- 게시글 검색칸 -->
			<input type="text" name="searchValue" 
				value="<%if(searchValue != null) out.print(searchValue); %>">
			<input type="hidden" name="searchAlign"
				 value="<%if(searchAlign != null) out.print(searchAlign); %>">
			 <input type="hidden" name="subSearchAlign"
			 value="<%if(subSearchAlign != null) out.print(subSearchAlign); %>">
			<button class="searchBtn">검색</button>
		</form>
		</div>
<!-- 게시글 리스트 -->
		<table class="listTable">
<!-- 테이블 헤드 -->
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
<!-- 게시글 목록 -->
		<tbody>
<%
			if(!rs.next()){
%>
			<tr><td id="td" colspan="6">아무것도 검색되지 않았습니다.</td></tr>
<%	
			}else{			
			while(true){
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
					<!-- 제목 클릭시 view.jsp 이동 및 blist 파라미터 넘기기 -->
					<a href="<%=request.getContextPath()%>
							/board/view.jsp?bno=<%=bno%>&blist=zone"><%=btitle %></a>
					<span id="replyspan">[<%=rs.getInt("rcnt") %>]</span>
				</td>
				<td><%=mnickNm %></td>
				<td><%=brdate %></td>
				<td><%=bhit %></td>
			</tr>
<%
				if(!rs.next()){
					break;
					}
				}
			}
%>
		</tbody>
		</table>
<!-- 글쓰기 버튼 -->
<%
	if(member != null){
%>
	<div class="btnDiv">
	<!-- 글쓰기 버튼: blist파라미터 넘기기 -->
		<button class="writeBtn" 
		 onclick="location.href='<%=request.getContextPath()%>/board/write.jsp?blist=zone'">글쓰기
		</button>
	</div>
<% 
	}
%>
<!-- 페이징 영역 -->
	<div class="paging">
<%
	if(pagingVO.getStartPage() > pagingVO.getCntPage()){
%>
		<span class="paging">
		<a href="zonelist.jsp?nowPage=<%=pagingVO.getStartPage()-1%>
					<%if(subSearchAlign!=null && !subSearchAlign.equals("")) out.print("&subSearchAlign="+subSearchAlign);
					if(searchAlign!=null && !searchAlign.equals("")) out.print("&searchAlign="+searchAlign);
					if(searchType!=null && !searchAlign.equals("")) out.print("&searchType="+searchType);
					if(searchValue!=null && !searchAlign.equals("")) out.print("&searchValue="+searchValue);
					%>" class="pluspage">이전</a>
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
				<span class="pagingnum">
				<a href="zoneList.jsp?nowPage=<%=i%>
					<%if(subSearchAlign!=null && !subSearchAlign.equals("")) out.print("&subSearchAlign="+subSearchAlign);
					if(searchAlign!=null && !searchAlign.equals("")) out.print("&searchAlign="+searchAlign);
					if(searchType!=null && !searchAlign.equals("")) out.print("&searchType="+searchType);
					if(searchValue!=null && !searchAlign.equals("")) out.print("&searchValue="+searchValue);
					%>"><%=i %></a>
				</span>
<%
		}
	}
	
	if(pagingVO.getEndPage() < pagingVO.getLastPage()){
%>
		<span class="paging">
		<a href="zonelist.jsp?nowPage=<%=pagingVO.getStartPage()+1%>
				<%if(subSearchAlign!=null && !subSearchAlign.equals("")) out.print("&subSearchAlign="+subSearchAlign);
					if(searchAlign!=null && !searchAlign.equals("")) out.print("&searchAlign="+searchAlign);
					if(searchType!=null && !searchAlign.equals("")) out.print("&searchType="+searchType);
					if(searchValue!=null && !searchAlign.equals("")) out.print("&searchValue="+searchValue);
					%>" class="pluspage">다음</a>
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