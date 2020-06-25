package com.inbox.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.inbox.model.InboxService;
import com.inbox.model.InboxVO;
import com.member.model.MemberVO;


@WebServlet("/inbox/WriteMail.Controller")
public class WriteMailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String action = request.getParameter("action");
		if("writeMail".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsg", errorMsgs);
			
			try {
//========================Get Member_ID from Session=============================
				HttpSession session = request.getSession();
				MemberVO member = (MemberVO) session.getAttribute("member");
				String member_ID = member.getMember_ID();
//							這邊先用emp_Name但是實際傳進來的是ID
				String emp_Name = request.getParameter("receiver").trim();
				String inbox_Mail_Title = request.getParameter("title").trim();
				String inbox_Mail_Info = request.getParameter("message").trim();
				String inbox_Mail_State = request.getParameter("state").trim();
				if(emp_Name == null || emp_Name.length() == 0) {
					errorMsgs.put("name_empty", "名字欄位不可為空白");
				}else {
					EmployeeVO emp = new EmployeeVO();
					EmployeeService service = new EmployeeService();
					emp = service.getOne(emp_Name);
					if(emp == null) {
						errorMsgs.put("name_wrong", "沒有此位員工喔");
					}	
				}
				if(inbox_Mail_Title == null || inbox_Mail_Title.length() == 0) {
					errorMsgs.put("title_empty", "標題不可空白");
				}
				if(inbox_Mail_Info == null || inbox_Mail_Info.length() == 0) {
					errorMsgs.put("message_empty", "內容不可為空白");
				}
				
				InboxVO inbox = new InboxVO();
				inbox.setEmp_ID(emp_Name);
				inbox.setInbox_Mail_Info(inbox_Mail_Info);
				inbox.setInbox_Mail_Title(inbox_Mail_Title);
				inbox.setMember_ID(member_ID);
				inbox.setInbox_Mail_State(inbox_Mail_State);
				
				if(!errorMsgs.isEmpty()) {
					request.setAttribute("inbox", inbox);
					RequestDispatcher failureView = request.getRequestDispatcher("/frontstage_member/member_Inbox/Member_Inbox.jsp");
					failureView.forward(request, response);
					return;
				}
				
				InboxService service = new InboxService();
				InboxVO inboxInsert = service.writeMail(member_ID, emp_Name, inbox_Mail_Info, inbox_Mail_Title, inbox_Mail_State);
				
				System.out.println(inboxInsert);
				response.sendRedirect(request.getContextPath() + "/frontstage_member/member_Inbox/Member_Inbox.jsp");
			}catch(Exception e) {
				errorMsgs.put("other", "cant get message" + e.getMessage());
				request.getRequestDispatcher("/frontstage_member/member_Inbox/Member_Inbox.jsp").forward(request, response);
			}
			
			
			
		}
		
		if("delete".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsg", errorMsgs);
			
			String[] inbox_Mail_ID = request.getParameterValues("mail_ID");
			if(inbox_Mail_ID == null) {
				errorMsgs.put("id_empty", "你沒有選擇任何信件哦");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("/frontstage_member/member_Inbox/Member_Inbox.jsp");
				failureView.forward(request, response);
				return;
				
			}
			
			List<Integer>deleteID = new ArrayList<Integer>();
			InboxService service = new InboxService();
			for(String mail_ID : inbox_Mail_ID) {
				deleteID.add(service.deleteMail(mail_ID));
			}
			System.out.println(deleteID);
			response.sendRedirect(request.getContextPath() + "/frontstage_member/member_Inbox/Member_Inbox.jsp");

		}
		if("searchMail".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsg", errorMsgs);
			
			Map<String, String[]> map = request.getParameterMap();
			Set<String>keys = map.keySet();
			for(String key : keys) {
				System.out.println(map.get(key)[0]);
			}
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
