<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 작성자 본인만 삭제할 수 있으므로 기본적으로 로그인 체크를 해야한다. -->
<%@ include file="./IsLoggedIn.jsp"%> 
<%
// 폼값(일련번호) 받기
String num = request.getParameter("num");   

BoardDTO dto = new BoardDTO();     // DTO 객체 생성        
BoardDAO dao = new BoardDAO(application);  // DAO 객체 생성
// 본인 확인을 위해 기존 게시물을 인출한다.
dto = dao.selectView(num);   

/*
	session영역에 저장된 회원정보를 얻어온 후 String으로 변환한다.
	영역에는 모든 값(객체)을 저장할 수 있도록 Object타입을 사용하므로
	사용시 기존의 값으로 형변환해야 한다.
*/
String sessionId = session.getAttribute("UserId").toString(); 

int delResult = 0;

// 세션의 아이디와 게시물의 아이디가 일치하면 작성자 본인이므로...
if (sessionId.equals(dto.getId())) { 
	// 게시물을 삭제한다.
    dto.setNum(num);
    delResult = dao.deletePost(dto);
 	// 자원 해제
    dao.close();

    if (delResult == 1) {
    	/*
			게시물이 삭제되면 내용보기는 의미가 없으므로 목록(리스트)으로
			이동하면 된다.
		*/
        JSFunction.alertLocation("삭제되었습니다.", "List.jsp", out); 
    } 
    else {
    	/* 작성자 본인이 아니면 삭제할 수 없다. */
        JSFunction.alertBack("삭제에 실패하였습니다.", out);
    } 
} 
else {  
    JSFunction.alertBack("본인만 삭제할 수 있습니다.", out);
    return;
}
%>