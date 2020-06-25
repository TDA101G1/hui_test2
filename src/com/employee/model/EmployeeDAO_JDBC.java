package com.employee.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.employee.model.EmployeeVO;

import Common.common;

import java.sql.Date;

public class EmployeeDAO_JDBC implements EmployeeDAO_interface {

	// 測試記得static
//	String driver = "oracle.jdbc.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String password = "123456";

	private static final String INSERT = " INSERT INTO EMPLOYEE (EMP_ID, EMP_ACCOUNT, EMP_PWD, EMP_GRADE, EMP_NAME, EMP_SEX, EMP_BIRTH, EMP_MAIL, EMP_PHONE, EMP_ADDRESS, EMP_EST_TIME, EMP_STATE,EMP_IMG) VALUES (('EID'||LPAD(to_char(SEQ_EMP_ID.NEXTVAL),6,'0')), ?, ?, ?, ? , ?, ?, ?, ?, ?, ? , ?, ? )";
	private static final String UPDATE = " UPDATE EMPLOYEE SET EMP_ACCOUNT=?, EMP_PWD=?, EMP_GRADE=?, EMP_NAME=?, EMP_SEX=?, EMP_BIRTH=?, EMP_MAIL=?, EMP_PHONE=?, EMP_ADDRESS=?, EMP_EST_TIME=?, EMP_STATE=? ,EMP_IMG = ? where EMP_ID = ? ";
	private static final String DELETE = " DELETE  FROM  EMPLOYEE WHERE EMP_ID = ? ";
	private static final String GET_ALL = " SELECT  EMP_ID, EMP_ACCOUNT, EMP_PWD, EMP_GRADE, EMP_NAME, EMP_SEX, emp_Birth, EMP_MAIL, EMP_PHONE, EMP_ADDRESS, to_char(emp_Est_Time,'yyyy-mm-dd')emp_Est_Time, EMP_IMG,EMP_STATE FROM EMPLOYEE ";
	private static final String GET_ONE = " SELECT  emp_ID, emp_Account, emp_Pwd, emp_Grade, emp_Name, emp_Sex,emp_Birth, emp_Mail, emp_Phone, emp_Address,to_char(emp_Est_Time,'yyyy-mm-dd')emp_Est_Time,emp_Img ,emp_State FROM EMPLOYEE WHERE emp_ID= ? ";
	private static final String SELECT  = " SELECT  emp_ID, emp_Account, emp_Pwd, emp_Grade, emp_Name, emp_Sex,emp_Birth, emp_Mail, emp_Phone, emp_Address,to_char(emp_Est_Time,'yyyy-mm-dd')emp_Est_Time,emp_Img ,emp_State FROM EMPLOYEE where EMP_ACCOUNT= ?  ";
	// 皜祈岫
	public static void main(String[] args) {

		java.util.Date du = new java.util.Date();

		long aa = du.getTime();

		java.sql.Date date = new java.sql.Date(aa);
		// 新增
//		EmployeeVO VO1 = new EmployeeVO();
		EmployeeDAO_JDBC dao = new EmployeeDAO_JDBC();

//		
//		VO1.setEmp_Account("1");
//		VO1.setEmp_Pwd("1");
//		VO1.setEmp_Grade("1");
//		VO1.setEmp_Name("1");
//		VO1.setEmp_Sex("1");
//		VO1.setEmp_Birth(date);
//		VO1.setEmp_Mail("1");
//		VO1.setEmp_Phone("1");
//		VO1.setEmp_Address("1");
//		VO1.setEmp_Est_Time(date);
//		VO1.setEmp_State(1);
//		VO1.setEmp_Img(null);
//		System.out.println("insert");
//
//		dao.insert(VO1);

		// 修改
//		EmployeeVO VO2 = new EmployeeVO();
//
//		VO2.setEmp_Account("2222");
//		VO2.setEmp_Pwd("1");
//		VO2.setEmp_Grade("2");
//		VO2.setEmp_Name("2");
//		VO2.setEmp_Sex("2");
//		VO2.setEmp_Birth(date);
//		VO2.setEmp_Mail("2");
//		VO2.setEmp_Phone("2");
//		VO2.setEmp_Address("2");
//		VO2.setEmp_Est_Time(date);
//		VO2.setEmp_State(1);
//		VO2.setEmp_Img(null);
//		VO2.setEmp_ID("EID000012");
//
//		dao.update(VO2);
//		        刪除
//		dao.delete("EID000012");
//         查單一
		   EmployeeVO VO3 = dao.getOne("E000008");
	
			System.out.print(VO3.getEmp_ID()+",");
			System.out.print(VO3.getEmp_Account()+",");
			System.out.print(VO3.getEmp_Pwd()+",");
			System.out.print(VO3.getEmp_Grade()+",");
			System.out.print(VO3.getEmp_Name()+",");
			System.out.print(VO3.getEmp_Sex()+",");
			System.out.print(VO3.getEmp_Birth()+",");
			System.out.print(VO3.getEmp_Mail()+",");
			System.out.print(VO3.getEmp_Phone()+",");
			System.out.print(VO3.getEmp_Address()+",");
			System.out.print(VO3.getEmp_Est_Time()+",");
			System.out.print(VO3.getEmp_Img());
			System.out.print(VO3.getEmp_State()+",");
//			
//		
		// 查全部
		List<EmployeeVO> list = dao.getAll();
		for (EmployeeVO a : list) {
			System.out.print(a.getEmp_ID() + ",");
			System.out.print(a.getEmp_Account() + ",");
			System.out.print(a.getEmp_Pwd() + ",");
			System.out.print(a.getEmp_Grade() + ",");
			System.out.print(a.getEmp_Name() + ",");
			System.out.print(a.getEmp_Sex() + ",");
			System.out.print(a.getEmp_Birth() + ",");
			System.out.print(a.getEmp_Mail() + ",");
			System.out.print(a.getEmp_Phone() + ",");
			System.out.print(a.getEmp_Address() + ",");
			System.out.print(a.getEmp_Est_Time() + ",");
			System.out.print(a.getEmp_Img() + ",");
			System.out.print(a.getEmp_State());
			System.out.println();
		}
//									
	}

