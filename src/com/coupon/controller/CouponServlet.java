package com.coupon.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.coupon.model.CouponService;
import com.coupon.model.CouponVO;
import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;

@WebServlet("/backstage/coupon/coupon.do")
public class CouponServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
		
		if ("insert".equals(action)) {
			
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {

				
				String cp_Name = req.getParameter("cp_Name").trim();
				String cp_NameReg = "^[(\u4e00-\u9fa5)a-zA-Z0-9)]{2,10}$";

				if (cp_Name == null || cp_Name.length() == 0) {
					errorMsgs.put("cp_Name", "請設立折價券的名稱");
				} else if (!cp_Name.matches(cp_NameReg)) {
					errorMsgs.put("cp_Name", "折價券名稱必須是中英文或是數字，介於2-10個字");
				}
				
				String cp_MID = req.getParameter("cp_MID").trim();
				
				String cp_EID = req.getParameter("cp_EID").trim();
					
				
				
				Double cp_Class = null;
				try {
					cp_Class = new Double(req.getParameter("cp_Class").trim());
				}catch (NumberFormatException e) {
					e.printStackTrace();
					cp_Class = 0.0;
					errorMsgs.put("cp_Class","折扣等級請輸入小數點數字");
				}
				
				String cp_Number = req.getParameter("cp_Number");
				String cp_NumberReg = "^[a-zA-Z0-9]{10}$";
				if(cp_Number == null ||cp_Number.trim().length() == 0) {
					errorMsgs.put("cp_Number","請按下代碼按鈕");
				}else if(!cp_Number.trim().matches(cp_NumberReg)) {
					errorMsgs.put("cp_Number","代碼只能為英文數字，長度為10");
					
				}
				
					
				String cp_Info =req.getParameter("cp_Info").trim();
				if(cp_Info == null || cp_Info.length() == 0) {
					errorMsgs.put("cp_Info", "請輸入商品使用說明");
				}
				
				Integer cp_State = new Integer(req.getParameter("cp_State").trim());
				

				
				CouponVO cpVO = new CouponVO();
				
				cpVO.setCoupon_Name(cp_Name);
				cpVO.setCoupon_Class(cp_Class);
				cpVO.setMember_ID(cp_MID);
				cpVO.setEmp_ID(cp_EID);
				cpVO.setCoupon_Number(cp_Number);
				cpVO.setCoupon_State(cp_State);
				cpVO.setCoupon_Info(cp_Info);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("cpVO", cpVO); 
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/coupon/addCoupon.jsp");
					failureView.forward(req, res);

					return;
				}
				
				//開始新增
				
				CouponService cpSvc = new CouponService();
				cpVO = cpSvc.insert(cpVO);
				//轉交
				String url="/backstage/coupon/getAllCoupon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req,res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/coupon/addCoupon.jsp");
				failureView.forward(req, res);
			}

		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();

			req.setAttribute("errorMsgs", errorMsgs);

			
			try {
				/***************************1.接收請求參數****************************************/
				String cp_ID = new String(req.getParameter("cp_ID"));
				
				/***************************2.開始查詢資料****************************************/
				
				CouponService cpSvc = new CouponService();
				CouponVO cpVO = cpSvc.getOne(cp_ID);
				//轉交
			
							
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("cpVO", cpVO);         
				String url = "/backstage/coupon/update_coupon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			}catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/coupon/getAllCoupon.jsp");
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
				String cp_ID = req.getParameter("cp_ID").trim();
				String cp_IDReg = "^[C][N][I][D][0-9]{6}$";
				if (cp_ID == null || cp_ID.trim().length() == 0) {
					errorMsgs.put("cp_ID", "優惠券編號請勿空白");
				} else if (!cp_ID.trim().matches(cp_IDReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("cp_ID", "格式錯誤，員編號碼只能是CNID開頭加上六個數字");
				}
				
				
				
				

			

				/*************************** 2.開始查詢資料 *****************************************/
				CouponService cpSvc = new CouponService();
				CouponVO cpVO = cpSvc.getOne(cp_ID);
				if (cpVO == null) {
					errorMsgs.put("cp_ID", "查無此優惠券");
				}
				
				
				req.setAttribute("cp_ID", cp_ID);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/coupon/getAllCoupon.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
		

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("cpVO", cpVO); // 資料庫取出的empVO物件,存入req
				String url = "/backstage/coupon/getOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/coupon/getAllCoupon.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自add.jsp的請求
			
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				String cp_ID = new String(req.getParameter("cp_ID").trim());

				String cp_Name = req.getParameter("cp_Name").trim();
				String cp_NameReg = "^[(\u4e00-\u9fa5)a-zA-Z0-9)]{2,10}$";

				if (cp_Name == null || cp_Name.length() == 0) {
					errorMsgs.put("cp_Name", "請設立折價券的名稱");
				} else if (!cp_Name.matches(cp_NameReg)) {
					errorMsgs.put("cp_Name", "折價券名稱必須是中英文或是數字，介於2-10個字");
				}
				
				String cp_MID = req.getParameter("cp_MID").trim();
				
				String cp_EID = req.getParameter("cp_EID").trim();
					
				java.sql.Timestamp cp_Date = java.sql.Timestamp.valueOf(req.getParameter("cp_Date").trim());
				
				Double cp_Class = null;
				try {
					cp_Class = new Double(req.getParameter("cp_Class").trim());
				}catch (NumberFormatException e) {
					e.printStackTrace();
					cp_Class = 0.0;
					errorMsgs.put("cp_Class","折扣等級請輸入小數點數字");
				}
				
				String cp_Number = req.getParameter("cp_Number");
				String cp_NumberReg = "^[a-zA-Z0-9]{10}$";
				if(cp_Number == null ||cp_Number.trim().length() == 0) {
					errorMsgs.put("cp_Number","請按下代碼按鈕");
				}else if(!cp_Number.trim().matches(cp_NumberReg)) {
					errorMsgs.put("cp_Number","代碼只能為英文數字，長度為10");
					
				}
				
					
				String cp_Info =req.getParameter("cp_Info").trim();
				if(cp_Info == null || cp_Info.length() == 0) {
					errorMsgs.put("cp_Info", "請輸入商品使用說明");
				}
				
				Integer cp_State = new Integer(req.getParameter("cp_State").trim());
				
				
				
				
				
				
				CouponVO cpVO = new CouponVO();
				
				cpVO.setCoupon_ID(cp_ID);
				cpVO.setCoupon_Name(cp_Name);
				cpVO.setCoupon_Class(cp_Class);
				cpVO.setMember_ID(cp_MID);
				cpVO.setEmp_ID(cp_EID);
				cpVO.setCoupon_Number(cp_Number);
				cpVO.setCoupon_State(cp_State);
				cpVO.setCoupon_Info(cp_Info);
				cpVO.setCoupon_Date(cp_Date);
				
				System.out.println(cpVO);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("cpVO", cpVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/coupon/update_coupon.jsp");
					failureView.forward(req, res);
					return;

				}

				/*************************** 2.開始修改資料 ***************************************/
				CouponService cpSvc = new CouponService();
				cpVO = cpSvc.update(cp_ID, cp_EID, cp_MID, cp_Name, cp_Class, cp_Number, cp_Info, cp_State,cp_Date );
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				System.out.println(cpVO);
				req.setAttribute("cpVO", cpVO);
				String url = "/backstage/coupon/getOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/coupon/update_coupon.jsp");
				
				failureView.forward(req, res);
			}
		}

		
		
		


	}
}
