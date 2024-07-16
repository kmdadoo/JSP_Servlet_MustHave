<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FileUpload</title>
	<script>
		// 작성폼의 입력값을 검증하기 위한 자바스크립트 함수
	    function validateForm(form) { 
	        if (form.title.value == "") {
	            alert("제목을 입력하세요.");
	            form.title.focus();
	            return false;
	        }
	        if (form.ofile.value == "") {
	            alert("첨부파일은 필수 입력입니다.");
	            return false;
	        }
	    }
	</script>
	</head>
	<body>
		<h3>파일 업로드</h3>
	    
	    <!-- 파일업로드시 실패하는 경우 에러메세지를 표현한다. 해당 데이터는
    	errorMessage에 저장될 것이다. -->
	    <span style="color: red;">${errorMessage }</span>
	    
	    <!-- 
	    	파일업로드를 위한 form태그 작성시 필수사항
	    		1.method 즉 전송방식은 반드시 post로 지정해야 한다.
	    		2.enctype을 mutipart/form-data로 지정해야한다.
	    	일반적인 폼값 전송을 위해 enctype을 명시하지 않는 경우
	    		request내장객체의 getParameter()로 폼값을 받을 수 있다. 
	     -->
	     
	    <!-- 파일명을 날짜와 시간을 통해 변경하는 방식으로 실무에서 주로 
    	사용하는 방식이다. -->
	    <form name="fileForm" method="post" enctype="multipart/form-data"
	          action="UploadProcess.do" onsubmit="return validateForm(this);">
	    
	        제목 : <input type="text" name="title" /><br /> 
	        카테고리(선택사항) : 
	            <input type="checkbox" name="cate" value="사진" checked />사진 
	            <input type="checkbox" name="cate" value="과제" />과제 
	            <input type="checkbox" name="cate" value="워드" />워드 
	            <input type="checkbox" name="cate" value="음원" />음원 <br /> 
	        첨부파일 : <input type="file" name="ofile" /> <br />
	        <!--  폼값을 전송해주는 버튼을 만들어준다. -->
	        <input type="submit" value="전송하기" />
	    </form>
	</body>
</html>