package com.member.order_master_Api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.order_master.model.Order_MasterService;
import com.order_master.model.Order_MasterVO;


@WebServlet("/order_master/UpdateOrder_Master.Api")
public class UpdateOrder_MasterApi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();
		
//接收前端送來的String type JSON 使用bufferedReader接收

				BufferedReader reader = request.getReader();
				String json = reader.readLine();
				System.out.println(json);
				reader.close();
				
//產生一個JSONOBJ用來放要傳出去的資料	
				JSONObject ob = new JSONObject();
				Boolean result = false;
				if(json != null) {
					try {
						JSONObject jobj = new JSONObject(json);
						String action = jobj.getString("action");
						String order_Master_ID = jobj.getString("order_Master_ID");
						
						if(action != null && order_Master_ID != null) {
							Order_MasterService omService = new Order_MasterService();
//驗證有無拿到該orderMaster
							Order_MasterVO bean = omService.getOne(order_Master_ID);
							if(bean != null) {
								bean = omService.updateOrder_Master_State(order_Master_ID);
								if(bean != null) {
									result = true;
									ob.put("result", result);
									ob.put("reason", "成功取消訂單：" + bean.getOrder_Master_ID());
									out.print(ob);
									out.close();
								}else {
									ob.put("reason", result);
									ob.put("reason", "刪除失敗，請聯繫客服人員");
									out.print(ob);
									out.close();
								}
							}else {
								ob.put("result", result);
								ob.put("reason", "查無該筆訂單");
								out.print(ob);
								out.close();
							}
							
						}
						
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
