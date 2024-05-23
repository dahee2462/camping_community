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
	String rcontent = request.getParameter("rcontent");
	String rnoParam = request.getParameter("rno");
	
	//null체크 -> 빈칸체크
	int rno = 0;
	if(rnoParam != null && !rnoParam.equals("")){
		rno = Integer.parseInt(rnoParam);
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
		
		// 세션의 맴버 mno와 현재 bno의 mno가 일치하는 지 확인해야함.
		// 확인하는 이유: 주소를 알고 파라미터를 알면 내가 작성하지 않더라도 삭제 요청을 보낼 수 있다.
		// 예외처리 - 관리자일경우 세션의 맴버 mno와 현재 bno의 mno가 달라도 삭제가능하도록 해야한다.
		String sql =" select mno from reply where rno = ?";
		
		psmt=conn.prepareStatement(sql);
		psmt.setInt(1,rno);
		rs = psmt.executeQuery();
		
		if(!rs.next() || member == null){
			out.print("FAIL");
			
		}else{
			
			if(!member.getMid().equals("admin") && rs.getInt("mno") != member.getMno()){
				// 관리자가 아닐경우, 세션의 맴버 mno와 현재 bno의 mno가 불일치하면 실패
				out.print("FAIL");
			}else{
				
				if(psmt != null) psmt.close();
				if(rs != null) rs.close();
						
			
				//SQL
				sql = "UPDATE reply "
							+" SET rcontent = ? "
							+" WHERE rno = ?";
				
				psmt = conn.prepareStatement(sql);
				
				psmt.setString(1, rcontent);
				psmt.setInt(2,rno);
				
				//수정되는 행수 반환
				int result = psmt.executeUpdate();
				
				if(result>0){ //수정됐다면
					out.print("SUCCESS");
				}else{
					out.print("FAIL");
				}
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}
%>