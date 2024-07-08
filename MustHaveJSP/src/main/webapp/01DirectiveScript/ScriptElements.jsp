<!-- page 지시어 선언 -->
<%@page import="common.MyClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
	선언부(Declaration) : 스크립트렛이나 표현식에서 사용할 메서드를 선언할 때
		사용된다. 선언부에서 선언된 메서드는 해당 JSP가 서블릿(Java파일)으로 
		변환될 때 멤버메서드 형태로 선언된다.
	파일 확인 경로 : C:\Dev\apache-tomcat-10.1.17\work\Catalina\localhost\MustHaveJSP\org\apache\jsp
 --%>
<%!
public int add(int num1 , int num2) {
    return num1 + num2;
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>스크립트 요소</title>
	</head>
	<body>
		<!-- 
			스크립트렛(Scriptlet) : 주로 JSP코드를 작성하고 실행할 때 사용한다.
				스크립트렛은 body, head 어디서든 사용할 수 있다. 또한 <script>
				<style> 태그 내부에서도 사용할 수 있다.
				여기에 기술된 코드는 _jspService() 메서드 내에 포함된다.
				그러므로 해당 영역에는 메서드를 선언할 수 없다.
			표현식(Expression) : 변수를 웹브라우저상에 출력할 때 사용한다.
				JS의 document.write()와 동일한 역할을 한다. 표현식 사용시 주의할
				점은 문장끝에 ;(세미콜론)을 붙이지 않는다.
				
		 -->
		<% // 스크립틀릿（자바 코드)
		int result = add(10, 20);
		%>
		덧셈 결과 1 : <%= result %> <br />  <!-- 표현식(변수) -->
		덧셈 결과 2 : <%= add(30, 40) %> 	<!-- 표현식（메서드 호출）-->
		
		<h2>내감 만든 JAVA 클래스의 메서드 호출하기</h2>
		<%
		int sum = MyClass.myFunc(1, 26);
		out.println("1~26까지의 합 : " +  sum);
		%>
		
	</body>
</html>