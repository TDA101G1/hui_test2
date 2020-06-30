package com.product.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Common.common;

public class ProductDAO_JDBC implements ProductDAO {
	private static final String INSERT_SQL = "INSERT INTO PRODUCT (PRODUCT_ID,PRODUCT_NAME,PRODUCT_INTRO,PRODUCT_STAYTIME,PRODUCT_ADDRESS,PRODUCT_LATITUTDE,PRODUCT_LONGITUDE,PRODUCT_COUNTY,PRODUCT_CLASS,PRODUCT_STYLE,PRODUCT_SEQ,PRODUCT_STATE,PRODUCT_SALE_REC,PRODUCT_CLICK_REC,PRODUCT_TOTAL_SCHEDULE,PRODUCT_INFO,PRODUCT_IMG1,PRODUCT_IMG2,PRODUCT_IMG3,PRODUCT_IMG4,PRODUCT_IMG5) VALUES (('PID'||LPAD(TO_CHAR(SEQ_PRODUCT_ID.NEXTVAL),6,'0')),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String UPDATE_SQL = "UPDATE PRODUCT SET PRODUCT_NAME= ?, PRODUCT_INTRO=?, PRODUCT_STAYTIME=?, PRODUCT_ADDRESS=?, PRODUCT_LATITUTDE=?, PRODUCT_LONGITUDE=?, PRODUCT_COUNTY=?, PRODUCT_CLASS=?, PRODUCT_STYLE=?, PRODUCT_SEQ=?, PRODUCT_STATE=?, PRODUCT_CLICK_REC=?, PRODUCT_SALE_REC=?, PRODUCT_TOTAL_SCHEDULE=?, PRODUCT_INFO=?, PRODUCT_IMG1=?, PRODUCT_IMG2=?, PRODUCT_IMG3=?, PRODUCT_IMG4=?, PRODUCT_IMG5=? WHERE PRODUCT_ID = ?";
	private static final String DELETE_SQL = "DELETE FROM PRODUCT WHERE PRODUCT_ID = ?";
	private static final String GET_ONE_SQL = "SELECT PRODUCT_ID,PRODUCT_NAME,PRODUCT_INTRO,PRODUCT_STAYTIME,PRODUCT_ADDRESS,PRODUCT_LATITUTDE,PRODUCT_LONGITUDE,PRODUCT_COUNTY,PRODUCT_CLASS,PRODUCT_STYLE,PRODUCT_SEQ,PRODUCT_STATE,PRODUCT_SALE_REC,PRODUCT_CLICK_REC,PRODUCT_TOTAL_SCHEDULE,PRODUCT_INFO,PRODUCT_IMG1,PRODUCT_IMG2,PRODUCT_IMG3,PRODUCT_IMG4,PRODUCT_IMG5 FROM PRODUCT WHERE PRODUCT_ID = ?";
//	private static final String GET_ALl_SQL = "SELECT PRODUCT_ID,PRODUCT_NAME,PRODUCT_INTRO,PRODUCT_STAYTIME,PRODUCT_ADDRESS,PRODUCT_LATITUTDE,PRODUCT_LONGITUDE,PRODUCT_COUNTY,PRODUCT_CLASS,PRODUCT_STYLE,PRODUCT_SEQ,PRODUCT_STATE,PRODUCT_SALE_REC,PRODUCT_CLICK_REC,PRODUCT_TOTAL_SCHEDULE,PRODUCT_INFO,PRODUCT_IMG1,PRODUCT_IMG2,PRODUCT_IMG3,PRODUCT_IMG4,PRODUCT_IMG5 FROM PRODUCT";
	private static final String GET_ALl_SQL = "SELECT PRODUCT_ID,PRODUCT_NAME,PRODUCT_INTRO,PRODUCT_STAYTIME,PRODUCT_ADDRESS,PRODUCT_LATITUTDE,PRODUCT_LONGITUDE,PRODUCT_COUNTY,PRODUCT_CLASS,PRODUCT_STYLE,PRODUCT_SEQ,PRODUCT_STATE,PRODUCT_SALE_REC,PRODUCT_CLICK_REC,PRODUCT_TOTAL_SCHEDULE,PRODUCT_INFO FROM PRODUCT";
//	String driver = "oracle.jdbc.driver.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String passwd = "123456";
//	Class.forName(common.DRIVER);
//	con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);	
	@Override
	public ProductVO insert(ProductVO productVO) {
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(INSERT_SQL, new String[] { "PRODUCT_ID" });) {
//			try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//					PreparedStatement ps = conn.prepareStatement(INSERT_SQL, new String[] { "PRODUCT_ID" });) {
			try {
				conn.setAutoCommit(false);

				ps.setString(1, productVO.getProduct_Name());
				ps.setString(2, productVO.getProduct_Intro());
				ps.setDouble(3, productVO.getProduct_Staytime());
				ps.setString(4, productVO.getProduct_Address());
				ps.setDouble(5, productVO.getProduct_Latitutde());
				ps.setDouble(6, productVO.getProduct_Longitude());
				ps.setString(7, productVO.getProduct_County());
				ps.setString(8, productVO.getProduct_Class());
				ps.setString(9, productVO.getProduct_Style());
				ps.setInt(10, productVO.getProduct_Seq());
				ps.setInt(11, productVO.getProduct_State());
				ps.setInt(12, productVO.getProduct_Sale_Rec());
				ps.setInt(13, productVO.getProduct_Click_Rec());
				ps.setString(14, productVO.getProduct_Total_Schedule());
				ps.setString(15, productVO.getProduct_Info()); // 結至5/18，只能輸入100-300MB的資料
				ps.setBytes(16, productVO.getProduct_Img1());
				ps.setBytes(17, productVO.getProduct_Img2());
				ps.setBytes(18, productVO.getProduct_Img3());
				ps.setBytes(19, productVO.getProduct_Img4());
				ps.setBytes(20, productVO.getProduct_Img5());
				ps.executeUpdate();

				conn.commit();
			} catch (SQLException e) {
				conn.rollback();
				e.printStackTrace();
			} finally {
				conn.setAutoCommit(true);
			}
			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next()) {
					productVO.setProduct_ID(rs.getString(1));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productVO;
	}

