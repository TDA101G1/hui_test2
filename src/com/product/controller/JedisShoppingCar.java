package com.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.order.model.OrderDetailVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;

import redis.clients.jedis.Jedis;

public class JedisShoppingCar {
	
	public String add(String member_ID, String product_ID, String product_Name,
			String productDetail_ID, String quantity, String spc, String start, String end, String price) throws JSONException {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		
		System.out.println(productDetail_ID);
		System.out.println(price);
		System.out.println(price);
		
		String replaceID = member_ID.replace("MID", "");
		Map<String, String> map = new HashMap<>();
		JSONArray jsonArray = new JSONArray(jedis.lrange("member:"+replaceID+":shoppingCar", 0, -1).toString());
		
		//空購物車，加入第一個商品
		if(jsonArray.isEmpty()) {
			map.put("product_Name", product_Name);
			map.put("product_ID", product_ID);
			map.put("productDetail_ID", productDetail_ID);
			map.put("spc", spc);
			map.put("quantity", quantity);
			map.put("start", start);
			map.put("end", end);
			map.put("price", price);
			map.put("addTime", String.valueOf(new java.util.Date().getTime()));
			System.out.println("======================================");
			System.out.println(map);
			System.out.println("======================================");
			String string = new JSONObject(map).toString();
			jedis.rpush("member:"+replaceID+":shoppingCar", string);
			
		//購物車內已經有東西，做遍歷
		}else {
			for(int i=0; i<jsonArray.length(); i++) {
				JSONObject oneProductJSON = jsonArray.getJSONObject(i);
				System.out.println("====================JSON===============");
				System.out.println(oneProductJSON);
				System.out.println("====================JSON===============");

				//找到相同PDID、規格名稱、起始時間、結束時間都一樣的商品 >> 做數量增加後覆蓋回去
				if(oneProductJSON.getString("productDetail_ID").equals(productDetail_ID) && oneProductJSON.getString("spc").equals(spc)
						&& oneProductJSON.getString("start").equals(start) && oneProductJSON.getString("end").equals(end)) {
					map.put("product_Name", product_Name);
					map.put("product_ID", product_ID);
					map.put("productDetail_ID", productDetail_ID);
					map.put("spc", spc);
					map.put("quantity", String.valueOf(oneProductJSON.getInt("quantity")+new Integer(quantity)));
					map.put("start", start);
					map.put("end", end);
					map.put("price", price);
					map.put("addTime", oneProductJSON.getString("addTime"));
					String string = new JSONObject(map).toString();
					jedis.lset("member:"+replaceID+":shoppingCar", i, string);
					jedis.close();
					return "added";
				}
			}
			
			//遍歷結束沒有任何一模一樣的的商品，做新增
			map.put("product_Name", product_Name);
			map.put("product_ID", product_ID);
			map.put("productDetail_ID", productDetail_ID);
			map.put("spc", spc);
			map.put("quantity", quantity);
			map.put("start", start);
			map.put("end", end);
			map.put("price", price);
			map.put("addTime", String.valueOf(new java.util.Date().getTime()));
			String string = new JSONObject(map).toString();
			jedis.lpush("member:"+replaceID+":shoppingCar", string);
		}
		
		jedis.close();
		return "added";
		
//		System.out.println(productDetailJSON.getString("productDetail_ID"));
//		System.out.println(productDetailJSON.getString("quantity"));
//		System.out.println(productDetailJSON.getString("addTime"));
//		System.out.println(productDetailJSON.getString("spc"));
//		System.out.println(productDetailJSON.getString("start"));
//		System.out.println(productDetailJSON.getString("end"));
//		System.out.println(productDetailJSON.getString("product_Name"));
	}
	
