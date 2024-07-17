package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/mvcboard/download.do")
public class DownloadController extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException 
	{
		// 매개변수를 파라미터로 받아 온다.
        String ofile = req.getParameter("ofile");   // 원본 파일명
        String sfile = req.getParameter("sfile");   // 저장된 파일명
        String idx = req.getParameter("idx");     // 일련번호

        // 다운로드 메서드를 호출한다.
        FileUtil.download(req, resp, "/Uploads", sfile, ofile);

        // 다운로드 횟수를 증가시킨다.
        MVCBoardDAO dao = new MVCBoardDAO();
        dao.downCountPlus(idx);
        dao.close();
    }
}