	@Override
	public Integer update(ProductVO productVO) {
		Integer couunt = null;
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(UPDATE_SQL);) {
//			try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//					PreparedStatement ps = conn.prepareStatement(UPDATE_SQL);) {
			try {
				conn.setAutoCommit(false);

				ps.setString(1, productVO.getProduct_Name());
				ps.setString(2, productVO.getProduct_Intro());
				ps.setDouble(3, productVO.getProduct_Staytime());
				ps.setString(4, productVO.getProduct_Address());
				ps.setDouble(5, productVO.getProduct_Latitutde());
				ps.setDouble(6, productVO.getProduct_Longitude());
				ps.setString(7, productVO.getProduct_County());
				ps.setString(8, productVO.getProduct_Class());
				ps.setString(9, productVO.getProduct_Style());
				ps.setInt(10, productVO.getProduct_Seq());
				ps.setInt(11, productVO.getProduct_State());
				ps.setInt(12, productVO.getProduct_Sale_Rec());
				ps.setInt(13, productVO.getProduct_Click_Rec());
				ps.setString(14, productVO.getProduct_Total_Schedule());
				ps.setString(15, productVO.getProduct_Info()); // 在開發環境中整支程式佔用超過2GB記憶體就會出錯
				ps.setBytes(16, productVO.getProduct_Img1());
				ps.setBytes(17, productVO.getProduct_Img2());
				ps.setBytes(18, productVO.getProduct_Img3());
				ps.setBytes(19, productVO.getProduct_Img4());
				ps.setBytes(20, productVO.getProduct_Img5());
				ps.setString(21, productVO.getProduct_ID());
				couunt = ps.executeUpdate();

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
	public Integer delete(String product_ID) {
		Integer count = null;
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(DELETE_SQL);) {
//			try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//					PreparedStatement ps = conn.prepareStatement(DELETE_SQL);) {
			try {
				conn.setAutoCommit(false);
				ps.setString(1, product_ID);
				count = ps.executeUpdate();
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
		return count;
	}

	@Override
	public ProductVO select(String product_ID) {
		ProductVO productVO = null;
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(GET_ONE_SQL);) {
//			try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//					PreparedStatement ps = conn.prepareStatement(GET_ONE_SQL);) {
			ps.setString(1, product_ID);
			try (ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					productVO = new ProductVO();
					productVO.setProduct_ID(rs.getString("PRODUCT_ID"));
					productVO.setProduct_Name(rs.getString("PRODUCT_NAME"));
					productVO.setProduct_Intro(rs.getString("PRODUCT_INTRO"));
					productVO.setProduct_Staytime(rs.getDouble("PRODUCT_STAYTIME"));
					productVO.setProduct_Address(rs.getString("PRODUCT_ADDRESS"));
					productVO.setProduct_Latitutde(rs.getDouble("PRODUCT_LATITUTDE"));
					productVO.setProduct_Longitude(rs.getDouble("PRODUCT_LONGITUDE"));
					productVO.setProduct_County(rs.getString("PRODUCT_COUNTY"));
					productVO.setProduct_Class(rs.getString("PRODUCT_CLASS"));
					productVO.setProduct_Style(rs.getString("PRODUCT_STYLE"));
					productVO.setProduct_Seq(rs.getInt("PRODUCT_SEQ"));
					productVO.setProduct_State(rs.getInt("PRODUCT_STATE"));
					productVO.setProduct_Sale_Rec(rs.getInt("PRODUCT_SALE_REC"));
					productVO.setProduct_Click_Rec(rs.getInt("PRODUCT_CLICK_REC"));
					productVO.setProduct_Total_Schedule(rs.getString("PRODUCT_TOTAL_SCHEDULE"));
					productVO.setProduct_Info(rs.getString("PRODUCT_INFO"));
					productVO.setProduct_Img1(rs.getBytes("PRODUCT_IMG1"));
					productVO.setProduct_Img2(rs.getBytes("PRODUCT_IMG2"));
					productVO.setProduct_Img3(rs.getBytes("PRODUCT_IMG3"));
					productVO.setProduct_Img4(rs.getBytes("PRODUCT_IMG4"));
					productVO.setProduct_Img5(rs.getBytes("PRODUCT_IMG5"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productVO;
	}

	@Override
	public List<ProductVO> getAll() {
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(GET_ALl_SQL)) {
//		try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//				PreparedStatement ps = conn.prepareStatement(GET_ALl_SQL)) {
			try (ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					productVO = new ProductVO();
					productVO.setProduct_ID(rs.getString("PRODUCT_ID"));
					productVO.setProduct_Name(rs.getString("PRODUCT_NAME"));
					productVO.setProduct_Intro(rs.getString("PRODUCT_INTRO"));
					productVO.setProduct_Staytime(rs.getDouble("PRODUCT_STAYTIME"));
					productVO.setProduct_Address(rs.getString("PRODUCT_ADDRESS"));
					productVO.setProduct_Latitutde(rs.getDouble("PRODUCT_LATITUTDE"));
					productVO.setProduct_Longitude(rs.getDouble("PRODUCT_LONGITUDE"));
					productVO.setProduct_County(rs.getString("PRODUCT_COUNTY"));
					productVO.setProduct_Class(rs.getString("PRODUCT_CLASS"));
					productVO.setProduct_Style(rs.getString("PRODUCT_STYLE"));
					productVO.setProduct_Seq(rs.getInt("PRODUCT_SEQ"));
					productVO.setProduct_State(rs.getInt("PRODUCT_STATE"));
					productVO.setProduct_Sale_Rec(rs.getInt("PRODUCT_SALE_REC"));
					productVO.setProduct_Click_Rec(rs.getInt("PRODUCT_CLICK_REC"));
					productVO.setProduct_Total_Schedule(rs.getString("PRODUCT_TOTAL_SCHEDULE"));
					productVO.setProduct_Info(rs.getString("PRODUCT_INFO"));
//					productVO.setProduct_Img1(rs.getBytes("PRODUCT_IMG1"));
//					productVO.setProduct_Img2(rs.getBytes("PRODUCT_IMG2"));
//					productVO.setProduct_Img3(rs.getBytes("PRODUCT_IMG3"));
//					productVO.setProduct_Img4(rs.getBytes("PRODUCT_IMG4"));
//					productVO.setProduct_Img5(rs.getBytes("PRODUCT_IMG5"));
					list.add(productVO);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<ProductVO> searchData(String query) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;
		String GET_SEARCH_DATA1 = "SELECT PRODUCT_ID,PRODUCT_NAME,PRODUCT_INTRO,PRODUCT_STAYTIME,PRODUCT_ADDRESS,"
				+ "PRODUCT_LATITUTDE,PRODUCT_LONGITUDE,PRODUCT_COUNTY,PRODUCT_CLASS,PRODUCT_STYLE,PRODUCT_SEQ,PRODUCT_STATE,"
				+ "PRODUCT_SALE_REC,PRODUCT_CLICK_REC,PRODUCT_TOTAL_SCHEDULE,PRODUCT_INFO FROM PRODUCT "
				+ "WHERE PRODUCT_NAME LIKE '%"+ query + "%'";
		try (Connection conn = common.dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(GET_SEARCH_DATA1);) {
//			try (Connection conn = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
//					PreparedStatement ps = conn.prepareStatement(GET_SEARCH_DATA1);) {
			//ps.setString(1, query);
			try (ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					productVO = new ProductVO();
					productVO.setProduct_ID(rs.getString("PRODUCT_ID"));
					productVO.setProduct_Name(rs.getString("PRODUCT_NAME"));
					productVO.setProduct_Intro(rs.getString("PRODUCT_INTRO"));
					productVO.setProduct_Staytime(rs.getDouble("PRODUCT_STAYTIME"));
					productVO.setProduct_Address(rs.getString("PRODUCT_ADDRESS"));
					productVO.setProduct_Latitutde(rs.getDouble("PRODUCT_LATITUTDE"));
					productVO.setProduct_Longitude(rs.getDouble("PRODUCT_LONGITUDE"));
					productVO.setProduct_County(rs.getString("PRODUCT_COUNTY"));
					productVO.setProduct_Class(rs.getString("PRODUCT_CLASS"));
					productVO.setProduct_Style(rs.getString("PRODUCT_STYLE"));
					productVO.setProduct_Seq(rs.getInt("PRODUCT_SEQ"));
					productVO.setProduct_State(rs.getInt("PRODUCT_STATE"));
					productVO.setProduct_Sale_Rec(rs.getInt("PRODUCT_SALE_REC"));
					productVO.setProduct_Click_Rec(rs.getInt("PRODUCT_CLICK_REC"));
					productVO.setProduct_Total_Schedule(rs.getString("PRODUCT_TOTAL_SCHEDULE"));
					productVO.setProduct_Info(rs.getString("PRODUCT_INFO"));
					list.add(productVO);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public ProductVO inserWithProduct_Ditel(ProductVO productVO, ProductDetailVO pdVO) {

		Connection con = null;
		PreparedStatement ps = null;

		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			// 先新增主黨
			String cols[] = { "Product_ID" };
			ps = con.prepareStatement(INSERT_SQL, cols);
			
			ps.setString(1, productVO.getProduct_Name());
			ps.setString(2, productVO.getProduct_Intro());
			ps.setDouble(3, productVO.getProduct_Staytime());
			ps.setString(4, productVO.getProduct_Address());
			ps.setDouble(5, productVO.getProduct_Latitutde());
			ps.setDouble(6, productVO.getProduct_Longitude());
			ps.setString(7, productVO.getProduct_County());
			ps.setString(8, productVO.getProduct_Class());
			ps.setString(9, productVO.getProduct_Style());
			ps.setInt(10, productVO.getProduct_Seq());
			ps.setInt(11, productVO.getProduct_State());
			ps.setInt(12, productVO.getProduct_Sale_Rec());
			ps.setInt(13, productVO.getProduct_Click_Rec());
			ps.setString(14, productVO.getProduct_Total_Schedule());
			ps.setString(15, productVO.getProduct_Info()); // 結至5/18，只能輸入100-300MB的資料
			ps.setBytes(16, productVO.getProduct_Img1());
			ps.setBytes(17, productVO.getProduct_Img2());
			ps.setBytes(18, productVO.getProduct_Img3());
			ps.setBytes(19, productVO.getProduct_Img4());
			ps.setBytes(20, productVO.getProduct_Img5());

			ps.executeUpdate();
			// 掘取對應的自增主鍵值
			
			String next_pid = null;
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				next_pid = rs.getString(1);
				System.out.println("自增主鍵值= " + next_pid + "(剛新增成功的部門編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			// 再同時新增明細
			ProductDetailDAO_JDBC dao = new ProductDetailDAO_JDBC();
			ProductDetailVO aPD = new ProductDetailVO();
			System.out.println("同時新增一筆商品明細=");
			
			aPD.setProduct_ID(new String(next_pid));
			aPD.setProduct_Detail_Instock(pdVO.getProduct_Detail_Instock());
			aPD.setProduct_Detail_Money(pdVO.getProduct_Detail_Money());
			aPD.setProduct_Detail_Saftystock(pdVO.getProduct_Detail_Saftystock());
			aPD.setProduct_Detail_Spc(pdVO.getProduct_Detail_Spc());

			dao.insert2(aPD, con);
			

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			
			System.out.println("新增商品主黨編號" + next_pid + "時,共有明細" + 1 + "同時被新增");
			
			return productVO;
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-Product");
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

	}
	
	@Override
	public ProductVO updateWithProduct_Ditel(ProductVO productVO, ProductDetailVO pdVO) {

		Connection con = null;
		PreparedStatement ps = null;

		try {

			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			// 先新增主黨
			ps = con.prepareStatement(UPDATE_SQL);
			
			ps.setString(1, productVO.getProduct_Name());
			ps.setString(2, productVO.getProduct_Intro());
			ps.setDouble(3, productVO.getProduct_Staytime());
			ps.setString(4, productVO.getProduct_Address());
			ps.setDouble(5, productVO.getProduct_Latitutde());
			ps.setDouble(6, productVO.getProduct_Longitude());
			ps.setString(7, productVO.getProduct_County());
			ps.setString(8, productVO.getProduct_Class());
			ps.setString(9, productVO.getProduct_Style());
			ps.setInt(10, productVO.getProduct_Seq());
			ps.setInt(11, productVO.getProduct_State());
			ps.setInt(12, productVO.getProduct_Sale_Rec());
			ps.setInt(13, productVO.getProduct_Click_Rec());
			ps.setString(14, productVO.getProduct_Total_Schedule());
			ps.setString(15, productVO.getProduct_Info()); 
			ps.setBytes(16, productVO.getProduct_Img1());
			ps.setBytes(17, productVO.getProduct_Img2());
			ps.setBytes(18, productVO.getProduct_Img3());
			ps.setBytes(19, productVO.getProduct_Img4());
			ps.setBytes(20, productVO.getProduct_Img5());
			ps.setString(21, productVO.getProduct_ID());

			ps.executeUpdate();
			// 掘取對應的自增主鍵值
			
			
			// 再同時新增明細
			ProductDetailDAO_JDBC dao = new ProductDetailDAO_JDBC();
			ProductDetailVO aPD = new ProductDetailVO();
			
			
			aPD.setProduct_ID( pdVO.getProduct_ID());
			aPD.setProduct_Detail_ID(pdVO.getProduct_Detail_ID());
			aPD.setProduct_Detail_Instock(pdVO.getProduct_Detail_Instock());
			aPD.setProduct_Detail_Money(pdVO.getProduct_Detail_Money());
			aPD.setProduct_Detail_Saftystock(pdVO.getProduct_Detail_Saftystock());
			aPD.setProduct_Detail_Spc(pdVO.getProduct_Detail_Spc());
			aPD.setProduct_Detail_Date(pdVO.getProduct_Detail_Date());
			
			System.out.println("同時修改一筆商品明細=" +aPD);


			dao.update2(aPD, con);
			

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			
			
			return productVO;
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-Product");
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

	}

	public static void main(String[] args) {
		ProductDAO_JDBC pDAO = new ProductDAO_JDBC();

////INSERT
//		ProductVO productVO_insert = new ProductVO();
//		productVO_insert.setProduct_Name("故宮博物院");
//		productVO_insert.setProduct_Intro("中華民族藏品最多最完整的國家博物館");
//		productVO_insert.setProduct_Staytime(4D);
//		productVO_insert.setProduct_Address("111台北市士林區至善路二段221號");
//		productVO_insert.setProduct_Latitutde(25.10235);
//		productVO_insert.setProduct_Longitude(121.54849);
//		productVO_insert.setProduct_County("台北市");
//		productVO_insert.setProduct_Class("景點");
//		productVO_insert.setProduct_Style("歷史人文");
//		productVO_insert.setProduct_Seq(1);
//		productVO_insert.setProduct_State(1);
//		productVO_insert.setProduct_Sale_Rec((int) (Math.random() * 10000));
//		productVO_insert.setProduct_Click_Rec((int) (Math.random() * 10000));
//		productVO_insert.setProduct_Total_Schedule("國家級展覽中心，內藏中國各年代古蹟。不定時推出國外博物館特藏展");
//		productVO_insert.setProduct_Info("國立故宮博物院，簡稱故宮");
//		productVO_insert.setProduct_Img1("123".getBytes());
//		productVO_insert.setProduct_Img2("123".getBytes());
//		productVO_insert.setProduct_Img3("123".getBytes());
//		productVO_insert.setProduct_Img4("123".getBytes());
//		productVO_insert.setProduct_Img5("123".getBytes());
//		System.out.println(pDAO.insert(productVO_insert));
//		// 連動其他表格
//		ProductDetailDAO_JDBC pdDAO = new ProductDetailDAO_JDBC();
//		ProductDetailVO Product_DetailVO_insert = new ProductDetailVO();
//		Product_DetailVO_insert.setProduct_ID(productVO_insert.getProduct_ID());
//		Product_DetailVO_insert.setProduct_Detail_Spc("8人房");
//		Product_DetailVO_insert.setProduct_Detail_Money(3000);
//		Product_DetailVO_insert.setProduct_Detail_Instock(100);
//		Product_DetailVO_insert.setProduct_Detail_Saftystock(5);
//		Product_DetailVO_insert.setProduct_Detail_Date(utils.ChangeDateFormate.ChangeDateFormate_Dash("2020-02-30"));
//		System.out.println(pdDAO.insert(Product_DetailVO_insert, productVO_insert));
//
////UPDATE
//		ProductVO productVO_update = new ProductVO();
//		productVO_update.setProduct_ID("PID000017");
//		productVO_update.setProduct_Name("龍山寺");
//		productVO_update.setProduct_Intro("中華民族藏品最多最完整的國家博物館");
//		productVO_update.setProduct_Staytime(4D);
//		productVO_update.setProduct_Address("111台北市士林區至善路二段221號");
//		productVO_update.setProduct_Latitutde(25.10235);
//		productVO_update.setProduct_Longitude(121.54849);
//		productVO_update.setProduct_County("台北市");
//		productVO_update.setProduct_Class("景點");
//		productVO_update.setProduct_Style("歷史人文");
//		productVO_update.setProduct_Seq(1);
//		productVO_update.setProduct_State(1);
//		productVO_update.setProduct_Sale_Rec(9478);
//		productVO_update.setProduct_Click_Rec(456);
//		productVO_update.setProduct_Total_Schedule("國家級展覽中心，內藏中國各年代古蹟。不定時推出國外博物館特藏展");
//		productVO_update.setProduct_Info("國立故宮博物院，簡稱故宮");
//		productVO_update.setProduct_Img1("123".getBytes());
//		productVO_update.setProduct_Img2("123".getBytes());
//		productVO_update.setProduct_Img3("123".getBytes());
//		productVO_update.setProduct_Img4("123".getBytes());
//		productVO_update.setProduct_Img5("123".getBytes());
//		System.out.println(pDAO.update(productVO_update));
//
////DELETE
//		System.out.println(pDAO.delete("PID000034"));
//
////SELECT
//		ProductVO productVO_select = pDAO.select("PID000017");
//		System.out.println(productVO_select.getProduct_Name());
//
////GET_ALL (ORDER BY PRODUCT_SALE_REC 降序DESC)
//		pDAO.getAll().forEach(System.out::println);
	}
}
