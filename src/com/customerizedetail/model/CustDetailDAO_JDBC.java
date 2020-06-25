package com.customerizedetail.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.product.model.ProductVO;

import Common.common;
import jdbc.util.CompositeQuery.jdbcUtilQuery_For_Index;

public class CustDetailDAO_JDBC implements CustDetailDAO {
	
//	private static final String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	private static final String username = "TDA101G1";
//	private static final String password = "123456";

	private static final String insert = "INSERT INTO CUSTOMERIZE_SCHEDULE_DETAIL "
			+ "VALUES(('CSD'||LPAD(to_char(SEQ_CUST_SCHEDULE_DETAIL_ID.NEXTVAL),6,'0'))" + ", ?, ?, ?, ?, ?)";

	private static final String update = "UPDATE CUSTOMERIZE_SCHEDULE_DETAIL SET CUST_SCHEDULE_ID=?, PRODUCT_ID=?"
			+ ", CUST_SCHEDULE_DETAIL_SEQ=?, CUST_SCHEDULE_DETAIL_DATE=?, CUST_SCHEDULE_DETAIL_INFO=?"
			+ " WHERE CUST_SCHEDULE_DETAIL_ID=?";

	private static final String delete = "DELETE FROM CUSTOMERIZE_SCHEDULE_DETAIL WHERE CUST_SCHEDULE_ID =?";

	private static final String select = "SELECT CUST_SCHEDULE_DETAIL_ID, CUST_SCHEDULE_ID ,PRODUCT_ID"
			+ ", CUST_SCHEDULE_DETAIL_SEQ, CUST_SCHEDULE_DETAIL_DATE, CUST_SCHEDULE_DETAIL_INFO "
			+ "FROM CUSTOMERIZE_SCHEDULE_DETAIL WHERE CUST_SCHEDULE_DETAIL_ID=?";
	
	private static final String select_by_schedule = "SELECT CUST_SCHEDULE_DETAIL_ID, CUST_SCHEDULE_ID ,PRODUCT_ID"
			+ ", CUST_SCHEDULE_DETAIL_SEQ, CUST_SCHEDULE_DETAIL_DATE, CUST_SCHEDULE_DETAIL_INFO "
			+ "FROM CUSTOMERIZE_SCHEDULE_DETAIL WHERE CUST_SCHEDULE_ID=?";

	private static final String getAll = "SELECT CUST_SCHEDULE_DETAIL_ID, CUST_SCHEDULE_ID ,PRODUCT_ID"
			+ ", CUST_SCHEDULE_DETAIL_SEQ, CUST_SCHEDULE_DETAIL_DATE, CUST_SCHEDULE_DETAIL_INFO "
			+ "FROM CUSTOMERIZE_SCHEDULE_DETAIL";
	
			public CustDetailVO insert(CustDetailVO custDetailVO) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String[] pk = {"CUST_SCHEDULE_DETAIL_ID"};
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(insert, pk);
			ps.setString(1, custDetailVO.getCust_Schedule_ID());
			ps.setString(2, custDetailVO.getProduct_ID());
			ps.setInt(3, custDetailVO.getCust_Schedule_Detail_Seq());
			ps.setDate(4, custDetailVO.getCust_Schedule_Detail_Date());
			ps.setString(5, custDetailVO.getCust_Schedule_Detail_Info());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(rs.next()){
				custDetailVO.setCust_Schedule_Detail_ID(rs.getString(1)); 
		    }
			con.commit();
			return custDetailVO;
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
	
