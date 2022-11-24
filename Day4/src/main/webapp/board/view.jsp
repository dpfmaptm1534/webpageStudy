<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/sessioncheck.jsp"%>
<%@page import="com.koreait.db.Dbconn"%>
<%@ page import="java.sql.*"%>

<%
request.setCharacterEncoding("UTF-8");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String num = request.getParameter("b_idx");
String userid = (String) session.getAttribute("userid");
String name = (String) session.getAttribute("name");
String b_idx = "";
String b_title = "";
String b_userid = "";
String b_hit = "";
String b_regdate = "";
String b_like = "";
String b_name = "";
String b_content = "";

String re_idx = "";
String re_userid = "";
String re_name = "";
String re_content = "";
String re_regdate = "";
String re_boardidx = "";

boolean visited =false;
//조회수 올리기
try {
	conn = Dbconn.getConnection();
	if (conn != null) {
		
		/* 먼저 조회한적있는지 체크 */
		String sql = "select * from tb_visited where v_boardidx=? and v_userid=? ";
		pstmt = conn.prepareStatement(sql); //컴파일하고 나서 set 설정해줘야함!
		pstmt.setString(1, num);
		pstmt.setString(2, userid);
		rs = pstmt.executeQuery();
		while(rs.next()) {visited=true;}
		
		/* 조회한적있다면 */
		if(visited){
			sql = "select * from tb_board where b_idx=? ";
			pstmt = conn.prepareStatement(sql); //컴파일하고 나서 set 설정해줘야함!
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			
			rs.next();
			b_idx = rs.getString("b_idx");
			b_title = rs.getString("b_title");
			b_userid = rs.getString("b_userid");
			b_hit = rs.getString("b_hit");
			b_regdate = rs.getString("b_regdate");
			b_like = rs.getString("b_like");
			b_name = rs.getString("b_name");
			b_content = rs.getString("b_content");
		}else{
		/* 조회한적없다면 */
			//tb_visited테이블에 등
			sql = "insert into tb_visited(v_boardidx,v_userid) values(?,?)";
			pstmt = conn.prepareStatement(sql); //컴파일하고 나서 set 설정해줘야함!
			pstmt.setString(1, num);
			pstmt.setString(2, userid);	
			pstmt.executeUpdate();
		
			
			sql = "update tb_board set b_hit=b_hit+1 where b_idx=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
			
			
			sql = "select * from tb_board where b_idx=? ";
			pstmt = conn.prepareStatement(sql); //컴파일하고 나서 set 설정해줘야함!
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
	
			rs.next();
			b_idx = rs.getString("b_idx");
			b_title = rs.getString("b_title");
			b_userid = rs.getString("b_userid");
			b_hit = rs.getString("b_hit");
			b_regdate = rs.getString("b_regdate");
			b_like = rs.getString("b_like");
			b_name = rs.getString("b_name");
			b_content = rs.getString("b_content");
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<script>
function like(){
/* 하트버튼의 속성값들을변경하여 하트전환 */
	const isHeart = document.querySelector("img[title=on]");
	if(isHeart){
		document.getElementById('heart').setAttribute('src', 'https://www.iconpacks.net/icons/2/free-heart-icon-3510-thumb.png')
		document.getElementById('heart').setAttribute('title', 'off')
		
	}else{
		document.getElementById('heart').setAttribute('src', 'https://cdn-icons-png.flaticon.com/512/105/105220.png')
		document.getElementById('heart').setAttribute('title', 'on')
	}
	
	const xhr = new XMLHttpRequest();  //0번
	xhr.open('get', 'like.jsp?idx=<%=num%>&userid=<%=userid%>',true); //1번
	xhr.send(); //2번  ->3번(불러오는 로딩) ->4번(다불러오면 완료상태로 변경!)
	
	// XMLHttpRequest.DONE -> readyState: 4)
	xhr.onreadystatechange = function(){
		if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
			document.getElementById('likenum').innerText= xhr.responseText.trim();
		}
	}
}

function del(idx){
	const yn = confirm('do you really wanna delete this little shit?');
	if(yn) location.href='../delete_ok?b_idx='+idx;
}
function replyDel(re_idx,b_idx){
	const yn = confirm('해당댓글을 삭제하시겠습니까?');
	if(yn)location.href= '../reply_del_ok?re_idx='+re_idx + "&b_idx=" + b_idx;
}

</script>
<style type="text/css">
table {
	width: 800px;
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 10px;
}
</style>
</head>
<body>
	<h2>글보기</h2>
	<table>
		<tr>
			<th>제목
			</td>
			<td><%=b_title%></td>
		</tr>
		<tr>
			<th>날짜
			</td>
			<td><%=b_regdate%></td>
		</tr>
		<tr>
			<th>작성자
			</td>
			<td><%=b_name%></td>
		</tr>
		<tr>
			<th>조회수
			</td>
			<td><%=b_hit%></td>
		</tr>
		<tr>
			<th>좋아요
			</td>
			<td id="likenum"><%=b_like%></td>
		</tr>
		<tr>
			<th>내용
			</td>
			<td><%=b_content%></td>
		</tr>

		<tr>
			<td colspan="2">
				<%
				if (b_userid.equals(userid)) {
				%> <input type="button" value="수정"
					onclick="location.href='edit.jsp?b_idx=<%=b_idx%>'"> <%-- <input type="button" value="삭제" onclick="location.href='delete_ok.jsp?b_idx=<%=b_idx%>'"> --%>
				<input type="button" value="삭제" onclick="del(<%=b_idx%>)"> <%
 }
 %> <input type="button" value="리스트" onclick="location.href='list.jsp'">
 				
<!-- 				<input type="button" id="like" value="좋아요" onclick="like()">
				 -->
				 
				 
				 <%
    
boolean isLike = false;
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
			%>
			<button onclick="like()">
					<img title="on" value="true" id="heart" src="https://cdn-icons-png.flaticon.com/512/105/105220.png" width="20px" id="like" />
			</button>
		<%
		}else{%>
		
			<button onclick="like()">
				<img title="off" value="false" id="heart" src="https://www.iconpacks.net/icons/2/free-heart-icon-3510-thumb.png" width="20px" id="notlike" />
			</button>
			<%
		}
		%>

					
<%
			}
		
	}
