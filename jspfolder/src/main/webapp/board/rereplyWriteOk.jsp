<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Vo.Member" %>
<%@page import="org.json.simple.JSONArray" %>
<%@page import="org.json.simple.JSONObject" %>

<%

	request.setCharacterEncoding("UTF-8");

//[get방식 차단]
	String method = request.getMethod();
	if(method.equals("GET")){
		response.sendRedirect("/jspfolder/index.jsp");
	}
//자바빈즈: rno: 부모의 rno, rercontent: 대댓글 내용, bno: 게시글의 bno
%>
<jsp:useBean id="reply" class="Vo.Reply"/>
<jsp:setProperty name="reply" property="*"/>
<%	
	//현재 대댓글 작성자 - (게시글 mno필요)
	Member member = (Member)session.getAttribute("login");

	if(member != null && reply.getBno() != 0 && reply.getRcontent() != null){	//로그인이 되어있고 존재하는 게시글이고 내용이 null이 아닐때
		
		reply.setMno(member.getMno());
		
		Connection conn = null;	
		PreparedStatement psmt = null;
		ResultSet rs = null;
	
		String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
		String user = "cteam";
		String pass ="ezen";
		
	
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(url,user,pass);
			
			int parentrgroup=0; int parentrorder=0; int parentrdepth=0;
			//부모의 group,order,depth 값 찾고,order 실행문 실행하고, 넣기
			String sql = " select rgroup, rorder, rdepth from reply where rno=? ";
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1,reply.getRno());
			rs = psmt.executeQuery();
			
			if(rs.next()){
				parentrgroup = rs.getInt("rgroup");
				parentrorder = rs.getInt("rorder");
				parentrdepth = rs.getInt("rdepth");
			}
			
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			
			
 			//대댓글 - rorder 값 수정 실행문
 			sql = " update reply set rorder = rorder+1 where bno = ? && rgroup = ? && ? < rorder ";
			
 			psmt=conn.prepareStatement(sql);
			
 			psmt.setInt(1,reply.getBno());
 			psmt.setInt(2,parentrgroup);
 			psmt.setInt(3,parentrorder);
			
 			psmt.executeUpdate();	
 			
 			if(rs != null) rs.close();
 			if(psmt != null) psmt.close();
 			
			//SQL
			sql = " INSERT INTO reply(bno, mno, rcontent, rrdate, rgroup, rorder, rdepth, parentrno)"
						+" VALUES(?,?,?,now(),?,?,?,?)";
			
			psmt=conn.prepareStatement(sql);
			
			psmt.setInt(1,reply.getBno());
			psmt.setInt(2,reply.getMno());
			psmt.setString(3,reply.getRcontent());
			psmt.setInt(4,parentrgroup);
			psmt.setInt(5,parentrorder+1);
			psmt.setInt(6,parentrdepth+1);
			psmt.setInt(7,reply.getRno());
			
			int result = psmt.executeUpdate();	
			
			//(삽입됐다면) => rorder값 수정 후 작성자:댓글내용 출력
			if(result>0){	
				
				
				
				if(psmt != null) psmt.close();
	 			if(rs != null) rs.close();
	 			
	 			//부모의 isAllChildDelyn을 0 으로 바꿔야함.
	 			sql = " update reply set isAllChildDelyn = 0 where rno = ? ";
			
	 			psmt=conn.prepareStatement(sql);
				
	 			psmt.setInt(1,reply.getRno());
				
	 			psmt.executeUpdate();	
	 			
	 			if(psmt != null) psmt.close();
	 			if(rs != null) rs.close();
				
				/*
					댓글이 등록된 후에는 rno를 따로 가지고 있지 않기 때문에
					현재 삭제버튼에 제공되고 있는 rno값은 객체의 초기값 0이 전달되고 있다.
					
					정상작동을 위하여 현재 등록된 댓글의 PK값을 가져와 reply객체의 
					rno필드에 값을 추가하는 로직이 필요하다
				*/
				
				
				//max를 쓰는 이유는 auto_increment기떄문
				//현재 등록된 댓글의 rno(PK)는 rno의 최댓값(max(rno))
				//현재 등록된 댓글의 PK값(rno)을 가져와 reply객체의 rno필드에 값을 추가 
				sql = "select rno, rrdate from reply where rno = (SELECT max(rno) from reply);";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				
				//rno구하기
				int rno=0;
				String rrdate = "";
				if(rs.next()){
					rno=rs.getInt("rno");
					rrdate = rs.getString("rrdate");
				}
				
				
				
				
					//출력내용(아래) json방식
				JSONArray jlist = new JSONArray();//[]
				JSONObject jobj = new JSONObject();//{}
				jobj.put("mnickNm",member.getMnickNm());//{"title":"테스트데이터"}
				jobj.put("rcontent",reply.getRcontent());
				jobj.put("rno",rno);
				jobj.put("rrdate",rrdate);
				jobj.put("bno",reply.getBno());
				jobj.put("rdepth",parentrdepth+1);
				jlist.add(jobj);
				%>
				
				
				
				<%=jlist.toJSONString()%>
				
				
						
				<%
				
			}else{ //삽입(댓글등록)이 안됐다면
				out.print("FAIL");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null) conn.close();
			if(psmt != null) psmt.close();
		}
	}else{ //로그인이 안됐다면
		out.print("FAIL");
	}
%>