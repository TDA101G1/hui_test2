package com.member.collection_Api;

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

import com.collection.model.CollectionService;


@WebServlet("/collection/RemoveCollection.Api")
public class RemoveCollectionApi extends HttpServlet {
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
				
				String collection_ID = jobj.getString("collection_id");
				if(collection_ID != null && collection_ID.length() != 0) {
					CollectionService service = new CollectionService();
					System.out.println(collection_ID);
					Integer deleteNum = service.deleteCollection(collection_ID);
					if(deleteNum != null) {
						
						ob.put("result", true);
						ob.put("count", deleteNum);
						out.print(ob);
						out.close();
					}else {
						ob.put("result", false);
						out.print(ob);
						out.close();
					}
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
