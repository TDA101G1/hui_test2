package com.member.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.model.MemberService;
import com.member.model.MemberVO;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/member/login.controller")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	{
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String action = request.getParameter("action");
		System.out.println(action);
		if ("SignIn".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsg", errorMsgs);
			String account = request.getParameter("account");
			String password = request.getParameter("password");
			request.setAttribute("account", account);
			try {

				if (account == null || account.trim().length() == 0) {
					errorMsgs.put("account", "Please input your account");
				}
				if (password == null || password.trim().length() == 0) {
					errorMsgs.put("password", "Please input your password");
				}
				if (!errorMsgs.isEmpty()) {
					request.getRequestDispatcher("/frontstage_member/login2.jsp").forward(request, response);
					return;
				}
				System.out.println("==========錯誤處理==========");
//====================================呼叫ＭＯＤＥＬ======================================
				MemberService service = new MemberService();

				MemberVO member = service.login(account, password);
				System.out.println(member);
				if (member == null) {
					System.out.println("not find");
					errorMsgs.put("login", "查無資料");
				}
				System.out.println(errorMsgs);
				if (!errorMsgs.isEmpty()) {
					request.getRequestDispatcher("/frontstage_member/login2.jsp").forward(request, response);
					return;
				}

//=====================================查詢完成，準備轉交==================================
				HttpSession session = request.getSession();
				session.setAttribute("member", member);
//				request.getRequestDispatcher("/MemberUpdate.jsp").forward(request, response);
				String location = (String) session.getAttribute("location");
				if(location != null) {
					System.out.println("有Location");
					System.out.println("login:" + location);
					response.sendRedirect(location);
				}else {
					System.out.println("no location");
					response.sendRedirect(request.getContextPath() + "/frontstage_member/MemberUpdate.jsp");
					return;
				}

//=====================================其他錯誤=========================================

			} catch (Exception e) {
				errorMsgs.put("other", "cant get message" + e.getMessage());
				try {
					request.getRequestDispatcher("/login2.jsp").forward(request, response);
				} catch (ServletException | IOException e1) {
					e1.printStackTrace();
				}
			}
		}

		if("SignUp".equals(action)) {
			try {
				request.getRequestDispatcher("/frontstage_member/SignUp.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}

		}
		
		if("LogOut".equals(action)) {
			HttpSession session = request.getSession();
			session.removeAttribute("member");
			session.invalidate();
			try {
				request.getRequestDispatcher("/index.jsp").forward(request, response);
				return;
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
