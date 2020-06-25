package Common;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class common {
	
	public final static String DRIVER = "oracle.jdbc.driver.OracleDriver"; 
//	public final static String URL = "jdbc:oracle:thin:@localhost:49161:XE";
	public final static String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	public final static String USERID = "TDA101G1";
	public final static String PASSWD = "123456";
			
	public static DataSource dataSource;
	
	static  {
		Context ctx;
		try {
			ctx = new javax.naming.InitialContext();
			dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB3");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static DataSource getDataSource() {
		Context ctx;
		DataSource ds = null;
		try {
			ctx = new javax.naming.InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB3");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ds;
	}
	
			
}
