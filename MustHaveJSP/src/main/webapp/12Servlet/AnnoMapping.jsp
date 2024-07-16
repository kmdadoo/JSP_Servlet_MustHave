<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>AnnoMapping.jsp</title>
	</head>
	<body>
		<h2>애너테이션으로 매핑하기</h2>
	    <p>
	    	<!-- EL을 이용해 request영역에 저장된 데이터 출력. -->
	        <strong>${ message }</strong>	<!-- EL을 사용하면 값이 없을 때 아무것도 출력 안됨. -->
	        <br /> 
	        <!-- 
	        	request내장객체를 이용해서 현재 프로젝트의 컨텍스트루트
	        	경로를 얻어온 후 링크에 적용한다. 이런경우 절대경로로 링크를
	        	설정하게 된다.
	         -->    
	        <a href="<%= request.getContextPath() %>/12Servlet/AnnoMapping.do">바로가기</a>
	    </p>
	</body>
</html>