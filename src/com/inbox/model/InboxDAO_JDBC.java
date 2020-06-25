package com.inbox.model;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import Common.common;
import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Inbox;

public class InboxDAO_JDBC implements InboxDAO_interface{

//	String driver = "oracle.jdbc.driver.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String passwd = "123456";
	
//已加state
	private static final String INSERT_STMT = "INSERT INTO Inbox (inbox_mail_id, member_id, emp_id, inbox_mail_info, inbox_mail_title, inbox_mail_state) VALUES ('IMID'||LPAD(to_char(SEQ_INBOX_MAIL_ID.NEXTVAL),6,'0'), ?, ?, ?,?,?)";
	private static final String UPDATE = "UPDATE inbox set member_id=?, emp_id=?, inbox_mail_info=?, inbox_mail_title=?, inbox_mail_timestamp=CURRENT_TIMESTAMP where inbox_mail_id=?";
//已加state
	private static final String GET_ALL_STMT = "SELECT inbox_mail_id, member_id, emp_id, inbox_mail_info, inbox_mail_title, inbox_mail_timestamp, inbox_mail_state FROM inbox order by inbox_mail_id";
	private static final String GET_ONE_STMT = "SELECT inbox_mail_id, member_id, emp_id, inbox_mail_info, inbox_mail_title, inbox_mail_timestamp FROM inbox where inbox_mail_id = ?";
	private static final String DELETE = "DELETE from inbox where inbox_mail_id=?";
	private static final String SELECT_BY_MEMEBER = "SELECT inbox_mail_id, member_id, emp_id, inbox_mail_info, inbox_mail_title, inbox_mail_timestamp, inbox_mail_state FROM inbox where member_id=?";


//====================================================SELECT ONE START========================================	
	@Override
	public InboxVO select(String inbox_Mail_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		InboxVO inboxVO = null;
		ResultSet rs = null;
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ONE_STMT);
			ps.setString(1, inbox_Mail_ID);
			rs = ps.executeQuery();
			
			
			inboxVO = new InboxVO();
			while(rs.next()) {
				inboxVO.setInbox_Mail_ID(rs.getString("inbox_mail_id"));
				inboxVO.setInbox_Mail_TimeStamp(rs.getTimestamp("inbox_mail_timestamp"));  //加上ＤＡＴＥ
				inboxVO.setInbox_Mail_Info(rs.getString("inbox_mail_info"));
				inboxVO.setInbox_Mail_Title(rs.getString("inbox_mail_title"));
				inboxVO.setEmp_ID(rs.getString("emp_id"));
				inboxVO.setMember_ID(rs.getString("member_id"));
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		finally{
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return inboxVO;
	}
	
//==================================================SELECT ONE END================================================
	
//==================================================SELECT ALL START==============================================

	@Override
	public List<InboxVO> selectAll() {
		System.out.println("selectALL");
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		InboxVO inboxVO = null;
		List<InboxVO>inboxs = new ArrayList<InboxVO>();
		
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ALL_STMT);
			rs = ps.executeQuery();
			System.out.println("selectALL");

			while(rs.next()) {

				inboxVO = new InboxVO();
				inboxVO.setEmp_ID(rs.getString("emp_id"));
				inboxVO.setInbox_Mail_TimeStamp(rs.getTimestamp("inbox_mail_timestamp")); //加上date
				inboxVO.setInbox_Mail_ID(rs.getString("inbox_mail_id"));
				inboxVO.setInbox_Mail_Info(rs.getString("inbox_mail_info"));
				inboxVO.setInbox_Mail_Title(rs.getString("inbox_mail_title"));
				inboxVO.setMember_ID(rs.getString("member_id"));
				inboxVO.setInbox_Mail_State(rs.getString("inbox_mail_state"));
				inboxs.add(inboxVO);

			}
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		finally {
			System.out.println("selectALL");

			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return inboxs;
	}
//==================================================SELECT ALL END==============================================
//==================================================INSERT  START==============================================	
	@Override
	public InboxVO insert(InboxVO inboxVO) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
//			con.setAutoCommit(false);
			ps = con.prepareStatement(INSERT_STMT, new String[] { "INBOX_MAIL_ID" });
			ps.setString(1, inboxVO.getMember_ID());
			ps.setString(2, inboxVO.getEmp_ID());
			ps.setString(3, inboxVO.getInbox_Mail_Info());
			ps.setString(4, inboxVO.getInbox_Mail_Title());
			ps.setString(5, inboxVO.getInbox_Mail_State());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(rs.next()) {
				inboxVO.setInbox_Mail_ID(rs.getString(1));
			}
//			con.commit();
			return inboxVO;
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
//					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return null;
	}
//==================================================INSERT END==============================================

//==================================================UPDATE START==============================================

