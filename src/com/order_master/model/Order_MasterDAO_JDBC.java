package com.order_master.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import com.order.model.OrderDetailDAO_JDBC;
import com.order.model.OrderDetailService;
import com.order.model.OrderDetailVO;
import com.product.model.ProductDetailDAO_JDBC;
import com.product.model.ProductDetailService;
import com.product.model.ProductDetailVO;

import Common.common;

public class Order_MasterDAO_JDBC implements Order_MasterDAO_interface {

//	String driver = "oracle.jdbc.driver.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO ORDER_MASTER (ORDER_MASTER_ID, MEMBER_ID, COUPON_ID, ORDER_MASTER_PAYMENT, ORDER_MASTER_STATE) VALUES ('OMID'||LPAD(to_char(SEQ_ORDER_MASTER_ID.NEXTVAL),6,'0'), ?, ?, ?, ?)";
	private static final String UPDATE = "UPDATE ORDER_MASTER set MEMBER_ID=?, COUPON_ID=?, ORDER_MASTER_PAYMENT=?, ORDER_MASTER_TIMESTAMP=CURRENT_TIMESTAMP, ORDER_MASTER_STATE=? where ORDER_MASTER_ID=?";
	private static final String GET_ALL_STMT = "SELECT ORDER_MASTER_ID, MEMBER_ID, COUPON_ID, ORDER_MASTER_PAYMENT, ORDER_MASTER_TIMESTAMP, ORDER_MASTER_STATE FROM ORDER_MASTER order by ORDER_MASTER_ID";
	private static final String GET_ONE_STMT = "SELECT ORDER_MASTER_ID, MEMBER_ID, COUPON_ID, ORDER_MASTER_PAYMENT, ORDER_MASTER_TIMESTAMP, ORDER_MASTER_STATE FROM ORDER_MASTER where ORDER_MASTER_ID=?";
	private static final String DELETE = "DELETE from ORDER_MASTER where ORDER_MASTER_ID=?";
	private static final String SELECT_BY_MEMEBER = "SELECT ORDER_MASTER_ID, MEMBER_ID, COUPON_ID, ORDER_MASTER_PAYMENT, ORDER_MASTER_TIMESTAMP, ORDER_MASTER_STATE FROM ORDER_MASTER where member_id=?";

	@Override
	public Order_MasterVO select(String order_Master_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Order_MasterVO OM = null;

		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ONE_STMT);
			ps.setString(1, order_Master_ID);
			rs = ps.executeQuery();