	@Override
	public EmployeeVO insert(EmployeeVO employeeVO) {

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(INSERT,new String[] { "EMP_ID" });

			ps.setString(1, employeeVO.getEmp_Account());
			ps.setString(2, employeeVO.getEmp_Pwd());
			ps.setString(3, employeeVO.getEmp_Grade());
			ps.setString(4, employeeVO.getEmp_Name());
			ps.setString(5, employeeVO.getEmp_Sex());
			ps.setDate(6, employeeVO.getEmp_Birth());
			ps.setString(7, employeeVO.getEmp_Mail());
			ps.setString(8, employeeVO.getEmp_Phone());
			ps.setString(9, employeeVO.getEmp_Address());
			ps.setDate(10, employeeVO.getEmp_Est_Time());
			ps.setInt(11, employeeVO.getEmp_State());
			ps.setBytes(12, employeeVO.getEmp_Img());

			ps.executeUpdate();
			
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				employeeVO.setEmp_ID(rs.getString(1));
			}
			
			con.commit();
			
			return employeeVO;
			

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException se) {
				se.printStackTrace();
			}
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException se) {
					se.printStackTrace();
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
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}
		return null;
	}

	@Override
	public void update(EmployeeVO employeeVO) {

		Connection con = null;
		PreparedStatement ps = null;
		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(UPDATE);

			ps.setString(1, employeeVO.getEmp_Account());
			ps.setString(2, employeeVO.getEmp_Pwd());
			ps.setString(3, employeeVO.getEmp_Grade());
			ps.setString(4, employeeVO.getEmp_Name());
			ps.setString(5, employeeVO.getEmp_Sex());
			ps.setDate(6, employeeVO.getEmp_Birth());
			ps.setString(7, employeeVO.getEmp_Mail());
			ps.setString(8, employeeVO.getEmp_Phone());
			ps.setString(9, employeeVO.getEmp_Address());
			ps.setDate(10, employeeVO.getEmp_Est_Time());
			ps.setInt(11, employeeVO.getEmp_State());
			ps.setBytes(12, employeeVO.getEmp_Img());
			ps.setString(13, employeeVO.getEmp_ID());

			ps.executeUpdate();
			con.commit();
			

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}if (con != null) {
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
	public void delete(String emp_ID) {

		Connection con = null;
		PreparedStatement ps = null;

		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(DELETE);

			ps.setString(1, emp_ID);
			ps.executeUpdate();

			con.commit();
			con.setAutoCommit(true);

		} catch (ClassNotFoundException e) {
			try {
				con.rollback();
				throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

		} catch (SQLException e) {
			e.getMessage();
		} finally {
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
	}

	@Override
	public EmployeeVO getOne(String emp_ID) {

		EmployeeVO employeeVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ONE);

			ps.setString(1, emp_ID);
			rs = ps.executeQuery();

			while (rs.next()) {
				employeeVO = new EmployeeVO();

				employeeVO.setEmp_ID(rs.getString("emp_ID"));
				employeeVO.setEmp_Account(rs.getString("emp_Account"));
				employeeVO.setEmp_Pwd(rs.getString("emp_Pwd"));
				employeeVO.setEmp_Grade(rs.getString("emp_Grade"));
				employeeVO.setEmp_Name(rs.getString("emp_Name"));
				employeeVO.setEmp_Sex(rs.getString("emp_Sex"));
				employeeVO.setEmp_Birth(rs.getDate("emp_Birth"));
				employeeVO.setEmp_Mail(rs.getString("emp_Mail"));
				employeeVO.setEmp_Phone(rs.getString("emp_Phone"));
				employeeVO.setEmp_Address(rs.getString("emp_Address"));
				employeeVO.setEmp_Est_Time(rs.getDate("emp_Est_Time"));
				employeeVO.setEmp_Img(rs.getBytes("emp_Img"));
				employeeVO.setEmp_State(rs.getInt("emp_State"));

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
		return employeeVO;
	}

	@Override
	public List<EmployeeVO> getAll() {

		List<EmployeeVO> list = new ArrayList<EmployeeVO>();
		EmployeeVO employeeVO = null;

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
				employeeVO = new EmployeeVO();

				employeeVO.setEmp_ID(rs.getString("emp_ID"));
				employeeVO.setEmp_Account(rs.getString("emp_Account"));
				employeeVO.setEmp_Pwd(rs.getString("emp_Pwd"));
				employeeVO.setEmp_Grade(rs.getString("emp_Grade"));
				employeeVO.setEmp_Name(rs.getString("emp_Name"));
				employeeVO.setEmp_Sex(rs.getString("emp_Sex"));
				employeeVO.setEmp_Birth(rs.getDate("emp_Birth"));
				employeeVO.setEmp_Mail(rs.getString("emp_Mail"));
				employeeVO.setEmp_Phone(rs.getString("emp_Phone"));
				employeeVO.setEmp_Address(rs.getString("emp_Address"));
				employeeVO.setEmp_Est_Time(rs.getDate("emp_Est_Time"));
				employeeVO.setEmp_Img(rs.getBytes("emp_Img"));
				employeeVO.setEmp_State(rs.getInt("emp_State"));
				list.add(employeeVO);

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

	@Override
	public EmployeeVO select(String emp_Account) {
		EmployeeVO employeeVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(SELECT);

			ps.setString(1, emp_Account);
			rs = ps.executeQuery();

			while (rs.next()) {
				employeeVO = new EmployeeVO();

				employeeVO.setEmp_ID(rs.getString("emp_ID"));
				employeeVO.setEmp_Account(rs.getString("emp_Account"));
				employeeVO.setEmp_Pwd(rs.getString("emp_Pwd"));
				employeeVO.setEmp_Grade(rs.getString("emp_Grade"));
				employeeVO.setEmp_Name(rs.getString("emp_Name"));
				employeeVO.setEmp_Sex(rs.getString("emp_Sex"));
				employeeVO.setEmp_Birth(rs.getDate("emp_Birth"));
				employeeVO.setEmp_Mail(rs.getString("emp_Mail"));
				employeeVO.setEmp_Phone(rs.getString("emp_Phone"));
				employeeVO.setEmp_Address(rs.getString("emp_Address"));
				employeeVO.setEmp_Est_Time(rs.getDate("emp_Est_Time"));
				employeeVO.setEmp_Img(rs.getBytes("emp_Img"));
				employeeVO.setEmp_State(rs.getInt("emp_State"));

			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("driver error" + e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
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
		return employeeVO;
	}
}
