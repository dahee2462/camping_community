<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%> <!-- java.sql import문 통합 -->
<%@ page import="Vo.Member"%> <!-- encoding UTF-8로 설정 -->
<%@ page import="regular.Regular"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!-- tableVo에 있는 Member 클래스를 useBean과 setProperty로 받아옴 -->
<jsp:useBean id="member" class="Vo.Member" /> <!-- Member member = new Member(); -->
<jsp:setProperty name="member" property="*" />
<%
	//[get방식 차단]
	String method = request.getMethod();
	if(method.equals("GET")){
		response.sendRedirect("join.jsp");
	}
	
	String mphone1 = request.getParameter("mphone1");
	String mphone2 = request.getParameter("mphone2");
	String mphone3 = request.getParameter("mphone3");
	String mphone = mphone1+mphone2+mphone3;
	
	
	// Connection은 conn이 null값으로 변수 생성
	Connection conn = null;

	// PreparedStatement는 psmt가 null 값으로 변수 생성
	PreparedStatement psmt= null;
	
	ResultSet rs= null;
	
	// url은 mysql에 있는 localhost의 campingWeb Schemas로 연결 및 계정과 비밀번호 입력
	String url = "jdbc:mysql://127.0.0.1:3306/campingweb";
	String user = "cteam";
	String pass ="ezen";
	
	
	int insertRow = 0;
	try{
		// masql drivermanager로 접속
		Class.forName("com.mysql.cj.jdbc.Driver");
		// conn 변수에 url과 계정 비밀번호 대입
		conn = DriverManager.getConnection(url,user,pass);
		// 연결 성공 시 연결 성공 출력
		System.out.println("연결성공!");
		
		String sql = " select mno from member where mid = ? or mnickNm = ? ";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,member.getMid());
		psmt.setString(2,member.getMnickNm());
		
		rs = psmt.executeQuery();
		
		//[유효성 검사]
		boolean isPass = true;
		
		if(!Regular.isId(member.getMid())){
			isPass = false; System.out.println(1);
		}
		
		if(!Regular.isPw(member.getMpw())){
			isPass = false;System.out.println(2);
		}
		
		if(!Regular.isNickNm(member.getMnickNm())){
			isPass = false;System.out.println(3);
		}
		
		if(!Regular.isName(member.getMname())){
			isPass = false; System.out.println(4);
		}
		
		if(!Regular.isBirth(""+member.getMbirth())){
			isPass = false; System.out.println(5);
		}
		
		if(!Regular.isNum3(mphone1)){
			isPass = false; System.out.println(6);
		}
		if(!Regular.isNum3_4(mphone2)){
			isPass = false; System.out.println(7);
		}
		if(!Regular.isNum4(mphone3)){
			isPass = false; System.out.println(8);
		}
		
		if(!Regular.isEmail(member.getMemail())){
			isPass = false; System.out.println(9);
		}
		
		if(rs.next()){
			isPass = false; System.out.println(10);
		}
		
		if(rs != null) rs.close();
		if(psmt != null) psmt.close();
		
		if(!isPass){
			
			%>
			<script>
				alert("회원가입에 실패했습니다. 다시 시도하세요.");
			</script>
			<%		
		}else{

			// mysql insert query문 작성 -> join.jsp에서 입력한 데이터 처리
			sql = " INSERT INTO member"
					   + " (mid, mpw, mnickNm, mname, mbirth, mphone, mgender, memail, mrdate)"
					   + " VALUES(?, md5(?), ?, ?, ?, ?, ?, ?, now())";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, member.getMid());
			psmt.setString(2, member.getMpw());
			psmt.setString(3, member.getMnickNm());
			psmt.setString(4, member.getMname());
			psmt.setInt(5, member.getMbirth());
			psmt.setString(6, mphone);
			psmt.setString(7, member.getMgender());
			psmt.setString(8, member.getMemail());
			
			insertRow = psmt.executeUpdate();
			
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}
	
	if(insertRow > 0){
%>
		<script>
			alert("회원가입이 완료되었습니다. 로그인을 시도하세요.");
			location.href="<%=request.getContextPath()%>";
<%
			session.invalidate();
%>
		</script>
<%
	}else{
%>
		<script>
			alert("회원가입에 실패했습니다. 다시 시도하세요.");
			location.href="<%=request.getContextPath()%>";
		</script>
<%		
	}
	
%>