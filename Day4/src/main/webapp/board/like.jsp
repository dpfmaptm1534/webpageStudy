<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/sessioncheck.jsp"%>
<%@page import="com.koreait.db.Dbconn"%>
<%@ page import="java.sql.*" %>
<%
    
String num = request.getParameter("idx");
String userid = request.getParameter("userid");
String likenum ="";
boolean isLike = false;
request.setCharacterEncoding("UTF-8");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql="";

try{
	conn = Dbconn.getConnection();
	if(conn != null){
/* 			System.out.println("DB연결 성공!"); */
		
		sql = "select * from tb_like where l_boardidx = ? and l_userid = ? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, num);
		pstmt.setString(2, userid);
		
		rs = pstmt.executeQuery();
		while(rs.next()){
			isLike = true;
		}
		
		if(isLike){
			String hitminus = "update tb_board set b_like=b_like-1 where b_idx=? ";
			pstmt = conn.prepareStatement(hitminus);
			pstmt.setString(1, num ); 
			pstmt.executeUpdate();
			
			hitminus = "delete from tb_like where l_boardidx = ? and l_userid = ? ";
			pstmt = conn.prepareStatement(hitminus);
			pstmt.setString(1, num ); 
			pstmt.setString(2, userid); 
			pstmt.executeUpdate();
			
			
			sql = "select * from tb_board where b_idx=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num );
			rs = pstmt.executeQuery();
			while(rs.next()){
			likenum=rs.getString("b_like");
			out.print(likenum);}
			
		}else{
			String hitplus = "update tb_board set b_like=b_like+1 where b_idx=? ";
			pstmt = conn.prepareStatement(hitplus);
			pstmt.setString(1, num ); 
			pstmt.executeUpdate();
			
			hitplus = "insert into tb_like(l_boardidx,l_userid) values(?,?)";
			pstmt = conn.prepareStatement(hitplus);
			pstmt.setString(1, num ); 
			pstmt.setString(2, userid); 
			pstmt.executeUpdate();
			
			sql = "select * from tb_board where b_idx=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num );
			rs = pstmt.executeQuery();
			while(rs.next()){
			likenum=rs.getString("b_like");
			out.print(likenum);
			}
		}
	}
	

	


}catch(Exception e){
		e.printStackTrace();
	}
%>