catch(Exception e){
		e.printStackTrace();
	}
%>
				 
				 
				
				
				
			</td>
		</tr>
	</table>
	<hr>
	<form method="post" action="../re_write_ok">
		<input type="hidden" name="b_idx" value="<%=b_idx%>">
		<p><%=userid%>(<%=name%>):<input type="text" name="re_content">
			<button>확인</button>
		</p>

	</form>
	<hr>

	<%
	conn = Dbconn.getConnection();
	sql = "";
	if (conn != null) {
		sql = "select * from tb_reply where re_boardidx=? order by re_idx desc;";
		pstmt = conn.prepareStatement(sql); //컴파일하고 나서 set 설정해줘야함!
		pstmt.setString(1, num);
		rs = pstmt.executeQuery();
	}

	while (rs.next()) {
		re_idx = rs.getString("re_idx");
		re_userid = rs.getString("re_userid");
		re_name = rs.getString("re_name");
		re_content = rs.getString("re_content");
		re_regdate = rs.getString("re_regdate");
		re_boardidx = rs.getString("re_boardidx");
		if(userid.equals(re_userid)){
			%>
			<p>
				☻ <%=re_name%>:
				<%=re_content%>(<%=re_regdate%>)
				<input type="button" value="삭제" onclick="replyDel('<%=re_idx%>','<%=b_idx%>')">
			</p>
			<%
		}else{
			%>
			<p>
				☻ <%=re_name%>:
				<%=re_content%>(<%=re_regdate%>)
			</p>
			<%	
				
			}
		}
	
	
	%>


</body>
</html>

<%
} catch (Exception e) {
e.printStackTrace();
}
%>