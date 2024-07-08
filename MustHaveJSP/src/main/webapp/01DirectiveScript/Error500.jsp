<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>page 지시어 - errorPage, isErrorPage 속성</title>
	</head>
	<body>
		<%
		/*
			해당 파일을 처음으로 실행했을때는 파라미터가 없는 상태이므로
			NumberFormatException이 발생된다. 실행 후 주소입력창에 파일명
			뒤에 ?age=30 과 같이 작성하면 예외는 사라진다.
		*/
		int myAge = Integer.parseInt(request.getParameter("age")) + 10;  // 에러발생
		out.println("10년 후 당신의 나이는 " + myAge + "입니다."); // 실행되지 않음
		%>
	</body>
</html>