	public JSONObject update(String member_ID, String product_ID, String product_Name, String productDetail_ID, 
			String quantity, String spc, String start, String end, String price, String index,  String addTime) throws JSONException {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		
		String replaceID = member_ID.replace("MID", "");
		JSONArray jsonArray = new JSONArray(jedis.lrange("member:"+replaceID+":shoppingCar", 0, -1));
		if(!jsonArray.isEmpty()) {
			for(int i=0; i<jsonArray.length(); i++) {
				JSONObject jsonObject = new JSONObject(jsonArray.getString(i)); //不懂為何不能使用getJSON
				if(jsonObject.getString("addTime").equals(addTime) && jsonObject.getString("start").equals(start) && jsonObject.getString("end").equals(end)) {
					HashMap<String, String> map = new HashMap<String, String>();
					map.put("product_Name", product_Name);
					map.put("product_ID", product_ID);
					map.put("productDetail_ID", productDetail_ID);
					map.put("spc", spc);
					map.put("quantity", quantity);
					map.put("start", start);
					map.put("end", end);
					map.put("price", price);
					map.put("addTime", jsonObject.getString("addTime"));
					String string = new JSONObject(map).toString();
					jedis.lset("member:"+replaceID+":shoppingCar", i, string);
					jedis.close();
					return new JSONObject().put("reply", "updated");
				}
			}
		}
		jedis.close();
		return new JSONObject().put("reply", "fail to update");
	}
	
