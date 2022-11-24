<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("userid") == null){
		response.sendRedirect("/Day4/login.jsp"); //맨앞이 슬러쉬면 경로 젤 위로 
		return;
	}
%>

