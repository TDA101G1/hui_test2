package com.member.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.inbox.model.InboxService;
import com.inbox.model.InboxVO;
import com.member.model.MemberService;
import com.member.model.MemberVO;


@WebServlet("/member/SignUp.Controller")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class SignUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		if ("SignUp".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsg", errorMsgs);
			
			
			try {
//接收參數
				java.util.Date today = new java.util.Date();
				java.sql.Date member_Est_Time = new java.sql.Date(today.getTime());
				Integer member_State = new Integer(1);
				String member_Name = request.getParameter("name").trim();
				String member_Account = request.getParameter("account").trim();
				String member_Pwd = request.getParameter("password").trim();
				String member_Sex = request.getParameter("sex").trim();
				String member_Phone = request.getParameter("phone").trim();
				String member_Mail = request.getParameter("email").trim();
				String member_AddressMain = request.getParameter("address_main").trim();
				String member_AddressDetail = request.getParameter("address_detail").trim();
				String member_Address = null;
				String member_Birth_Stirng = request.getParameter("birthday").trim();
				java.sql.Date member_Birth = null;
				
				Part part = request.getPart("img");
				InputStream in = part.getInputStream();
				byte[]member_Img = new byte[in.available()];
				in.read(member_Img);
				in.close();
//Name
				String member_NameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				String member_AccountReg = "^[(a-zA-Z0-9)]{2,10}$";
				String member_PwdReg = "^[(a-zA-Z0-9)]{2,10}$";
				String member_MailReg = "[a-zA-Z0-9_]{4,12}@[a-zA-Z0-9]+(\\.[a-zA-Z]+){1,3}";
				String member_PhoneReg = "^[0][9]\\d{8}$";
				if(member_Name == null || member_Name.trim().length() == 0) {
					errorMsgs.put("name_empty", "Please input your Name");
				}
				else if(!member_Name.trim().matches(member_NameReg)) {
					errorMsgs.put("name_Reg", "姓名格式錯誤");
				}
				
//Account		
				if(member_Account == null || member_Account.trim().length() == 0) {
					errorMsgs.put("account_empty", "Please input your account");
				}else if (!member_Account.trim().matches(member_AccountReg)) {
					errorMsgs.put("account_empty", "只能是英文字母和數字 , 且長度必需在2到10之間");
				}
//Password
				if(member_Pwd == null || member_Pwd.trim().length() == 0) {
					errorMsgs.put("password_empty", "Please input your password");
				}else if(!member_Pwd.trim().matches(member_PwdReg)) {
					errorMsgs.put("password_empty", "只能是英文字母和數字 , 且長度必需在2到10之間d");
				}
//Phone			
				if(member_Phone == null || member_Phone.trim().length() == 0) {
					errorMsgs.put("phone_empty", "Please input your phone");
				}else if(!member_Phone.trim().matches(member_PhoneReg)) {
					errorMsgs.put("phone_empty", "電話必須是09開頭的十碼數字");
				}
//mail
				if(member_Mail == null || member_Mail.trim().length() == 0) {
					errorMsgs.put("mail_empty", "Please input your Email");
				}else if(!member_Mail.trim().matches(member_MailReg)) {
					errorMsgs.put("mail_empty", "格式錯誤");
				}
//address
				if(member_AddressDetail == null || member_AddressDetail.trim().length() == 0) {
					errorMsgs.put("addressDetail_empty", "Please input your Address");
				}else {
					member_Address =new String( member_AddressMain + member_AddressDetail);
				}
//sex
				if(member_Sex == null || member_Sex.trim().length() == 0) {
					errorMsgs.put("sex_empty", "Please choose your sex");
				}
//Birthday
				if(member_Birth_Stirng == null || member_Birth_Stirng.trim().length() == 0) {
					errorMsgs.put("birthday_empty", "Please input your birthday");
				}else {
					DateFormat format = new SimpleDateFormat("yyyy/MM/dd");
					java.util.Date utilDate = new java.util.Date();
					utilDate = format.parse(member_Birth_Stirng);
					member_Birth = new java.sql.Date(utilDate.getTime());
					
				}
				System.out.println(member_Address + member_Birth);
				
			
				MemberVO member = new MemberVO();
				
				member.setMember_Account(member_Account);
				member.setMember_Address(member_Address);
				member.setMember_Birth(member_Birth);
				member.setMember_Mail(member_Mail);
				member.setMember_Name(member_Name);
				member.setMember_Sex(member_Sex);
				member.setMember_Phone(member_Phone);
				
				if(!errorMsgs.isEmpty()) {
					request.setAttribute("member", member);
					RequestDispatcher failureView = request.getRequestDispatcher("/frontstage_member/SignUp.jsp");
					failureView.forward(request, response);
					return;
				}
				
				
				MemberService service = new MemberService();
				MemberVO memberInsert = service.insert(member_Account, member_Pwd, member_Name, member_Phone, member_Sex, 
						member_Birth, member_Mail, member_Address, member_Img, member_Est_Time, member_State);
				System.out.println(member_Account+ member_Pwd+member_Name+ member_Phone+ member_Sex+ 
						member_Birth+ member_Mail+ member_Address+ null+ member_Est_Time+ member_State);
				System.out.println(memberInsert);
				
				if(memberInsert != null) {
					InboxService inboxService = new InboxService();
//					InboxVO newMail = new InboxVO();
//					newMail.setEmp_ID("EID000000");
//					newMail.setMember_ID(memberInsert.getMember_ID());
//					newMail.setInbox_Mail_Info("內文");
//					newMail.setInbox_Mail_Title("標題");
//					newMail.setInbox_Mail_State("1");
					inboxService.writeMail(memberInsert.getMember_ID(), "EID000000", "感謝您註冊本網站，請記住您的密碼，切勿給予他人", "完成註冊", "4");
					inboxService.writeMail(memberInsert.getMember_ID(), "EID000000", "TOURISM於五月上架多個新產品，歡迎前往商城看看", "新商品上架囉", "4");
					inboxService.writeMail(memberInsert.getMember_ID(), "EID000000", "TOURISM於四月上架多個新產品，歡迎前往商城看看", "新商品上架囉", "4");
					inboxService.writeMail(memberInsert.getMember_ID(), "EID000000", "歡迎寄信給客服人員並索取優惠券，客服人員會很高興為您服務", "優惠券索取辦法", "4");
					inboxService.writeMail(memberInsert.getMember_ID(), "EID000000", "TOURISM五月將有多個優惠活動，請寄信給客服人員才能拿到專屬優惠券喔", "專屬優惠券", "4");
					inboxService.writeMail(memberInsert.getMember_ID(), "EID000000", "此為系統發送測試信件，請勿回覆", "信註冊會員測試信件", "4");
					
				}
//				RequestDispatcher successView = request.getRequestDispatcher("/listAllMember.jsp");
//				successView.forward(request, response);
				response.sendRedirect(request.getContextPath() + "/frontstage_member/login2.jsp");
			
			
			}catch (Exception e) {
				errorMsgs.put("other", "cant get message" + e.getMessage());
				request.getRequestDispatcher("/frontstage_member/SignUp.jsp").forward(request, response);
				return;
			}
			
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
