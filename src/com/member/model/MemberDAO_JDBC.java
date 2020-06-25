package com.member.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import Common.common;

public class MemberDAO_JDBC implements MemberDAO_interface {

//	private static DataSource ds = null;
//	static {
//		try {
//			Context ctx = new InitialContext();
//			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TDA101G1");
//		} catch (NamingException e) {
//			e.printStackTrace();
//		}
//	}

//	String driver = "oracle.jdbc.driver.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO MEMBERS (member_ID, member_account, member_pwd, member_name, member_phone, member_sex, member_birth, member_mail, member_address, member_img, member_est_time, member_state) VALUES ('MID'||LPAD(to_char(SEQ_MEMBER_ID.NEXTVAL),6,'0'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String UPDATE = "UPDATE members set member_account=?, member_pwd=?, member_name=?, member_phone=?, member_sex=?, member_birth=?, member_mail=?, member_address=?, member_img=?, member_est_time=?, member_state=? where member_id=?";
	private static final String GET_ALL_STMT = "SELECT member_id, member_account, member_pwd, member_name, member_phone, member_sex, member_birth, member_mail, member_address, member_img, member_est_time, member_state FROM members order by member_id";
	private static final String GET_ONE_STMT = "SELECT member_id, member_account, member_pwd, member_name, member_phone, member_sex, member_birth, member_mail, member_address, member_img, member_est_time, member_state FROM members where member_id = ?";
	private static final String GET_ONE_By_Account = "SELECT member_id, member_account, member_pwd, member_name, member_phone, member_sex, member_birth, member_mail, member_address, member_img, member_est_time, member_state FROM members where member_Account = ?";

