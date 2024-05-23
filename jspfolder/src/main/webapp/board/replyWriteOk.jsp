<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Vo.Member" %>
<%

	request.setCharacterEncoding("UTF-8");

//[get방식 차단]
	String method = request.getMethod();
	if(method.equals("GET")){
		response.sendRedirect("/jspfolder/index.jsp");
	}
//자바빈즈: 댓글 reply (NPE가 발생할수 있는 취약점)
%>
<jsp:useBean id="reply" class="Vo.Reply"/>
<jsp:setProperty name="reply" property="*"/>
<%	
	//(게시글 mno필요)
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
			
				
			//SQL
			String sql = " INSERT INTO reply(bno, mno, rcontent, rrdate)"
						+" VALUES(?,?,?,now())";
			
			psmt=conn.prepareStatement(sql);
			
			psmt.setInt(1,reply.getBno());
			psmt.setInt(2,reply.getMno());
			psmt.setString(3,reply.getRcontent());
			
			int result = psmt.executeUpdate();	
			
			//(삽입됐다면) => 작성자:댓글내용 출력
			if(result>0){	
			
				/*
					댓글이 등록된 후에는 rno를 따로 가지고 있지 않기 때문에
					현재 삭제버튼에 제공되고 있는 rno값은 객체의 초기값 0이 전달되고 있다.
					
					정상작동을 위하여 현재 등록된 댓글의 PK값을 가져와 reply객체의 
					rno필드에 값을 추가하는 로직이 필요하다
				*/
				
				if(psmt != null) psmt.close();
				
				//max를 쓰는 이유는 auto_increment기떄문
				//현재 등록된 댓글의 rno(PK)는 rno의 최댓값(max(rno))
				//현재 등록된 댓글의 PK값(rno)을 가져와 reply객체의 rno필드에 값을 추가 
				sql = "select rno, rrdate from reply where rno = (SELECT max(rno) from reply) ";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				
				//rno구하기
				int rno=0;
				String rrdate = "";
				if(rs.next()){
					rno=rs.getInt("rno");
					rrdate = rs.getString("rrdate");
				}
				
				if(rs != null) rs.close();
				if(psmt != null) psmt.close();
				
				// 대댓글 구현시 댓글에서 해야하는것 - rgroup에 rno 넣기
				sql =  " update reply set rgroup= ? where rno =? ";
				
				psmt=conn.prepareStatement(sql);
				
				psmt.setInt(1,rno);
				psmt.setInt(2,rno);
				
				psmt.executeUpdate();	
				
				
				
				
				
				
				//출력내용(아래)
			%>
				<div class="replyRow">
					<%=member.getMnickNm() %>: 
					<span>
						<%=reply.getRcontent() %>
						</span>
					<span>
						<button onclick="modifyFn(this,<%=rno%>)">수정</button>
						<button onclick="replyDelFn(<%=rno%>, this)">삭제</button>
					</span>
					<span><%=rrdate%></span>
					<span>
						<button onclick="rereplyInput(this,<%=rno%>,<%=reply.getBno()%>)">대댓글</button>
					</span>
				</div>	
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