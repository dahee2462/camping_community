<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Vo.Member" %>
<%@ page import="java.sql.*" %>
<%
	
	String mid = request.getParameter("mid");
	String mpw = request.getParameter("mpw");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	
	boolean isLogin = false;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,pass);
		System.out.println("연결성공!");
		
		String sql = " SELECT mid, mpw, mno, mname, mnickNm"
				   + "   FROM member"
				   + "  WHERE mid = ?"
				   + "    AND mpw = md5(?)";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, mid);
		psmt.setString(2, mpw);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			Member member = new Member();
			member.setMno(rs.getInt("mno"));
			member.setMid(rs.getString("mid"));
			member.setMname(rs.getString("mname"));
			member.setMnickNm(rs.getString("mnickNm"));
			
			session.setAttribute("login", member);
			isLogin = true;
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
	
	if(isLogin){
%>
		<script>
			alert("로그인 되었습니다.");
			location.href="<%=request.getContextPath()%>";
		</script>		
<%
	}else{
%>
		<script>
			alert("아이디와 비밀번호를 확인하세요.");
			location.href="login.jsp";
		</script>		
<%
	}
	
%>