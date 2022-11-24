<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<%@ page import ="java.sql.*" %>
<%@ page import = "com.koreait.db.Dbconn" %>
<%
	String userid = request.getParameter("userid");
	String userpw = request.getParameter("userpw"); //name값으로 인
	
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs = null;
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			String sql = "select mem_idx, mem_username from tb_member where mem_userid=? and mem_userpw=sha2(?,256)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			pstmt.setString(2,userpw);
			rs = pstmt.executeQuery();
			if(rs.next()){
				session.setAttribute("userid",userid);
				session.setAttribute("idx",rs.getString("mem_idx"));
				session.setAttribute("name",rs.getString("mem_username"));
			%>
				<script>
					alert('로그인 되었습니다');
					location.href="login.jsp" //refresh가됨 새로고침이되는것임
				</script>
			<%
				}else{
			%>
				<script>
					alert('아이디 또는 비밀번호를 확인하세요');
					history.back(); // 캐쉬가남음 캐쉬에 있는 정보를 가져다가 앞으로갓다가 뒤로갓다가 할수있는것이라서
				</script>
<%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
			
	
	