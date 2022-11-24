<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/sessioncheck.jsp"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="java.sql.*" %>

<%
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	String num = request.getParameter("b_idx");
	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String b_title ="";
	String b_content = "";


try{
	conn = Dbconn.getConnection();
	if(conn != null){
/* 			System.out.println("DB연결 성공!"); */
		String sql = "select * from tb_board where b_idx = ?";

		pstmt = conn.prepareStatement(sql); //컴파일하고 나서 set 설정해줘야함!
		pstmt.setString(1, num ); 
		rs = pstmt.executeQuery();
		rs.next();
		 b_title = rs.getString("b_title");
		 b_content = rs.getString("b_content");
	}
	

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
</head>
<body>
	<h2>글수정</h2>
<form method="post" action="../edit_ok">
<input type="hidden" name= "b_idx" value="<%=num%>">																																																																																																																																										

	<p>작성자: <%=name %>(<%=userid%>)</p>
	<p>제목: <input type="text" name="b_title" value=<%=b_title%>></p>
<p>내용</p>
<p><textarea style="width: 300px; height: 200px; resize: none;" name="b_content" ><%=b_content%></textarea></p>
<p><button>수정</button>
<button type = "reset">재작성</button>
<button type = "button" onclick = "history.back()"> 뒤로 </button>
</p>
</form>
</body>
</html>

<%
}catch(Exception e){
		e.printStackTrace();
	}
%>


