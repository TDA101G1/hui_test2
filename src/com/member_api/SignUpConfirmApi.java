package com.member_api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
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
import com.redis.test.GenerateRandomNumber;
import com.redis.test.SendMail;

import redis.clients.jedis.Jedis;

@WebServlet("/member/SignUpConfirm.Api")
public class SignUpConfirmApi extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("application/json; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();

		final String title = "Tourism網站信箱驗證碼";
//接收前端送來的String type JSON 使用bufferedReader接收

		BufferedReader reader = request.getReader();
		String json = reader.readLine();
		System.out.println(json);
		reader.close();
		
		JSONObject ob = new JSONObject();
		
		if (json != null)
			try {
//轉換String type JSON -->  JSON OBJECT

				JSONObject jobj = new JSONObject(json);
				String action = jobj.getString("action");
				
				Boolean result = true;
				ob.put("result", result);
				
				if("sendCode".equals(action)) {
					String emailAddress = jobj.getString("emailAddress").trim();
					System.out.println(emailAddress);
					if(emailAddress == null || emailAddress.length() == 0) {
						result = false;
					}	
					if(result.equals(false)) {
						ob.put("result", result);
						out.print(ob);
						out.close();
						return;
					}	
					Jedis jedis = new Jedis("localhost", 6379);
					jedis.auth("123456");
					String message = new GenerateRandomNumber().genAuthCode();
					jedis.set(emailAddress, message);
					Integer countdown = 120;
					jedis.expire(emailAddress, countdown);
					jedis.close();
					
					SendMail newMail = new SendMail();
					result = newMail.sendMail(emailAddress, title, message);
					System.out.println("confirm code=" + message + "寄信成功了嗎？：" + result);
					
					if(result.equals(false)) {
						ob.put("result", result);
						out.print(ob);
						out.close();
						System.out.println("寄信");
						return;
					}else {
						ob.put("result", result);
						ob.put("countdown", countdown);
						out.print(ob);
					}
//生成一個JSONOBJECT，把結果包進去，然後前端可以直接接JSON

				}
				
				if("verify".equals(action)){
					String emailAddress = jobj.getString("emailAddress").trim();
					String confirmcode = jobj.getString("confirmcode").trim();
					
					if(emailAddress == null || emailAddress.length() == 0) {
						result = false;
					}
					if(confirmcode == null || confirmcode.length() == 0) {
						result = false;
					}
					
					if(result.equals(false)) {
						ob.put("result", result);
						out.print(ob);
						out.close();
						return;
					}
					Jedis jedis = new Jedis();
//					Jedis jedis = new Jedis("localhost", 6379);
					jedis.auth("123456");
					String realcode = jedis.get(emailAddress);
					jedis.close();
					System.out.println("Jedis:" + realcode);
					if(realcode != null && realcode.length() != 0) {
						if(realcode.equals(confirmcode)) {
							result = true;
						}else {
							result = false;
						}
					}else {
						result = false;
					}
					
					if(result.equals(false)) {
						ob.put("result", result);
						out.print(ob);
						out.close();
						return;
					}else {
						ob.put("result", result);
						out.print(ob);
					}
				}
				if("forgetPassword".equals(action)) {
					String account = jobj.getString("account").trim();
					String emailAddress = jobj.getString("emailAddress").trim();
//					MemberVO member = null;
					String password = "";
					if(account == null || account.length() == 0) {
						result = false;
					}
					if(emailAddress == null || emailAddress.length() == 0) {
						result =false;
					}
					
					if(result = false) {
						ob.put("result", false);
						ob.put("reason", "帳號或信箱為空值");
						out.print(ob);
						out.close();
						return;
					}
					
					MemberService mService = new MemberService();
					List<MemberVO>members = mService.getAll();
					Optional<MemberVO>target = members.stream()
							.filter(p -> p.getMember_Account().equals(account))
							.filter(p -> p.getMember_Mail().equals(emailAddress))
							.findFirst();
					if(target.isPresent()) {
						password = target.get().getMember_Pwd();
						result = true;
						ob.put("result", result);
						ob.put("emailAddress", emailAddress);
						
						SendMail newMail = new SendMail();
						Boolean sendResult = newMail.sendMail(emailAddress, "忘記密碼", password);
						
						ob.put("sendMail", sendResult);
						
						out.print(ob);
						out.close();
					}else {
						result = false;
						ob.put("result", result);
						ob.put("reason", "帳號或註冊信箱錯誤");
						out.print(ob);
						out.close();
					}
					
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}finally {
				System.out.println(ob);
				out.close();
				
			}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
