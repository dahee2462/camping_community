<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%> <!-- java.sql import문 통합 -->
<!-- encoding UTF-8로 설정 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- tableVo에 있는 Member 클래스를 useBean과 setProperty로 받아옴 -->
<jsp:useBean id="member" class="tableVo.Member" /> <!-- Member member = new Member(); -->
<jsp:setProperty name="member" property="*" />
<%
	// Connection은 conn이 null값으로 변수 생성
	Connection conn = null;

	// PreparedStatement는 psmt가 null 값으로 변수 생성
	PreparedStatement psmt= null;
	
	// url은 mysql에 있는 localhost의 campingWeb Schemas로 연결 및 계정과 비밀번호 입력
	String url = "jdbc:mysql://localhost:3306/campingweb";
	String user = "root";
	String pass = "ezem";
	int insertRow = 0;
	
	try{
		// masql drivermanager로 접속
		Class.forName("com.mysql.cj.jdbc.Driver");
		// conn 변수에 url과 계정 비밀번호 대입
		conn = DriverManager.getConnection(url,user,pass);
		// 연결 성공 시 연결 성공 출력
		System.out.println("연결성공!");
		
		// mysql insert query문 작성 -> join.jsp에서 입력한 데이터 처리
		String sql = " INSERT FORM member "
				   + " (mid, mpw, mnickNm, mname, mbirth, mphone, mgender, memail, mrdate)"
				   + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, now())";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, member.getMid());
		psmt.setString(2, member.getMpw());
		psmt.setString(3, member.getMnicknm());
		psmt.setString(4, member.getMname());
		psmt.setInt(5, (int)member.getMbirth());
		psmt.setString(6, member.getMphone());
		psmt.setString(7, member.getMgender());
		psmt.setString(8, member.getMemail());
		
		insertRow = psmt.executeUpdate();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) conn.close();
	}
	
	if(insertRow > 0){
%>
		<script>
			alert("회원가입이 완료되었습니다. 로그인을 시도하세요.");
			location.href="<%=request.getContextPath()%>";
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