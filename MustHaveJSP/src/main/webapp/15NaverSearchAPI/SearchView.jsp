<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>네이버검색 API</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script>
		// [검색 요청] 버튼 클릭 시 실행할 메서드를 정의합니다.
		$(function() {
			// 검색 요청 버튼（id=“searchBtn”）을 눌렀을 때 $.ajax 메서드를 호출하도록 정의
		    $('#searchBtn').click(function() {
		      $.ajax({
		        url : "../NaverSearchAPI.do",  // 요청 URL
		        type : "get",                  // HTTP 메서드 get 방식으로 전송
		        data : {                // 매개변수로는 검색어와 검색 시작 위치를 전달  
		            keyword : $('#keyword').val(),                  // 검색어
		            startNum : $('#startNum option:selected').val() // 검색 시작 위치
		        },
		        dataType : "json",      // 응답 데이터 형식 JSON으로 지정
		        success : sucFuncJson,  // 요청 성공 시 호출할 메서드 설정
		        error : errFunc       	// 요청 실패 시 호출할 메서드 설정
		      });
		    });
		});
		
		// 검색 성공 시 결과를 화면에 뿌려줍니다.
		function sucFuncJson(d) {
		    var str = "";
		 	// 콜백 데이터 중 items 부분을 반복 파싱. 
			// 파싱된 데이터는 10개씩 문자열에 누적 저장
		    $.each(d.items, function(index, item) {
		        str += "<ul>";
		        str += "    <li>" + (index + 1) + "</li>";
		        str += "    <li>" + item.title + "</li>";
		        str += "    <li>" + item.description + "</li>";
		        str += "    <li>" + item.bloggername + "</li>";
		        str += "    <li>" + item.bloggerlink + "</li>";
		        str += "    <li>" + item.postdate + "</li>";
		        str += "    <li><a href='" + item.link + "' target='_blank'>바로가기</a></li>";
		        str += "</ul>";
		    });
		 	// id가 “searchResult”인 영역에 HTML 형태로 출력
		    $('#searchResult').html(str);
		}
		
		// 실패 시 경고창을 띄워줍니다.
		function errFunc(e) {
		    alert("실패: " + e.status);
		}
		</script>
		
		<style>
		    ul{border:2px #cccccc solid;}
		</style>
	</head>
	<body>
		<div>
		    <div>
		    	<!-- 검색을 위한 <form> 태그를 정의 -->
		        <form id="searchFrm">
		            한 페이지에 10개씩 출력됨 <br />
		            <!-- 검색 시작 위치를 페이지 단위로 선택 -->
		            <select id="startNum">
		                <option value="1">1페이지</option>
		                <option value="11">2페이지</option>
		                <option value="21">3페이지</option>
		                <option value="31">4페이지</option>
		                <option value="41">5페이지</option>
		            </select>
		            <!-- 검색어를 입력 -->
		            <input type="text" id="keyword" placeholder="검색어를 입력하세요." />
		            <button type="button" id="searchBtn">검색 요청</button> <!-- 검색 요청 버튼 -->
		        </form>
		    </div>
		    <!-- 검색 결과가 출력되는 영역 -->
		    <div class="row" id="searchResult">
		        여기에 검색 결과가 출력됩니다.
		    </div>
	    </div>
	</body>
</html>