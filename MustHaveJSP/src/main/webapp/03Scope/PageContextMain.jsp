<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% // 속성 저장
/*
	page 영역 : 하나의 페이지에서만 영역이 공유되고 페이지 이동, 포워드 된
		페이지에서는 영역이 소멸되어 공유되지 않는다. 즉 해당 페이지에서만 
		사용할 수 있는 영역이다. JSP에서의 영역은 데이터를 저장하는 공간으로
		메모리라고 생각하면 된다.
*/
// pageContext 를 이용해 page 영역에 정수형 데이터 속성값을 저장
pageContext.setAttribute("pageInteger", 1000);
// pageContext 를 이용해 page 영역에 문자열 데이터 속성값을 저장
pageContext.setAttribute("pageString", "페이지 영역의 문자열");
// 일반적인 클래스를 통해 생성한 객체
pageContext.setAttribute("pagePerson", new Person("한석봉", 99)); 
/*
	page영역을 포함한 4가지 영역에는 모든 데이터(객체)를 저장할 수 있다.
	Object를 기반으로 저장되므로 차후 값을 읽을때는 해당 타입으로 형변환
	해야 한다.
*/
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>page 영역</title>
	</head>
	<body>
		<h2>page 영역의 속성값 읽기</h2>
	    <%
	 	// 정수 데이터를 읽을때는 Integer클래스를 통해 자동 언박싱한다.
	    int pInteger = (Integer)(pageContext.getAttribute("pageInteger"));
	 	// 문자열 데이터는 toString()을 통해 문자열 형태로 반환한다.
	    String pString = pageContext.getAttribute("pageString").toString();
	 	// Person과 같이 개발자가 정의한 클래스는 원래의 타입으로 형변환 한다.
	    Person pPerson = (Person)(pageContext.getAttribute("pagePerson"));
	    %>
	    <ul>
	    	<!-- Java의 기본클래스인 경우 별도의 처리없이 즉시 내용을 출력할 수 있다.  -->
	        <li>Integer 객체 : <%= pInteger %></li>
	        <li>String 객체 : <%= pString %></li>
	        <!-- Person 클래스는 getter()를 통해 출력한다. -->
	        <li>Person 객체 : <%= pPerson.getName() %>, 
	        	<%= pPerson.getAge() %></li>
	    </ul>
	    
	    <!-- 
	    	지시어를 통한 include는 포함시킬 페이지의 원본소스를 그대로 현재 문서에
	    	포함시킨 후 컴파일을 진행한다. 따라서 동일한 페이지로 취급되므로 page
	    	영역이 그대로 공유된다.
	    	즉, 인클루드 된 페이지의 내용은 정상적으로 출력된다.
	     -->
	    <h2>include된 파일에서 page 영역 읽어오기</h2>
	    <%@ include file="PageInclude.jsp" %>
	       
	    <!-- 
	    	페이지 이동은 새로운 페이지를 웹서버에 요청하는 것이므로 page영역은 공유
	    	되지 않는다. 즉, 아래의 링크를 통해 이동한 페이지에서는 아무런 내용이 
	    	출력되지 않는다.
	     -->
	    <h2>페이지 이동 후 page 영역 읽어오기</h2>
	    <a href="PageLocation.jsp">PageLocation.jsp 바로가기</a>
	</body>
</html>