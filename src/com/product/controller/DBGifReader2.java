package com.product.controller;
import Common.common;
import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;
@WebServlet("/DBGifReader2")
public class DBGifReader2 extends HttpServlet {
	
	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//		System.out.println(new java.util.Date().getTime());
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
//		System.out.println("近來");
		try {
//			Statement stmt = con.createStatement();
//			String product_ID = req.getParameter("product_ID");
//			String whichImg = req.getParameter("whichImg");
//			ResultSet rs = stmt.executeQuery("SELECT "+whichImg+" FROM PRODUCT WHERE PRODUCT_ID = '"+product_ID+"'");
//			con = common.dataSource.getConnection();
			Statement stmt = con.createStatement();
			String conditions = req.getParameter("conditions");
			String whichImg = req.getParameter("whichImg");
			String tName = req.getParameter("tName");
//			System.out.println("測試 ================="+conditions + whichImg+tName );
			ResultSet rs = null;
			if(tName.equals("PRODUCT")) {
//				System.out.println("到PRODUCT搜尋圖片");
				rs = stmt.executeQuery("SELECT "+whichImg+" FROM "+tName+" WHERE PRODUCT_ID = '"+conditions+"'");
			}else if (tName.equals("PRODUCT_CMT")) {
//				System.out.println("到PRODUCT_CMT搜尋圖片");
				rs = stmt.executeQuery("SELECT "+whichImg+" FROM "+tName+" WHERE PRODUCT_CMT_ID = '"+conditions+"'");
			}else if (tName.equals("MEMBERS")) {
//				System.out.println("到MEMBERS搜尋圖片");
				rs = stmt.executeQuery("SELECT MEMBER_IMG FROM "+tName+" WHERE MEMBER_ID = '"+conditions+"'");
			}
			
			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream(whichImg));
				byte[] buf = new byte[8 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
				//res.sendError(HttpServletResponse.SC_NOT_FOUND);
				InputStream in = getServletContext().getResourceAsStream("/NoData/null4.jpg");
				byte[] buf = new byte[in.available()];
				in.read(buf);
				out.write(buf);
				in.close();
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			//System.out.println(e);
			InputStream in = getServletContext().getResourceAsStream("/NoData/null4.jpg");
			byte[] buf = new byte[in.available()];
			in.read(buf);
			out.write(buf);
			in.close();
		}
	}

	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB3");
//			String driver = "oracle.jdbc.driver.OracleDriver";
//			String url = "jdbc:oracle:thin:@localhost:49161:XE";
//			String userid = "TDA101G1";
//			String passwd = "123456";
//			try {
//				Class.forName(driver);
//			} catch (ClassNotFoundException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void destroy() {
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}

}