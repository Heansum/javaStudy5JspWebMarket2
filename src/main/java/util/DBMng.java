package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBMng {
	private static Connection conn = null;
	
	private DBMng() {
		// 싱글턴 패턴이 적용된 클래스
	}
	
	/**
	 * DBMS 커넥션을 반환하는 메서드
	 * 
	 * @return java.sql.Connection
	 * @throws SQLException : DBMS에 문제가 생겼을 때
	 */
	
	
	
	public static Connection getConnection() throws SQLException {
		if(conn == null) {
			try {
				Class.forName("org.mariadb.jdbc.Driver");
			
				conn = DriverManager.getConnection("jdbc:mariadb://localhost:3307/webmarketdb?user=root&password=koreait");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} // end try
		} // end if
		
		return conn;
	}
	
	public static void closeConnection() {
		if(conn != null) {
			try {
				conn.close();
				
				conn = null;
			} catch (SQLException e) {
				e.printStackTrace();
			} // end try
		} // end if
	}
	
	
}
