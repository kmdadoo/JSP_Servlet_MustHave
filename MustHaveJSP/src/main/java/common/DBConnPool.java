package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/*
	JNDI(Java Naming and Directory Interface) : 디렉토리 서비스에서 제공하는 
		데이터 및 객체를 찾아서 참조(lookup)하는 API로 쉽게 말하면 외부에 
		있는 객체를 이름으로 찾아오기 위한 기술이다.
		
	DECP(DataBase Connection Pool : 커넥션 풀) : DB와 연결된 커넥션 객체를 
		미리 만들어	풀(Pool)에 저장해 뒀다가 필요할 때 가져다 쓰고 반납하는 
		기법을 말한다. DB에 부하를 줄이고 자원을 효율적으로 관리할 수 있다.
*/
public class DBConnPool
{
	// 멤버변수
	public Connection con;
    public Statement stmt;
    public PreparedStatement psmt;
    public ResultSet rs;
    
    /*
	 	커넥션풀 설정을 위해 server.xml, context.xml파일에 엘리먼트를 추가해야 한다. 
	 	자세한 내용은 교체 참조.
	 */
    // 기본 생성자
    public DBConnPool() {
        try {
        	// 1.Context객체를 생성한다. (Tomcat서버라 생각하면 된다.)
        	// InitialContext는 네이밍 서비스를 이용하기 위한 시작점
            Context initCtx = new InitialContext();
            /*
	         	2.앞에서 생성한 객체를 통해 JNDI서비스 구조의 초기 ROOT 디렉토리를 
	         	얻어온다. 여기서 얻어오는 톰켓의 루트 디렉토리명은 java:comp/env로
	         	이미 정해져 있으므로 그대로 사용하면 된다. 
	         */
            Context ctx = (Context)initCtx.lookup("java:comp/env");
            /*
	          	3.sever.xml에 등록한 네이밍을 lookup하여 DataSeouce를 얻어온다. 해당
	          	데이터소스는 DB에 연결하기 위한 정보를 가지고 있다.
				여기서 “dbcp_myoracle”은 context.xml 파일에 추가한〈ResourceLink〉에 
				있는 name 속성의 값
	         */
            DataSource source = (DataSource)ctx.lookup("dbcp_myoracle");
            // 4.커넥션풀에 생성해 놓은 커넥션 객체를 가져다가 사용한다.
            con = source.getConnection();

            System.out.println("DB 커넥션 풀 연결 성공");
        }
        catch (Exception e) {
            System.out.println("DB 커넥션 풀 연결 실패");
            e.printStackTrace();
        }
    }
    
    /*
	 	사용한 끝난 객체는 Pool에 반납한다. 즉 여기서의 close()는 객체의 소멸이 
	 	아닌 반납이다. 
	 */
    public void close() {
        try {            
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (psmt != null) psmt.close();
            if (con != null) con.close(); 

            System.out.println("DB 커넥션 풀 자원 반납");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
