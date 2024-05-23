<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="regular.Regular"%>
<%@ page import="Vo.*" %>	
<%
	String method = request.getMethod();
	if(method.equals("GET")){
		response.sendRedirect("join.jsp");
	}

//	사용자가 입력하여 전달한 아이디 값이 DB에 있는지 확인
	String id = request.getParameter("id"); // join.jsp id 받아오기
	
//	Connection은 conn이 null값으로 변수 생성
	Connection conn = null;
// 	PreparedStatement는 psmt가 null 값으로 변수 생성
	PreparedStatement psmt= null;
//	Result는 rs가 null 값으로 변수 생성
	ResultSet rs = null;
//	url은 mysql에 있는 localhost의 campingWeb Schemas로 연결 및 계정과 비밀번호 입력
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	
	
	try{
// 	masql drivermanager로 접속
		Class.forName("com.mysql.cj.jdbc.Driver");
//	conn 변수에 url과 계정 비밀번호 대입
		conn = DriverManager.getConnection(url,user,pass);
//	sql query문 작성
		String sql = " SELECT count(*) AS cnt "
				   + "   FROM member "
				   + "  WHERE mid = ?";

		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		
		rs = psmt.executeQuery();
		
		int cnt = 1;
		
		if(rs.next()){
			cnt = rs.getInt("cnt");
		}
//	cnt = -1 은 null, 빈문자열일때 		
		if(id == null || (id != null && id.equals(""))){
			cnt = -1;
// isID는 join.js id 정규식이랑 똑같음.			
		}else if(!Regular.isId(id)){
			cnt = -2;
		}
			
		out.print(cnt);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
%>