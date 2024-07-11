<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>액션 태그 - UseBean</title>
	</head>
	<body>
		<h3>액션 태그로 폼값 한 번에 받기</h3>
		<!-- 
			폼값을 전송하는 페이지에서 input태그의 name속성과 이를 저장할
			DTO객체의 멤버변수명이 반드시 일치해야하고, 또한 값 설정을 위
			한 setter/getter 메서드가 반드시 정의되어 있어야 한다. 
		 -->
		<!-- scope 속성을 설정하지 않았으므로 가장좁은 page 영역에 저장된다. -->
	    <jsp:useBean id="person" class="common.Person" /> 
	    <!-- 전송된 폼값이 자바빈즈에 한번에 저장된다. -->
	    <jsp:setProperty property="*" name="person" />  
	    <ul>
	        <li>이름 : <jsp:getProperty name="person" property="name" /></li>  
	        <li>나이 : <jsp:getProperty name="person" property="age" /></li> 
	    </ul>
	    <!--
			폼값은 항상 input 태그의 name 속성에 지정한 이름을 통해 전송됩니다. 
			name 속성에 지정한 이름과 Person 클래스의 멤버 변수 이름이 같았기 
			때문에 폼값을 한 번에 저장할 수 있는 것입니다.
		-->
	</body>
</html>