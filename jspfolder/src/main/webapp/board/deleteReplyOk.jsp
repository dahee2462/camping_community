<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Vo.*" %>
<%	
	//[get방식 차단]
	String method = request.getMethod();
	if(method.equals("GET")){
		response.sendRedirect("/jspfolder/index.jsp");
	}
	Member member = (Member)session.getAttribute("login");
	
	//rno
	String rnoParam = request.getParameter("rno");
	
	int rno = 0;
	//null체크 -> 빈칸체크
	if(rnoParam != null && !rnoParam.equals("")){
		rno=Integer.parseInt(rnoParam);
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
		String sql =" select mno, bno, isAllChildDelyn, rgroup, parentrno from reply where rno = ?";
		
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
				
				int bno = rs.getInt("bno");
				int isAllChildDelyn = rs.getInt("isAllChildDelyn");
				int rgroup = rs.getInt("rgroup");
				int parentrno = rs.getInt("parentrno");
				
				
				if(rs != null) rs.close();
				if(psmt != null) psmt.close();
				
			
				//SQL
				sql = "update reply set rdelyn = 1 where rno = ? ";
				
				psmt=conn.prepareStatement(sql);
				
				psmt.setInt(1,rno);
				
				//삭제되는 결과행수 반환
				int result = psmt.executeUpdate();	
				
				if(psmt != null) psmt.close();
				if(rs != null) rs.close();
				
				if(result>0){	//삭제됐다면
					out.print("SUCCESS");
				}else{
					out.print("FAIL");
				}
				
				//대댓글 삭제 로직
				//자신의 ischildalldelyn = 1일때
				//모든 형제의 delyn=1이고 ischildalldelyn= 1이면 부모의 ischildalldelyn = 1
				//모든 부모에 형제의 delyn=1이고 ischildalldelyn= 1이면 조부모의 ischildalldelyn = 1
				//이렇게 최상위댓글까지 올라감
				while(true){
					if(isAllChildDelyn==1){
						//모든 형제의 delyn=1이고 ischildalldelyn= 1일때 -> rs.next()가 false
						sql = " select rdelyn,isAllChildDelyn from reply "+
							 " where (bno = ? && rgroup = ? && parentrno = ?) "+
							 " && (rdelyn=0 || isAllChildDelyn=0) ";
					
						psmt=conn.prepareStatement(sql);
						
						psmt.setInt(1,bno);
						psmt.setInt(2,rgroup);
						psmt.setInt(3,parentrno);
						
						rs = psmt.executeQuery();
						
						if(!rs.next()){
							
							if(rs != null) rs.close();
							if(psmt != null) psmt.close();
							
							//부모의 ischildalldelyn = 1 로 변경
							sql = " update reply set isAllChildDelyn = 1 where rno = ? ";
							psmt=conn.prepareStatement(sql);
							psmt.setInt(1,parentrno);
							psmt.executeUpdate();	
							
							
							if(psmt != null) psmt.close();
							//부모의 parentrno가져와서 rno 와 parentrno 갱신
							sql = " select parentrno from reply where rno = ? ";
							psmt=conn.prepareStatement(sql);
							psmt.setInt(1,parentrno);
							
							rs = psmt.executeQuery();
							
							rno = parentrno;
							if(rs.next()){
								parentrno = rs.getInt("parentrno");
							}
							
							if(rs != null) rs.close();
							if(psmt != null) psmt.close();
							
							//최상위댓글이면 끝
							if(parentrno==0){	
								break;
							}
							
						//(모든 형제의 delyn=1이고 ischildalldelyn= 1)이 아닐때
						}else{
							
							if(rs != null) rs.close();
							if(psmt != null) psmt.close();
							
							break;
						}
					//자식중에 삭제되지 않은것이 있다면 끝
					}else{
						break;
					}
				}
				
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
%>