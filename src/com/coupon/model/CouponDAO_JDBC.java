package com.coupon.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.coupon.model.CouponDAO_interface;

import Common.common;

import java.sql.Timestamp;

public class CouponDAO_JDBC implements CouponDAO_interface {

//	String driver = "oracle.jdbc.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String password = "123456";

	private static final String INSERT = " INSERT INTO COUPON (COUPON_ID, EMP_ID, MEMBER_ID, COUPON_NAME, COUPON_CLASS, COUPON_NUMBER, COUPON_INFO , COUPON_STATE) VALUES (('CPID'||LPAD(to_char(SEQ_COUPON_ID.NEXTVAL),6,'0')), ?, ?, ?, ? , ?, ?,?)";
	private static final String UPDATE = " UPDATE COUPON SET EMP_ID=?, MEMBER_ID=?, COUPON_NAME=?, COUPON_CLASS=?, COUPON_NUMBER=?, COUPON_INFO=? ,COUPON_STATE=? where COUPON_ID = ? ";
	private static final String DELETE = " DELETE  FROM  COUPON  WHERE COUPON_ID = ? ";
	private static final String GET_ALL = " SELECT  COUPON_ID, EMP_ID, MEMBER_ID, COUPON_NAME, COUPON_CLASS, COUPON_NUMBER, COUPON_INFO , COUPON_DATE,COUPON_STATE FROM COUPON order by COUPON_ID ";
	private static final String GET_ONE = " SELECT  COUPON_ID, EMP_ID, MEMBER_ID, COUPON_NAME, COUPON_CLASS, COUPON_NUMBER, COUPON_INFO ,COUPON_DATE, COUPON_STATE FROM COUPON WHERE COUPON_ID= ? ";

	public static void main(String[] args) {
		CouponDAO_JDBC dao = new CouponDAO_JDBC();
//		新增
		CouponVO VO1 = new CouponVO();

//		VO1.setEmp_ID("E000001");
//		VO1.setMember_ID("1");
//		VO1.setCoupon_Name("1");
//		VO1.setCoupon_Class(0);
//		VO1.setCoupon_Number("1");
//		VO1.setCoupon_Info("2");
//		VO1.setCoupon_State(1);
//		
//		
//		System.out.println("insert");
//
//		dao.insert(VO1);

//		修改		
//		    CouponVO VO2 = new CouponVO();
//			
//		    
//			VO2.setEmp_ID("E000001");
//			VO2.setMember_ID("1");
//			VO2.setCoupon_Name("20");
//			VO2.setCoupon_Class(1);
//			VO2.setCoupon_Number("1");
//			VO2.setCoupon_Info("2");
//			VO2.setCoupon_State(1);
//			VO2.setCoupon_ID("CPID000004");
//			
//			System.out.println("update");
//		
//			dao.update(VO2);
//		        刪除
//			dao.delete("CPID000004");
//         查單一
//		CouponVO VO3 = dao.getOne("CPID000005");
//
//		System.out.print(VO3.getCoupon_ID() + ",");
//		System.out.print(VO3.getEmp_ID() + ",");
//		System.out.print(VO3.getMember_ID() + ",");
//		System.out.print(VO3.getCoupon_Name() + ",");
//		System.out.print(VO3.getCoupon_Class() + ",");
//		System.out.print(VO3.getCoupon_Number() + ",");
//		System.out.print(VO3.getCoupon_Info() + ",");
//		System.out.print(VO3.getCoupon_Date() + ",");
//		System.out.print(VO3.getCoupon_State());

		// 查全部
		List<CouponVO> list = dao.getAll();
		for (CouponVO a : list) {

			System.out.print(a.getCoupon_ID() + ",");
			System.out.print(a.getEmp_ID() + ",");
			System.out.print(a.getMember_ID() + ",");
			System.out.print(a.getCoupon_Name() + ",");
			System.out.print(a.getCoupon_Class() + ",");
			System.out.print(a.getCoupon_Number() + ",");
			System.out.print(a.getCoupon_Info() + ",");
			System.out.print(a.getCoupon_Date() + ",");
			System.out.print(a.getCoupon_State());
			System.out.println();
		}

	}

