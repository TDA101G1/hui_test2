package com.credit_card_controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credit_card.model.Credit_CardService;
import com.credit_card.model.Credit_CardVO;
import com.member.model.MemberVO;


@WebServlet("/credit_card/Credit_Card.Controller")
public class CreditCardController extends HttpServlet {
	private static final long serialVersionUID = 1L;



	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		if("insertCreditCard".equals(action)) {

			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsg", errorMsgs);
			
			try {
				
				HttpSession session = request.getSession();
				MemberVO member = (MemberVO) session.getAttribute("member");
				String member_ID = member.getMember_ID();
				String credit_Card_Owner_Name = request.getParameter("ownername").trim();
				String credit_Card_Number = null;
				String credit_Card_Number_tmp = request.getParameter("cardnumber").trim();
				String credit_Card_expireDate = request.getParameter("expiredate").trim();
				String credit_Card_Postal_Code = request.getParameter("zip").trim();
				String credit_Card_Address = request.getParameter("address").trim();
				Integer credit_Card_State = Integer.parseInt(request.getParameter("state"));
				String credit_Card_Expire_M = null;
				String credit_Card_Expire_Y = null;
				
				if(credit_Card_Owner_Name == null || credit_Card_Owner_Name.length() == 0) {
					errorMsgs.put("name_empty", "名字不可為空白");
				}
				if(credit_Card_Number_tmp == null || credit_Card_Number_tmp.length() == 0) {
					errorMsgs.put("number_empty", "卡號不可為空白");
				}else {
					StringBuilder sb = new StringBuilder();
					for(int i = 0 ; i < credit_Card_Number_tmp.split(" ").length; i++) {
						sb.append(credit_Card_Number_tmp.split(" ")[i]);
					}
					credit_Card_Number = sb.toString();
				}
				if(credit_Card_expireDate == null || credit_Card_expireDate.length() == 0) {
					errorMsgs.put("date_empty", "日期不可為空白");
				}else {
					credit_Card_Expire_M = credit_Card_expireDate.split("/")[0];
					credit_Card_Expire_Y = credit_Card_expireDate.split("/")[1];
					
				}
				if(credit_Card_Postal_Code == null || credit_Card_Postal_Code.length() == 0) {
					errorMsgs.put("zip_empty", "郵遞區號不可為空白");
				}
				if(credit_Card_Address == null || credit_Card_Address.length() == 0) {
					errorMsgs.put("address_empty", "地址不可為空白");
				}
				
				Credit_CardVO card = new Credit_CardVO();
				card.setCredit_Card_Expire_Y(credit_Card_Expire_Y);
				card.setCredit_Card_Address(credit_Card_Address);
				card.setCredit_Card_Expire_M(credit_Card_Expire_M);
				card.setCredit_Card_Number(credit_Card_Number);
				card.setCredit_Card_Owner_Name(credit_Card_Owner_Name);
				card.setCredit_Card_Postal_Code(credit_Card_Postal_Code);
				card.setCredit_Card_State(credit_Card_State);
				card.setMember_ID(member_ID);
				
				if(!errorMsgs.isEmpty()) {
					request.setAttribute("card", card);
					RequestDispatcher failureView = request.getRequestDispatcher("/frontstage_member/member_Credit_Card/Member_Credit_Card.jsp");
					failureView.forward(request, response);
					return;
				}
				
				Credit_CardService service = new Credit_CardService();
				Credit_CardVO insertCard = service.addCredit_Card(credit_Card_Number, member_ID, credit_Card_Owner_Name, credit_Card_Expire_M, credit_Card_Expire_Y, credit_Card_Address, credit_Card_Postal_Code, credit_Card_State);
				System.out.println("insert:" + insertCard);
				
				response.sendRedirect(request.getContextPath() + "/frontstage_member/MemberUpdate.jsp");
				
			}catch (Exception e) {
				errorMsgs.put("other", "cant get message" + e.getMessage());
				try {
					request.getRequestDispatcher("/frontstage_member/member_Credit_Card/Member_Credit_Card.jsp").forward(request, response);
				} catch (ServletException | IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