	//移除購物車內單筆商品
	public JSONObject delete(String member_ID, String index, String addTime, String start, String end) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		String replaceID = member_ID.replace("MID", "");
		JSONArray jsonArray = new JSONArray(jedis.lrange("member:"+replaceID+":shoppingCar", 0, -1));
		if(!jsonArray.isEmpty()) {
			for(int i=0; i<jsonArray.length(); i++) {
				JSONObject jsonObject = new JSONObject(jsonArray.getString(i).toString());
				if(jsonObject.getString("addTime").equals(addTime) && jsonObject.getString("start").equals(start) && jsonObject.getString("end").equals(end)) {
					jedis.lrem("member:"+replaceID+":shoppingCar", 0, jsonObject.toString());
					jedis.close();
					return new JSONObject().put("reply", "deleted");
				}
			}
		}
		jedis.close();
		return new JSONObject().put("reply", "fail to deleted");
	}
	
	//移除購物車內複數商品
	public JSONObject removeGoods(String member_ID, String jsonArr) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		String replaceID = member_ID.replace("MID", "");
		JSONArray jsonArray = new JSONArray(jsonArr);
		if(!jsonArray.isEmpty()) {
			Long count = null;
			for(int i=0; i<jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				count = jedis.lrem("member:"+replaceID+":shoppingCar", 0, jsonObject.toString());
			}
			jedis.close();
			return new JSONObject().put("reply", "移除的筆數: "+count.toString());
		}
		jedis.close();
		return new JSONObject().put("reply", "fail to removeGoods");
	}
	
	//移除購物車內已經失效的商品
	public JSONObject removeFailureGoods(String member_ID, String jsonArr) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		String replaceID = member_ID.replace("MID", "");
		JSONArray jsonArrayAll = new JSONArray(jedis.lrange("member:"+replaceID+":shoppingCar", 0, -1));
		JSONArray jsonArray = new JSONArray(jsonArr);
		if(!jsonArray.isEmpty() && !jsonArrayAll.isEmpty()) {
			long count = 0;

			for(int i=0; i<jsonArrayAll.length(); i++) {
				JSONObject jsonObject = new JSONObject(jsonArrayAll.get(i).toString());
				String product_Name = jsonObject.getString("product_Name");
				String product_ID = jsonObject.getString("product_ID");
				String addTime = jsonObject.getString("addTime");
				long length = jsonArray.length();
				
				for(int j=0; j<length; j++) {
					JSONObject jsonObject2 = jsonArray.getJSONObject(j);
					String product_Name2 = jsonObject2.getString("product_Name");
					String product_ID2 = jsonObject2.getString("product_ID");
					String addTime2 = jsonObject2.getString("addTime");
					if(addTime.equals(addTime2) && product_ID.equals(product_ID2) && product_Name.equals(product_Name2)) {
						count += jedis.lrem("member:"+replaceID+":shoppingCar", 0, jsonObject.toString());
					}
				}
				
				if(count == length) {
					jedis.close();
					return new JSONObject().put("reply", "removeFailureGoods");
				}
			}
		}
		jedis.close();
		return new JSONObject().put("reply", "fail to removeFailureGoods");
	}
	
	//載入shoppingCar.jsp，拿到該會員的購物車資訊，轉成list給jsp處理 
	public List<ProductVO> getMemberCar(String member_id){
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		List<ProductVO> list = new ArrayList<>();
		String replaceID = member_id.replace("MID", "");
		JSONArray jsonArray = new JSONArray(jedis.lrange("member:"+replaceID+":shoppingCar", 0, -1).toString());
		
		if(!jsonArray.isEmpty()) {
			List<ProductVO> all = new ProductService().getAll();
			for(int i=0; i<jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				Optional<ProductVO> findFirst = all.stream()
						.filter(pd -> pd.getProduct_ID().equals(jsonObject.getString("product_ID")))
						.findFirst();
				if(findFirst.isPresent()) {
					list.add(findFirst.get());
				}
			}
		}
		
		jedis.close();
		return list;
	}
	
	//確認購物車內的會員所選的商品規格與數量
	public JSONArray getMemberSelected(String member_id){
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		String replaceID = member_id.replace("MID", "");
		JSONArray jsonArray = new JSONArray(jedis.lrange("member:"+replaceID+":shoppingCar", 0, -1).toString());
		jedis.close();
		return jsonArray;
	}
	
	//前往結帳做的檢查
	public String goCheckout(String member_ID, String jsonArr) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		
		String replaceID = member_ID.replace("MID", "");
		JSONArray jsonArray = new JSONArray(jsonArr);
		JSONArray jsonArrayAll = new JSONArray(jedis.lrange("member:"+replaceID+":shoppingCar", 0, -1));
		int length = jsonArray.length();
		int count = 0;
		
		if(!jsonArrayAll.isEmpty() && !jsonArray.isEmpty()) {
			for(int i=0; i<jsonArrayAll.length(); i++) {
				JSONObject jsonObject = new JSONObject(jsonArrayAll.get(i).toString());
				String addTime = jsonObject.getString("addTime");
				String price = jsonObject.getString("price");
				String quantiy = jsonObject.getString("quantity");
				String start = jsonObject.getString("start");
				String end = jsonObject.getString("end");
				String productDetail_ID = jsonObject.getString("productDetail_ID");
				
				for(int j=0; j<length; j++) {
					JSONObject jsonObject2 = new JSONObject(jsonArray.get(j).toString());
					String addTime2 = jsonObject2.getString("addTime");
					String price2 = jsonObject2.getString("price");
					String quantiy2 = jsonObject2.getString("quantity");
					String start2 = jsonObject2.getString("start");
					String end2 = jsonObject2.getString("end");
					String productDetail_ID2 = jsonObject2.getString("productDetail_ID");
					if(addTime.equals(addTime2) && price.equals(price2) && 
							quantiy.equals(quantiy2) && start.equals(start2) &&
							end.equals(end2) && productDetail_ID.equals(productDetail_ID2)) {
						count++;
					}
				}
			}
			if(length == count) {
				jedis.close();
				return "比對成功";
			}
		}
		jedis.close();
		return "比對失敗";
	}
	
	//先為確認付款做檢查，轉成orderDetailVO，準備新增訂單
	public List<OrderDetailVO> createOrderDetaillList(String member_ID, String jsonArr) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		
		String replaceID = member_ID.replace("MID", "");
		JSONArray jsonArray = new JSONArray(jsonArr);
		JSONArray jsonArrayAll = new JSONArray(jedis.lrange("member:"+replaceID+":shoppingCar", 0, -1));
		int length = jsonArray.length();
		int count = 0;
		
		if(!jsonArrayAll.isEmpty() && !jsonArray.isEmpty()) {
			for(int i=0; i<jsonArrayAll.length(); i++) {
				JSONObject jsonObject = new JSONObject(jsonArrayAll.get(i).toString());
				String addTime = jsonObject.getString("addTime");
				String price = jsonObject.getString("price");
				String quantiy = jsonObject.getString("quantity");
				String start = jsonObject.getString("start");
				String end = jsonObject.getString("end");
				String productDetail_ID = jsonObject.getString("productDetail_ID");
				
				for(int j=0; j<length; j++) {
					JSONObject jsonObject2 = new JSONObject(jsonArray.get(j).toString());
					String addTime2 = jsonObject2.getString("addTime");
					String price2 = jsonObject2.getString("price");
					String quantiy2 = jsonObject2.getString("quantity");
					String start2 = jsonObject2.getString("start");
					String end2 = jsonObject2.getString("end");
					String productDetail_ID2 = jsonObject2.getString("productDetail_ID");
					if(addTime.equals(addTime2) && price.equals(price2) && 
							quantiy.equals(quantiy2) && start.equals(start2) &&
							end.equals(end2) && productDetail_ID.equals(productDetail_ID2)) {
						count++;
					}
				}
			}
			if(length == count) {
				List<OrderDetailVO> orderDetaillList = new ArrayList<OrderDetailVO>();
				for(int j=0; j<length; j++) {
					JSONObject jsonObject = new JSONObject(jsonArray.get(j).toString());
					String quantiy = jsonObject.getString("quantity");
					String productDetail_ID = jsonObject.getString("productDetail_ID");
					OrderDetailVO orderDetailVO = new OrderDetailVO();
					orderDetailVO.setProduct_Detail_ID(productDetail_ID);
					orderDetailVO.setOrder_Detail_Qty(new Integer(quantiy));
					orderDetailVO.setOrder_Detail_Used_Qty(new Integer(0));
					orderDetaillList.add(orderDetailVO);
				}
				
				jedis.close();
				return orderDetaillList;
			}
		}
		jedis.close();
		return null;
	}

	
	public static void main(String[] args) throws JSONException {
		Jedis jedis = new Jedis("localhost", 6379);
//		jedis.auth("123456");
//		Map<String, String> inner = new HashMap<>();
//		inner.put("product_ID", "PID000001");
// 		inner.put("product_Name", "有夠累套裝行程");
// 		inner.put("productDetail_ID", "PDID000091");
//		inner.put("spc", "3日遊");
//		inner.put("quantity", "3");
//		inner.put("start", "123");
//		inner.put("end", "456");
//		inner.put("addTime", "2020-06-18 01:05:32");
//		arrayList.add(inner);
//		String string = new JSONObject(inner).toString();
//		jedis.rpush("member:000005:shoppingCar", string);
//		JSONArray jsonArray = new JSONArray(jedis.lrange("member:000005:shoppingCar", 0, -1).toString());
//		System.out.println(jsonArray);
//		for(int i=0; i<jsonArray.length(); i++) {
//			JSONObject jsonObject = jsonArray.getJSONObject(i);
//			System.out.println(jsonObject);
//			System.out.println(jsonObject.getString("quantity"));
//
//		}
		

		
		jedis.close();
//		{"member:000001:shoppingCar":[
//		{"pd_id000001":{"quantity":"1","spc":"規格1","start":"","end":""}},
//		{"pd_id000002":{"quantity":"1","spc":"規格1","start":"","end":""}}
//		]}
//		{"member:000001:shoppingCar":[
//		{"pdid":"pdid000001","quantity":"1","spc":"規格1","start":"","end":""},
//		{"pdid":"pdid000002","quantity":"1","spc":"規格1","start":"","end":""}
//		]}
	}



}
