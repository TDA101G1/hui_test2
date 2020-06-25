package com.member.collection_Api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.customerize.model.CustomerizeService;
import com.customerize.model.CustomerizeVO;

@WebServlet("/collection/RemoveSchedule.Api")
public class RemoveSchedule extends HttpServlet {
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
		
		if(json != null || json.length() != 0) {
			try {
				JSONObject jobj = new JSONObject(json);
				
				String schedule_ID = jobj.getString("schedule_id");
				
				if(schedule_ID != null || schedule_ID.length() != 0) {
					CustomerizeService cService = new CustomerizeService();
					CustomerizeVO bean = new CustomerizeVO();
					bean.setCust_Schedule_ID(schedule_ID);
					CustomerizeVO bean_tmp = cService.select(bean);
					bean_tmp.setCust_Schedule_State(0);
					bean_tmp = cService.update(bean_tmp);
					List<CustomerizeVO>list = new ArrayList<CustomerizeVO>();
					list.add(bean_tmp);
					ob.put("result", true);
					ob.put("reason", list);
					out.print(ob);
					out.close();
				}else {
					
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
