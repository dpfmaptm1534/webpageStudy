<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/sessioncheck.jsp"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="java.sql.*" %>
	<%
	request.setCharacterEncoding("UTF-8");
	String b_idx = request.getParameter("b_idx");
	String re_idx = request.getParameter("re_idx");
	String re_userid = request.getParameter("re_userid");
	
	String userid = (String)session.getAttribute("userid");
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			String sql = "delete from tb_reply where re_idx =? and re_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, re_idx);
			pstmt.setString(2,userid);
			pstmt.executeUpdate();
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	 %>
	 <script>
	 	alert('삭제되었습니다');
	 	location.href= 'view.jsp?b_idx=<%=b_idx%>';
	 </script>