package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
	어노테이션을 통한 요청명 매핑으로 *를 통해 여러 요청명을 한번에 매핑한다.
	즉, .one으로 끝나는 모든 요청에 대해 매핑 처리하였다.
*/
@WebServlet("*.one")
public class FrontController extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	/*
		get방식으로 들어오는 요청을 처리하기 위해 doGet메서드를 오버라이딩
		해야 한다. 만약 서블릿이 이 메서드가 정의되지 않았다면 405에러가
		발생하게 된다. 즉 해당 방식의 요청을 처리할 수 없다는 의미이다.
	*/
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		// request내장객체를 통해 현재 요청된 URL을 얻어 온다. 즉 웹브라우저의
		// 주소표시줄에 있는 전체경로명에서 HOST(localhost)를 제외한 나머지
		// 경로를 얻어 올 수 있다.
		String uri = req.getRequestURI();
		// URL의 마지막 /의 index를 얻어 온다.
        int lastSlash = uri.lastIndexOf("/");
        // 앞에서 얻어온 index를 통해 URL을 자른다. 즉 마지막에 있는 요청명만
        // 남긴다.
        String commandStr = uri.substring(lastSlash);
        // 마지막 요청명을 통해 요청을 판단한 후 해당 요청을 처리할 
        // 메서드를 호출한다. 이때 사용자의 요청정보를 담은 request객체를
        // 인수로 전달한다.즉 모든 요청을 메서드로 전달하는 것이다.
        if (commandStr.equals("/regist.one")) 
            registFunc(req);	// 회원가입 요청
        else if (commandStr.equals("/login.one"))
            loginFunc(req);		// 로그인 요청
        else if (commandStr.equals("/freeboard.one"))
            freeboardFunc(req);	// 자유게시판 요청

        // 요청명에 관련된 변수들을 request 영역에 저장한다.
        req.setAttribute("uri", uri);
        req.setAttribute("commandStr", commandStr); 
        // View로 포워드 한다.
        req.getRequestDispatcher("/12Servlet/FrontController.jsp").forward(req, resp);
	}
	
	// 페이지별 처리 매서드. 각 페이지에 출력할 데이터를 request 영역에 저장
	void registFunc(HttpServletRequest req) {
        req.setAttribute("resultValue", "<h4>회원가입1</h4>");
    }

    void loginFunc(HttpServletRequest req) {
        req.setAttribute("resultValue", "<h4>로그인2</h4>");
    }

    void freeboardFunc(HttpServletRequest req) {
        req.setAttribute("resultValue", "<h4>자유게시판3</h4>");
    }
    
    /*
		이렇게 하면 요청명마다 매번 서블릿을 하나씩 만들지 않아도 되니 
		편리하다. 서블릿 클래스의 내용이 방대해질 수 있으므로 카테고리
		별로 구분하여 작성하는 것이 좋습니다.
	*/
}
