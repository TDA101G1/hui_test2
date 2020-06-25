package com.employee.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
import javax.servlet.http.Part;

import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;

import com.employee.model.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
@WebServlet("/backstage/employee/employee.do")
public class EmployeeServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");

		if ("insert".equals(action)) { // 來自add.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
		
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				String emp_Account = req.getParameter("emp_Account").trim();
				String emp_AccountReg = "^[(a-zA-Z0-9)]{2,10}$";
				if (emp_Account == null || emp_Account.trim().length() == 0) {
					errorMsgs.put("emp_Account", "帳號請勿空白");
				} else if (!emp_Account.trim().matches(emp_AccountReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Account", "員工帳號: 只能是英文字母和數字 , 且長度必需在2到10之間");
				} else if (emp_Account.trim().matches(emp_AccountReg)) {
					EmployeeService empSvc = new EmployeeService();
					List<EmployeeVO> list = empSvc.getAll().stream().filter(e -> e.getEmp_Account().equals(emp_Account))
							.collect(Collectors.toList());
					if (list.size() != 0) {
						errorMsgs.put("emp_Account", "帳號已經被人註冊過囉!");

					}

				}

				String emp_Pwd = req.getParameter("emp_Pwd").trim();
				String emp_PwdReg = "^[(a-zA-Z0-9)]{2,10}$";
				if (emp_Pwd == null || emp_Pwd.trim().length() == 0) {
					errorMsgs.put("emp_Pwd", "密碼請勿空白");
				} else if (!emp_Pwd.trim().matches(emp_PwdReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Pwd", "員工密碼: 只能是英文字母和數字 , 且長度必需在2到10之間");
				} else if (emp_Pwd.trim().matches(emp_PwdReg)) {
					EmployeeService empSvc = new EmployeeService();
					List<EmployeeVO> list = empSvc.getAll().stream().filter(e -> e.getEmp_Pwd().equals(emp_Pwd))
							.collect(Collectors.toList());
					if (list.size() != 0) {
						errorMsgs.put("emp_Pwd", "密碼已經被人註冊過囉!");
					}
				}

				String emp_Name = req.getParameter("emp_Name").trim();
				String emp_NameReg = "^[(\u4e00-\u9fa5)a-zA-Z]{2,10}$";
				if (emp_Name == null || emp_Name.trim().length() == 0) {
					errorMsgs.put("emp_Name", "姓名請勿空白");
				} else if (!emp_Name.trim().matches(emp_NameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Name", "員工姓名只能是英文字母或中文");
				}

				String emp_Sex = null;
				emp_Sex = req.getParameter("emp_Sex").trim();
				if (emp_Sex == null) {
					errorMsgs.put("emp_Sex", "請填入性別");
				}

				String emp_Address = req.getParameter("emp_Address").trim();
				String emp_AddressReg = "^[(\u4e00-\u9fa5)0-9]+$";
				if (emp_Address == null || emp_Address.trim().length() == 0 || emp_Address.length() <= 6) {
					errorMsgs.put("emp_Address", "請填入完整地址");
				} else if (!emp_Address.trim().matches(emp_AddressReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Address", "地址只能是中文或數字");
				} else if (emp_Address.trim().equals("縣市")) {
					errorMsgs.put("emp_Address", "請選擇地區");
				}

				String emp_Grade = null;
				emp_Grade = req.getParameter("emp_Grade").trim();
				if (emp_Grade == null || emp_Grade.trim().length() == 0) {
					errorMsgs.put("emp_Grade", "請填入權限");
				}

				java.sql.Date emp_Birth = null;
				try {
					emp_Birth = java.sql.Date.valueOf(req.getParameter("emp_Birth").trim());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					emp_Birth = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("emp_Birth", "請輸入日期!");
				}

				java.sql.Date emp_Est_Time = null;
				try {
					emp_Est_Time = java.sql.Date.valueOf(req.getParameter("emp_Est_Time").trim());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					emp_Est_Time = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("emp_Est_Time", "請輸入日期!");
				}

				String emp_Mail = req.getParameter("emp_Mail").trim();
				String emp_MailReg = "[a-zA-Z0-9_]{4,12}@[a-zA-Z0-9]+(\\.[a-zA-Z]+){1,3}";
				if (emp_Mail == null || emp_Mail.trim().length() == 0) {
					errorMsgs.put("emp_Mail", "信箱請勿空白");
				} else if (!emp_Mail.trim().matches(emp_MailReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Mail", "信箱格式不正確");
				}

				String emp_Phone = req.getParameter("emp_Phone").trim();
				String emp_PhoneReg = "^[0][9]\\d{8}$";
				if (emp_Phone == null || emp_Phone.trim().length() == 0) {
					errorMsgs.put("emp_Phone", "電話請勿空白");
				} else if (!emp_Phone.trim().matches(emp_PhoneReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Phone", "電話必須是09開頭的十碼數字");
				}

				Integer emp_State = null;
				try {
					emp_State = new Integer(req.getParameter("emp_State").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					emp_State = null;
					errorMsgs.put("emp_State", "狀態請勿空白");
				}

				byte[] emp_img = null;
				Part part = req.getPart("emp_img");
				if (part == null || part.getSize() == 0) {
					errorMsgs.put("emp_img", "請上傳照片");
				} else {
					InputStream in = part.getInputStream();
					emp_img = new byte[in.available()];
					in.read(emp_img);
					in.close();
				}

				EmployeeVO empVO = new EmployeeVO();

				empVO.setEmp_Account(emp_Account);
				empVO.setEmp_Pwd(emp_Pwd);
				empVO.setEmp_Grade(emp_Grade);
				empVO.setEmp_Name(emp_Name);
				empVO.setEmp_Sex(emp_Sex);
				empVO.setEmp_Birth(emp_Birth);
				empVO.setEmp_Mail(emp_Mail);
				empVO.setEmp_Phone(emp_Phone);
				empVO.setEmp_Address(emp_Address);
				empVO.setEmp_Est_Time(emp_Est_Time);
				empVO.setEmp_State(emp_State);
				empVO.setEmp_Img(emp_img);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/employee/add.jsp");
					failureView.forward(req, res);
					return;

				}

				/*************************** 2.開始新增資料 ***************************************/
				EmployeeService empSvc = new EmployeeService();
				empVO = empSvc.insert(empVO);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/backstage/employee/getAllEMP.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/employee/add.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自add.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				String emp_ID = new String(req.getParameter("emp_ID").trim());
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				String emp_Account = req.getParameter("emp_Account").trim();
				String emp_AccountReg = "^[(a-zA-Z0-9)]{2,10}$";
				if (emp_Account == null || emp_Account.trim().length() == 0) {
					errorMsgs.put("emp_Account", "帳號請勿空白");
				} else if (!emp_Account.trim().matches(emp_AccountReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Account", "員工帳號: 只能是英文字母和數字 , 且長度必需在2到10之間");
				}

				String emp_Pwd = req.getParameter("emp_Pwd").trim();
				String emp_PwdReg = "^[(a-zA-Z0-9)]{2,10}$";
				if (emp_Pwd == null || emp_Pwd.trim().length() == 0) {
					errorMsgs.put("emp_Pwd", "密碼請勿空白");
				} else if (!emp_Pwd.trim().matches(emp_PwdReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Pwd", "員工密碼: 只能是英文字母和數字 , 且長度必需在2到10之間");
				}

				String emp_Name = req.getParameter("emp_Name").trim();
				String emp_NameReg = "^[(\u4e00-\u9fa5)a-zA-Z]{2,10}$";
				if (emp_Name == null || emp_Name.trim().length() == 0) {
					errorMsgs.put("emp_Name", "姓名請勿空白");
				} else if (!emp_Name.trim().matches(emp_NameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Name", "員工姓名: 只能是英文字母或中文");
				}

				String emp_Sex = null;
				emp_Sex = req.getParameter("emp_Sex").trim();
				if (emp_Sex == null) {
					errorMsgs.put("emp_Sex", "請填入性別");
				}

				String emp_Address = req.getParameter("emp_Address").trim();
				String emp_AddressReg = "^[(\u4e00-\u9fa5)0-9]+$";
				if (emp_Address == null || emp_Address.trim().length() == 0 || emp_Address.length() == 6) {
					errorMsgs.put("emp_Address", "請填入完整地址");
				} else if (!emp_Address.trim().matches(emp_AddressReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Address", "地址只能是中文或數字");
				} else if (emp_Address.trim().equals("縣市")) {
					errorMsgs.put("emp_Address", "請選擇地區");
				}

				String emp_Grade = null;
				emp_Grade = req.getParameter("emp_Grade").trim();
				if (emp_Grade == null || emp_Grade.trim().length() == 0) {
					errorMsgs.put("emp_Grade", "請填入權限");
				}

				java.sql.Date emp_Birth = null;
				try {
					emp_Birth = java.sql.Date.valueOf(req.getParameter("emp_Birth").trim());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					emp_Birth = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("emp_Birth", "請輸入日期!");
				}

				java.sql.Date emp_Est_Time = null;
				try {
					emp_Est_Time = java.sql.Date.valueOf(req.getParameter("emp_Est_Time").trim());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					emp_Est_Time = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("emp_Est_Time", "請輸入日期!");
				}

				String emp_Mail = req.getParameter("emp_Mail").trim();
				String emp_MailReg = "[a-zA-Z0-9_]{4,12}@[a-zA-Z0-9]+(\\.[a-zA-Z]+){1,3}";
				if (emp_Mail == null || emp_Mail.trim().length() == 0) {
					errorMsgs.put("emp_Mail", "信箱請勿空白");
				} else if (!emp_Mail.trim().matches(emp_MailReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Mail", "信箱格式不正確");
				}

				String emp_Phone = req.getParameter("emp_Phone").trim();
				String emp_PhoneReg = "^[0][9]\\d{8}$";
				if (emp_Phone == null || emp_Phone.trim().length() == 0) {
					errorMsgs.put("emp_Phone", "電話請勿空白");
				} else if (!emp_Phone.trim().matches(emp_PhoneReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Phone", "電話必須是09開頭的十碼數字");
				}

				Integer emp_State = null;
				try {
					emp_State = new Integer(req.getParameter("emp_State").trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					emp_State = null;
					errorMsgs.put("emp_State", "狀態請勿空白");
				}

				byte[] emp_img = null;
				Part part = req.getPart("emp_img");
				if (part == null || part.getSize() == 0) {
					EmployeeVO empVO = new EmployeeVO();
					EmployeeService empSvc = new EmployeeService();
					empVO = empSvc.getOne(emp_ID);
					emp_img = empVO.getEmp_Img();
				} else {
					InputStream in = part.getInputStream();
					emp_img = new byte[in.available()];
					in.read(emp_img);
					in.close();
				}

				EmployeeVO empVO = new EmployeeVO();
				empVO.setEmp_ID(emp_ID);
				empVO.setEmp_Account(emp_Account);
				empVO.setEmp_Pwd(emp_Pwd);
				empVO.setEmp_Grade(emp_Grade);
				empVO.setEmp_Name(emp_Name);
				empVO.setEmp_Sex(emp_Sex);
				empVO.setEmp_Birth(emp_Birth);
				empVO.setEmp_Mail(emp_Mail);
				empVO.setEmp_Phone(emp_Phone);
				empVO.setEmp_Address(emp_Address);
				empVO.setEmp_Est_Time(emp_Est_Time);
				empVO.setEmp_State(emp_State);
				empVO.setEmp_Img(emp_img);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/employee/getforupdate.jsp");
					failureView.forward(req, res);
					return;

				}

				/*************************** 2.開始修改資料 ***************************************/
				EmployeeService empSvc = new EmployeeService();
				empVO = empSvc.update(emp_ID, emp_Account, emp_Pwd, emp_Grade, emp_Name, emp_Sex, emp_Birth, emp_Mail,
						emp_Phone, emp_Address, emp_Est_Time, emp_img, emp_State);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("empVO", empVO);
				String url = "/backstage/employee/getone.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/employee/getforupdate.jsp");
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
				String emp_ID = req.getParameter("emp_ID").trim();
				String emp_IDReg = "^[E][I][D][0-9]{6}$";
				if (emp_ID == null || emp_ID.trim().length() == 0) {
					errorMsgs.put("emp_ID", "員工編號請勿空白");
				} else if (!emp_ID.trim().matches(emp_IDReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_ID", "格式錯誤，員編號碼只能是EID開頭加上六個數字");
				}
				
				req.setAttribute("emp_ID", emp_ID);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/employee/getAllEMP.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				EmployeeService empSvc = new EmployeeService();
				EmployeeVO empVO = empSvc.getOne(emp_ID);
				if (empVO == null) {
					errorMsgs.put("emp_ID", "查無此員工");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/employee/getAllEMP.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req
				String url = "/backstage/employee/getone.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/employee/getAllEMP.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOneforupdate".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/

				String emp_ID = new String(req.getParameter("emp_ID"));
				/*************************** 2.開始查詢資料 ****************************************/

				EmployeeService empSvc = new EmployeeService();
				EmployeeVO empVO = empSvc.getOne(emp_ID);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req
				String url = "/backstage/employee/getforupdate.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/employee/getAllEMP.jsp");
				failureView.forward(req, res);
			}
		}

		if ("login".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				String emp_Account = req.getParameter("emp_Account").trim();
				String emp_AccountReg = "^[(a-zA-Z0-9)]{2,10}$";
				if (emp_Account == null || emp_Account.trim().length() == 0) {
					errorMsgs.put("emp_Account", "帳號請勿空白");
				} else if (!emp_Account.trim().matches(emp_AccountReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Account", "員工帳號: 只能是英文字母和數字 , 且長度必需在2到10之間");
				}

				String emp_Pwd = req.getParameter("emp_Pwd").trim();
				String emp_PwdReg = "^[(a-zA-Z0-9)]{2,10}$";
				if (emp_Pwd == null || emp_Pwd.trim().length() == 0) {
					errorMsgs.put("emp_Pwd", "密碼請勿空白");
				} else if (!emp_Pwd.trim().matches(emp_PwdReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_Pwd", "密碼: 只能是英文字母和數字 , 且長度必需在2到10之間");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/login.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				EmployeeService empSvc = new EmployeeService();
				EmployeeVO empVO = empSvc.login(emp_Account, emp_Pwd);
				if (empVO == null) {
					errorMsgs.put("emp_Account", "請確認帳號，沒有此帳號");
				} else if (empVO != null && !(empVO.getEmp_Pwd().equals(emp_Pwd))) {
					errorMsgs.put("emp_Pwd", "請確認密碼，密碼錯誤");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/login.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("in_empVO", empVO); // 資料庫取出的empVO物件,存入req
				String url = "/backstage/Home.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/login.jsp");
				failureView.forward(req, res);
			}
		}

	}

}
