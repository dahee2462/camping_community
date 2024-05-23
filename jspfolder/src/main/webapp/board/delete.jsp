<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Vo.Member" %>
<%	
	//**삭제: 반드시 POST
		//타입체크:GET방식으로 접근하는것 방지
	String method = request.getMethod();
	if(method.equals("GET")){	
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='<%= request.getContextPath() %>/index.jsp';
		</script>
	<%
	}
	//로그인 하지 않고 들어왔을때 차단 (버튼이 보이지 않아도 post방식으로 보내는 방법 있음)
	int mno=0;
	Member member = (Member)session.getAttribute("login");
	if(member != null){
		mno = member.getMno();
	}
	if(mno ==0){
		%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="<%= request.getContextPath() %>/index.jsp";
		</script>
		<%
	}
	//bno 없이 들어왔을때 차단
	String bnoParam = request.getParameter("bno");
	//null체크->빈칸체크
	int bno=0;
	if(bnoParam != null && !bnoParam.equals("")){
		bno = Integer.parseInt(bnoParam);
	}
	if(bno ==0 ){
		%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="<%= request.getContextPath() %>/index.jsp";
		</script>
		<%
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
	
	//파라미터 받기
	String btype = request.getParameter("btype");
	Connection conn = null;	
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	

	//결과를 담을 변수 설정
	int result =0;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn=DriverManager.getConnection(url,user,pass);
		// 세션의 맴버 mno와 현재 bno의 mno가 일치하는 지 확인해야함.
		// 확인하는 이유: 주소를 알고 파라미터를 알면 내가 작성하지 않더라도 삭제 요청을 보낼 수 있다.
		// 예외처리 - 관리자일경우 세션의 맴버 mno와 현재 bno의 mno가 달라도 삭제가능하도록 해야한다.
		String sql =" select mno, btype from board where bno = ?";
		
		psmt=conn.prepareStatement(sql);
		psmt.setInt(1,bno);
		rs = psmt.executeQuery();
		
		if(!rs.next() || member == null){
			response.sendRedirect("/jspfolder/index.jsp");
			//존재하지 않는 게시물 삭제 요청 - 비정상 접근 차단
		}else{
			if(!member.getMid().equals("admin") && rs.getInt("mno") != member.getMno()){ 
				// 관리자가 아닐경우, 세션의 맴버 mno와 현재 bno의 mno가 불일치하면 비정상 접근 차단
					response.sendRedirect("/jspfolder/index.jsp");
			}else if(rs.getString("btype").equals("공지사항") && !member.getMid().equals("admin")){ 
				// 만약 현재 가져온 bno의 btype값이 공지사항일때, 세션의 맴버 mid가 admin이 아니면 차단 및 코드 미실행
					response.sendRedirect("/jspfolder/index.jsp");
			}else{
				if(psmt != null) psmt.close();
				if(rs != null) rs.close();
				
				sql = "DELETE from board WHERE bno = ?";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1,bno);
				result = psmt.executeUpdate();	
		
			}
		
		}
				
				
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}
	
	
	
	
	//리다이렉트
	if(result >0){ //삭제완료시
		%>
		<script>
			alert("삭제가 완료되었습니다.");
			location.href='<%=request.getContextPath()%>/board/connectList.jsp?blist=<%=blist%>';
		</script>
		<%
		}else{
		%>
		<script>
			alert("삭제가 완료되지 않았습니다.");
			location.href='<%=request.getContextPath()%>/board/connectList.jsp?blist=<%=blist%>';
		</script>
		<%
		}
	
%>