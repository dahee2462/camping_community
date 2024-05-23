<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Vo.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<%	
	
	

	Member member = (Member)session.getAttribute("login");
	
	String blist = request.getParameter("blist");
	//null체크를 했어도 아래에서 메소드 사용시마다 널체크 해야함.
	if(blist==null){
		%>
		<script>
			alert("잘못된 접근입니다");
			location.href="<%= request.getContextPath() %>/index.jsp";
		</script>
		<%
	}
	String bnoParam = request.getParameter("bno");
	
	int bno=0;
	// 넘버포맷익셉션 막는 예외처리
	if(bnoParam != null && !bnoParam.equals("")){
		bno = Integer.parseInt(bnoParam);
	}else{
		%>
		<script>
			alert("잘못된 접근입니다");
			location.href="<%= request.getContextPath() %>/index.jsp";
		</script>
		<%
	}
	
	int mno =0;
	if(member!=null){
		mno= member.getMno();
	}
	
	
	
	
	
	//이전글 다음글
	int prebno=bno , nextbno=bno;
	String prebnoTitle ="", nextbnoTitle=""; 
	
	
	Connection conn = null;	
	PreparedStatement psmt = null;
	ResultSet rs = null;
	String url = "jdbc:mysql://localhost:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	
	//sql의 결과 행을 담을 객체 생성(선택)
	Board board = new Board();
	
 	//[첨부파일] 첨부파일목록 담을 객체
	List<Uploadfile> flist = new ArrayList<Uploadfile>();
	
	//[댓글] 댓글목록을 담을 객체
	List<Reply> rlist = new ArrayList<Reply>(); 
	
	try{
		//[조회수]
		//쿠키를 사용하여 게시글 무한증식 방지
		
		
		//1. 쿠키목록 가져오기
		boolean isBnoCookie = false;
		//2. 쿠키배열 생성
		Cookie[] cookies = request.getCookies();
		//3. 쿠키 원소들에 접근
		for(Cookie tempCookie : cookies){

			if(tempCookie.getName().equals("board"+bno)){
				isBnoCookie = true;
				break;	
			}
		}
		
		
		
		//4. 쿠키굽기			
		if(!isBnoCookie){
			//1)쿠키생성()
			Cookie cookie = new Cookie("board"+bno,"ok");	
			cookie.setMaxAge(60*60*24);	
			//2)쿠키원소추가
			response.addCookie(cookie);
		}
		
		
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn=DriverManager.getConnection(url,user,pass);
		
		String sql = "";
		
		//[조회수]
		if(!isBnoCookie){
			
			//1. 조회수 업데이트
			sql = "UPDATE board"
					+" SET bhit = bhit +1"
					+" WHERE bno = ?";
				
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1,bno);	//파라미터 bno임
			
			psmt.executeUpdate();
			
			if(psmt != null) psmt.close();
		}
		
		
		
		
		//2. [게시글]
		sql = "SELECT b.*, m.mnickNm "
				+" FROM board b"
				+" INNER JOIN member m "
				+" ON b.mno = m.mno "
				+" WHERE b.bno = ?";

		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, bno);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			board.setBno(rs.getInt("bno"));
			board.setBtitle(rs.getString("btitle"));
			board.setMno(rs.getInt("mno"));
			board.setMnickNm(rs.getString("mnickNm"));
			board.setBrdate(rs.getString("brdate"));
			board.setBcontent(rs.getString("bcontent"));
			board.setBtype(rs.getString("btype"));
			board.setBhit(rs.getInt("bhit"));
			board.setBlike(rs.getInt("blike"));
		}
		
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
		
		//[첨부파일]
		sql = "SELECT * FROM uploadfile WHERE bno = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, bno);
		
		rs = psmt.executeQuery();
		
		while(rs.next()){
			//첨부파일 객체 생성
			Uploadfile uf = new Uploadfile();
			
			uf.setFno(rs.getInt("fno"));
			uf.setBno(rs.getInt("bno"));
			uf.setFrealNm(rs.getString("frealNm"));
			uf.setForiginNm(rs.getString("foriginNm"));
			uf.setFrdate(rs.getString("frdate"));
			
			//첨부파일 목록변수에 첨부파일원소 추가
			flist.add(uf);
		}
		
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
		
 		//[댓글] 전체게시글의 댓글
		sql = "SELECT r.*, m.mnickNm, m.mno "
				+" from reply r"
				+" inner join member m"
				+" on r.mno = m.mno"
				+" where r.bno = ? order by rgroup desc, rorder asc ";
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, board.getBno());
		
		rs = psmt.executeQuery();
		
		while(rs.next()){
			//댓글 객체 생성
			Reply reply = new Reply();
			
			reply.setRno(rs.getInt("rno")); 
			reply.setBno(rs.getInt("bno"));
			reply.setMno(rs.getInt("mno"));
			reply.setMnickNm(rs.getString("mnickNm"));
			reply.setRcontent(rs.getString("rcontent"));
			reply.setRrdate(rs.getString("rrdate"));
			reply.setRdepth(rs.getInt("rdepth"));
			reply.setRdelyn(rs.getInt("rdelyn"));
			reply.setParentrno(rs.getInt("parentrno"));
			reply.setIsAllChildDelyn(rs.getInt("isAllChildDelyn"));
			
			//댓글 목록변수에 댓글원소객체 추가
			rlist.add(reply);
		} 
		
		//이전글 다음글 
		String preSql = "select bno,btitle from board where bno < ?  ";
		String nextSql = "select bno,btitle from board where bno > ?  ";
		if(blist !=null){
			preSql += " && "; nextSql += " && ";
			if(blist.equals("notice")){
				preSql += " btype = '공지사항' "; nextSql += " btype = '공지사항' ";
			}else if(blist.equals("hot")){
				preSql += " (btype = '자유게시판' or btype like concat('캠핑장비','%') or  btype like concat('캠핑지역','%'))  "; 
				nextSql += " (btype = '자유게시판' or btype like concat('캠핑장비','%') or  btype like concat('캠핑지역','%'))  ";
			}else if(blist.equals("free")){
				preSql += " btype = '자유게시판' "; nextSql += " btype = '자유게시판' ";
			}else if(blist.equals("zone")){
				preSql += " btype like concat('캠핑지역','%') "; nextSql += " btype like concat('캠핑지역','%') ";
			}else if(blist.equals("zone_Seoul")){
				preSql += " btype = '캠핑지역_서울' "; nextSql += " btype = '캠핑지역_서울' ";
			}else if(blist.equals("zone_CC")){
				preSql += " btype = '캠핑지역_충청권' "; nextSql += " btype = '캠핑지역_충청권' ";
			}else if(blist.equals("zone_GG")){
				preSql += " btype = '캠핑지역_경기권' "; nextSql += " btype = '캠핑지역_경기권' ";
			}else if(blist.equals("zone_GW")){
				preSql += " btype = '캠핑지역_강원권' "; nextSql += " btype = '캠핑지역_강원권' ";
			}else if(blist.equals("zone_HN")){
				preSql += " btype = '캠핑지역_호남권' "; nextSql += " btype = '캠핑지역_호남권' ";
			}else if(blist.equals("zone_JJ")){
				preSql += " btype = '캠핑지역_제주' "; nextSql += " btype = '캠핑지역_제주' ";
			}else if(blist.equals("zone_YN")){
				preSql += " btype = '캠핑지역_영남권' "; nextSql += " btype = '캠핑지역_영남권' ";
			}else if(blist.equals("gear")){
				preSql += " btype like concat('캠핑장비','%') "; nextSql += " btype like concat('캠핑장비','%') ";
			}else if(blist.equals("gear_Tent")){
				preSql += " btype = '캠핑장비_텐트' "; nextSql += " btype = '캠핑장비_텐트' ";
			}else if(blist.equals("gear_Bad")){
				preSql += " btype = '캠핑장비_침낭' "; nextSql += " btype = '캠핑장비_침낭' ";
			}else if(blist.equals("gear_Chair")){
				preSql += " btype = '캠핑장비_의자' "; nextSql += " btype = '캠핑장비_의자' ";
			}else if(blist.equals("gear_Fire")){
				preSql += " btype = '캠핑장비_화기' "; nextSql += " btype = '캠핑장비_화기' ";
			}else if(blist.equals("gear_Car")){
				preSql += " btype = '캠핑장비_차박' "; nextSql += " btype = '캠핑장비_차박' ";
			}else if(blist.equals("attend")){
				preSql += " btype = '출석체크' "; nextSql += " btype = '출석체크' ";
			}else if(blist.equals("QnA")){
				preSql += " btype = 'QnA' "; nextSql += " btype = 'QnA' ";
			}else{
				preSql += " (btype = '자유게시판' or btype like concat('캠핑장비','%') or  btype like concat('캠핑지역','%') or btype='공지사항') ";
				nextSql += " (btype = '자유게시판' or btype like concat('캠핑장비','%') or  btype like concat('캠핑지역','%') or btype='공지사항') ";
			}
		}
		preSql += " order by bno desc limit 1 ";
		nextSql += " order by bno limit 1 ";
		
		//이전글 bno 받아오기
		psmt = conn.prepareStatement(preSql);
		psmt.setInt(1, board.getBno());
		
		rs = psmt.executeQuery();
		if(rs.next()){
			prebno = rs.getInt("bno");
			prebnoTitle = rs.getString("btitle");
		}
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
		
		//다음글 bno 받아오기
		
		psmt = conn.prepareStatement(nextSql);
		psmt.setInt(1, board.getBno());
		
		rs = psmt.executeQuery();
		if(rs.next()){
			nextbno = rs.getInt("bno");
			nextbnoTitle = rs.getString("btitle");
		}
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}

