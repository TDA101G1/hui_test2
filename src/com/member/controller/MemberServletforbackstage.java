package com.member.controller;



import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/backstage/member/member.do")
public class MemberServletforbackstage extends HttpServlet {


	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
		
		System.out.println(action);

	

		if ("getOne".equals(action)) { // 來自select_page.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String mem_ID = req.getParameter("mem_ID").trim();
				String mem_IDReg = "^[M][I][D][0-9]{6}$";
				if (mem_ID == null || mem_ID.trim().length() == 0) {
					errorMsgs.put("mem_ID", "會員編號請勿空白");
				} else if (!mem_ID.trim().matches(mem_IDReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("mem_ID", "格式錯誤，會員編號只能是MID開頭加上六個數字");
				}
				
				req.setAttribute("mem_ID", mem_ID);
				
			

				/*************************** 2.開始查詢資料 *****************************************/
				MemberService mSvc = new MemberService();
				MemberVO memVO = mSvc.getOne(mem_ID);
				if (memVO == null) {
					errorMsgs.put("mem_ID", "查無此會員");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backstage/member/getAllMember.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("memVO", memVO); // 資料庫取出的empVO物件,存入req
				String url = "/backstage/member/getOneMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backstage/member/getAllMember.jsp");
				failureView.forward(req, res);
			}
		}




	}

}
