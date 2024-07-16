package fileupload;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// 어노테이션을 통해 요청명에 대한 매핑을 한다. 
@WebServlet("/13FileUpload/UploadProcess.do")
@MultipartConfig(	// 파일업로드를 처리하기 위한 서블릿 구성 어노테이션. 
	// 멀티파트 요청을 처리
	// 업로드 할 개별 파일의 최대 크기를 1MB로 지정
	maxFileSize = 1024 * 1024 * 1,
	// 멀티파트요청에 포함된 전체 파일의 크기로 10MB로 지정.
	maxRequestSize = 1024 * 1024 * 10
)
public class UploadProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		try {
			// 드라이브 명으로 절대경로 지정하기 
			//String saveDirectory = "C:\Dev\apache-tomcat-10.1.25\wtpwebapps\MustHaveJSP/src/main/webapp/Uploads";
			// Uploads 디렉토리의 물리적 경로 가져오기
		    String saveDirectory = getServletContext().getRealPath("/Uploads");
		    
		    // 파일 업로드 하기
		    String originalFileName = FileUtil.uploadFile(req, saveDirectory);
	        
		    // 저장된 파일명 변경하기
	        String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
	        
	        // DB에 저장하기
	        insertMyFile(req, originalFileName, savedFileName);
	        
	        // 파일 목록 페이지로 이동하기
	        resp.sendRedirect("FileList.jsp");
		}
		catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("errorMessage", "파일 업로드 오류");
			req.getRequestDispatcher("FileUploadMain.jsp").forward(req, resp);
		}
	}
	
	// 매개변수로 정의된 reuqest 내장 객체를 통해 서버로 전송된 폼값을 받을 수 있습니다. 또한
	// 원본파일명과 변경된파일명도 전달받습니다
	private void insertMyFile(HttpServletRequest req, String oFileName, String sFileName) 
	{
		// 파일 외 폼값 받기
	    String title = req.getParameter("title");
	    String[] cateArray = req.getParameterValues("cate");
	    StringBuffer cateBuf = new StringBuffer();
	    if (cateArray == null) {
	        cateBuf.append("선택한 항목 없음");
	    }
	    else {
	        for (String s : cateArray) {
	            cateBuf.append(s + ", ");
	        }
	    }
	    System.out.println("파일외폼값:"+title +"\n"+ cateBuf);
	    
	    // DB에 입력하기
        MyFileDTO dto = new MyFileDTO();
        dto.setTitle(title);
        dto.setCate(cateBuf.toString());
        dto.setOfile(oFileName);
        dto.setSfile(sFileName);

        // DAO를 통해 데이터베이스에 반영
        MyFileDAO dao = new MyFileDAO();
        dao.insertFile(dto);
        dao.close();
	}
}
