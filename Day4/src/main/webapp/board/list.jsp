<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/sessioncheck.jsp"%>
<%@page import="com.koreait.db.Dbconn"%>
<%@ page import="java.sql.*"%>
<%
/*
1 0 9
2 10 19
n (n-1)*10 (n-1)*10+9 
*/

String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}
int pagePerCount = 10;
int pageEnd = 0;
int index =0 + ((Integer.parseInt(pageNum)-1)*10);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	width: 800px;
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 10px;
}

.bottom {
	
}

.totalnum {
	margin-left: 600px;
}
</style>
</head>
<body>
	<h2>리스트</h2>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>조회수</th>
			<th>날짜</th>
			<th>좋아요</th>
		</tr>
		<%
		request.setCharacterEncoding("UTF-8");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String userid = (String) session.getAttribute("userid");
		String name = (String) session.getAttribute("name");
		String title = request.getParameter("b_title");
		String content = request.getParameter("b_content");

		String b_idx = "";
		String b_title = "";
		String b_userid = "";
		String b_hit = "";
		String b_regdate = "";
		String b_like = "";
		String b_name = "";
		String cnt = "";
		int total_cnt = 0;
		String nnn = "";

		try {
			conn = Dbconn.getConnection();
			if (conn != null) {
				/* 			System.out.println("DB연결 성공!"); */
				String sql = "select * from tb_board order by b_idx desc LIMIT ?, ?";
				pstmt = conn.prepareStatement(sql); //컴파일하고 나서 set 설정해줘야함!
				pstmt.setInt(1, (Integer.parseInt(pageNum) - 1) * pagePerCount);
				pstmt.setInt(2, pagePerCount);
				rs = pstmt.executeQuery();
				while (rs.next()) {
			b_idx = rs.getString("b_idx");
			b_title = rs.getString("b_title");
			b_userid = rs.getString("b_userid");
			b_hit = rs.getString("b_hit");
			b_regdate = rs.getString("b_regdate");
			b_like = rs.getString("b_like");
			b_name = rs.getString("b_name");
		%>

		<tr>
			<td><%index += 1;%> <%=index%></td>
			<td><a href="view.jsp?b_idx=<%=b_idx%>"><%=b_title%> <%
 try {
 	conn = Dbconn.getConnection();
 	if (conn != null) {
 		ResultSet re_rs = null;
 		/* 			System.out.println("DB연결 성공!"); */
 		String re_sql = "select count(*) as cnt from tb_reply where re_boardidx=?;";

 		pstmt = conn.prepareStatement(re_sql); //컴파일하고 나서 set 설정해줘야함!
 		pstmt.setString(1, b_idx);
 		re_rs = pstmt.executeQuery();
 		re_rs.next();
 		cnt = re_rs.getString("cnt");
 	}
 } catch (Exception e) {
 	e.printStackTrace();
 }
 %> <!-- 댓글갯수 --> <%
 if (cnt.equals("0")) {
 %> <%
 } else {
 %> [<%=cnt%>] <%
 }
 %> <!--  3일이내 올라온 글들은 new --> <%
 try {
 	conn = Dbconn.getConnection();
 	if (conn != null) {
 		ResultSet re_rs = null;
 		/* 			System.out.println("DB연결 성공!"); */
 		String re_sql = "select b_idx from tb_board where b_regdate >= (select date_sub(now(),interval 3 day)) and b_idx=?";
 		pstmt = conn.prepareStatement(re_sql); //컴파일하고 나서 set 설정해줘야함!
 		pstmt.setString(1, b_idx);
 		re_rs = pstmt.executeQuery(); // 값이 존재하지 않으면 에러가니면서 catch로 
 		re_rs.next();
 		nnn = re_rs.getString("b_idx");
 	}
 } catch (Exception e) {
 	nnn = null;
 	e.printStackTrace();
 }
 if (nnn != null) {
 %> <img alt="" style="width: 20px;"
					src="https://ncrefuge.org/wp-content/uploads/2019/11/new-icon.png">
					<%
					}
					%> </a></td>
			<td><%=b_userid%>(<%=b_name%>)</td>
			<td><%=b_hit%></td>
			<td><%=b_regdate%></td>
			<td><%=b_like%></td>
		</tr>

		<%
		}
		}
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
		<%
		try {
			conn = Dbconn.getConnection();
			if (conn != null) {
				ResultSet re_rs = null;
				/* 			System.out.println("DB연결 성공!"); */
				String re_sql = "select count(*) as cnt from tb_board";
				pstmt = conn.prepareStatement(re_sql); //컴파일하고 나서 set 설정해줘야함!
				re_rs = pstmt.executeQuery();
				re_rs.next();
				total_cnt = re_rs.getInt("cnt"); //전체 게시글
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
		<tr>
			<td colspan="6">
				<%
				if (total_cnt % pagePerCount == 0)
					pageEnd = total_cnt / pagePerCount;
				else {
					pageEnd = (total_cnt / pagePerCount) + 1;
				}
				for (int i = 1; i <= pageEnd; i++) {
				%> <a href='./list.jsp?pageNum=<%=i%>'> [<%=i%>]
			</a>&nbsp;&nbsp; <%
 }
 %>
			
		</tr>
		</td>
	</table>


	<p class="bottom">
		<a href='write.jsp'> 글쓰기</a> <a href="../login.jsp">돌아가기</a> <span
			class="totalnum">글 전체수 : <%=total_cnt%>개
		</span>
	</p>


</body>
</html>