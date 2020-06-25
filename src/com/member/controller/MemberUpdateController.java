package com.member.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
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
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/MemberUpdate.Controller")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MemberUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


	protected void doGet(HttpServletRequest request, HttpServletResponse response)  {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String action = request.getParameter("action");
		
		if ("Update".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsg", errorMsgs);
			

//			System.out.println(member_Est_Time);
//			System.out.println(member_ID);
//			System.out.println(member_Name);
//			System.out.println(member_Account);
//			System.out.println(member_Pwd);
//			System.out.println(member_Sex);
//			System.out.println(member_Mail);
//			System.out.println(member_AddressMain);
//			System.out.println(member_AddressDetail);
//			System.out.println(member_BirthString_Stirng);
//			System.out.println(member_Img);
			try {
//接收參數
				java.util.Date today = new java.util.Date();
				java.sql.Date member_Est_Time = new java.sql.Date(today.getTime());
				Integer member_State = new Integer(1);
				String member_ID = request.getParameter("id").trim();
				String member_Name = request.getParameter("name").trim();
				String member_Account = request.getParameter("account").trim();
				String member_Pwd = request.getParameter("password").trim();
				String member_Sex = request.getParameter("sex").trim();
				String member_Phone = request.getParameter("phone").trim();
				String member_Mail = request.getParameter("email").trim();
				String member_AddressMain = request.getParameter("address_main").trim();
				String member_AddressDetail = request.getParameter("address_detail").trim();
				String member_Address = null;
				String member_Birth_String = request.getParameter("birthday").trim();
				java.sql.Date member_Birth = null;
				
				byte[] member_Img = null;
				
				try {
					Part part = request.getPart("img");
					System.out.println("part SIZE:" + part.getSize());
						if(part.getSize() == 0) {
							MemberService service = new MemberService();
							MemberVO member = service.getOne(member_ID);
							member_Img = member.getMember_Img();
						}else {
							InputStream in = part.getInputStream();
							member_Img = new byte[in.available()];
							in.read(member_Img);
							in.close();	
						}
						
				} catch (IOException e) {
					e.printStackTrace();
				}
//Name
				String member_NameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if(member_Name == null || member_Name.trim().length() == 0) {
					errorMsgs.put("name_empty", "Please input your Name");
				}
				else if(!member_Name.matches(member_NameReg)) {
					errorMsgs.put("name_Reg", "姓名格式錯誤");
				}
				
//Account		
				
				if(member_Account == null || member_Account.trim().length() == 0) {
					errorMsgs.put("account_empty", "Please input your account");
				}
//Password
				if(member_Pwd == null || member_Pwd.trim().length() == 0) {
					errorMsgs.put("password_empty", "Please input your password");
				}
//Phone			
				if(member_Phone == null || member_Phone.trim().length() == 0) {
					errorMsgs.put("phone_empty", "Please input your phone");
				}
//mail
				if(member_Mail == null || member_Mail.trim().length() == 0) {
					errorMsgs.put("mail_empty", "Please input your Email");
				}
//address
				if(member_AddressDetail == null || member_AddressDetail.trim().length() == 0) {
					errorMsgs.put("addressDetail_empty", "Please input your Address");
				}else {
					member_Address = member_AddressMain + member_AddressDetail;
				}
//sex
				if(member_Sex == null || member_Sex.trim().length() == 0) {
					errorMsgs.put("sex_empty", "Please choose your sex");
				}
//Birthday
				if(member_Birth_String == null || member_Birth_String.trim().length() == 0) {
					errorMsgs.put("birthday_empty", "Please input your birthday");
				}else {
					DateFormat format = new SimpleDateFormat("yyyy/MM/dd");
					java.util.Date utilDate = new java.util.Date();
					utilDate = format.parse(member_Birth_String);
					member_Birth = new java.sql.Date(utilDate.getTime());
					
				}
//				System.out.println(member_Address + member_Birth);
				
			
				MemberVO member = new MemberVO();
				member.setMember_ID(member_ID);
				member.setMember_Name(member_Name);
				member.setMember_Account(member_Account);
				member.setMember_Pwd(member_Pwd);
				member.setMember_Phone(member_Phone);
				member.setMember_Mail(member_Mail);
				member.setMember_Address(member_Address);
				member.setMember_Sex(member_Sex);
				member.setMember_Birth(member_Birth);
				
				if(!errorMsgs.isEmpty()) {
					request.setAttribute("member", member);
					RequestDispatcher failureView = request.getRequestDispatcher("/frontstage_member/MemberUpdate.jsp");
					failureView.forward(request, response);
					return;
				}
				
				
				MemberService service = new MemberService();
				MemberVO memberUpdate = service.update(member_ID, member_Account, member_Pwd, member_Name, member_Phone, member_Sex, member_Birth, member_Mail, member_Address, member_Img, member_Est_Time, member_State);
				System.out.println(memberUpdate);
				HttpSession session = request.getSession();
				session.setAttribute("member", memberUpdate);
//				RequestDispatcher successView = request.getRequestDispatcher("/listAllMember.jsp");
//				successView.forward(request, response);
				response.sendRedirect(request.getContextPath() + "/index.jsp");
			
			
			}catch (Exception e) {
				errorMsgs.put("other", "cant get message" + e.getMessage());
				try {
					request.getRequestDispatcher("/frontstage_member/MemberUpdate.jsp").forward(request, response);
				} catch (ServletException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (IOException e1) {
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
