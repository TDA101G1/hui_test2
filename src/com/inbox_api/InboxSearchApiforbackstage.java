package com.inbox_api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

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


@WebServlet("/inbox/InboxSearch.Apiforbackstage")
public class InboxSearchApiforbackstage extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();
		
//生成一個JSONOBJECT，把結果包進去，然後前端可以直接接JSON	
		
				JSONObject ob = null;			
//接收前端送來的String type JSON 使用bufferedReader接收

		BufferedReader reader = request.getReader();
		String json = reader.readLine();
		System.out.println(json);
		reader.close();	
		
		try {
			JSONObject jobj = new JSONObject(json);
//			String[] emp_ID = jobj.getString("emp_id");
//			String title = jobj.getString("title");
//			String dateString = jobj.getString("date");
			String member_ID = jobj.getString("member_id");
			String state = jobj.getString("state");
			Map<String, String[]>map = new TreeMap<String, String[]>();
			map.put("EMP_ID", new String[] {jobj.getString("emp_id")});
			map.put("INBOX_MAIL_TITLE", new String[] {jobj.getString("title")});
			map.put("INBOX_MAIL_TIMESTAMP", new String[] {jobj.getString("date")});

//取得動態inbox搜尋結果
			InboxService service = new InboxService();
			Set<InboxVO> inboxs = service.getInboxByMemberID(state, member_ID, map);
			
//取得員工名稱			
			MemberService memService = new MemberService();
			Set<MemberVO> mems = new HashSet<MemberVO>();
			for(InboxVO inbox : inboxs) {
				mems.add(memService.getOne(inbox.getMember_ID()));
			}
			
			System.out.println(inboxs);
			System.out.println("MEM SET:" + mems);
			ob = new JSONObject();
			ob.put("key", inboxs);
			ob.put("mems", mems);
			System.out.println(ob);
			out.print(ob);
			out.close();
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
