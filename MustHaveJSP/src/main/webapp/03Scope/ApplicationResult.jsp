<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>application 영역</title>
	</head>
	<body>
		<h2>application 영역의 속성 읽기</h2>
	    <%
	 	// Object로 저장된 속성값을 Map타입으로 형변환한다.
	    Map<String, Person> maps
	            = (Map<String, Person>)application.getAttribute("maps");
	    /*
	   		Map컬렉션은 key를 통해 value를 저장하므로 반복전에 key를 먼저
	   		얻어와야 한다. keySet()을 통해 얻어온 key의 목록을 통해 반복하고
	   		get()을 통해 value를 얻어와 출력한다.
	   	*/
	    Set<String> keys = maps.keySet();
	 	// 확장된 for문에서 모든키에 해당하는 값들을 하나씩 꺼내 출력합니다. 
		// Map에 저장된 객체를 꺼낼 때는 get()을 사용
	    for (String key : keys) {
	        Person person = maps.get(key);
	        out.print(String.format("이름 : %s, 나이 : %d<br/>", 
	                person.getName(), person.getAge()));
	    }  
	 	// session을 삭제했을 때처럼 모든 웹 브라우저를 닫고 실행
	    %>
	</body>
</html>