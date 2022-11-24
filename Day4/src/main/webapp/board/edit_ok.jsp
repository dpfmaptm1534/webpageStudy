<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/sessioncheck.jsp"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="java.sql.*" %>
	<%
	request.setCharacterEncoding("UTF-8");
	String b_idx = request.getParameter("b_idx");
	String b_title = request.getParameter("b_title");
	String b_content = request.getParameter("b_content");
	String b_userid =(String)session.getAttribute("userid");
	String b_name =(String)session.getAttribute("name");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			String sql = "update tb_board set b_title=?, b_content=?, b_userid=?, b_name=? where b_idx =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_title);
			pstmt.setString(2, b_content);
			pstmt.setString(3, b_userid);
			pstmt.setString(4, b_name);
			pstmt.setString(5, b_idx);
			pstmt.executeUpdate();
		
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	 %>
	 <script>
	 	alert('수정되었습니다');
	 	location.href='view.jsp?b_idx=<%=b_idx%>';
	 </script>