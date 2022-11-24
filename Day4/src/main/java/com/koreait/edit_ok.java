package com.koreait;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.db.Dbconn;

/**
 * Servlet implementation class edit_ok
 */
@WebServlet("/edit_ok")
public class edit_ok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public edit_ok() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession(); //session.getattribute 할때 session역할  
		PrintWriter writer = response.getWriter(); //jsp 에서 out.println의 out역할
		
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
				 writer.println("<script>alert('수정되었습니다');location.href='./board/view.jsp?b_idx="+b_idx+"';</script>");
				 
	}

}
