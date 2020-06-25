package com.inbox_api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.inbox.model.InboxService;
import com.inbox.model.InboxVO;
import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/inbox/Inbox.Api")
public class InboxApi extends HttpServlet {

	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
//使用text接收參數
//		response.setContentType("text/html; charset=UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();
		
		EmployeeService service = new EmployeeService();
		List<EmployeeVO> emps = service.getAll();
		Set<String>emp_IDs = new HashSet<String>();
		for(EmployeeVO emp : emps) {
			emp_IDs.add(emp.getEmp_ID());
		}
		System.out.println("all emp account:" + emp_IDs);
//		String account = request.getParameter("account");
//		System.out.println(account);
//		String result = (member_Accounts.contains(account) == true) ? "1" : "0";
//		out.print(result);
	
//接收前端送來的String type JSON 使用bufferedReader接收
		
		BufferedReader reader = request.getReader();
		String json = reader.readLine();
		System.out.println(json);
		reader.close();
		
//生成一個JSONOBJECT，把結果包進去，然後前端可以直接接JSON	
		
		JSONObject ob = new JSONObject();	


			try {
//轉換String type JSON -->  JSON OBJECT
				
				JSONObject jobj = new JSONObject(json);
				String emp_id = jobj.getString("name");
				String title = jobj.getString("title");
				String message = jobj.getString("message");
				String member_id = jobj.getString("id");
				String state = jobj.getString("state");
				
				System.out.println(emp_id + title + message);
				
				JSONObject errorObj = new JSONObject();
				
//驗證資料		
				if(emp_id == null || emp_id.length() == 0) {
					errorObj.put("name", "Name is empty");
				}else {
					String result = (emp_IDs.contains(emp_id) == true) ? "OK": "NG";  //確認有員工的話傳送ＯＫ否則ＮＧ
					if("NG".equals(result)) {
						errorObj.put("empAccountCheck", "沒有此帳號喔");	
					}
				}
				if(title == null || title.length() == 0) {
					errorObj.put("title", "title is empty");
				}
				if(message == null || message.length() == 0) {
					errorObj.put("message", "message is empty");
				}
				
//有錯誤的話就不往下執行
				if(errorObj.length() != 0) {
					ob.put("result", "NG");
					ob.put("resultDetail", errorObj);
					out.print(ob);
					out.close();
					return;								
				}
				
				InboxService inboxService = new InboxService();
				InboxVO inbox = inboxService.writeMail(member_id, emp_id, message, title, state);
				if(inbox == null) {
					ob.put("result", "NG");
					ob.put("resultDetail", "信件寄出失敗，請重新");
				}else {
					ob.put("result", "OK");
					ob.put("resultDetail", "信件寄出成功，請在寄件夾確認你的信件");

				}
				
				out.print(ob);
				out.close();
				
	
			} catch (JSONException e) {
				e.printStackTrace();
			}
		
		
		}	
		
		
		
	


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}