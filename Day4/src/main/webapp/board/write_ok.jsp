<%@page import="com.koreait.db.Dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ include file="../include/sessioncheck.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	PreparedStatement pstmt = null;
	


	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	String title = request.getParameter("b_title");
	String content = request.getParameter("b_content");



	try{
		conn = Dbconn.getConnection();
		if(conn != null){
/* 			System.out.println("DB연결 성공!"); */
			String sql = "insert into tb_board(b_userid,b_name,b_title,b_content) values(?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, name);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.executeUpdate();

			
			
			
		
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<script>
	alert('등록되었습니다');
	location.href='./list.jsp';
</script>