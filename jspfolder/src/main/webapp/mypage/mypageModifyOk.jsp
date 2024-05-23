<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Vo.*" %>
<%@ page import="regular.Regular" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class="Vo.Member" />
<jsp:setProperty name="member" property="*" />
<%
//	[get방식 차단]
	String method = request.getMethod();
	if(method.equals("GET")){
		response.sendRedirect("mypage.jsp");
	}
// 	[비인증 접근 제한] OK 마지막에서 인증해제 해야함
 	if(session.getAttribute("isAutFlag") == null){
 		
		%>
		<script>
			alert("비정상적인 접근입니다.");
			location.href="/jspfolder/index.jsp";
		</script>
		<%
	}else if(!(boolean)session.getAttribute("isAutFlag")){
		%>
		<script>
			alert("비정상적인 접근입니다.");
			location.href="/jspfolder/index.jsp";
		</script>
		<%
		
	}else{
		int sessionMno=0;
		Member memberSession = (Member)session.getAttribute("login");
		if(memberSession != null){
			sessionMno = memberSession.getMno();
		}
		if(sessionMno ==0){
			%>
			<script>
				alert("오류가 발생해 메인페이지로 이동합니다.");
				location.href="/jspfolder/index.jsp";
			</script>
			<%
		}

	Connection conn = null;
	PreparedStatement psmt= null;
	
	
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	String mphone1 = request.getParameter("mphone1");
	String mphone2 = request.getParameter("mphone2");
	String mphone3 = request.getParameter("mphone3");
	String mphone = mphone1+mphone2+mphone3;
	
	//[유효성 검사]
	boolean isPass = true;
	if(!Regular.isPass(member.getMpw())){
		isPass = false; System.out.println(1);
	}
	if(!Regular.isNum3(mphone1)){
		isPass = false; System.out.println(2);
	}
	if(!Regular.isNum3_4(mphone2)){
		isPass = false; System.out.println(3);
	}
	if(!Regular.isNum4(mphone2)){
		isPass = false; System.out.println(4);
	}
	if(!Regular.isEmail(member.getMemail())){
		isPass = false; System.out.println(5);
	}
	if(!isPass){
		%>
		<script>
			alert("오류가 발생해 메인페이지로 이동합니다.");
			location.href="/jspfolder/index.jsp";
		</script>
		<%
	}else{
	
	
		int result = 0;
		try{
			// masql drivermanager로 접속
			Class.forName("com.mysql.cj.jdbc.Driver");
			// conn 변수에 url과 계정 비밀번호 대입
			conn = DriverManager.getConnection(url,user,pass);
			// 연결 성공 시 연결 성공 출력
			System.out.println("연결성공!");
			
			// mysql insert query문 작성 -> join.jsp에서 입력한 데이터 처리
			String sql = " update member set mpw = md5(?), mphone = ?, memail = ? where mno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, member.getMpw());
			psmt.setString(2, mphone);
			psmt.setString(3, member.getMemail());
			psmt.setInt(4,sessionMno);
			
			result = psmt.executeUpdate();
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null) conn.close();
			if(psmt != null) psmt.close();
			/* 인증세션 제거 */
			session.removeAttribute("isAutFlag");
		}
		
		if(result > 0){
%>
			<script>
				alert("정보 수정이 완료되었습니다.");
				location.href="<%=request.getContextPath()%>";
			</script>
<%
		}else{
%>
			<script>
				alert("정보 수정에 실패했습니다. 다시 시도하세요.");
				location.href="<%=request.getContextPath()%>";
			</script>
<%		
		}
	}
}
%>