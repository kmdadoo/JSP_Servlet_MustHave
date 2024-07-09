<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//팝업창 오픈 여부 판단을 위한 변수
String popupMode = "on";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<title>쿠키를 이용한 팝업 관리</title>
		<style>
			<!--팝업창의 위치와 색상 등의 형태를 지정하는 CSS -->
		    div#popup{
		        position: absolute; top:100px; left:100px; color:yellow;  
		        width:300px; height:100px; background-color:gray;
		    }
		    div#popup>div{
		        position: relative; background-color:#ffffff; top:0px;
		        border:1px solid gray; padding:10px; color:black;
		    }
		</style>
		<script>
		// jQuery의 엔트리 포인트(시작점)
		$(function() {
			// 팝업창 닫기 버튼을 누르면 아래코드를 실행한다.
		    $('#closeBtn').click(function() {
		    	// 레이어 팝업창을 숨김처리한다.
		        $('#popup').hide();
		    });
		});
		</script>
	</head>
	<body>
		<h2>팝업 메인 페이지</h2>
		<%
			//단순히 텍스트를 10번 반복해서 출력한다. 
		    for (int i = 1; i <= 10; i++) {
		        out.println("현재 팝업창은 " + popupMode + " 상태입니다.<br/>");
		    }
			//popupMode가 on인 경우에만 레이어 팝업창을 보여준다. 
		    if (popupMode.equals("on")) {
		%>
		    <div id="popup">
		        <h2 align="center">공지사항 팝업입니다.</h2>
		        <div align="right"><form name="popFrm">
		            <input type="checkbox" id="inactiveToday" value="1" />
		            하루 동안 열지 않음
		            <input type="button" value="닫기" id="closeBtn" />
		        </form></div>
		    </div>
		<%
		    }
		%>
	</body>
</html>