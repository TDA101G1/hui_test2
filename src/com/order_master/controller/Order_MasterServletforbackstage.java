package com.order_master.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
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

import com.coupon.model.CouponService;
import com.coupon.model.CouponVO;
import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.order_master.model.Order_MasterService;
import com.order_master.model.Order_MasterVO;
import com.product.model.ProductDetailVO;

@WebServlet("/backstage/order_master/order_master.do")
public class Order_MasterServletforbackstage extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		HttpSession session = req.getSession();

		String uri = (String) session.getAttribute("URL");

		System.out.println(uri);

		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");

	
		if ("getOneforupdate".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/

				String om_ID = new String(req.getParameter("order_Master_ID"));
				/*************************** 2.開始查詢資料 ****************************************/

				Order_MasterService omSvc = new Order_MasterService();
				Order_MasterVO omVO = omSvc.getOne(om_ID);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("omVO", omVO); // 資料庫取出的empVO物件,存入req
				String url = "/backstage/Order_Master/update_Order_Master.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/backstage/Order_Master/getAllOrder_Master.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自add.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				java.sql.Timestamp order_master_Date = java.sql.Timestamp
						.valueOf(req.getParameter("order_Master_Date").trim());

				String order_master_ID = req.getParameter("order_Master_ID").trim();

				String member_ID = req.getParameter("member_ID").trim();

				String coupon_ID = req.getParameter("coupon_ID").trim();

				String order_Master_Payment = req.getParameter("order_Master_Payment").trim();

				Integer order_Master_State = new Integer(req.getParameter("order_Master_State").trim());

			

				Order_MasterVO omVO = new Order_MasterVO();

				omVO.setOrder_Master_ID(order_master_ID);
				omVO.setOrder_Master_TimeStamp(order_master_Date);
				omVO.setMember_ID(member_ID);
				omVO.setCoupon_ID(coupon_ID);
				omVO.setOrder_Master_Payment(order_Master_Payment);
				omVO.setOrder_Master_State(order_Master_State);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("omVO", omVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backstage/Order_Master/update_Order_Master.jsp");
					failureView.forward(req, res);
					return;

				}

				/*************************** 2.開始修改資料 ***************************************/
				Order_MasterService omSvc = new Order_MasterService();
				omVO = omSvc.update(omVO);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("omVO", omVO);
				String url = "/backstage/Order_Master/getAllOrder_Master.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/backstage/Order_Master/update_Order_Master.jsp");
				failureView.forward(req, res);
			}
		}

		if ("inserWithOrder_Ditel".equals(action)) { // 來自add.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				java.sql.Timestamp order_master_Date = java.sql.Timestamp
						.valueOf(req.getParameter("order_Master_Date").trim());

				String order_master_ID = req.getParameter("order_Master_ID").trim();

				String member_ID = req.getParameter("member_ID").trim();

				String coupon_ID = req.getParameter("coupon_ID").trim();

				String order_Master_Payment = req.getParameter("order_Master_Payment").trim();

				Integer order_Master_State = new Integer(req.getParameter("order_Master_State").trim());

				if (order_Master_State == 1) {
					Order_MasterService omSvc = new Order_MasterService();
					List<Order_MasterVO> list = omSvc.getAll().stream()
							.filter(e -> e.getOrder_Master_ID().equals(order_master_ID))
							.filter(e -> e.getOrder_Master_State() != 1).collect(Collectors.toList());

					if (list.size() == 1) {
						errorMsgs.put("order_Master_State", "訂單已經取消就無法再修改囉!");
					}

				} else {
					Order_MasterService omSvc = new Order_MasterService();
					List<Order_MasterVO> list = omSvc.getAll().stream()
							.filter(e -> e.getOrder_Master_ID().equals(order_master_ID))
							.filter(e -> e.getOrder_Master_State() != 0).collect(Collectors.toList());

					if (list.size() != 1) {
						errorMsgs.put("order_Master_State", "訂單已經是取消狀態囉!");
					}

				}

				Order_MasterVO omVO = new Order_MasterVO();

				omVO.setOrder_Master_ID(order_master_ID);
				omVO.setOrder_Master_TimeStamp(order_master_Date);
				omVO.setMember_ID(member_ID);
				omVO.setCoupon_ID(coupon_ID);
				omVO.setOrder_Master_Payment(order_Master_Payment);
				omVO.setOrder_Master_State(order_Master_State);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("omVO", omVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backstage/Order_Master/update_Order_Master.jsp");
					failureView.forward(req, res);
					return;

				}

				/*************************** 2.開始修改資料 ***************************************/
				Order_MasterService omSvc = new Order_MasterService();
				omVO = omSvc.update(omVO);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("omVO", omVO);
				String url = "/backstage/Order_Master/getAllOrder_Master.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/backstage/Order_Master/update_Order_Master.jsp");
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
				String order_Master_ID = req.getParameter("order_Master_ID").trim();
				String order_Master_IDReg = "^[O][M][I][D][0-9]{6}$";
				if (order_Master_ID == null || order_Master_ID.trim().length() == 0) {
					errorMsgs.put("order_Master_ID", "訂單編號請勿空白");
				} else if (!order_Master_ID.trim().matches(order_Master_IDReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("order_Master_ID", "格式錯誤，訂單號碼只能是OMID開頭加上六個數字");
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/Order_Master/getAllOrder_Master.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
			
				req.setAttribute("order_Master_ID", order_Master_ID);
				/*************************** 2.開始查詢資料 *****************************************/
				Order_MasterService omSvc = new Order_MasterService();
				Order_MasterVO omVO = omSvc.getOne(order_Master_ID);
				if (order_Master_ID == null) {
					errorMsgs.put("order_Master_ID", "查無此訂單");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/Order_Master/getAllOrder_Master.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("omVO", omVO); // 資料庫取出的empVO物件,存入req
				String url = "/backstage/Order_Master/getoneOrder_Master.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/Order_Master/getAllOrder_Master.jsp");
				failureView.forward(req, res);
			}
		}

	}
}