			OM = new Order_MasterVO();
			while (rs.next()) {
				OM.setCoupon_ID(rs.getString("COUPON_ID"));
				OM.setMember_ID(rs.getString("MEMBER_ID"));
				OM.setOrder_Master_ID(rs.getString("ORDER_MASTER_ID"));
				OM.setOrder_Master_Payment(rs.getString("ORDER_MASTER_PAYMENT"));
				OM.setOrder_Master_State(rs.getInt("ORDER_MASTER_STATE"));
				OM.setOrder_Master_TimeStamp(rs.getTimestamp("ORDER_MASTER_TIMESTAMP"));
			}

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return OM;
	}

	@Override
	public List<Order_MasterVO> selectAll() {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Order_MasterVO OM = null;
		List<Order_MasterVO> OMS = new ArrayList<Order_MasterVO>();

		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ALL_STMT);
			rs = ps.executeQuery();

			while (rs.next()) {
				OM = new Order_MasterVO();
				OM.setCoupon_ID(rs.getString("COUPON_ID"));
				OM.setMember_ID(rs.getString("MEMBER_ID"));
				OM.setOrder_Master_ID(rs.getString("ORDER_MASTER_ID"));
				OM.setOrder_Master_Payment(rs.getString("ORDER_MASTER_PAYMENT"));
				OM.setOrder_Master_State(rs.getInt("ORDER_MASTER_STATE"));
				OM.setOrder_Master_TimeStamp(rs.getTimestamp("ORDER_MASTER_TIMESTAMP"));
				OMS.add(OM);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return OMS;
	}

	@Override
	public Order_MasterVO insert(Order_MasterVO order_Master) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(INSERT_STMT, new String[] { "ORDER_MASTER_ID" });
			ps.setString(1, order_Master.getMember_ID());
			ps.setString(2, order_Master.getCoupon_ID());
			ps.setString(3, order_Master.getOrder_Master_Payment());
			ps.setInt(4, order_Master.getOrder_Master_State());

			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				order_Master.setOrder_Master_ID(rs.getString(1));
			}
			con.commit();
			return order_Master;

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return null;

	}

	@Override
	public Order_MasterVO update(Order_MasterVO order_Master) {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(UPDATE);

			ps.setString(1, order_Master.getMember_ID());
			ps.setString(2, order_Master.getCoupon_ID());
			ps.setString(3, order_Master.getOrder_Master_Payment());
			ps.setInt(4, order_Master.getOrder_Master_State());
			ps.setString(5, order_Master.getOrder_Master_ID());
			ps.executeUpdate();
			con.commit();
			return order_Master;
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
	public Integer delete(String order_Master_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		Integer result = null;

		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(DELETE);

			ps.setString(1, order_Master_ID);
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
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return -1;

	}

	@Override
	public Set<Order_MasterVO> selectByMember(String member_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Set<Order_MasterVO> OMS = new HashSet<Order_MasterVO>();
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(SELECT_BY_MEMEBER);
			ps.setString(1, member_ID);
			rs = ps.executeQuery();

			while (rs.next()) {
				Order_MasterVO OM = new Order_MasterVO();
				OM.setCoupon_ID(rs.getString("Coupon_ID"));
				OM.setMember_ID(rs.getString("Member_ID"));
				OM.setOrder_Master_ID(rs.getString("Order_Master_ID"));
				OM.setOrder_Master_Payment(rs.getString("Order_Master_Payment"));
				OM.setOrder_Master_State(rs.getInt("Order_Master_State"));
				OM.setOrder_Master_TimeStamp(rs.getTimestamp("ORDER_MASTER_TIMESTAMP"));
				OMS.add(OM);
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
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return OMS;
	}

	@Override
	public Order_MasterVO updateOrderMasterWithProdetail(String order_Master_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
//首先先取得要update的order_MasterVO
			Order_MasterService omService = new Order_MasterService();
			Order_MasterVO order_Master = omService.getOne(order_Master_ID);
			order_Master.setOrder_Master_State(0);
			
//拿到orderDetail(跟參數傳進來的orderMaster一樣的orderMasterID）
			OrderDetailService odService = new OrderDetailService();
			List<OrderDetailVO> orderDetails = odService.getAll().stream()
					.filter(orderDetail -> orderDetail.getOrder_Master_ID().equals(order_Master_ID))
					.collect(Collectors.toList());
//拿到productDetail
			ProductDetailService pdService = new ProductDetailService();
			List<ProductDetailVO> productDetails = pdService.getAll();
			List<ProductDetailVO> productDetails_tmp = new ArrayList<ProductDetailVO>();
			productDetails_tmp.addAll(productDetails);

			for (OrderDetailVO bean : orderDetails) {
				String product_Detail_ID = bean.getProduct_Detail_ID();
				productDetails.removeIf(p -> p.getProduct_Detail_ID().equals(product_Detail_ID));
			}
			productDetails_tmp.removeAll(productDetails);

//拿到orderDetail的 ID & 使用剩餘數量
			Map<String, Integer> result = new HashMap<String, Integer>();
			for (OrderDetailVO bean : orderDetails) {
				result.put(bean.getProduct_Detail_ID(), (bean.getOrder_Detail_Qty() - bean.getOrder_Detail_Used_Qty()));
			}

//將剩餘數量加回productDetail中
			for (ProductDetailVO pdbean : productDetails_tmp) {
				for (Map.Entry<String, Integer> entry : result.entrySet()) {
					if (pdbean.getProduct_Detail_ID().equals(entry.getKey())) {
						pdbean.setProduct_Detail_Instock(pdbean.getProduct_Detail_Instock() + entry.getValue());
					}
				}
			}
			ps = con.prepareStatement(UPDATE);

			ps.setString(1, order_Master.getMember_ID());
			ps.setString(2, order_Master.getCoupon_ID());
			ps.setString(3, order_Master.getOrder_Master_Payment());
			ps.setInt(4, order_Master.getOrder_Master_State());
			ps.setString(5, order_Master.getOrder_Master_ID());
			
			Integer updateNum = ps.executeUpdate();
			ProductDetailDAO_JDBC dao = new ProductDetailDAO_JDBC();
			for(ProductDetailVO pdbean : productDetails_tmp) {
				dao.updateWithStock(pdbean, con);
			}
			
			con.commit();
			con.setAutoCommit(true);
			return order_Master;
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			if (con != null) {
				try {
					// 3���]�w���exception�o�ͮɤ�catch�϶���
					System.err.print("Transaction is being ");
					System.err.println("rolled back-��-dept");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}finally {
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
//		return null;
	}
	
	@Override
	public String inserWithOrder_Ditel(Order_MasterVO omVO, List<OrderDetailVO> list) {

		String msg = null;
		Connection con = null;
		PreparedStatement ps = null;

		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			// 先新增主黨
			String cols[] = { "ORDER_MASTER_ID" };
			ps = con.prepareStatement(INSERT_STMT, cols);
			ps.setString(1, omVO.getMember_ID());
			ps.setString(2, omVO.getCoupon_ID());
			ps.setString(3, omVO.getOrder_Master_Payment());
			ps.setInt(4, omVO.getOrder_Master_State());

			ps.executeUpdate();
			// 掘取對應的自增主鍵值
			String next_omid = null;
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				next_omid = rs.getString(1);
				System.out.println("自增主鍵值= " + next_omid + "(剛新增成功的訂單編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			// 再同時新增明細
			OrderDetailDAO_JDBC dao = new OrderDetailDAO_JDBC();
//			System.out.println("list.size()-A=" + list.size());
			for (OrderDetailVO aOD : list) {
				aOD.setOrder_Master_ID(new String(next_omid));
				dao.insert2(aOD, con);
			}

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
//			System.out.println("list.size()-B=" + list.size());
			System.out.println("新增訂單主黨編號" + next_omid + "時,共有明細" + list.size() + "同時被新增");
			msg = "success";
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-Master");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		return msg;
	}

}
