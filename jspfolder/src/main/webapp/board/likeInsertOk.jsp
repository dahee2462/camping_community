<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="Vo.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	//[get방식 차단]
	String method = request.getMethod();
	if(method.equals("GET")){
		response.sendRedirect("/jspfolder/index.jsp");
	}
	Member member = (Member)session.getAttribute("login");
	request.setCharacterEncoding("UTF-8");

	//파라미터 가져오기
	String bnoParam = request.getParameter("bno");
	String mnoParam = request.getParameter("mno");
	
	//null체크 -> 빈칸체크
	int bno = 0;
	if(bnoParam != null && !bnoParam.equals("")){
		bno = Integer.parseInt(bnoParam);
	}
	
	int mno = 0;
	if(mnoParam != null && !mnoParam.equals("")){
		mno = Integer.parseInt(mnoParam);
	}
	
	
	Connection conn = null;	
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn=DriverManager.getConnection(url,user,pass);
		
		//쿠키가 있다면 추가하지 않음 
		
		boolean islikeCookie = false;
		
		Cookie[] cookies = request.getCookies();
		
		//로그인을 안했거나 좋아요를 눌렀으면 true
		for(Cookie tempCookie : cookies){
			if(tempCookie.getName().equals(bno+"like"+mno) || mno==0){
				islikeCookie = true;
				break;	
			}
		}
		
		if(islikeCookie){
			if(mno ==0){
				out.print("FAIL");
			}
			out.print("FAIL");
		}else{
		
			//1)쿠키생성()
			Cookie cookie = new Cookie(bno+"like"+mno,"ok");	
			cookie.setMaxAge(60*60*24);	
			//2)쿠키원소추가
			response.addCookie(cookie);
			
			
		
			//SQL
			String sql = "UPDATE board "
						+" SET blike = blike + 1 "
						+" WHERE bno = ?";
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1,bno);
			
			psmt.executeUpdate();
			
			if(psmt != null) psmt.close();
			
			sql = "select blike from board where bno = ? ";
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1,bno);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				out.print(rs.getInt("blike"));
			}
				
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}
%>