package com.member_api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
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

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.sun.xml.internal.fastinfoset.tools.PrintTable;

@WebServlet("/member/Login.Api")
public class LoginApi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
//使用text接收參數
//		response.setContentType("text/html; charset=UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();
		
		MemberService service = new MemberService();
		List<MemberVO> members = service.getAll();
		Set<String>member_Accounts = new HashSet<String>();
		for(MemberVO member : members) {
			member_Accounts.add(member.getMember_Account());
		}
		System.out.println(member_Accounts);
//		String account = request.getParameter("account");
//		System.out.println(account);
//		String result = (member_Accounts.contains(account) == true) ? "1" : "0";
//		out.print(result);
	
//接收前端送來的String type JSON 使用bufferedReader接收
		
		BufferedReader reader = request.getReader();
		String json = reader.readLine();
		System.out.println(json);
		reader.close();
		
		if(json != null )
		try {
//轉換String type JSON -->  JSON OBJECT
			
			JSONObject jobj = new JSONObject(json);
			JSONObject ob = new JSONObject();
			String account = jobj.getString("account").trim();
			System.out.println(account);
			if(account == null || account.length() == 0) {
				ob.put("result", "NG");
				ob.put("reason", "請確認您輸入的帳號不可為空白");
				out.print(ob);
				out.close();
			}else {
				
				String result = (member_Accounts.contains(account) == true) ? "NG": "OK";
				System.out.println(result);
//生成一個JSONOBJECT，把結果包進去，然後前端可以直接接JSON
				ob.put("result", result);
				out.print(ob);
				out.close();
				
			}
			

		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		
			
		
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
