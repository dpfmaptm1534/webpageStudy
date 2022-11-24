<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/sessioncheck.jsp"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="java.sql.*" %>
	<%
	request.setCharacterEncoding("UTF-8");
	String b_idx = request.getParameter("b_idx");
	
	String userid = (String)session.getAttribute("userid");
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			String sql = "delete from tb_board where b_idx =? and b_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			pstmt.setString(2,userid);
			pstmt.executeUpdate();
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	 %>
	 <script>
	 	alert('삭제되었습니다');
	 	location.href= 'list.jsp';
	 </script>