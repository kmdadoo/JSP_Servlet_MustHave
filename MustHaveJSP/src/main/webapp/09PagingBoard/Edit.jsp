<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 수정 페이지로 진입시 로그인을 확인한다. -->
<%@ include file="./IsLoggedIn.jsp"%>
<%
// 수정할 게시물의 일련번호를 파라미터로 받아온다.
String num = request.getParameter("num");
// DAO 객체 생성
BoardDAO dao = new BoardDAO(application); 
// 기존 게시물의 내용을 읽어온다.
BoardDTO dto = dao.selectView(num);
// 세션영역에 저장된 회원 아이디를 가져와서 문장열로 반환한다.
String sessionId = session.getAttribute("UserId").toString();	// 로그인 아이디 확인
// 로그인한 회원이 작성자인지 판단한다. 본인인지 확인
if (!sessionId.equals(dto.getId())) {  
    JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
    return;
}
/*
	URL의 패턴을 파악하면 내가 작성한 게시물이 아니어도 얼마든지 수정페이지로
	진입할 수 있다. 따라서 수정페이지 자체에서도 작성자 본인이 맞는지 확인하는
	절차가 필요하다.
*/
//자원해제
dao.close(); 
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원제 게시판</title>
		<script type="text/javascript">
		function validateForm(form) {  
		    if (form.title.value == "") {
		        alert("제목을 입력하세요.");
		        form.title.focus();
		        return false;
		    }
		    if (form.content.value == "") {
		        alert("내용을 입력하세요.");
		        form.content.focus();
		        return false;
		    }
		}
		</script>
	</head>
	<body>
		<jsp:include page="../Common/Link.jsp" />
		<h2>회원제 게시판 - 수정하기(Edit)</h2>
		<!-- 수정 처리는 EditProcess.jsp에서... -->
		<form name="writeFrm" method="post" action="EditProcess.jsp"
		      onsubmit="return validateForm(this);">
	      	<!-- 
				게시물의 일련번호를 서버(EditProcess.jsp)로 전송하기 위해서 
				hidden타입의 input이 반드시 필요하다.
			-->
			<input type="hidden" name="num" value="<%= dto.getNum() %>" />
		    <table border="1" width="90%">
		        <tr>
		            <td>제목</td>
		            <td>
		                <input type="text" name="title" style="width: 90%;" 
		                	value="<%= dto.getTitle() %>" />
		            </td>
		        </tr>
		        <tr>
		            <td>내용</td>
		            <td>
		            	<!-- 시작 태그와 종료 태그 사이에 텍스트가 들 
							어가므로 반드시 공백 space 없이 작성 -->
		                <textarea name="content" style="width: 90%; 
		                	height: 100px;"><%= dto.getContent() %></textarea>
		            </td> 
		        </tr>
		        <tr>
		            <td colspan="2" align="center">
		                <button type="submit">작성 완료</button>
		                <button type="reset">다시 입력</button>
		                <button type="button" onclick="location.href='List.jsp';">
		                    목록 보기</button>
		            </td>
		        </tr>
		    </table>
		</form>
	</body>
</html>