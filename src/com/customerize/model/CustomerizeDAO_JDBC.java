package com.customerize.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import Common.common;

public class CustomerizeDAO_JDBC implements CustomerizeDAO {
//	private static final String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	private static final String username = "TDA101G1";
//	private static final String password = "123456";
	
	private static final String insert = "INSERT INTO CUSTOMERIZE_SCHEDULE (CUST_SCHEDULE_ID, MEMBER_ID"
			+ ", CUST_SCHEDULE_NAME, CUST_SCHEDULE_CLICK_RECORD, CUST_SCHEDULE_START_TIME, CUST_SCHEDULE_END_TIME"
			+ ", CUST_SCHEDULE_TOTAL_DAY, CUST_SCHEDULE_SHARE, CUST_SCHEDULE_STATE, CUST_SCHEDULE_IMG, CUST_POSITION "
			+ ", CUST_QUANTITY, CUST_SELECTED_COUNTY)"
			+ " VALUES(('CID'||LPAD(to_char(SEQ_CUST_SCHEDULE_ID.NEXTVAL),6,'0'))"
			+ ", ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	private static final String update = "UPDATE CUSTOMERIZE_SCHEDULE SET MEMBER_ID=?,CUST_SCHEDULE_NAME=?"
			+ ", CUST_SCHEDULE_CLICK_RECORD=?, CUST_SCHEDULE_START_TIME=?, CUST_SCHEDULE_END_TIME=?"
			+ ", CUST_SCHEDULE_TOTAL_DAY=?, CUST_SCHEDULE_SHARE=?, CUST_SCHEDULE_STATE=?"
			+ ", CUST_SCHEDULE_LAST_TIMESTAMP=CURRENT_TIMESTAMP, CUST_SCHEDULE_IMG=?, CUST_POSITION=?"
			+ ", CUST_QUANTITY=?, CUST_SELECTED_COUNTY=? WHERE CUST_SCHEDULE_ID=?";
	
	private static final String delete = "DELETE FROM CUSTOMERIZE_SCHEDULE WHERE CUST_SCHEDULE_ID=?";
	
	private static final String select = "SELECT CUST_SCHEDULE_ID, MEMBER_ID, CUST_SCHEDULE_NAME"
			+ ", CUST_SCHEDULE_CLICK_RECORD, CUST_SCHEDULE_START_TIME, CUST_SCHEDULE_END_TIME"
			+ ", CUST_SCHEDULE_TOTAL_DAY, CUST_SCHEDULE_SHARE, CUST_SCHEDULE_STATE, CUST_SCHEDULE_LAST_TIMESTAMP"
			+ ", CUST_POSITION, CUST_QUANTITY, CUST_SELECTED_COUNTY, CUST_SCHEDULE_IMG FROM CUSTOMERIZE_SCHEDULE WHERE CUST_SCHEDULE_ID =?";
	//, position, people, selected_county 
	private static final String getAll = "SELECT CUST_SCHEDULE_ID, MEMBER_ID, CUST_SCHEDULE_NAME"
			+ ", CUST_SCHEDULE_CLICK_RECORD, CUST_SCHEDULE_START_TIME, CUST_SCHEDULE_END_TIME"
			+ ", CUST_SCHEDULE_TOTAL_DAY, CUST_SCHEDULE_SHARE, CUST_SCHEDULE_STATE, CUST_SCHEDULE_LAST_TIMESTAMP"
			+ ", CUST_POSITION, CUST_QUANTITY, CUST_SELECTED_COUNTY FROM CUSTOMERIZE_SCHEDULE";
	
