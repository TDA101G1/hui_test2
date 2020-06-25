package com.member.collection_Api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.customerize.model.CustomerizeService;
import com.customerize.model.CustomerizeVO;
import com.customerizedetail.model.CustDetailService;
import com.customerizedetail.model.CustDetailVO;
import com.member.model.MemberVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;

@WebServlet("/collection/Member_Calendar.Api")
public class Member_CalendarApi extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
//轉換資料
		if (json != null || json.length() != 0) {
			try {
				JSONObject jobj = new JSONObject(json);

				String action = jobj.getString("action");
				if ("getSchedule".equals(action)) {
					String member_ID = jobj.getString("member_id");
//取得所有某一個會員的customerMaster
					CustomerizeService cService = new CustomerizeService();
					List<CustomerizeVO> custs = cService.getAll().stream()
							.filter(cust -> cust.getMember_ID().equals(member_ID))
							.filter(cust -> cust.getCust_Schedule_State().equals(1)).collect(Collectors.toList());

//取得custMaster的custsDetail資訊（主要是product ID)
					CustDetailService cdService = new CustDetailService();
					List<CustDetailVO> custDetails = cdService.getAll();
					Map<String, List<String>> custDetailMap = new HashMap<String, List<String>>();
					for (CustomerizeVO bean : custs) {
						List<String> product_ID = custDetails.stream().filter(
								custDetail -> custDetail.getCust_Schedule_ID().equals(bean.getCust_Schedule_ID()))
								.map(custDetail -> custDetail.getProduct_ID()).collect(Collectors.toList());
						custDetailMap.put(bean.getCust_Schedule_ID(), product_ID);
					}
//取得product			
					List<ProductVO> products = new ArrayList<ProductVO>();
					ProductService pService = new ProductService();
					products = pService.getAll();
					Map<JSONObject, List<String>> finalSchedule = new HashMap<JSONObject, List<String>>();
					for (Map.Entry<String, List<String>> entry : custDetailMap.entrySet()) {
						List<String> product_tmp = new ArrayList<String>();
						for (String product_ID : entry.getValue()) {
							Optional<String> target = products.stream()
									.filter(p -> p.getProduct_ID().equals(product_ID)).findFirst()
									.map(p -> p.getProduct_Name());
							if (target.isPresent()) {
								product_tmp.add(target.get());
							}
						}
						for(CustomerizeVO bean : custs) {
							Integer count = 0;
							if(bean.getCust_Schedule_ID().equals(entry.getKey())) {
								JSONObject j_tmp = new JSONObject(bean);
								finalSchedule.put(j_tmp, product_tmp);
								count++;
								
							}
						}
					}
					System.out.println(finalSchedule.size());
					ob.put("schedule", finalSchedule);
					out.print(ob);
					out.close();

				}
				else if("updateCust".equals(action)) {
					String cust_id = jobj.getString("cust_id");
					String startDate = jobj.getString("startdate");
					String endDate = jobj.getString("enddate");
					java.sql.Date startDate_tmp = null;
					java.sql.Date endDate_tmp = null;
					DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					CustomerizeService cService = new CustomerizeService();
					CustomerizeVO bean = new CustomerizeVO();
					bean.setCust_Schedule_ID(cust_id);
					bean = cService.select(bean);
					
					if(bean != null) {
						if(startDate != null || startDate.length() != 0) {
							java.util.Date utilDate = new java.util.Date();
							try {
								utilDate = format.parse(startDate);
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							startDate_tmp = new java.sql.Date(utilDate.getTime());
						}
						if(endDate != null || endDate.length() != 0) {
							java.util.Date utilDate = new java.util.Date();
							try {
								utilDate = format.parse(endDate);
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							endDate_tmp = new java.sql.Date(utilDate.getTime());
						}
						
						bean.setCust_Schedule_Start_Time(startDate_tmp);
						bean.setCust_Schedule_End_Time(endDate_tmp);
						
						CustomerizeVO updateBean = cService.update(bean);
						
						ob.put("result", true);
						ob.put("update", new JSONObject(updateBean));
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
