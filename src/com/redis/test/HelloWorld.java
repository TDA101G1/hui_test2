package com.redis.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;

import com.member.model.MemberVO;
import com.order.model.OrderDetailService;
import com.order.model.OrderDetailVO;
import com.product.model.ProductDetailService;
import com.product.model.ProductDetailVO;

import redis.clients.jedis.Jedis;

public class HelloWorld {

	public static void main(String[] args) {
		
////先拿到orderDetail(跟參數傳進來的orderMaster一樣的orderMasterID）
//		OrderDetailService odService = new OrderDetailService();
//		List<OrderDetailVO>orderDetails = odService.getAll().stream()
//					.filter(orderDetail -> orderDetail.getOrder_Master_ID().equals("OMID000010"))
//					.collect(Collectors.toList());
////拿到productDetail
//		ProductDetailService pdService = new ProductDetailService();
//		List<ProductDetailVO> productDetails = pdService.getAll();
//		List<ProductDetailVO>productDetails_tmp = new ArrayList<ProductDetailVO>();
//		productDetails_tmp.addAll(productDetails);
//		
//		for(OrderDetailVO bean : orderDetails) {
//			String product_Detail_ID = bean.getProduct_Detail_ID();
//			productDetails.removeIf(p -> p.getProduct_Detail_ID().equals(product_Detail_ID));
//		}
//		productDetails_tmp.removeAll(productDetails);
//
////拿到orderDetail的 ID & 使用剩餘數量
//		Map<String, Integer>result = new HashMap<String, Integer>();
//		for(OrderDetailVO bean : orderDetails) {
//			result.put(bean.getProduct_Detail_ID(), (bean.getOrder_Detail_Qty() - bean.getOrder_Detail_Used_Qty()));
//		}
//
////將剩餘數量加回productDetail中
//		for(ProductDetailVO pdbean : productDetails_tmp) {
//			for(Map.Entry<String, Integer> entry : result.entrySet()) {
//				if(pdbean.getProduct_Detail_ID().equals(entry.getKey())) {
//					pdbean.setProduct_Detail_Instock(pdbean.getProduct_Detail_Instock() + entry.getValue());
//				}
//			}
//		}
//		System.out.println(orderDetails);
//		System.out.println(productDetails);
//		System.out.println(productDetails_tmp);
//		System.out.println(result);
		
		List<MemberVO> members = new ArrayList<MemberVO>();
		MemberVO bean1 = new MemberVO();
		bean1.setMember_ID("1");
		bean1.setMember_Name("test");
		MemberVO bean2 = new MemberVO();
		bean2.setMember_ID("2");
		members.add(bean1);
		members.add(bean2);
		
		JSONArray jarray = new JSONArray(members);
		System.out.println(jarray);
		Map<String, List<MemberVO>>test = new HashMap<String, List<MemberVO>>();
		test.put("A", members);
		JSONObject jobj = new JSONObject(test);
		System.out.println(jobj);
		
		
	};
	}
// 