	@Override // 新增資料
	public MemberVO insert(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
			try {
				Class.forName(common.DRIVER);
//				con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
				con = common.dataSource.getConnection();
				con.setAutoCommit(false);
				ps = con.prepareStatement(INSERT_STMT, new String[] { "MEMBER_ID" });
				ps.setString(1, memberVO.getMember_Account());
				ps.setString(2, memberVO.getMember_Pwd());
				ps.setString(3, memberVO.getMember_Name());
				ps.setString(4, memberVO.getMember_Phone());
				ps.setString(5, memberVO.getMember_Sex());
				ps.setDate(6, memberVO.getMember_Birth());
				ps.setString(7, memberVO.getMember_Mail());
				ps.setString(8, memberVO.getMember_Address());
				ps.setBytes(9, memberVO.getMember_Img());
				ps.setDate(10, memberVO.getMember_Est_Time());
				ps.setInt(11, memberVO.getMember_State());

				ps.executeUpdate();
				rs = ps.getGeneratedKeys();
				if(rs.next()) {
					memberVO.setMember_ID(rs.getString(1));
				}
				con.commit();
				return memberVO;
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			}catch (SQLException e) {
			try {
				con.rollback();
				new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
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
					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

	@Override
	public MemberVO update(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement ps = null;

			try {
				Class.forName(common.DRIVER);
//				con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
				con = common.dataSource.getConnection();
				con.setAutoCommit(false);
				ps = con.prepareStatement(UPDATE);

				ps.setString(1, memberVO.getMember_Account());
				ps.setString(2, memberVO.getMember_Pwd());
				ps.setString(3, memberVO.getMember_Name());
				ps.setString(4, memberVO.getMember_Phone());
				ps.setString(5, memberVO.getMember_Sex());
				ps.setDate(6, memberVO.getMember_Birth());
				ps.setString(7, memberVO.getMember_Mail());
				ps.setString(8, memberVO.getMember_Address());
				ps.setBytes(9, memberVO.getMember_Img());
				ps.setDate(10, memberVO.getMember_Est_Time());
				ps.setInt(11, memberVO.getMember_State());
				ps.setString(12, memberVO.getMember_ID());

				ps.executeUpdate();
				
				con.commit();
				return memberVO;
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			}catch (SQLException e) {
			new RuntimeException("A database error occured. " + e.getMessage());
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
					con.setAutoCommit(false);
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

	@Override
	public MemberVO select(String member_ID) {

		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
			try {
				Class.forName(common.DRIVER);
//				con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
				con = common.dataSource.getConnection();
				ps = con.prepareStatement(GET_ONE_STMT);

				ps.setString(1, member_ID);
				rs = ps.executeQuery();

				while (rs.next()) {
					memberVO = new MemberVO();
					memberVO.setMember_ID(rs.getString("member_id"));
					memberVO.setMember_Account(rs.getString("member_account"));
					memberVO.setMember_Pwd(rs.getString("member_pwd"));
					memberVO.setMember_Name(rs.getString("member_name"));
					memberVO.setMember_Phone(rs.getString("member_phone"));
					memberVO.setMember_Sex(rs.getString("member_sex"));
					memberVO.setMember_Birth(rs.getDate("member_birth"));
					memberVO.setMember_Mail(rs.getString("member_mail"));
					memberVO.setMember_Address(rs.getString("member_address"));
					memberVO.setMember_Img(rs.getBytes("member_img"));
					memberVO.setMember_Est_Time(rs.getDate("member_est_time"));
					memberVO.setMember_State(rs.getInt("member_state"));
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
					e.printStackTrace();
				}
			}
	
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
	
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return memberVO;
	}

	@Override
	public List<MemberVO> selectAll() {

		Connection con = null;
		PreparedStatement ps = null;
		List<MemberVO> members = new ArrayList<MemberVO>();
		ResultSet rs = null;

			try {
				Class.forName(common.DRIVER);
//				con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
				con = common.dataSource.getConnection();
				ps = con.prepareStatement(GET_ALL_STMT);
				rs = ps.executeQuery();
				
					while (rs.next()) {
						MemberVO memberVO = new MemberVO();
						memberVO.setMember_ID(rs.getString("member_id"));
						memberVO.setMember_Account(rs.getString("member_account"));
						memberVO.setMember_Pwd(rs.getString("member_pwd"));
						memberVO.setMember_Name(rs.getString("member_name"));
						memberVO.setMember_Phone(rs.getString("member_phone"));
						memberVO.setMember_Sex(rs.getString("member_sex"));
						memberVO.setMember_Birth(rs.getDate("member_birth"));
						memberVO.setMember_Mail(rs.getString("member_mail"));
						memberVO.setMember_Address(rs.getString("member_address"));
						memberVO.setMember_Img(rs.getBytes("member_img"));
						memberVO.setMember_Est_Time(rs.getDate("member_est_time"));
						memberVO.setMember_State(rs.getInt("member_state"));
						members.add(memberVO);
					}
				
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		finally {
		
			if( rs != null) {
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
		return members;
	}

	public static void main(String[] args) {
		MemberDAO_JDBC dao = new MemberDAO_JDBC();
		System.out.println(dao.selectAll());
		System.out.println(dao.select("MID000002"));
		
		MemberVO member = new MemberVO();
		member.setMember_Account("GGININ");
		member.setMember_Address("台北");
		member.setMember_Birth(java.sql.Date.valueOf("1999-04-02"));
		java.sql.Date today = new Date(new java.util.Date().getTime());
		member.setMember_Est_Time(today);
		member.setMember_Mail("abc@gmail.com");
		member.setMember_Name("王大陸");
		member.setMember_Phone("0912345678");
		member.setMember_Pwd("123");
		member.setMember_Sex("M");
		member.setMember_State(1);
		
		dao.insert(member);
		
	}

	@Override
	public MemberVO selectByAccount(String member_Account) {
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

			try {
				Class.forName(common.DRIVER);
//				con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
				con = common.dataSource.getConnection();
				ps = con.prepareStatement(GET_ONE_By_Account);

				ps.setString(1, member_Account);
				rs = ps.executeQuery();

				while (rs.next()) {
					memberVO = new MemberVO();
					memberVO.setMember_ID(rs.getString("member_id"));
					memberVO.setMember_Account(rs.getString("member_account"));
					memberVO.setMember_Pwd(rs.getString("member_pwd"));
					memberVO.setMember_Name(rs.getString("member_name"));
					memberVO.setMember_Phone(rs.getString("member_phone"));
					memberVO.setMember_Sex(rs.getString("member_sex"));
					memberVO.setMember_Birth(rs.getDate("member_birth"));
					memberVO.setMember_Mail(rs.getString("member_mail"));
					memberVO.setMember_Address(rs.getString("member_address"));
					memberVO.setMember_Img(rs.getBytes("member_img"));
					memberVO.setMember_Est_Time(rs.getDate("member_est_time"));
					memberVO.setMember_State(rs.getInt("member_state"));
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
					e.printStackTrace();
				}
			}
	
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
	
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return memberVO;
	}

}