	public CustDetailVO update(CustDetailVO custDetailVO) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(update);
			ps.setString(1, custDetailVO.getCust_Schedule_ID());
			ps.setString(2, custDetailVO.getProduct_ID());
			ps.setInt(3, custDetailVO.getCust_Schedule_Detail_Seq());
			ps.setDate(4, custDetailVO.getCust_Schedule_Detail_Date());
			ps.setString(5, custDetailVO.getCust_Schedule_Detail_Info());
			ps.setString(6, custDetailVO.getCust_Schedule_Detail_ID());
			ps.executeUpdate();
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
		return custDetailVO;
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
		return false;
	}

	@Override
	public CustDetailVO select(String cust_Schedule_Detail_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		CustDetailVO custDetail = null; 
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(select);
			ps.setString(1, cust_Schedule_Detail_ID);
			rs = ps.executeQuery();
			if(rs.next()) {
				custDetail = new CustDetailVO();
				custDetail.setCust_Schedule_Detail_ID(rs.getString(1));
				custDetail.setCust_Schedule_ID(rs.getString(2));
				custDetail.setProduct_ID(rs.getString(3));
				custDetail.setCust_Schedule_Detail_Seq(rs.getInt(4));
				custDetail.setCust_Schedule_Detail_Date(rs.getDate(5));
				custDetail.setCust_Schedule_Detail_Info(rs.getString(6));
			}
		} catch (SQLException e) {
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
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return custDetail;
	}
	
	@Override
	public List<CustDetailVO> select_by_schedule(String cust_Schedule_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CustDetailVO> lists = new ArrayList<>();
		CustDetailVO custDetail = null;
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(select_by_schedule);
			ps.setString(1, cust_Schedule_ID);
			rs = ps.executeQuery();
			while (rs.next()) {
				custDetail = new CustDetailVO();
				custDetail.setCust_Schedule_Detail_ID(rs.getString(1));
				custDetail.setCust_Schedule_ID(rs.getString(2));
				custDetail.setProduct_ID(rs.getString(3));
				custDetail.setCust_Schedule_Detail_Seq(rs.getInt(4));
				custDetail.setCust_Schedule_Detail_Date(rs.getDate(5));
				custDetail.setCust_Schedule_Detail_Info(rs.getString(6));
				lists.add(custDetail);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return lists;
	}

	@Override
	public List<CustDetailVO> getAll() {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CustDetailVO> custDetails = new ArrayList<>(); 
		CustDetailVO custDetail = null; 
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(getAll);
			rs = ps.executeQuery();
			while(rs.next()) {
				custDetail = new CustDetailVO();
				custDetail.setCust_Schedule_Detail_ID(rs.getString(1));
				custDetail.setCust_Schedule_ID(rs.getString(2));
				custDetail.setProduct_ID(rs.getString(3));
				custDetail.setCust_Schedule_Detail_Seq(rs.getInt(4));
				custDetail.setCust_Schedule_Detail_Date(rs.getDate(5));
				custDetail.setCust_Schedule_Detail_Info(rs.getString(6));
				custDetails.add(custDetail);
			}
		} catch (SQLException e) {
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
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return custDetails;
	}
	
	
	public List<CustDetailVO> get_detail_join_product(Map<String, String[]> map) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String finalSql = "SELECT CUST_SCHEDULE_DETAIL_ID, CUST_SCHEDULE_ID, CSD.PRODUCT_ID, CUST_SCHEDULE_DETAIL_SEQ," + 
					" CUST_SCHEDULE_DETAIL_DATE, CUST_SCHEDULE_DETAIL_INFO, P.PRODUCT_ID," + 
					" PRODUCT_NAME, PRODUCT_INTRO, PRODUCT_STAYTIME, PRODUCT_ADDRESS, PRODUCT_LATITUTDE," + 
					" PRODUCT_LONGITUDE, PRODUCT_COUNTY FROM CUSTOMERIZE_SCHEDULE_DETAIL CSD" + 
					" JOIN PRODUCT P ON CSD.PRODUCT_ID = P.PRODUCT_ID" + 
					  jdbcUtilQuery_For_Index.getFinalSql_For_detailjoinProduct(map) + 
					" ORDER BY CUST_SCHEDULE_DETAIL_DATE, CUST_SCHEDULE_DETAIL_SEQ";
		System.out.println("finalSql = " + finalSql);
		List<CustDetailVO> detailJoinProduct = new ArrayList<>();
		CustDetailVO custDetail = null;
		ProductVO product = null;
		try {
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(finalSql);
			rs = ps.executeQuery();
			while (rs.next()) {
				custDetail = new CustDetailVO();
				product = new ProductVO();
				custDetail.setCust_Schedule_Detail_ID(rs.getString(1));
				custDetail.setCust_Schedule_ID(rs.getString(2));
				custDetail.setProduct_ID(rs.getString(3));
				custDetail.setCust_Schedule_Detail_Seq(rs.getInt(4));
				custDetail.setCust_Schedule_Detail_Date(rs.getDate(5));
				custDetail.setCust_Schedule_Detail_Info(rs.getString(6));
				product.setProduct_ID(rs.getString(7));
				product.setProduct_Name(rs.getString(8));
				product.setProduct_Intro(rs.getString(9));
				product.setProduct_Staytime(rs.getDouble(10));
				product.setProduct_Address(rs.getString(11));
				product.setProduct_Latitutde(rs.getDouble(12));
				product.setProduct_Longitude(rs.getDouble(13));
				product.setProduct_County(rs.getString(14));
				custDetail.setProductVO(product);
				detailJoinProduct.add(custDetail);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return detailJoinProduct;
	}
}
