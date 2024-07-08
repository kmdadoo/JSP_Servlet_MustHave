<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내장 객체 - request</title>
	</head>
	<body>
		<%
		// post방식으로 전송된 한글이 깨지는 현상을 처리한다.
		request.setCharacterEncoding("UTF-8"); 
		/*
			getParameter() : input태그 중 text, radio타입처럼 하나의 값이 
				전송되는 경우 사용한다. 받은값은 문자, 숫자에 상관없이
				String타입으로 저장된다.
			getParameterValues() : checkbox 혹은 <select> 태그에 mutiple
				속성을 부여하여 2개이상의 값이 전송될 경우 사용한다. 받은
				값은 String타입의 배열로 저장된다.
		*/
		String id = request.getParameter("id");  
		String sex = request.getParameter("sex");
		// checkbox의 경우 2개이상의 값이므로 배열로 받아서...
		String[] favo = request.getParameterValues("favo");  
		String favoStr = "";
		if (favo != null) { 
			// 전송된 값이 있는 경우 배열의 크기만큼 반복한다.
		    for (int i = 0; i < favo.length; i++) {
		        favoStr += favo[i] + " ";
		    }
		 	// 체크박스는 선택한 항목만 전송한다.
		}
		/*
			textarea 태그는 텍스트를 여러 줄 입력할 수 있습니다.
			그래서 출력 시에는 엔터키를 <br> 태그로 변환해야 줄바꿈이 제대로 
			반영됩니다. 엔터키는 특수 기호 \r\n으로 입력됩니다.
		*/
		String intro = request.getParameter("intro").replace("\r\n", "<br/>");  
		%>
		<ul>
		    <li>아이디 : <%= id %></li>
		    <li>성별 : <%= sex %></li>
		    <li>관심사항 : <%= favoStr %></li>
		    <li>자기소개 : <%= intro %></li>
		</ul>
	</body>
</html>