	@Override
	public InboxVO update(InboxVO inboxVO) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
//			con.setAutoCommit(false);
			ps = con.prepareStatement(UPDATE);
			
			ps.setString(1, inboxVO.getMember_ID());
			ps.setString(2, inboxVO.getEmp_ID());
			ps.setString(3, inboxVO.getInbox_Mail_Info());
			ps.setString(4, inboxVO.getInbox_Mail_Title());
			ps.setString(5, inboxVO.getInbox_Mail_ID());
			
			ps.executeUpdate();
//			con.commit();
			return inboxVO;
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if (con != null) {
				try {
//					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
		
	}

//==================================================UPDATE END==============================================
	
//==================================================DELETE START=================================================

	@Override
	public Integer delete(String inbox_Mail_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		Integer result = -1;
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
//			con.setAutoCommit(false);
			ps = con.prepareStatement(DELETE);
			
			ps.setString(1, inbox_Mail_ID);
			result = ps.executeUpdate();
			
//			con.commit();
			return result;
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
//					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return result;
	}
//==================================================DELETE END==============================================

	
//==================================================SELECT BY MEMBER END=========================================
	@Override
	public Set<InboxVO> selectByMember(String member_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Set<InboxVO>inboxs = new HashSet<InboxVO>();
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(SELECT_BY_MEMEBER);
			ps.setString(1, member_ID);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				InboxVO inbox = new InboxVO();
				inbox.setEmp_ID(rs.getString("emp_ID"));
				inbox.setInbox_Mail_TimeStamp(rs.getTimestamp("inbox_mail_timestamp"));
				inbox.setInbox_Mail_ID(rs.getString("inbox_mail_id"));
				inbox.setInbox_Mail_Info(rs.getString("inbox_mail_info"));
				inbox.setInbox_Mail_Title(rs.getString("inbox_mail_title"));
				inbox.setMember_ID(rs.getString("member_id"));
				inbox.setInbox_Mail_State(rs.getString("inbox_mail_state"));
				
				inboxs.add(inbox);
				
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		
		finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return inboxs;
	}
	
	@Override
	public Set<InboxVO> selectByMember(String member_ID, Map<String, String[]> map) {
		Set<InboxVO>inboxs = new HashSet<InboxVO>();
		InboxVO inbox = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
//			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			String finalSQL = "select * from inbox where member_id=? " + jdbcUtil_CompositeQuery_Inbox.get_WhereCondition(map);
			ps = con.prepareStatement(finalSQL);
			ps.setString(1, member_ID);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				inbox = new InboxVO();
				inbox.setEmp_ID(rs.getString("emp_ID"));
				inbox.setInbox_Mail_TimeStamp(rs.getTimestamp("inbox_mail_timestamp"));
				inbox.setInbox_Mail_ID(rs.getString("inbox_mail_id"));
				inbox.setInbox_Mail_Info(rs.getString("inbox_mail_info"));
				inbox.setInbox_Mail_Title(rs.getString("inbox_mail_title"));
				inbox.setMember_ID(rs.getString("member_id"));
				inbox.setInbox_Mail_State(rs.getString("inbox_mail_state"));
				
				inboxs.add(inbox);
				
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		
		finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return inboxs;
	}
	
public static void main(String[] args) {
	InboxDAO_JDBC dao = new InboxDAO_JDBC();
//	System.out.println(dao.select(1));
	System.out.println(dao.selectAll());
	InboxVO inbox = new InboxVO();
//	inbox.setEmp_ID("1000");
//	inbox.setInbox_Mail_Info("這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試");
//	inbox.setMember_ID("3");
//	dao.insert(inbox);
	
//	inbox.setInbox_Mail_ID("5");
//	inbox.setEmp_ID("1000");
//	inbox.setMember_ID("5");
//	inbox.setInbox_Mail_Info("update test");
//	dao.update(inbox);
	
//	dao.delete("6");
	
	System.out.println(dao.selectByMember("3"));
	
}



}