	@Override
	public CouponVO insert(CouponVO couponVO) {

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(INSERT, new String[] { "COUPON_ID" });

			ps.setString(1, couponVO.getEmp_ID());
			ps.setString(2, couponVO.getMember_ID());
			ps.setString(3, couponVO.getCoupon_Name());
			ps.setDouble(4, couponVO.getCoupon_Class());
			ps.setString(5, couponVO.getCoupon_Number());
			ps.setString(6, couponVO.getCoupon_Info());
			ps.setInt(7, couponVO.getCoupon_State());

			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				couponVO.setCoupon_ID(rs.getString(1));
			}
			con.commit();

			return couponVO;

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("driver error" + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("database error" + e.getMessage());

			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
			
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
					e2.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return null;
	}

	@Override
	public void update(CouponVO couponVO) {

		Connection con = null;
		PreparedStatement ps = null;
		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(UPDATE);

			ps.setString(1, couponVO.getEmp_ID());
			ps.setString(2, couponVO.getMember_ID());
			ps.setString(3, couponVO.getCoupon_Name());
			ps.setDouble(4, couponVO.getCoupon_Class());
			ps.setString(5, couponVO.getCoupon_Number());
			ps.setString(6, couponVO.getCoupon_Info());
			ps.setInt(7, couponVO.getCoupon_State());
			ps.setString(8, couponVO.getCoupon_ID());

			ps.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void delete(String coupon_ID) {

		Connection con = null;
		PreparedStatement ps = null;

		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(DELETE);

			ps.setString(1, coupon_ID);
			ps.executeUpdate();

			con.commit();

		} catch (ClassNotFoundException e) {
			try {
				con.rollback();
				throw new RuntimeException("driver error" + e.getMessage());

			} catch (SQLException e1) {
				throw new RuntimeException("driver error" + e.getMessage());
			}
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("database error" + e.getMessage());
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.getMessage();
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
	}

	@Override
	public CouponVO getOne(String coupon_ID) {

		CouponVO couponVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ONE);

			ps.setString(1, coupon_ID);

			rs = ps.executeQuery();

			while (rs.next()) {
				couponVO = new CouponVO();

				couponVO.setCoupon_ID(rs.getString("coupon_ID"));
				couponVO.setEmp_ID(rs.getString("emp_ID"));
				couponVO.setMember_ID(rs.getString("member_ID"));
				couponVO.setCoupon_Name(rs.getString("coupon_Name"));
				couponVO.setCoupon_Class(rs.getDouble("coupon_Class"));
				couponVO.setCoupon_Number(rs.getString("coupon_Number"));
				couponVO.setCoupon_Info(rs.getString("coupon_Info"));
				couponVO.setCoupon_Date(rs.getTimestamp("coupon_Date"));
				couponVO.setCoupon_State(rs.getInt("coupon_State"));

			}

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("driver error" + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("database error" + e.getMessage());
		} finally {
			
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
			
		}
		return couponVO;

	}

	@Override
	public List<CouponVO> getAll() {

		List<CouponVO> list = new ArrayList<CouponVO>();
		CouponVO couponVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ALL);
			rs = ps.executeQuery();

			while (rs.next()) {
				couponVO = new CouponVO();

				couponVO.setCoupon_ID(rs.getString("coupon_ID"));
				couponVO.setEmp_ID(rs.getString("emp_ID"));
				couponVO.setMember_ID(rs.getString("member_ID"));
				couponVO.setCoupon_Name(rs.getString("coupon_Name"));
				couponVO.setCoupon_Class(rs.getDouble("coupon_Class"));
				couponVO.setCoupon_Number(rs.getString("coupon_Number"));
				couponVO.setCoupon_Info(rs.getString("coupon_Info"));
				couponVO.setCoupon_Date(rs.getTimestamp("coupon_Date"));
				couponVO.setCoupon_State(rs.getInt("coupon_State"));
				list.add(couponVO);

			}

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("driver error" + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("database error" + e.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

}