	@Override
	public CustomerizeVO insert(CustomerizeVO custVO) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String[] pk = {"CUST_SCHEDULE_ID", "cust_Schedule_Last_Timestamp"};
		try {
//			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(insert, pk);
			ps.setString(1, custVO.getMember_ID());
			ps.setString(2, custVO.getCust_Schedule_Name());
			ps.setInt(3, custVO.getCust_Schedule_Click_Record());
			ps.setDate(4, custVO.getCust_Schedule_Start_Time());
			ps.setDate(5, custVO.getCust_Schedule_End_Time());
			ps.setInt(6, custVO.getCust_Schedule_Total_Day());
			ps.setInt(7, custVO.getCust_Schedule_Share());
			ps.setInt(8, custVO.getCust_Schedule_State());
			ps.setBytes(9, custVO.getCust_Schedule_Img());
			ps.setString(10, custVO.getCust_Position());
			ps.setInt(11, custVO.getCust_Quantity());
			ps.setString(12, custVO.getCust_Selected_County());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(rs.next()){
				custVO.setCust_Schedule_ID(rs.getString(1)); 
				custVO.setCust_Schedule_Last_Timestamp(rs.getTimestamp(2)); 
		    }
			con.commit();
			return custVO;
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
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
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	@Override
	public CustomerizeVO update(CustomerizeVO custVO) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(update);
			ps.setString(1, custVO.getMember_ID());
			ps.setString(2, custVO.getCust_Schedule_Name());
			ps.setInt(3, custVO.getCust_Schedule_Click_Record());
			ps.setDate(4, custVO.getCust_Schedule_Start_Time());
			ps.setDate(5, custVO.getCust_Schedule_End_Time());
			ps.setInt(6, custVO.getCust_Schedule_Total_Day());
			ps.setInt(7, custVO.getCust_Schedule_Share());
			ps.setInt(8, custVO.getCust_Schedule_State());
			ps.setBytes(9, custVO.getCust_Schedule_Img());
			ps.setString(10, custVO.getCust_Position());
			ps.setInt(11, custVO.getCust_Quantity());
			ps.setString(12, custVO.getCust_Selected_County());
			ps.setString(13, custVO.getCust_Schedule_ID());
			int row = ps.executeUpdate();
			System.out.println("更新了" + row + "筆");
			con.commit();
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return custVO;
	}

	@Override
	public boolean delete(String cust_Schedule_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(delete);
			ps.setString(1, cust_Schedule_ID);
			ps.executeUpdate();
			con.commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}

	@Override
	public CustomerizeVO select(String cust_Schedule_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		CustomerizeVO cust = null;
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(select);
			ps.setString(1, cust_Schedule_ID);
			rs = ps.executeQuery();
			if(rs.next()) {
				cust = new CustomerizeVO();
				cust.setCust_Schedule_ID(rs.getString(1));
				cust.setMember_ID(rs.getString(2));
				cust.setCust_Schedule_Name(rs.getString(3));
				cust.setCust_Schedule_Click_Record(rs.getInt(4));
				cust.setCust_Schedule_Start_Time(rs.getDate(5));
				cust.setCust_Schedule_End_Time(rs.getDate(6));
				cust.setCust_Schedule_Total_Day(rs.getInt(7));
				cust.setCust_Schedule_Share(rs.getInt(8));
				cust.setCust_Schedule_State(rs.getInt(9));
				cust.setCust_Schedule_Last_Timestamp(rs.getTimestamp(10));
				cust.setCust_Position(rs.getString(11));
				cust.setCust_Quantity(rs.getInt(12));
				cust.setCust_Selected_County(rs.getString(13));
				cust.setCust_Schedule_Img(rs.getBytes(14));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return cust;
	}

	@Override
	public List<CustomerizeVO> getAll() {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CustomerizeVO> custs = new ArrayList<CustomerizeVO>();
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(getAll);
			rs = ps.executeQuery();
			while(rs.next()) {
				CustomerizeVO cust = new CustomerizeVO();
				cust.setCust_Schedule_ID(rs.getString(1));
				cust.setMember_ID(rs.getString(2));
				cust.setCust_Schedule_Name(rs.getString(3));
				cust.setCust_Schedule_Click_Record(rs.getInt(4));
				cust.setCust_Schedule_Start_Time(rs.getDate(5));
				cust.setCust_Schedule_End_Time(rs.getDate(6));
				cust.setCust_Schedule_Total_Day(rs.getInt(7));
				cust.setCust_Schedule_Share(rs.getInt(8));
				cust.setCust_Schedule_State(rs.getInt(9));
				cust.setCust_Schedule_Last_Timestamp(rs.getTimestamp(10));
				cust.setCust_Position(rs.getString(11));
				cust.setCust_Quantity(rs.getInt(12));
				cust.setCust_Selected_County(rs.getString(13));
//				cust.setCust_Schedule_Img(rs.getBytes(14));        
				custs.add(cust);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return custs;
	}
}
