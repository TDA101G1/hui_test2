package com.member.order_detail_Api;

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

import com.order.model.OrderDetailService;
import com.order.model.OrderDetailVO;


@WebServlet("/order_detail/UpdateOrder_Detail.Api")
public class UpdateOrder_DetailApi extends HttpServlet {
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
		
		if(json != null) {
			try {
				JSONObject jobj = new JSONObject(json);
				String action = jobj.getString("action");
				String order_Detail_ID = jobj.getString("order_Detail_ID");
				Integer use_qty = Integer.parseInt(jobj.getString("use_qty"));
				
				if("use_ticket".equals(action)) {
					OrderDetailService odService = new OrderDetailService();
					OrderDetailVO bean = new OrderDetailVO();
					bean.setOrder_Detail_ID(order_Detail_ID);
					
					bean = odService.select(bean);
					
					if(bean == null) {
						ob.put("result", false);
						ob.put("reason", "查無訂單，請聯繫客服人員");
						out.print(ob);
						out.close();
						return;
					}else {
						if(bean.getOrder_Detail_Used_Qty() >= bean.getOrder_Detail_Qty()) {
							ob.put("result", false);
							ob.put("reason", "票券已經使用完畢");
							out.print(ob);
							out.close();
							return;
						}else {
							if(use_qty > (bean.getOrder_Detail_Qty() - bean.getOrder_Detail_Used_Qty())) {
								ob.put("result", false);
								ob.put("reason", "您輸入的數量大於剩餘數量");
								out.print(ob);
								out.close();
							}else {
								Integer order_Detail_Used_Qty = bean.getOrder_Detail_Used_Qty();
								order_Detail_Used_Qty += use_qty;
								bean.setOrder_Detail_Used_Qty(order_Detail_Used_Qty);
								Integer update_Num = odService.update(bean);
								
								if(update_Num.equals(1)) {
									ob.put("result", true);
									ob.put("reason", "已成功使用:" + use_qty + " 目前還剩餘:" + (bean.getOrder_Detail_Qty() - bean.getOrder_Detail_Used_Qty()));
									ob.put("remaining", (bean.getOrder_Detail_Qty() - bean.getOrder_Detail_Used_Qty()));
									out.print(ob);
									out.close();
								}
							}
						}
					}
					
					
					
					
				}
				System.out.println(action + order_Detail_ID + use_qty);
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