%>

<meta charset="UTF-8">
<title>게시글 상세보기</title>
<link href="<%=request.getContextPath() %>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/view.css" type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/js/jquery-3.7.1.min.js"></script>
<script src="<%=request.getContextPath() %>/js/view.js"></script>
</head>
<body>
	<%@ include file="/include/header.jsp" %>
	<div class="container">
	<%@ include file="/include/nav.jsp" %>
	<section>
		<h2 class="hidden">게시글 상세보기</h2>
		<table class="viewTable" border="1" >
			<tbody>
				<tr>
					<th>작성자</th>
					<td><%=board.getMnickNm() %></td>
					<th>등록일</th>
					<td><%=board.getBrdate()%></td>
					<th>조회수</th>
					<td><%= board.getBhit()%></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><%=board.getBtitle() %></td>
					<th>카테고리</th>
					<td><%=board.getBtype() %></td>
				</tr>
				<tr>
					<td colspan="6">
					<div><%=board.getBcontent() %></div>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="5">
					<%
						for(Uploadfile tempf: flist){
							if(tempf.getForiginNm() != null){
					%>		
							<a href="download.jsp?frealNm=<%=tempf.getFrealNm()%>&foriginNm=<%=tempf.getForiginNm()%>">
								<%= tempf.getForiginNm()%>
							</a><br>
					<%
							}
						}
					%> 
					</td>
				</tr>
				<tr>
					<td colspan="6"> <a href="view.jsp?bno=<%=nextbno%>&blist=<%=blist%>">다음글 ▲ <%=nextbnoTitle %></a></td>
				</tr>
				<tr>
					<td colspan="6"> <a href="view.jsp?bno=<%=prebno%>&blist=<%=blist%>">이전글 ▼ <%=prebnoTitle %></a> </td>
				</tr>
			</tbody>
		</table>
		<button onclick="connectList()" class="viewBtn">목록</button>
		
		<div id="writeBtns">
		<%	// 로그인한 유저가 쓴 게시글에서만 수정, 삭제 버튼 노출 , 관리자
		if(member != null && (member.getMno() == board.getMno() ||  member.getMid().equals("admin"))){
		%>
			<button onclick="location.href='modify.jsp?bno=<%=board.getBno()%>&blist=<%=blist%>'" class="viewBtn">수정</button>
			<button onclick="delFn()" class="viewBtn">삭제</button>
			<script>
				function delFn(){
					let isDel = confirm("정말 삭제하시겠습니까?");
							
					if(isDel){
						document.delfrm.submit();
					}
				}
			</script>
		<%
		}
		
		
		%>
		<form name="delfrm" action="delete.jsp" method="post">
			<input type="hidden" name="bno" value="<%=bno%>">
			<input type="hidden" name="blist" value="<%=blist %>">
			<input type="hidden" name="btype" value="<%=board.getBtype() %>">
		</form>
		</div>	
		
		<!-- 좋아요영역 -->
		
		<form name="likefrm">
			<input type="hidden" name="bno" value="<%=bno%>">
			<input type="hidden" name="mno" value="<%if(member!=null) out.print(member.getMno()); %>">
			<div id="likeWrap">
				<img id="likeWrapImg" src="<%=request.getContextPath() %>/images/like.png" alt="좋아요" width="80px" onclick="likeInsertFn(this)">
				<div id="likeCount"><%=board.getBlike() %></div>
			</div>
		</form>
		
		
		

		<!-- 댓글영역 -->
		<form name="replyfrm" class="replyfrm" >
			<input type="hidden" name="bno" value="<%=board.getBno() %>">
			<input type="text" name="rcontent">
			<button type="button" onclick="replyInsertFn()">댓글</button>
		</form>
		
		<div class="replyArea">
	<%
		
		for(Reply reply: rlist){
	%>
			<div class="replyRow" style="margin-left:<%=reply.getRdepth()*40+"px"%>">
			<%
				//댓글의 삭제여부 확인
				if(reply.getRdelyn()==0){
			%>
					<%=reply.getMnickNm() %> : 
					<span>
						<%=reply.getRcontent() %>
					</span>
					<%
		
					//로그인이 되어있는 상태에서, 자기가 작성한 댓글만 보이는 제어문, 관리자
					
					if(member != null && (reply.getMno() == member.getMno()||member.getMid().equals("admin"))){
						%>
						<span>
							<button onclick="modifyFn(this,<%=reply.getRno()%>)">수정</button>
							<button onclick="replyDelFn(<%=reply.getRno()%>, this)">삭제</button>
						</span>
						<%
					}
					
					%>
					
					<span><%=reply.getRrdate() %></span>
					
					<%
					// [대댓글 버튼]
					if(member != null){
					%>
						<span>
							<button onclick="rereplyInput(this,<%=reply.getRno()%>,<%=bno%>)">대댓글</button>
						</span>
					<%
					}
				}else{
					if(reply.getIsAllChildDelyn() == 0){
					%>
						<div>삭제된 댓글입니다.</div>
					<%
					}	
				}
					
					//rereplyinput이 생성되는곳
					%>
			</div>
			<%
			
		}	
			//대댓글 생성하는곳
			%>
		</div>
	</section>
	</div>
	<%@ include file="/include/footer.jsp" %>
	<form name="connectfrm" method="get" action="connectList.jsp">
			<input type="hidden" name="blist" value="<%=blist %>">
	</form>
	<script>
		function connectList(){
			document.connectfrm.submit();
		}
	</script>
</body>

</html>

<%
						
%>