package com.product.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.JSONException;
import org.json.JSONObject;

import com.coupon.model.CouponService;
import com.coupon.model.CouponVO;
import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.product.model.ProductDetailService;
import com.product.model.ProductDetailVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/backstage/ProductServlet.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 25)
public class ProductServletforbackstage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html;charset=UTF-8");

		req.setCharacterEncoding("UTF-8");
		res.addHeader("Access-Control-Allow-Origin", "*");
		HttpSession session = req.getSession();

		String action = req.getParameter("action");
		System.out.println("此次請求action為: " + action);

		if ("insert".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {

				String product_Name = req.getParameter("product_Name").trim();
				if (product_Name == null || product_Name.trim().length() == 0) {
					errorMsgs.put("product_Name", "請輸入景點名稱");
				}

				String product_Info = req.getParameter("product_Info").trim();
				if (product_Info == null || product_Info.trim().length() == 0) {
					errorMsgs.put("product_Info", "請輸入詳情");
				}

				String product_Intro = req.getParameter("product_Intro").trim();
				if (product_Info == null || product_Intro.trim().length() == 0) {
					errorMsgs.put("product_Intro", "請輸入簡介");
				}

				Integer product_State = new Integer(req.getParameter("product_State").trim());

				Double product_Staytime = null;
				try {
					product_Staytime = new Double(req.getParameter("product_Staytime").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Staytime = null;
					errorMsgs.put("product_Staytime", "請輸入停留時間");
				}

				Double product_Latitutde = null;
				try {
					System.out.println(req.getParameter("product_Latitutde").trim());
					product_Latitutde = new Double(req.getParameter("product_Latitutde").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Latitutde = 0.0;
					errorMsgs.put("product_Latitutde", "請輸入經度");
				}

				Double product_Longitude = null;
				try {
					System.out.println(req.getParameter("product_Longitude").trim());
					product_Longitude = new Double(req.getParameter("product_Longitude").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Longitude = 0.0;
					errorMsgs.put("product_Longitude", "請輸入緯度");
				}

				String product_Address = req.getParameter("product_Address").trim();
				if (product_Address == null || product_Address.trim().length() == 0) {
					errorMsgs.put("product_Address", "請輸入地址");
				}

				String product_Class = new String(req.getParameter("product_Class").trim());

				String product_County = req.getParameter("product_County").trim();
				if (product_County == null || product_County.trim().length() == 0 || product_County.equals("縣市")) {
					errorMsgs.put("product_County", "請選擇縣市");
				}

				String product_Total_Schedule = req.getParameter("product_Total_Schedule").trim();
				if (product_Total_Schedule == null || product_Total_Schedule.trim().length() == 0) {
					errorMsgs.put("product_Total_Schedule", "請輸入行程總覽");
				}

				// 上傳照片
				byte[] product_Img1 = null;
				Part part = req.getPart("product_Img1");
				if (part == null || part.getSize() == 0) {
					errorMsgs.put("product_Img1", "請存入第一張照片");
				} else {
					InputStream in = part.getInputStream();
					product_Img1 = new byte[in.available()];
					in.read(product_Img1);
					in.close();
				}

				byte[] product_Img2 = null;
				Part part2 = req.getPart("product_Img2");
				if (part2 == null || part2.getSize() == 0) {
					errorMsgs.put("product_Img2", "請存入第五張照片");
				} else {
					InputStream in = part2.getInputStream();
					product_Img2 = new byte[in.available()];
					in.read(product_Img2);
					in.close();
				}

				byte[] product_Img3 = null;
				Part part3 = req.getPart("product_Img3");
				if (part3 == null || part3.getSize() == 0) {
					errorMsgs.put("product_Img3", "請存入第四張照片");
				} else {
					InputStream in = part3.getInputStream();
					product_Img3 = new byte[in.available()];
					in.read(product_Img3);
					in.close();
				}

				byte[] product_Img4 = null;
				Part part4 = req.getPart("product_Img4");
				if (part4 == null || part4.getSize() == 0) {
					errorMsgs.put("product_Img4", "請存入第三張照片");
				} else {
					InputStream in = part4.getInputStream();
					product_Img4 = new byte[in.available()];
					in.read(product_Img4);
					in.close();
				}

				byte[] product_Img5 = null;
				Part part5 = req.getPart("product_Img5");
				if (part5 == null || part5.getSize() == 0) {
					errorMsgs.put("product_Img5", "請存入第二張照片");
				} else {
					InputStream in = part5.getInputStream();
					product_Img5 = new byte[in.available()];
					in.read(product_Img5);
					in.close();
				}

				// 商品明細

				String product_Detail_Spc = req.getParameter("product_Detail_Spc").trim();

				if (product_Detail_Spc.trim().length() == 0 || product_Detail_Spc ==null) {
					errorMsgs.put("product_Detail_Spc", "請加入規格");
				}

				Integer product_Detail_Instock = null;
				try {
					product_Detail_Instock = new Integer(req.getParameter("product_Detail_Instock").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Instock = null;
					errorMsgs.put("product_Detail_Instock", "請輸入庫存量");
				}
				Integer product_Detail_Money = null;
				try {
					product_Detail_Money = new Integer(req.getParameter("product_Detail_Money").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Money = null;
					errorMsgs.put("product_Detail_Money", "請輸入景點金額");
				}

				Integer product_Detail_Saftystock = null;
				try {
					product_Detail_Saftystock = new Integer(req.getParameter("product_Detail_Saftystock").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Saftystock = null;
					errorMsgs.put("product_Detail_Saftystock", "請輸入安全庫存量");
				}

				ProductVO productVO = new ProductVO();
				productVO.setProduct_Name(product_Name);
				productVO.setProduct_Intro(product_Intro);
				productVO.setProduct_Staytime(product_Staytime);
				productVO.setProduct_Address(product_Address);
				productVO.setProduct_Latitutde(product_Latitutde);
				productVO.setProduct_Longitude(product_Longitude);
				productVO.setProduct_County(product_County);
				productVO.setProduct_Class(product_Class);
				productVO.setProduct_Style("");
				productVO.setProduct_Seq(0);
				productVO.setProduct_State(product_State);
				productVO.setProduct_Sale_Rec(0);
				productVO.setProduct_Click_Rec(0);
				productVO.setProduct_Total_Schedule(product_Total_Schedule);
				productVO.setProduct_Info(product_Info);
				productVO.setProduct_Img1(product_Img1);
				productVO.setProduct_Img2(product_Img2);
				productVO.setProduct_Img3(product_Img3);
				productVO.setProduct_Img4(product_Img4);
				productVO.setProduct_Img5(product_Img5);

				ProductDetailVO productDetailVO = new ProductDetailVO();

				productDetailVO.setProduct_Detail_Date(null);
				productDetailVO.setProduct_Detail_Instock(product_Detail_Instock);
				productDetailVO.setProduct_Detail_Money(product_Detail_Money);
				productDetailVO.setProduct_Detail_Saftystock(product_Detail_Saftystock);
				productDetailVO.setProduct_Detail_Spc(product_Detail_Spc);
				
				req.setAttribute("pVO", productVO);
				req.setAttribute("pdVO", productDetailVO);
				// Send the use back to the form, if there were errors

				if (!errorMsgs.isEmpty()) {
					

					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/addProduct.jsp");
					failureView.forward(req, res);
					return;

				}

				ProductService pSvc = new ProductService();
				productVO = pSvc.inserWith(productVO, productDetailVO);

				String url = "/backstage/product/getAllproduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/addSchedule.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insertSchedule".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {

				Double product_Staytime = null;
				try {
					product_Staytime = new Double(req.getParameter("product_Staytime").trim());

					System.out.println(product_Staytime);
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Staytime = null;
					errorMsgs.put("product_Staytime", "請輸入停留時間");
				}

				if (product_Staytime == 2.0) {
					String day1 = req.getParameter("day1").trim();
					String day2 = req.getParameter("day2").trim();
					req.setAttribute("day1", day1);
					req.setAttribute("day2", day2);

					if (day1 == null || day1.trim().length() == 0) {
						errorMsgs.put("day1", "請輸入第一天行程");

					}

					if (day2 == null || day2.trim().length() == 0) {
						errorMsgs.put("day2", "請輸入第二天行程");
					}

				} else if (product_Staytime == 3.0) {
					String day1 = req.getParameter("day1").trim();
					String day2 = req.getParameter("day2").trim();
					String day3 = req.getParameter("day3").trim();
					req.setAttribute("day1", day1);
					req.setAttribute("day2", day2);
					req.setAttribute("day3", day3);

					if (day1 == null || day1.trim().length() == 0) {
						errorMsgs.put("day1", "請輸入第一天行程");

					}

					if (day2 == null || day2.trim().length() == 0) {
						errorMsgs.put("day2", "請輸入第二天行程");
					}

					if (day3 == null || day3.trim().length() == 0) {
						errorMsgs.put("day3", "請輸入第三天行程");
					}

				} else if (product_Staytime == 1.0 || product_Staytime == null) {
					String day1 = req.getParameter("day1").trim();
					req.setAttribute("day1", day1);

					if (day1 == null || day1.trim().length() == 0) {
						errorMsgs.put("day1", "請輸入第一天行程");

					}
				}

				String product_Name = req.getParameter("product_Name").trim();
				if (product_Name == null || product_Name.trim().length() == 0) {
					errorMsgs.put("product_Name", "請輸入景點名稱");
				}

				String product_Info = req.getParameter("product_Info").trim();
				if (product_Info == null || product_Info.trim().length() == 0) {
					errorMsgs.put("product_Info", "請輸入詳情");
				}

				String product_Intro = req.getParameter("product_Intro").trim();
				if (product_Info == null || product_Intro.trim().length() == 0) {
					errorMsgs.put("product_Intro", "請輸入簡介");
				}

				Integer product_State = new Integer(req.getParameter("product_State").trim());

				String product_Address = req.getParameter("product_Address").trim();
				if (product_Address == null || product_Address.trim().length() == 0) {
					errorMsgs.put("product_Address", "請輸入景點數量");
				}

				String product_Class = req.getParameter("product_Class").trim();

				String product_County = req.getParameter("product_County").trim();
				if (product_County == null || product_County.trim().length() == 0 || product_County.equals("縣市")) {
					errorMsgs.put("product_County", "請選擇縣市");
				}

				// 上傳照片
				byte[] product_Img1 = null;
				Part part = req.getPart("product_Img1");
				if (part == null || part.getSize() == 0) {
					errorMsgs.put("product_Img1", "請存入第一張照片");
				} else {
					InputStream in = part.getInputStream();
					product_Img1 = new byte[in.available()];
					in.read(product_Img1);
					in.close();
				}

				byte[] product_Img2 = null;
				Part part2 = req.getPart("product_Img2");
				if (part2 == null || part2.getSize() == 0) {
					errorMsgs.put("product_Img2", "請存入第二張照片");
				} else {
					InputStream in = part2.getInputStream();
					product_Img2 = new byte[in.available()];
					in.read(product_Img2);
					in.close();
				}

				byte[] product_Img3 = null;
				Part part3 = req.getPart("product_Img3");
				if (part3 == null || part3.getSize() == 0) {
					errorMsgs.put("product_Img3", "請存入第三張照片");
				} else {
					InputStream in = part3.getInputStream();
					product_Img3 = new byte[in.available()];
					in.read(product_Img3);
					in.close();
				}

				byte[] product_Img4 = null;
				Part part4 = req.getPart("product_Img4");
				if (part4 == null || part4.getSize() == 0) {
					errorMsgs.put("product_Img4", "請存入第四張照片");
				} else {
					InputStream in = part4.getInputStream();
					product_Img4 = new byte[in.available()];
					in.read(product_Img4);
					in.close();
				}

				byte[] product_Img5 = null;
				Part part5 = req.getPart("product_Img5");
				if (part5 == null || part5.getSize() == 0) {
					errorMsgs.put("product_Img5", "請存入第五張照片");
				} else {
					InputStream in = part5.getInputStream();
					product_Img5 = new byte[in.available()];
					in.read(product_Img5);
					in.close();
				}

				// 商品明細

				String product_Detail_Spc = req.getParameter("product_Detail_Spc").trim();

				if (product_Detail_Spc.trim().length() == 0 || product_Detail_Spc ==null) {
					errorMsgs.put("product_Detail_Spc", "請加入規格");
				}

				Integer product_Detail_Instock = null;
				try {
					product_Detail_Instock = new Integer(req.getParameter("product_Detail_Instock").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Instock = null;
					errorMsgs.put("product_Detail_Instock", "請輸入庫存量");
				}
				Integer product_Detail_Money = null;
				try {
					product_Detail_Money = new Integer(req.getParameter("product_Detail_Money").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Money = null;
					errorMsgs.put("product_Detail_Money", "請輸入景點金額");
				}

				Integer product_Detail_Saftystock = null;
				try {
					product_Detail_Saftystock = new Integer(req.getParameter("product_Detail_Saftystock").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Saftystock = null;
					errorMsgs.put("product_Detail_Saftystock", "請輸入安全庫存量");
				}
				
				

				ProductVO productVO = new ProductVO();
				productVO.setProduct_Name(product_Name);
				productVO.setProduct_Intro(product_Intro);
				productVO.setProduct_Staytime(product_Staytime);
				productVO.setProduct_Address(product_Address);
				productVO.setProduct_Latitutde(0.0);
				productVO.setProduct_Longitude(0.0);
				productVO.setProduct_County(product_County);
				productVO.setProduct_Class(product_Class);
				productVO.setProduct_Style("");
				productVO.setProduct_Seq(0);
				productVO.setProduct_State(product_State);
				productVO.setProduct_Sale_Rec(0);
				productVO.setProduct_Click_Rec(0);
				// 行程存在錯誤訊息之下
				productVO.setProduct_Info(product_Info);
				productVO.setProduct_Img1(product_Img1);
				productVO.setProduct_Img2(product_Img2);
				productVO.setProduct_Img3(product_Img3);
				productVO.setProduct_Img4(product_Img4);
				productVO.setProduct_Img5(product_Img5);

				ProductDetailVO productDetailVO = new ProductDetailVO();

				productDetailVO.setProduct_Detail_Date(null);
				productDetailVO.setProduct_Detail_Instock(product_Detail_Instock);
				productDetailVO.setProduct_Detail_Money(product_Detail_Money);
				productDetailVO.setProduct_Detail_Saftystock(product_Detail_Saftystock);
				productDetailVO.setProduct_Detail_Spc(product_Detail_Spc);
				
				req.setAttribute("pVO", productVO);
				req.setAttribute("pdVO", productDetailVO);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

				

					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/addSchedule.jsp");
					failureView.forward(req, res);
					return;

				}

				ProductService pSvc = new ProductService();

				if (product_Staytime == 1.0) {
					String day1 = req.getParameter("day1").trim();

					productVO.setProduct_Total_Schedule(day1);

				} else if (product_Staytime == 2.0) {
					String day1 = req.getParameter("day1").trim();
					String day2 = req.getParameter("day2").trim();
					productVO.setProduct_Total_Schedule(  day1 + "Dayys" + day2);
				} else {
					String day1 = req.getParameter("day1").trim();
					String day2 = req.getParameter("day2").trim();
					String day3 = req.getParameter("day3").trim();

					productVO.setProduct_Total_Schedule(day1 + "Dayys" + day2 + "Dayys" + day3);

				}

				productVO = pSvc.inserWith(productVO, productDetailVO);

				String url = "/backstage/product/getAllproduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/addSchedule.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne".equals(action)) { // 來自select_page.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String p_ID = req.getParameter("p_ID").trim();
				System.out.println(p_ID);
				String p_IDReg = "^[P][I][D][0-9]{6}$";
				if (p_ID == null || p_ID.trim().length() == 0) {
					errorMsgs.put("p_ID", "商品編號請勿空白");
				} else if (!p_ID.trim().matches(p_IDReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("p_ID", "格式錯誤，商品號碼只能是PID開頭加上六個數字");
				}
				
				
				// Send the use back to the form, if there were errors
			

				/*************************** 2.開始查詢資料 *****************************************/
				ProductService pSvc = new ProductService();
				ProductVO pVO = pSvc.select(p_ID);
				if (pVO == null) {
					errorMsgs.put("p_ID", "查無此商品");

				}
				
				req.setAttribute("p_ID", p_ID);

				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/getAllproduct.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("pVO", pVO); // 資料庫取出的empVO物件,存入req
				String url = "/backstage/product/get_SPC.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/getAllproduct.jsp");
				failureView.forward(req, res);
			}
		}

		if ("get_SPC".equals(action)) { // 來自select_page.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String p_ID = req.getParameter("p_ID").trim();

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/getAllproduct.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ProductService pSvc = new ProductService();
				ProductVO pVO = pSvc.select(p_ID);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("pVO", pVO); // 資料庫取出的empVO物件,存入req
				String url = "/backstage/product/get_SPC.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/getAllproduct.jsp");
				failureView.forward(req, res);
			}
		}

		if ("get_Oneforupdate".equals(action)) { // 來自select_page.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				String p_ID = req.getParameter("p_ID").trim();

				String pd_ID = req.getParameter("pd_ID").trim();

				/*************************** 2.開始查詢資料 *****************************************/
				ProductService pSvc = new ProductService();
				ProductDetailService pdSvc = new ProductDetailService();
				ProductVO pVO = pSvc.select(p_ID);

				ProductDetailVO pdVO = new ProductDetailVO();
				pdVO.setProduct_Detail_ID(pd_ID);
				pdVO = pdSvc.select(pdVO);
				
				req.setAttribute("pVO", pVO);
				req.setAttribute("pdVO", pdVO);// 資料庫取出的empVO物件,存入req

				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/get_SPC.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

			

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			
				if (pVO.getProduct_Class().equals("套裝行程")) {

					String url = "/backstage/product/updateSchedule.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
					successView.forward(req, res);

				} else {
					String url = "/backstage/product/updateProduct.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
					successView.forward(req, res);

				}

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/get_SPC.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				

				String product_ID = req.getParameter("product_ID").trim();

				String productDetail_ID = req.getParameter("productDatile_ID").trim();

				String product_Name = req.getParameter("product_Name").trim();
				if (product_Name == null || product_Name.trim().length() == 0) {
					errorMsgs.put("product_Name", "請輸入景點名稱");
				}

				String product_Info = req.getParameter("product_Info").trim();
				if (product_Info == null || product_Info.trim().length() == 0) {
					errorMsgs.put("product_Info", "請輸入詳情");
				}

				String product_Intro = req.getParameter("product_Intro").trim();
				if (product_Info == null || product_Intro.trim().length() == 0) {
					errorMsgs.put("product_Intro", "請輸入簡介");
				}

				Integer product_State = new Integer(req.getParameter("product_State").trim());

				Double product_Staytime = null;
				try {
					product_Staytime = new Double(req.getParameter("product_Staytime").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Staytime = null;
					errorMsgs.put("product_Staytime", "請輸入停留時間");
				}

				Double product_Latitutde = null;
				try {
					System.out.println(req.getParameter("product_Latitutde").trim());
					product_Latitutde = new Double(req.getParameter("product_Latitutde").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Latitutde = 0.0;
					errorMsgs.put("product_Latitutde", "請輸入經度");
				}

				Double product_Longitude = null;
				try {
					System.out.println(req.getParameter("product_Longitude").trim());
					product_Longitude = new Double(req.getParameter("product_Longitude").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Longitude = 0.0;
					errorMsgs.put("product_Longitude", "請輸入緯度");
				}

				String product_Address = req.getParameter("product_Address").trim();
				if (product_Address == null || product_Address.trim().length() == 0) {
					errorMsgs.put("product_Address", "請輸入地址");
				}

				String product_Class = new String(req.getParameter("product_Class").trim());

				String product_County = req.getParameter("product_County").trim();
				if (product_County == null || product_County.trim().length() == 0 || product_County.equals("縣市")) {
					errorMsgs.put("product_County", "請選擇縣市");
				}

				String product_Total_Schedule = req.getParameter("product_Total_Schedule").trim();
				if (product_Total_Schedule == null || product_Total_Schedule.trim().length() == 0) {
					errorMsgs.put("product_Total_Schedule", "請輸入行程總覽");
				}

				// 上傳照片
				byte[] product_Img1 = null;
				Part part = req.getPart("product_Img1");
				if (part == null || part.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img1 = pVO.getProduct_Img1();

				} else {
					InputStream in = part.getInputStream();
					product_Img1 = new byte[in.available()];
					in.read(product_Img1);
					in.close();
				}

				byte[] product_Img2 = null;
				Part part2 = req.getPart("product_Img2");
				if (part2 == null || part2.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img2 = pVO.getProduct_Img2();

				} else {
					InputStream in = part2.getInputStream();
					product_Img2 = new byte[in.available()];
					in.read(product_Img2);
					in.close();
				}

				byte[] product_Img3 = null;
				Part part3 = req.getPart("product_Img3");
				if (part3 == null || part3.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img3 = pVO.getProduct_Img3();

				} else {
					InputStream in = part3.getInputStream();
					product_Img3 = new byte[in.available()];
					in.read(product_Img3);
					in.close();
				}

				byte[] product_Img4 = null;
				Part part4 = req.getPart("product_Img4");
				if (part4 == null || part4.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img4 = pVO.getProduct_Img4();

				} else {
					InputStream in = part4.getInputStream();
					product_Img4 = new byte[in.available()];
					in.read(product_Img4);
					in.close();
				}

				byte[] product_Img5 = null;
				Part part5 = req.getPart("product_Img5");
				if (part5 == null || part5.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img5 = pVO.getProduct_Img5();

				} else {
					InputStream in = part5.getInputStream();
					product_Img5 = new byte[in.available()];
					in.read(product_Img5);
					in.close();
				}

				// 商品明細

				String product_Detail_Spc = req.getParameter("product_Detail_Spc").trim();

				if (product_Detail_Spc.trim().length() == 0 || product_Detail_Spc ==null) {
					errorMsgs.put("product_Detail_Spc", "請加入規格");
				}

				if (product_Detail_Spc.trim().length() == 0 || product_Detail_Spc ==null) {
					errorMsgs.put("product_Detail_Spc", "請加入規格");
				}
				
				
				

				Integer product_Detail_Instock = null;
				try {
					product_Detail_Instock = new Integer(req.getParameter("product_Detail_Instock").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Instock = null;
					errorMsgs.put("product_Detail_Instock", "請輸入庫存量");
				}
				Integer product_Detail_Money = null;
				try {
					product_Detail_Money = new Integer(req.getParameter("product_Detail_Money").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Money = null;
					errorMsgs.put("product_Detail_Money", "請輸入景點金額");
				}
				
				

				Integer product_Detail_Saftystock = null;
				try {
					product_Detail_Saftystock = new Integer(req.getParameter("product_Detail_Saftystock").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Saftystock = null;
					errorMsgs.put("product_Detail_Saftystock", "請輸入安全庫存量");
				}

				Integer product_sale_rec = new Integer(req.getParameter("product_sale_rec").trim());

				Integer product_click_rec = new Integer(req.getParameter("product_click_rec").trim());

				Integer product_Seq = new Integer(req.getParameter("product_Seq").trim());

				ProductVO productVO = new ProductVO();
				productVO.setProduct_Name(product_Name);
				productVO.setProduct_Intro(product_Intro);
				productVO.setProduct_Staytime(product_Staytime);
				productVO.setProduct_Address(product_Address);
				productVO.setProduct_Latitutde(product_Latitutde);
				productVO.setProduct_Longitude(product_Longitude);
				productVO.setProduct_County(product_County);
				productVO.setProduct_Class(product_Class);
				productVO.setProduct_Style("");
				productVO.setProduct_Seq(product_Seq);
				productVO.setProduct_State(product_State);
				productVO.setProduct_Sale_Rec(product_sale_rec);
				productVO.setProduct_Click_Rec(product_click_rec);
				productVO.setProduct_Total_Schedule(product_Total_Schedule);
				productVO.setProduct_Info(product_Info);
				productVO.setProduct_Img1(product_Img1);
				productVO.setProduct_Img2(product_Img2);
				productVO.setProduct_Img3(product_Img3);
				productVO.setProduct_Img4(product_Img4);
				productVO.setProduct_Img5(product_Img5);
				productVO.setProduct_ID(product_ID);
			

				ProductDetailVO productDetailVO = new ProductDetailVO();

				productDetailVO.setProduct_Detail_Date(null);
				productDetailVO.setProduct_Detail_Instock(product_Detail_Instock);
				productDetailVO.setProduct_Detail_Money(product_Detail_Money);
				productDetailVO.setProduct_Detail_Saftystock(product_Detail_Saftystock);
				productDetailVO.setProduct_Detail_Spc(product_Detail_Spc);
				productDetailVO.setProduct_Detail_ID(productDetail_ID);
				productDetailVO.setProduct_ID(product_ID);
				
				req.setAttribute("pVO", productVO);
				req.setAttribute("pdVO", productDetailVO);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
			

					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/updateProduct.jsp");
					failureView.forward(req, res);
					return;

				}

				ProductService pSvc = new ProductService();
				productVO = pSvc.updateWith(productVO, productDetailVO);

				

				String url = "/backstage/product/get_SPC.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/updateProduct.jsp");
				failureView.forward(req, res);
			}
		}

		if ("updateSchedule".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {

				Double product_Staytime = null;
				try {
					product_Staytime = new Double(req.getParameter("product_Staytime").trim());

				
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Staytime = null;
					errorMsgs.put("product_Staytime", "請輸入停留時間");
				}
				
				
				String product_ID = req.getParameter("product_ID").trim();

				String productDetail_ID = req.getParameter("productDatile_ID").trim();

				
				

				if (product_Staytime == 2.0) {
					String day1 = req.getParameter("day1").trim();
					String day2 = req.getParameter("day2").trim();
					req.setAttribute("day1", day1);
					req.setAttribute("day2", day2);

					if (day1 == null || day1.trim().length() == 0) {
						errorMsgs.put("day1", "請輸入第一天行程");

					}

					if (day2 == null || day2.trim().length() == 0) {
						errorMsgs.put("day2", "請輸入第二天行程");
					}

				} else if (product_Staytime == 3.0) {
					String day1 = req.getParameter("day1").trim();
					String day2 = req.getParameter("day2").trim();
					String day3 = req.getParameter("day3").trim();
					req.setAttribute("day1", day1);
					req.setAttribute("day2", day2);
					req.setAttribute("day3", day3);

					if (day1 == null || day1.trim().length() == 0) {
						errorMsgs.put("day1", "請輸入第一天行程");

					}

					if (day2 == null || day2.trim().length() == 0) {
						errorMsgs.put("day2", "請輸入第二天行程");
					}

					if (day3 == null || day3.trim().length() == 0) {
						errorMsgs.put("day3", "請輸入第三天行程");
					}

				} else if (product_Staytime == 1.0 || product_Staytime == null) {
					String day1 = req.getParameter("day1").trim();
					req.setAttribute("day1", day1);

					if (day1 == null || day1.trim().length() == 0) {
						errorMsgs.put("day1", "請輸入第一天行程");

					}
				}

				String product_Name = req.getParameter("product_Name").trim();
				if (product_Name == null || product_Name.trim().length() == 0) {
					errorMsgs.put("product_Name", "請輸入景點名稱");
				}

				String product_Info = req.getParameter("product_Info").trim();
				if (product_Info == null || product_Info.trim().length() == 0) {
					errorMsgs.put("product_Info", "請輸入詳情");
				}

				String product_Intro = req.getParameter("product_Intro").trim();
				if (product_Info == null || product_Intro.trim().length() == 0) {
					errorMsgs.put("product_Intro", "請輸入簡介");
				}

				Integer product_State = new Integer(req.getParameter("product_State").trim());

				String product_Address = req.getParameter("product_Address").trim();
				if (product_Address == null || product_Address.trim().length() == 0) {
					errorMsgs.put("product_Address", "請輸入景點數量");
				}

				String product_Class = req.getParameter("product_Class").trim();

				String product_County = req.getParameter("product_County").trim();
				if (product_County == null || product_County.trim().length() == 0 || product_County.equals("縣市")) {
					errorMsgs.put("product_County", "請選擇縣市");
				}

				// 上傳照片
				byte[] product_Img1 = null;
				Part part = req.getPart("product_Img1");
				if (part == null || part.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img1 = pVO.getProduct_Img1();
				} else {
					InputStream in = part.getInputStream();
					product_Img1 = new byte[in.available()];
					in.read(product_Img1);
					in.close();
				}

				byte[] product_Img2 = null;
				Part part2 = req.getPart("product_Img2");
				if (part2 == null || part2.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img2 = pVO.getProduct_Img2();
				} else {
					InputStream in = part2.getInputStream();
					product_Img2 = new byte[in.available()];
					in.read(product_Img2);
					in.close();
				}

				byte[] product_Img3 = null;
				Part part3 = req.getPart("product_Img3");
				if (part3 == null || part3.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img3 = pVO.getProduct_Img3();
				} else {
					InputStream in = part3.getInputStream();
					product_Img3 = new byte[in.available()];
					in.read(product_Img3);
					in.close();
				}

				byte[] product_Img4 = null;
				Part part4 = req.getPart("product_Img4");
				if (part4 == null || part4.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img4 = pVO.getProduct_Img4();
				} else {
					InputStream in = part4.getInputStream();
					product_Img4 = new byte[in.available()];
					in.read(product_Img4);
					in.close();
				}

				byte[] product_Img5 = null;
				Part part5 = req.getPart("product_Img5");
				if (part5 == null || part5.getSize() == 0) {
					ProductVO pVO = new ProductVO();
					ProductService pSvc = new ProductService();

					pVO = pSvc.select(product_ID);
					product_Img5 = pVO.getProduct_Img5();
				} else {
					InputStream in = part5.getInputStream();
					product_Img5 = new byte[in.available()];
					in.read(product_Img5);
					in.close();
				}

				// 商品明細

				String product_Detail_Spc = req.getParameter("product_Detail_Spc").trim();

				if (product_Detail_Spc.trim().length() == 0 || product_Detail_Spc ==null) {
					errorMsgs.put("product_Detail_Spc", "請加入規格");
				}

				Integer product_Detail_Instock = null;
				try {
					product_Detail_Instock = new Integer(req.getParameter("product_Detail_Instock").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Instock = null;
					errorMsgs.put("product_Detail_Instock", "請輸入庫存量");
				}
				Integer product_Detail_Money = null;
				try {
					product_Detail_Money = new Integer(req.getParameter("product_Detail_Money").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Money = null;
					errorMsgs.put("product_Detail_Money", "請輸入景點金額");
				}

				Integer product_Detail_Saftystock = null;
				try {
					product_Detail_Saftystock = new Integer(req.getParameter("product_Detail_Saftystock").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					product_Detail_Saftystock = null;
					errorMsgs.put("product_Detail_Saftystock", "請輸入安全庫存量");
				}
				
				
				Integer product_sale_rec = new Integer(req.getParameter("product_sale_rec").trim());

				Integer product_click_rec = new Integer(req.getParameter("product_click_rec").trim());

				Integer product_Seq = new Integer(req.getParameter("product_Seq").trim());

				ProductVO productVO = new ProductVO();
				
				if (product_Staytime == 1.0) {
					String day1 = req.getParameter("day1").trim();

					productVO.setProduct_Total_Schedule(day1);

				} else if (product_Staytime == 2.0) {
					String day1 = req.getParameter("day1").trim();
					String day2 = req.getParameter("day2").trim();
					productVO.setProduct_Total_Schedule( day1 + "Dayys" + day2);
				} else {
					String day1 = req.getParameter("day1").trim();
					String day2 = req.getParameter("day2").trim();
					String day3 = req.getParameter("day3").trim();

					productVO.setProduct_Total_Schedule( day1 + "Dayys" + day2 + "Dayys" + day3);

				}

				
				
				
				productVO.setProduct_Name(product_Name);
				productVO.setProduct_Intro(product_Intro);
				productVO.setProduct_Staytime(product_Staytime);
				productVO.setProduct_Address(product_Address);
				productVO.setProduct_Latitutde(0.0);
				productVO.setProduct_Longitude(0.0);
				productVO.setProduct_County(product_County);
				productVO.setProduct_Class(product_Class);
				productVO.setProduct_Style("");
				productVO.setProduct_Seq(product_Seq);
				productVO.setProduct_State(product_State);
				productVO.setProduct_Sale_Rec(product_sale_rec);
				productVO.setProduct_Click_Rec(product_click_rec);
				// 行程存在錯誤訊息之下
				productVO.setProduct_Info(product_Info);
				productVO.setProduct_Img1(product_Img1);
				productVO.setProduct_Img2(product_Img2);
				productVO.setProduct_Img3(product_Img3);
				productVO.setProduct_Img4(product_Img4);
				productVO.setProduct_Img5(product_Img5);
				productVO.setProduct_ID(product_ID);

				ProductDetailVO productDetailVO = new ProductDetailVO();

				productDetailVO.setProduct_Detail_Date(null);
				productDetailVO.setProduct_Detail_Instock(product_Detail_Instock);
				productDetailVO.setProduct_Detail_Money(product_Detail_Money);
				productDetailVO.setProduct_Detail_Saftystock(product_Detail_Saftystock);
				productDetailVO.setProduct_Detail_Spc(product_Detail_Spc);
				productDetailVO.setProduct_Detail_ID(productDetail_ID);
				productDetailVO.setProduct_ID(product_ID);
				
				req.setAttribute("pVO", productVO);
				req.setAttribute("pdVO", productDetailVO);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

				

					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/updateSchedule.jsp");
					failureView.forward(req, res);
					return;

				}

				ProductService pSvc = new ProductService();

			
				productVO = pSvc.updateWith(productVO, productDetailVO);

				String url = "/backstage/product/get_SPC.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/product/updateSchedule.jsp");
				failureView.forward(req, res);
			}
		}

		
	}
}
