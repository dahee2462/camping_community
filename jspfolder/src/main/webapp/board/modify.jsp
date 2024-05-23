<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Vo.Board" %>
<%@ page import="Vo.Member" %>
<!DOCTYPE html>
<html>
<head>
<%

	//null체크(잘못된 접근입니다)에서 쓰기위함
	Member member = (Member)session.getAttribute("login");

	//bno
	String bnoParam = request.getParameter("bno");
	
	//null체크->빈칸체크
	int bno=0;
	if(bnoParam != null && !bnoParam.equals("")){
		bno = Integer.parseInt(bnoParam);
	}
	
	String blist = request.getParameter("blist");
	//null체크를 했어도(비정상 접근 차단 이유) 아래에서 메소드 사용시마다 널체크 해야함. if로 전체를 감싸지 않는이상 무조건 아래까지 실행되기 때문.
	if(blist==null){
		%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="<%= request.getContextPath() %>/index.jsp";
		</script>
		<%
	}
	
	Connection conn = null;	
	PreparedStatement psmt = null;
	ResultSet rs = null;
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	
	//sql의 결과 행을 담을 객체 생성(선택)
	Board board = new Board();
	String foriginNm = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn=DriverManager.getConnection(url,user,pass);
		
		//SQL문
		String sql = "SELECT b.*, m.mnickNm, f.foriginNm "
				   + "  FROM (board b INNER JOIN member m ON b.mno = m.mno)"
				   + " left JOIN uploadfile f ON b.bno = f.bno"
				   + " WHERE b.bno = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, bno);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			board.setBno(rs.getInt("bno"));
			board.setBtitle(rs.getString("btitle"));
			board.setMno(rs.getInt("mno"));
			board.setMnickNm(rs.getString("mnickNm"));
			board.setBtype(rs.getString("btype"));
			board.setBcontent(rs.getString("bcontent"));
			board.setBhit(rs.getInt("bhit"));

			foriginNm = rs.getString("foriginNm");
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
	
	//로그인이 안되어있거나 게시글을 쓴 본인이 아니면 뒤로
	// 예외처리- 어드민은 게시글을 쓴 본인이 아니어도 통과
	
	
	if(member == null){
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="<%=request.getContextPath()%>";
		</script>
	<%	
	}else if(member != null && (board.getMno() != member.getMno())){
		if(member.getMid().equals("admin")){
		}else{
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="<%=request.getContextPath()%>";
		</script>
	<%	
		}
	}
%>

<meta charset="UTF-8">
<title>게시글 수정</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/write.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@ include file ="/include/header.jsp" %>
	<div class="container">
	<%@ include file="/include/nav.jsp" %>
	<section>
		<h2 class="hidden">게시글 수정</h2>
		<form name="frm" action="modifyOk.jsp" method="post" enctype="multipart/form-data">
			<!-- hidden으로 bno값 보내기 -->
			<input type="hidden" name="bno" value="<%=board.getBno()%>">
			<input type="hidden" name="blist" value="<%=blist%>">
			<input type="hidden" name="btype" value="<%=board.getBtype()%>">
			
			<table border="1" class="writeTable">
				<tbody>
					<tr>
						<th align="right">제목</th>
						<td><input type="text" name="btitle" value="<%=board.getBtitle() %>"></td>
						<th align="right">카테고리</th>
						<td><%=board.getBtype() %></td>
					</tr>
					<tr>
						<td colspan="4">
							<textarea name="bcontent"><%=board.getBcontent()%></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
						<%
							if(foriginNm != null){
						%>
							<%=foriginNm %> 
						<%
							}
						%>
							<input type="file" name="uploadFile">

						</td>
					</tr>
				</tbody>
			</table>
			<div class="writeBtns">
			<button type="button" 
				onclick="location.href='<%=request.getContextPath()%>/board/connectList.jsp?blist=<%=blist%>'">취소</button>
			<button>저장</button>
			</div>
		</form>
	</section>
	</div>
	<%@ include file ="/include/footer.jsp" %>
</body>
</html>