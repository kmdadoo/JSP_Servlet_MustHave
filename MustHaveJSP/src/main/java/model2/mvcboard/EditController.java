package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/mvcboard/edit.do")
@MultipartConfig(	// 파일업로드를 위한 Multipart 설정
	maxFileSize = 1024 * 1024 * 1,
	maxRequestSize = 1024 * 1024 * 10
)
public class EditController extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	// 수정 페이지로 진입해서 기존 내용을 수정폼에 설정한다.
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException 
	{
		// 수정페이지로 전달된 일련번호를 통해 게시물을 인출한다.
        String idx = req.getParameter("idx");
        MVCBoardDAO dao = new MVCBoardDAO();
        // 기존 게시물 내용을 담을 DTO 객체
        MVCBoardDTO dto = dao.selectView(idx);
        // 인출된 내용은 request영역에 저장한 후 
        req.setAttribute("dto", dto);
        // View로 포원드한다.
        req.getRequestDispatcher("/14MVCBoard/Edit.jsp").forward(req, resp);
    }
	
	// 게시물 수정처리 및 파일 업로드
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // 1. 파일 업로드 처리 =============================
        // 업로드 디렉터리의 물리적 경로 확인
        String saveDirectory = req.getServletContext().getRealPath("/Uploads");
      
        // 파일 업로드
        String originalFileName = "";
        try {
        	originalFileName = FileUtil.uploadFile(req, saveDirectory);
        }
        catch (Exception e) {
        	JSFunction.alertBack(resp, "파일 업로드 오류입니다.");
        	return;
		}

        // 2. 파일 업로드 외 처리 =============================
        // 수정 내용을 매개변수에서 얻어옴
        String idx = req.getParameter("idx");
        String prevOfile = req.getParameter("prevOfile");
        String prevSfile = req.getParameter("prevSfile");

        String name = req.getParameter("name");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
            
        // 비밀번호는 session에서 가져옴
        HttpSession session = req.getSession();
        String pass = (String)session.getAttribute("pass");

        // DTO에 저장
        MVCBoardDTO dto = new MVCBoardDTO();
        dto.setIdx(idx);
        dto.setName(name);
        dto.setTitle(title);
        dto.setContent(content);
        dto.setPass(pass);
            
        // 원본 파일명과 저장된 파일 이름 설정
        if (originalFileName != "") {             
        	String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
        	
            dto.setOfile(originalFileName);  // 원래 파일 이름
            dto.setSfile(savedFileName);  // 서버에 저장된 파일 이름

            // 기존 파일 삭제
            FileUtil.deleteFile(req, "/Uploads", prevSfile);
        }
        else {
            // 첨부 파일이 없으면 기존 이름 유지
            dto.setOfile(prevOfile);
            dto.setSfile(prevSfile);
        }

        // DB에 수정 내용 반영
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.updatePost(dto);
        dao.close();

        // 성공 or 실패?
        if (result == 1) {  // 수정 성공
            session.removeAttribute("pass");
            resp.sendRedirect("../mvcboard/view.do?idx=" + idx);
        }
        else {  // 수정 실패
            JSFunction.alertLocation(resp, "비밀번호 검증을 다시 진행해주세요.",
                "../mvcboard/view.do?idx=" + idx);
        }
    }
}
