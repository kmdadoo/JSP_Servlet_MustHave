<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 포워드되는 페이지로 한글을 전달할때는 반드시 포워드시키는 
// 최초페이지에서 인코딩 처리를해야한다.
request.setCharacterEncoding("UTF-8");	// web.xml에 있으면 생략 가능
String pValue = "방랑시인";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>액션 태그 - param</title>
	</head>
	<body>
		<!-- Person클래스로 request영역에 자바빈을 생성한다.  -->
		<jsp:useBean id="person" class="common.Person" scope="request" />
	    
	    <!-- setter()를 통해 멤버변수의 값을 설정한다. -->
	    <jsp:setProperty name="person" property="name" value="김삿갓" /> 
	    <jsp:setProperty name="person" property="age" value="56" />
	    
	    <!-- 다음 페이지로 포워드 한다. 이때 3개의 파라미터를 전송한다. -->
	    <!-- 쿼리스트링으로 -->
	    <jsp:forward page="ParamForward.jsp?param1=김병연">	
	        <jsp:param name="param2" value="경기도 양주" />	
	        <jsp:param name="param3" value="<%=pValue%>" />
	    </jsp:forward> 
	</body>
</html>