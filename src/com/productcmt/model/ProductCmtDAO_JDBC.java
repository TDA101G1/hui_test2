package com.productcmt.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.CommonDataSource;

import Common.common;


public class ProductCmtDAO_JDBC implements ProductCmtDAO {

//	String driver = "oracle.jdbc.driver.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String passwd = "123456";
//	Class.forName(common.DRIVER);
//	con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
	private static final String insert = "INSERT INTO PRODUCT_CMT (PRODUCT_CMT_ID, PRODUCT_ID, MEMBER_ID "
			+ ", PRODUCT_CMT_GRADE, PRODUCT_CMT_INFO, PRODUCT_CMT_IMG1, PRODUCT_CMT_IMG2)"
			+ "VALUES(('CMT'||LPAD(to_char(SEQ_PRODUCT_CMT_ID.NEXTVAL),6,'0'))" + ", ?, ?, ?, ?, ?, ?)";

	private static final String update = "UPDATE PRODUCT_CMT SET PRODUCT_ID=?, MEMBER_ID=?"
			+ ", PRODUCT_CMT_GRADE=?, PRODUCT_CMT_INFO=?, PRODUCT_CMT_IMG1=?, PRODUCT_CMT_IMG2=?"
			+ ", PRODUCT_CMT_TIMESTAMP=CURRENT_TIMESTAMP WHERE PRODUCT_CMT_ID=?";

	private static final String delete = "DELETE FROM PRODUCT_CMT WHERE PRODUCT_CMT_ID=?";

	private static final String select = "SELECT PRODUCT_CMT_ID, PRODUCT_ID, MEMBER_ID, PRODUCT_CMT_GRADE"
			+ ", PRODUCT_CMT_INFO, PRODUCT_CMT_IMG1, PRODUCT_CMT_IMG2, PRODUCT_CMT_TIMESTAMP "
			+ "FROM PRODUCT_CMT WHERE PRODUCT_CMT_ID=?";
	
	private static final String select_by_member = "SELECT PRODUCT_CMT_ID, PRODUCT_ID, MEMBER_ID, PRODUCT_CMT_GRADE"
			+ ", PRODUCT_CMT_INFO, PRODUCT_CMT_IMG1, PRODUCT_CMT_IMG2, PRODUCT_CMT_TIMESTAMP "
			+ "FROM PRODUCT_CMT WHERE MEMBER_ID=?";
	
//耀升為了加速註解的，包含下面的getAll方法圖片被註解
//	private static final String select_by_product = "SELECT PRODUCT_CMT_ID, PRODUCT_ID, MEMBER_ID, PRODUCT_CMT_GRADE"
//			+ ", PRODUCT_CMT_INFO, PRODUCT_CMT_IMG1, PRODUCT_CMT_IMG2, PRODUCT_CMT_TIMESTAMP "
//			+ "FROM PRODUCT_CMT WHERE PRODUCT_ID=?";
	
	private static final String select_by_product = "SELECT PRODUCT_CMT_ID, PRODUCT_ID, MEMBER_ID, PRODUCT_CMT_GRADE , PRODUCT_CMT_INFO, PRODUCT_CMT_TIMESTAMP FROM PRODUCT_CMT WHERE PRODUCT_ID=?";

//耀升為了加速註解的，包含下面的getAll方法圖片被註解
//	private static final String getAll = "SELECT PRODUCT_CMT_ID, PRODUCT_ID, MEMBER_ID, PRODUCT_CMT_GRADE, PRODUCT_CMT_INFO, PRODUCT_CMT_IMG1, PRODUCT_CMT_IMG2, PRODUCT_CMT_TIMESTAMP FROM PRODUCT_CMT";
	private static final String getAll = "SELECT PRODUCT_CMT_ID, PRODUCT_ID, MEMBER_ID, PRODUCT_CMT_GRADE, PRODUCT_CMT_INFO, PRODUCT_CMT_TIMESTAMP FROM PRODUCT_CMT";
	
