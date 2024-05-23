<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Vo.*" %>
<%	

	//[get방식 차단]
	String method = request.getMethod();
	if(method.equals("GET")){
		%>
		<script>
			alert("비정상적인 접근입니다.");
			location.href="mypagePw.jsp";
		</script>
		
		<%
	}
	
	request.setCharacterEncoding("UTF-8");
	String checkmpw = request.getParameter("checkmpw");
	
	
	int mno=0;
	Member memberSession = (Member)session.getAttribute("login");
	if(memberSession != null){
		mno = memberSession.getMno();
	}
	if(mno ==0){
		%>
		<script>
			alert("오류가 발생해 메인페이지로 이동합니다.");
			location.href="/jspfolder/index.jsp";
		</script>
		<%
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		
		String sql ="select mno from member where mpw = md5(?) && mno = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,checkmpw);
		psmt.setInt(2,mno);
		rs = psmt.executeQuery();
		
		if(rs.next()){
 			session.setAttribute("isAutFlag",true);
 			session.setMaxInactiveInterval(300);
			
			response.sendRedirect("mypageModify.jsp");

			
		}else{
			%>
				<script>
					alert("비밀번호가 다릅니다.");
					location.href="mypagePw.jsp";
				</script>
				
			<%
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
	

%>