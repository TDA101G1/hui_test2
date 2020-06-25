package com.order.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.order_master.model.Order_MasterVO;
import com.product.model.ProductDetailVO;

import Common.common;

public class OrderDetailDAO_JDBC implements OrderDetailDAO {
	private static final String INSERT_SQL = "INSERT INTO ORDER_DETAIL (ORDER_DETAIL_ID, ORDER_MASTER_ID, PRODUCT_DETAIL_ID, ORDER_DETAIL_QTY, ORDER_DETAIL_USED_QTY) VALUES (('ODID'||LPAD(TO_CHAR(SEQ_ORDER_DETAIL_ID.NEXTVAL),6,'0')),?,?,?,?)";
	private static final String UPDATE_SQL = "UPDATE ORDER_DETAIL SET ORDER_MASTER_ID=?, PRODUCT_DETAIL_ID=?, ORDER_DETAIL_QTY=?, ORDER_DETAIL_USED_QTY=? WHERE ORDER_DETAIL_ID = ?";
	private static final String DELETE_SQL = "DELETE FROM ORDER_DETAIL WHERE ORDER_DETAIL_ID = ?";
	private static final String GET_ONE_SQL = "SELECT ORDER_DETAIL_ID, ORDER_MASTER_ID, PRODUCT_DETAIL_ID, ORDER_DETAIL_QTY, ORDER_DETAIL_USED_QTY FROM ORDER_DETAIL WHERE ORDER_DETAIL_ID = ?";
	private static final String GET_ALL_SQL = "SELECT ORDER_DETAIL_ID, ORDER_MASTER_ID, PRODUCT_DETAIL_ID, ORDER_DETAIL_QTY, ORDER_DETAIL_USED_QTY FROM ORDER_DETAIL ORDER BY ORDER_DETAIL_ID DESC";

//	String driver = "oracle.jdbc.driver.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String passwd = "123456";
//	Class.forName(common.DRIVER);
//	con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
	@Override
	public OrderDetailVO insert(OrderDetailVO orderDetailVO, Order_MasterVO order_MasterVO,
			ProductDetailVO productDetailVO) {
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(INSERT_SQL, new String[] { "ORDER_DETAIL_ID" });) {
//		try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//				PreparedStatement ps = conn.prepareStatement(INSERT_SQL, new String[] { "ORDER_DETAIL_ID" });) {
			try {
				conn.setAutoCommit(false);

				ps.setString(1, order_MasterVO.getOrder_Master_ID());
				ps.setString(2, productDetailVO.getProduct_Detail_ID());
				ps.setInt(3, orderDetailVO.getOrder_Detail_Qty());
				ps.setInt(4, orderDetailVO.getOrder_Detail_Used_Qty());
				ps.executeUpdate();

				conn.commit();
			} catch (SQLException e) {
				conn.rollback();
				e.printStackTrace();
			} finally {
				conn.setAutoCommit(true);
			}
			try (ResultSet rs = ps.getGeneratedKeys();) {
				if (rs.next()) {
					orderDetailVO.setOrder_Detail_ID(rs.getString(1));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderDetailVO;
	}

	@Override
	public Integer update(OrderDetailVO orderDetailVO) {
		Integer couunt = null;
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(UPDATE_SQL);) {
//			try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//					PreparedStatement ps = conn.prepareStatement(UPDATE_SQL);) {
			try {
				conn.setAutoCommit(false);

				ps.setString(1, orderDetailVO.getOrder_Master_ID());
				ps.setString(2, orderDetailVO.getProduct_Detail_ID());
				ps.setInt(3, orderDetailVO.getOrder_Detail_Qty());
				ps.setInt(4, orderDetailVO.getOrder_Detail_Used_Qty());
				ps.setString(5, orderDetailVO.getOrder_Detail_ID());
				couunt = ps.executeUpdate();

				conn.commit();
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			} finally {
				conn.setAutoCommit(true);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return couunt;
	}

	@Override
	public Integer delete(String orderDetailVO_ID) {
		Integer couunt = null;
		
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(DELETE_SQL);) {
//			try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//					PreparedStatement ps = conn.prepareStatement(DELETE_SQL);) {
			try {
				conn.setAutoCommit(false);

				ps.setString(1, orderDetailVO_ID);
				ps.executeUpdate();

				conn.commit();
			} catch (SQLException e) {
				conn.rollback();
				e.printStackTrace();
			} finally {
				conn.setAutoCommit(true);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return couunt;
	}

	@Override
	public OrderDetailVO select(String orderDetailVO_ID) {
		OrderDetailVO orderDetailVO = null;
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(GET_ONE_SQL);) {
//			try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//					PreparedStatement ps = conn.prepareStatement(GET_ONE_SQL);) {
			ps.setString(1, orderDetailVO_ID);
			try (ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					orderDetailVO = new OrderDetailVO();
					orderDetailVO.setOrder_Detail_ID(rs.getString("ORDER_DETAIL_ID"));
					orderDetailVO.setOrder_Master_ID(rs.getString("ORDER_MASTER_ID"));
					orderDetailVO.setProduct_Detail_ID(rs.getString("PRODUCT_DETAIL_ID"));
					orderDetailVO.setOrder_Detail_Qty(rs.getInt("ORDER_DETAIL_QTY"));
					orderDetailVO.setOrder_Detail_Used_Qty(rs.getInt("ORDER_DETAIL_USED_QTY"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderDetailVO;
	}

	@Override
	public List<OrderDetailVO> getAll() {
		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		OrderDetailVO orderDetailVO = null;
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(GET_ALL_SQL);) {
//			try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//					PreparedStatement ps = conn.prepareStatement(GET_ALL_SQL);) {
			try (ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					orderDetailVO = new OrderDetailVO();
					orderDetailVO.setOrder_Detail_ID(rs.getString("ORDER_DETAIL_ID"));
					orderDetailVO.setOrder_Master_ID(rs.getString("ORDER_MASTER_ID"));
					orderDetailVO.setProduct_Detail_ID(rs.getString("PRODUCT_DETAIL_ID"));
					orderDetailVO.setOrder_Detail_Qty(rs.getInt("ORDER_DETAIL_QTY"));
					orderDetailVO.setOrder_Detail_Used_Qty(rs.getInt("ORDER_DETAIL_USED_QTY"));
					list.add(orderDetailVO);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//新加的
	public void insert2 (OrderDetailVO orderDetailVO, Connection con) {

		PreparedStatement ps = null;

		try {

     		ps = con.prepareStatement(INSERT_SQL);


			
			ps.setString(1, orderDetailVO.getOrder_Master_ID());
			ps.setString(2, orderDetailVO.getProduct_Detail_ID());
			ps.setInt(3, orderDetailVO.getOrder_Detail_Qty());
			ps.setInt(4, orderDetailVO.getOrder_Detail_Used_Qty());
			ps.executeUpdate();


			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-Detail");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
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
		}
	}
	
	

	public static void main(String[] args) {
//		OrderDetailDAO_JDBC dao = new OrderDetailDAO_JDBC();
//		OrderDetailVO orderDetailVO = new OrderDetailVO();
//		Order_MasterVO order_MasterVO = new Order_MasterVO();
//		ProductDetailVO productDetailVO = new ProductDetailVO();
//		order_MasterVO.setOrder_Master_ID("OMID000001");
//		productDetailVO.setProduct_Detail_ID("PDID000001");
//
//		orderDetailVO.setOrder_Detail_ID("ODID000001");
//		orderDetailVO.setOrder_Master_ID(order_MasterVO.getOrder_Master_ID());
//		orderDetailVO.setProduct_Detail_ID(productDetailVO.getProduct_Detail_ID());
//		orderDetailVO.setOrder_Detail_Qty((int) (Math.random() * 100));
//		orderDetailVO.setOrder_Detail_Used_Qty((int) (Math.random() * 100));
//
////insert
//		System.out.println(dao.insert(orderDetailVO, order_MasterVO, productDetailVO));
//
////update
//		System.out.println(dao.update(orderDetailVO));
//
////delete
//		System.out.println(dao.delete(orderDetailVO.getOrder_Detail_ID()));
//
////select
//		System.out.println(dao.select(orderDetailVO.getOrder_Detail_ID()));
//
////getAll
//		dao.getAll().forEach(System.out::println);

	}
}
