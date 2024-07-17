package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.JSFunction;

/*
	글쓰기 페이지로 진입시에는 단순한 페이지 이동이므로 doGet()이 요청을
	처리한다. 즉 글쓰기 페이지만 보여주면 된다.
	내용을 모두 채운후 작성(submit)할때는 post방식이므로 doPost()가 
	요청을 받아 처리한다.
*/
public class WriteController extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	// 글쓰기 페이지로 진입할때의 요청을 처리한다.
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
		// 단순한 포워드 기능만 있으면 된다.
        req.getRequestDispatcher("/14MVCBoard/Write.jsp")
        	.forward(req, resp);
    }
	
	// 클라이언트가 작성한 내용을 DB에 입력하고 파일업로드 처리를 한다.
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
		// 1. 파일 업로드 처리 ===============
		// 파일이 업로드될 디렉토리의 물리적 경로를 얻어온다.
        String saveDirectory = req.getServletContext().getRealPath("/Uploads");
        
        // 13장에서 만든 FileUtil.uploadFile() 메서드 호출
        String originalFileName = "";
        try
		{
			originalFileName = FileUtil.uploadFile(req, saveDirectory);
		} catch (Exception e)
		{
			JSFunction.alertLocation(resp, "파일 업로드 오류 입니다.","../mvcboard/write.do");
			/*
            	객체가 생성돼지 않아 업로드에 실패하면 나머지 폼값도 받을 수 없으므로
            	반드시 return을 통해 실행을 중지시켜야 한다.
			 */
			return;
		}       
        
        // 2. 파일 업로드 외 처리 ============================
        // 파일을 제외한 나머지 폼값을 받아서 DTO객체에 저장한다.
        MVCBoardDTO dto = new MVCBoardDTO(); 
        dto.setName(req.getParameter("name"));
        dto.setTitle(req.getParameter("title"));
        dto.setContent(req.getParameter("content"));
        dto.setPass(req.getParameter("pass"));

        /* 서버에 저장된 파일이 있는 경우에만 파일명 변경 처리를 한다.
         만약 첨부하지 않았다면 아래코드는 실행하지 않는다.*/
        if (originalFileName != "") {
        	// 첩부 파일이 있을 경우 파일명 변경
        	String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
        	
        	dto.setOfile(originalFileName); // 원래 파일 이름
        	dto.setSfile(savedFileName);	// 서버에 저장된 파일 이름
        }

        // 새로운 게시물을 테이블에 입력한다. 
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.insertWrite(dto);
        // 커넥션풀 자원반납
        dao.close();

        // 서블릿에서 특정 요청명으로 이동할 때는 sendRedirect()를 사용하면 된다.
        if (result == 1) {  
        	// 글쓰기에 성공하면 리스트로 이동한다.
            resp.sendRedirect("../mvcboard/list.do");
        }
        else { 
        	// 실패하면 작성페이지로 다시 돌아간다.
            resp.sendRedirect("../mvcboard/write.do");
        }
    }
}
