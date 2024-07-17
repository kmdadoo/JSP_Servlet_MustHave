package utils;

import java.io.PrintWriter;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.jsp.JspWriter;	// out이 JspWriter 타입

public class JSFunction
{
	/*
	  	메서드 생성시 static을 통해 정적메서드로 정의되었으므로
	  	객체 생성없이 클래스명으로 즉시 메서드를 호출할 수 있다. 
	 */
	// 메시지 알림창을 띄운 후 명시한 URL로 이동합니다.
	/*
		• msg ： 알림창에 띄울 메시지
		• url : 알림창을 닫은 후 이동할 페이지의 URL 
		• out ： 자바스크립트 코드를 삽입할 출력 스트림(JSP의 out 내장 객체)
	*/
	public static void alertLocation(String msg, String url, 
			JspWriter out) 
	{
		/*
		 	Java클래스에서는 JSP의 내장객체를 사용할 수 없으므로 반드시
		 	매개변수로 전달받아 사용해야 한다.
		 	여기서는 화면에 문자열을 출력하기 위해 out 내장객체를 JspWriter
		 	타입으로 받은 후 사용하고 있다. 
		 */
        try {
        	// JS를 하나의 문자열로 정의한다.［예제 4-6］내용임
            String script = "<script>" // 삽입할 자바스크립트 코드
                          + "    alert('" + msg + "');"
                          + "    location.href='" + url + "';"
                          + "</script>";
            // 해당 문자열을 웹브라우저에 출력한다.
            out.println(script);	// 자바스클립트 코드를 out 내장 객체로 출력
        }
        catch (Exception e) {}
    }
	
	//  메시지 알림창을 띄운 후 이전 페이지로 돌아갑니다.
    public static void alertBack(String msg, JspWriter out) 
    {
        try {
            String script = "<script>"
                          + "    alert('" + msg + "');"
                          + "    history.back();"
                          + "</script>";
            out.println(script);
        }
        catch (Exception e) {}
    }

    public static void alertLocation(HttpServletResponse resp, String msg, String url) 
    {
        try {
        	resp.setContentType("text/html; charset=UTF-8");
        	PrintWriter writer = resp.getWriter();
        	
            String script = "<script>"
                          + "    alert('" + msg + "');"
                          + "    location.href='" + url + "';"
                          + "</script>";
            writer.println(script);
        }
        catch (Exception e) {}
    }
    
    public static void alertBack(HttpServletResponse resp, String msg) 
    {
        try {
        	resp.setContentType("text/html; charset=UTF-8");
        	PrintWriter writer = resp.getWriter();
        	
            String script = "<script>"
                          + "    alert('" + msg + "');"
                          + "    history.back();"
                          + "</script>";
            writer.println(script);
        }
        catch (Exception e) {}
    }

}