	@Override
	public ProductCmtVO insert(ProductCmtVO productCMTVO) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String[] pk = { "PRODUCT_CMT_ID" };
		try {
			try {
				Class.forName(common.DRIVER);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
			con = common.dataSource.getConnection();	
			ps = con.prepareStatement(insert, pk);
			ps.setString(1, productCMTVO.getProduct_ID());
			ps.setString(2, productCMTVO.getMember_ID());
			ps.setDouble(3, productCMTVO.getProduct_Cmt_Grade());
			ps.setString(4, productCMTVO.getProduct_Cmt_Info());
			ps.setBytes(5, productCMTVO.getProduct_Cmt_Img1());
			ps.setBytes(6, productCMTVO.getProduct_Cmt_Img2());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				productCMTVO.setProduct_Cmt_ID(rs.getString(1));
			}
			con.commit();
			;
			return productCMTVO;
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
	public ProductCmtVO update(ProductCmtVO productCMTVO) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			try {
				Class.forName(common.DRIVER);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
			con = common.dataSource.getConnection();	
			con.setAutoCommit(false);
			ps = con.prepareStatement(update);
			ps.setString(1, productCMTVO.getProduct_ID());
			ps.setString(2, productCMTVO.getMember_ID());
			ps.setDouble(3, productCMTVO.getProduct_Cmt_Grade());
			ps.setString(4, productCMTVO.getProduct_Cmt_Info());
			ps.setBytes(5, productCMTVO.getProduct_Cmt_Img1());
			ps.setBytes(6, productCMTVO.getProduct_Cmt_Img2());
			ps.setString(7, productCMTVO.getProduct_Cmt_ID());
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
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return productCMTVO;
	}

	@Override
	public boolean delete(String product_Cmt_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			try {
				Class.forName(common.DRIVER);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
			con = common.dataSource.getConnection();	
			con.setAutoCommit(false);
			ps = con.prepareStatement(delete);
			ps.setString(1, product_Cmt_ID);
			ps.executeUpdate();
			con.commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (con != null) {
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
	public ProductCmtVO select(String product_Cmt_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ProductCmtVO cmtVO = null;
		try {
			try {
				Class.forName(common.DRIVER);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
			con = common.dataSource.getConnection();	
			ps = con.prepareStatement(select);
			ps.setString(1, product_Cmt_ID);
			rs = ps.executeQuery();
			if (rs.next()) {
				cmtVO = new ProductCmtVO();
				cmtVO.setProduct_Cmt_ID(rs.getString(1));
				cmtVO.setProduct_ID(rs.getString(2));
				cmtVO.setMember_ID(rs.getString(3));
				cmtVO.setProduct_Cmt_Grade(rs.getDouble(4));
				cmtVO.setProduct_Cmt_Info(rs.getString(5));
				cmtVO.setProduct_Cmt_Img1(rs.getBytes(6));
				cmtVO.setProduct_Cmt_Img2(rs.getBytes(7));
				cmtVO.setProduct_Cmt_Timestamp(rs.getTimestamp(8));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
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
		return cmtVO;
	}

	@Override
	public List<ProductCmtVO> select_by_member(String member_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<ProductCmtVO> lists = new ArrayList<>();
		ProductCmtVO cmtVO = null;
		try {
			try {
				Class.forName(common.DRIVER);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
			con = common.dataSource.getConnection();	
			ps = con.prepareStatement(select_by_member);
			ps.setString(1, member_ID);
			rs = ps.executeQuery();
			while (rs.next()) {
				cmtVO = new ProductCmtVO();
				cmtVO.setProduct_Cmt_ID(rs.getString(1));
				cmtVO.setProduct_ID(rs.getString(2));
				cmtVO.setMember_ID(rs.getString(3));
				cmtVO.setProduct_Cmt_Grade(rs.getDouble(4));
				cmtVO.setProduct_Cmt_Info(rs.getString(5));
				cmtVO.setProduct_Cmt_Img1(rs.getBytes(6));
				cmtVO.setProduct_Cmt_Img2(rs.getBytes(7));
				cmtVO.setProduct_Cmt_Timestamp(rs.getTimestamp(8));
				lists.add(cmtVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
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
	public List<ProductCmtVO> select_by_product(String product_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<ProductCmtVO> lists = new ArrayList<>();
		ProductCmtVO cmtVO = null;
		try {
			try {
				Class.forName(common.DRIVER);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
			con = common.dataSource.getConnection();	
			ps = con.prepareStatement(select_by_product);
			ps.setString(1, product_ID);
			rs = ps.executeQuery();
			while (rs.next()) {
				cmtVO = new ProductCmtVO();
				cmtVO.setProduct_Cmt_ID(rs.getString(1));
				cmtVO.setProduct_ID(rs.getString(2));
				cmtVO.setMember_ID(rs.getString(3));
				cmtVO.setProduct_Cmt_Grade(rs.getDouble(4));
				cmtVO.setProduct_Cmt_Info(rs.getString(5));
//				cmtVO.setProduct_Cmt_Img1(rs.getBytes(6));
//				cmtVO.setProduct_Cmt_Img2(rs.getBytes(7));
//				cmtVO.setProduct_Cmt_Timestamp(rs.getTimestamp(8));
				cmtVO.setProduct_Cmt_Timestamp(rs.getTimestamp(6));
				lists.add(cmtVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
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
	public List<ProductCmtVO> getAll() {
//		System.out.println(new java.util.Date().getTime()+" < CMT.getAll Start");
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<ProductCmtVO> cmtVOs = new ArrayList<>();
		ProductCmtVO cmtVO = null;
		try {
			try {
				Class.forName(common.DRIVER);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
			con = common.dataSource.getConnection();	
			ps = con.prepareStatement(getAll);
			rs = ps.executeQuery();
			while (rs.next()) {
				cmtVO = new ProductCmtVO();
				cmtVO.setProduct_Cmt_ID(rs.getString(1));
				cmtVO.setProduct_ID(rs.getString(2));
				cmtVO.setMember_ID(rs.getString(3));
				cmtVO.setProduct_Cmt_Grade(rs.getDouble(4));
				cmtVO.setProduct_Cmt_Info(rs.getString(5));
//				cmtVO.setProduct_Cmt_Img1(rs.getBytes(6));
//				cmtVO.setProduct_Cmt_Img2(rs.getBytes(7));
//				cmtVO.setProduct_Cmt_Timestamp(rs.getTimestamp(8));
				cmtVO.setProduct_Cmt_Timestamp(rs.getTimestamp(6));
				cmtVOs.add(cmtVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
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
//		System.out.println(new java.util.Date().getTime()+" < CMT.getAll End");
		return cmtVOs;
	}
}