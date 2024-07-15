<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>   
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL - url</title>
	</head>
	<body>
	<!-- 
		url 태그 : url을 생성할 때 사용한다. 절대경로로 사용시 컨텍스트루트
			경로는 제외한다. var속성을 지정하지 않는 경우 해당 위치에 생성된 
			url이 출력된다. param태그로 지정한 값은 쿼리스트링으로 URL뒤에
			연결된다.
	 -->
		<h4>url 태그로 링크 걸기</h4>
		<!-- HOST(도메인 부분)를 제외한 나머지경로를 반환한다. var속성이
		지정되었으므로 해당 위치에는 출력되지 않는다. -->
	    <c:url value="/11JSTL/inc/OtherPage.jsp" var="url"> 
	        <c:param name="user_param1" value="Must" /> <!-- 매개변수를 value속성으로 지정 -->
	        <c:param name="user_param2">Have</c:param> 	<!-- 태그와 태그사이의 콘텐츠로 지정 -->
	    </c:url>
	    <!-- 앞에서 생성된 URL은 a태그에 포함된다. -->
	    <a href="${url }">OtherPage.jsp 바로가기</a> <!-- 필요한 위치에 삽입할 수 있다. -->
	</body>
</html>