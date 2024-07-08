<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	HTML 주석 : 보통의 경우 인클루드되는 JSP파일은 HTML태그 없이 순수한 JSP코드만
		작성하는 것이 좋다. 포함되었을 때 html태그가 중복될수 있기 때문이다.
 -->
<%
LocalDate today = LocalDate.now();  // 오늘 날짜
LocalDateTime tomorrow = LocalDateTime.now().plusDays(1);  // 내일 날짜
%>