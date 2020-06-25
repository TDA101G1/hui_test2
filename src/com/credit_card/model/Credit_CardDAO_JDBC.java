package com.credit_card.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import Common.common;



public class Credit_CardDAO_JDBC implements Credit_CardDAO_interface {
	
//	String driver = "oracle.jdbc.driver.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String passwd = "123456";
	
	private static final String INSERT_STMT = "INSERT INTO CREDIT_CARD (CREDIT_CARD_NUMBER, MEMBER_ID, CREDIT_CARD_OWNER_NAME, CREDID_CARD_EXPIRE_M, CREDIT_CARD_EXPIRE_Y, CREDIT_CARD_ADDRESS, CREDIT_CARD_POSTAL_CODE, CREDIT_CARD_STATE) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT CREDIT_CARD_NUMBER, MEMBER_ID, CREDIT_CARD_OWNER_NAME, CREDID_CARD_EXPIRE_M, CREDIT_CARD_EXPIRE_Y, CREDIT_CARD_ADDRESS, CREDIT_CARD_POSTAL_CODE, CREDIT_CARD_STATE FROM CREDIT_CARD order by CREDIT_CARD_NUMBER";
	private static final String GET_ONE_STMT = "SELECT CREDIT_CARD_NUMBER, MEMBER_ID, CREDIT_CARD_OWNER_NAME, CREDID_CARD_EXPIRE_M, CREDIT_CARD_EXPIRE_Y, CREDIT_CARD_ADDRESS, CREDIT_CARD_POSTAL_CODE, CREDIT_CARD_STATE FROM CREDIT_CARD where CREDIT_CARD_NUMBER=?";
	private static final String DELETE = "DELETE FROM CREDIT_CARD WHERE CREDIT_CARD_NUMBER=?";
	private static final String SELECT_BY_MEMBER = "SELECT CREDIT_CARD_NUMBER, MEMBER_ID, CREDIT_CARD_OWNER_NAME, CREDID_CARD_EXPIRE_M, CREDIT_CARD_EXPIRE_Y, CREDIT_CARD_ADDRESS, CREDIT_CARD_POSTAL_CODE, CREDIT_CARD_STATE FROM CREDIT_CARD where MEMBER_ID=?";

	@Override
	public List<Credit_CardVO> selectAll() {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Credit_CardVO> cards = new ArrayList<Credit_CardVO>();
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ALL_STMT);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Credit_CardVO card = new Credit_CardVO();
				card.setCredit_Card_Number(rs.getString("credit_card_number"));
				card.setMember_ID(rs.getString("member_id"));
				card.setCredit_Card_Owner_Name(rs.getString("CREDIT_CARD_OWNER_NAME"));
				card.setCredit_Card_Expire_M(rs.getString("CREDID_CARD_EXPIRE_M"));
				card.setCredit_Card_Expire_Y("CREDID_CARD_EXPIRE_Y");
				card.setCredit_Card_Address("CREDIT_CARD_ADDRESS");
				card.setCredit_Card_Postal_Code(rs.getString("CREDIT_CARD_POSTAL_CODE"));
				card.setCredit_Card_State(rs.getInt("CREDIT_CARD_STATE"));
				cards.add(card);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		return cards;
	}

	@Override
	public Credit_CardVO insert(Credit_CardVO credit_CardVO) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(INSERT_STMT);
			con.setAutoCommit(false);
			ps.setString(1, credit_CardVO.getCredit_Card_Number());
			ps.setString(2, credit_CardVO.getMember_ID());
			ps.setString(3, credit_CardVO.getCredit_Card_Owner_Name());
			ps.setString(4, credit_CardVO.getCredit_Card_Expire_M());
			ps.setString(5, credit_CardVO.getCredit_Card_Expire_Y());
			ps.setString(6, credit_CardVO.getCredit_Card_Address());
			ps.setString(7, credit_CardVO.getCredit_Card_Postal_Code());
			ps.setInt(8, credit_CardVO.getCredit_Card_State());
			
			ps.executeUpdate();
			con.commit();
			
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
					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return credit_CardVO;
		
	}

	@Override
	public Integer delete(String credit_Card_Number) {
		Connection con = null;
		PreparedStatement ps = null;
		Integer result = -1;
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(DELETE);
			con.setAutoCommit(false);
			ps.setString(1, credit_Card_Number);
			
			result = ps.executeUpdate();
			con.commit();
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
					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return result;
		
	}

	@Override
	public Credit_CardVO select(String credit_Card_Number) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Credit_CardVO card = null;
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ONE_STMT);
			card = new Credit_CardVO();
			ps.setString(1, credit_Card_Number);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				card.setCredit_Card_Number(rs.getString("credit_card_number"));
				card.setMember_ID(rs.getString("member_id"));
				card.setCredit_Card_Owner_Name(rs.getString("CREDIT_CARD_OWNER_NAME"));
				card.setCredit_Card_Expire_M(rs.getString("CREDID_CARD_EXPIRE_M"));
				card.setCredit_Card_Expire_Y("CREDID_CARD_EXPIRE_Y");
				card.setCredit_Card_Address("CREDIT_CARD_ADDRESS");
				card.setCredit_Card_Postal_Code(rs.getString("CREDIT_CARD_POSTAL_CODE"));
				card.setCredit_Card_State(rs.getInt("CREDIT_CARD_STATE"));
				
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());

		}
		finally {
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
		
		return card;
	}

	@Override
	public Set<Credit_CardVO> getCredit_CardByMember_ID(String member_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Set<Credit_CardVO> cards = new HashSet<Credit_CardVO>();
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(SELECT_BY_MEMBER);
			ps.setString(1, member_ID);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Credit_CardVO card = new Credit_CardVO();
				card.setCredit_Card_Number(rs.getString("credit_card_number"));
				card.setMember_ID(rs.getString("member_id"));
				card.setCredit_Card_Owner_Name(rs.getString("CREDIT_CARD_OWNER_NAME"));
				card.setCredit_Card_Expire_M(rs.getString("CREDID_CARD_EXPIRE_M"));
				card.setCredit_Card_Expire_Y("CREDID_CARD_EXPIRE_Y");
				card.setCredit_Card_Address("CREDIT_CARD_ADDRESS");
				card.setCredit_Card_Postal_Code(rs.getString("CREDIT_CARD_POSTAL_CODE"));
				card.setCredit_Card_State(rs.getInt("CREDIT_CARD_STATE"));
				cards.add(card);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		return cards;
	}

}
