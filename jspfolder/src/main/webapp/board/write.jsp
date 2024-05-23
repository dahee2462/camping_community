<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Vo.Member" %>
<!DOCTYPE html>
<html>
<head>
<%
	//(mnickNm)
	Member member = (Member)session.getAttribute("login");

	String blist = request.getParameter("blist");
	//null체크를 했어도(비정상 접근 차단 이유) 아래에서 메소드 사용시마다 널체크 해야함. if로 전체를 감싸지 않는이상 무조건 아래까지 실행되기 때문.
	if(blist==null){
		%>
		<script>
			alert("잘못된 접근입니다");
			location.href="<%= request.getContextPath() %>/index.jsp";
		</script>
		<%
	}
	
	
	String mnickNm ="";
	if(member == null){	//로그인이 안되어있는 경우 예외처리, 참고->( 이 경우 if문 아래의 자바코드도 실행되므로 아래 코드에서 member의 메소드를 null체크없이 사용하면 에러가 뜰 가능성이 있다.)
	
%>
	<script>
		alert("잘못된 접근입니다");
		location.href="<%= request.getContextPath() %>/index.jsp";
	</script>
<%
	}else{
		mnickNm = member.getMnickNm();
	}
%>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/write.css" rel="stylesheet">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script src="<%=request.getContextPath()%>/js/write.js"></script>
</head>
<body>
	<%@ include file ="/include/header.jsp" %>
	<div class="container">
	<%@ include file="/include/nav.jsp" %>
	<section>
		<h2>게시글 등록</h2>
		<%	
			//encytype이 있어야 전달받은 파일을 기계어로 백단에 그대로 파라미터로 보낼 수 있음(원래 파라미터는 문자열로만 전달가능하기에)
			//라이브러리필요: cos.jar를 lib파일에 이게 있어야 알아서 bulid됨 
		%>
		
		<form action="writeOk.jsp" method="post" name="frm" enctype="multipart/form-data">
			<input type="hidden" name="blist" value="<%=blist%>">
			<table border="1" class="writeTable">
				<tbody>
					<tr>
						<th >제목</th>
						<td>
								<input type="text" name="btitle">
						</td>
						<th>카테고리</th>
						<td>
							<select name="btype" id="mainSelect" onchange="showSubSelect(this)" >
								<option value="자유게시판" <%if(blist != null && blist.equals("free")) out.print("selected"); %>> 자유게시판</option>
								<option value="캠핑지역" <%if(blist != null && (blist.indexOf("zone") != -1)) out.print("selected"); %>> 캠핑지역</option>
								<option value="캠핑장비" <%if(blist != null ){if(blist.indexOf("gear") != -1) out.print("selected");} %>> 캠핑장비</option>
								<option value="출석체크" <%if(blist != null && blist.equals("attend")) out.print("selected"); %>> 출석체크</option>
								<option value="QnA" <%if(blist != null && blist.equals("QnA")) out.print("selected"); %>> QnA</option>
							<%
							if(member != null && member.getMid().equals("admin")){ // member 메소드 사용 전 null체크 추가
							%>
								<option value="공지사항" <%if(blist != null && blist.equals("notice")) out.print("selected"); %>>공지사항</option>
							<%
							}
							%>
							</select>
						</td>
					</tr>
					<tr id="subTr">
						<th id="writerTh">작성자</th>
						<% if(blist != null && (blist.indexOf("zone") != -1)){%>
						<td id="writerTd"><%=mnickNm%></td>
						<th id="subSelectTh" >세부카테고리</th>
						<td id="subSelectTd">
							<select name="btype" id="subSelect">
								<option value="캠핑지역_서울" <%if(blist != null && blist.equals("zone_Seoul")) out.print("selected"); %>>서울</option>
								<option value="캠핑지역_경기권" <%if(blist != null && blist.equals("zone_GG")) out.print("selected"); %>>경기권</option>
								<option value="캠핑지역_강원권" <%if(blist != null && blist.equals("zone_GW")) out.print("selected"); %>>강원권</option>
								<option value="캠핑지역_충청권" <%if(blist != null && blist.equals("zone_CC")) out.print("selected"); %>>충청권</option>
								<option value="캠핑지역_영남권" <%if(blist != null && blist.equals("zone_YN")) out.print("selected"); %>>영남권</option>
								<option value="캠핑지역_호남권" <%if(blist != null && blist.equals("zone_HN")) out.print("selected"); %>>호남권</option>
								<option value="캠핑지역_제주" <%if(blist != null && blist.equals("zone_JJ")) out.print("selected"); %>>제주</option>
							</select>
						</td>
						<%}else if(blist != null && (blist.indexOf("gear") != -1)){ %>
						<td id="writerTd"><%=mnickNm%></td>
						<th id="subSelectTh" >세부카테고리</th>
						<td id="subSelectTd">
							<select name="btype" id="subSelect">
								<option value="캠핑장비_텐트" <%if(blist != null && blist.equals("gear_Tent")) out.print("selected"); %>>텐트/타프</option>
								<option value="캠핑장비_침낭" <%if(blist != null && blist.equals("gear_Bad")) out.print("selected"); %>>침낭/매트</option>
								<option value="캠핑장비_의자" <%if(blist != null && blist.equals("gear_Chair")) out.print("selected"); %>>의자/테이블</option>
								<option value="캠핑장비_화기" <%if(blist != null && blist.equals("gear_Fire")) out.print("selected"); %>>화기/기타</option>
								<option value="캠핑장비_차박" <%if(blist != null && blist.equals("gear_Car")) out.print("selected"); %>>차박</option>
							</select>
						</td>
						<% }else{%>
						<td id="writerTd" colspan="3"><%=mnickNm%></td>
						<%} %>
					</tr>
					<tr>
						<td colspan="5">
							<textarea name="bcontent"></textarea>
						</td>
					</tr>
					<% // 첨부파일 :브라우저에서 접근할 수 있도록 wepapp하위에 첨부파일 만듦%>
					<tr>
						<th>첨부파일 </th>
						<td colspan="5">
							<input type="file" name="uploadFile">
						</td>
					</tr>
				</tbody>
			</table>
			<button type="button" class="cancleBtn" onclick="connectList()">취소</button>
			<button class="saveBtn">저장</button>
		</form>
	</section>
	</div>
	
	<%@ include file ="/include/footer.jsp" %>
	
	<script>
		function connectList(){
			location.href='<%=request.getContextPath()%>/board/connectList.jsp?blist=<%=blist%>';
		}
	</script>
</body>
</html>