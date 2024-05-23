<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//-------------------첨부파일 다운로드 백단-------------------------

	request.setCharacterEncoding("UTF-8");

	//실제이름, 원래이름 파라미터로 가져오기
	String frealNm = request.getParameter("frealNm");
	String foriginNm = request.getParameter("foriginNm");
	
	//웹앱 하위에 있는 업로드폴더 위치
	String root = "E:\\98.팀프로젝트\\01.1차프로젝트\\team_project\\jspfolder\\src\\main\\webapp\\upload";
	//String root = "D:\\team\\team_project\\jspfolder\\src\\main\\webapp\\upload";
	//String root = "C:\\Users\\MYCOM\\git\\team_project7\\jspfolder\\src\\main\\webapp\\upload";

	
	InputStream in = null; //실제 파일 읽음
	OutputStream os = null;	//사용자 Pc에 써줌
	File file = null;
	boolean skip = false;
	String client = "";
	
	if((frealNm == null || (frealNm != null && frealNm.equals(""))) || (foriginNm == null || (foriginNm != null && foriginNm.equals("")))){
		response.sendRedirect("/jspfolder/index.jsp");
	}else{
		try{
			// 파일을 읽어 스트림에 담기
			try{
				//-file객체에 업로드폴더, 실제이름 넣어 생성
				file = new File(root, frealNm);
				
				//-InputStream 객체에 file객체 넣어 생성
				in = new FileInputStream(file);
			
			}catch(FileNotFoundException fe){
				skip = true;
			}
	
			client = request.getHeader("User-Agent");
	
			// 파일 다운로드 헤더 지정
			response.reset();
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Description", "JSP Generated Data");
	
	
			if(!skip){
	
				
				// IE
				if(client.indexOf("MSIE") != -1){
					response.setHeader ("Content-Disposition", "attachment; filename="+new String(foriginNm.getBytes("KSC5601"),"ISO8859_1"));
	
				}else{
					// 한글 파일명 처리
					foriginNm = new String(foriginNm.getBytes("utf-8"),"iso-8859-1");
	
					response.setHeader("Content-Disposition", "attachment; filename=\"" + foriginNm + "\"");
					response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
				}  
				
				response.setHeader ("Content-Length", ""+file.length() );
	
				os = response.getOutputStream();
				
				byte b[] = new byte[(int)file.length()];
				
				int leng = 0;
				
				while( (leng = in.read(b)) > 0 ){
					os.write(b,0,leng);
				}
	
			}else{
				response.setContentType("text/html;charset=UTF-8");
				out.println("<script language='javascript'>alert('파일을 찾을 수 없습니다');history.back();</script>");
	
			}
			
			//닫기
			in.close();
			os.close();
	
		}catch(Exception e){
		  e.printStackTrace();
		}
	}
%>