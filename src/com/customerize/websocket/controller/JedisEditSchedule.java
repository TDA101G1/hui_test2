package com.customerize.websocket.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.google.gson.Gson;

import redis.clients.jedis.Jedis;

public class JedisEditSchedule {
	
	public static void setShareSchedule(String member_id, String cust_schedule_id) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		String key = new StringBuilder("member:").append(member_id).toString();
		jedis.sadd(key, cust_schedule_id);
		jedis.close();
	}
	
	public static void setRoomMembers (String cust_schedule_id, MemberDetail member) {
	Gson gson = new Gson();
	Jedis jedis = new Jedis("localhost", 6379);
	jedis.auth("123456");
	String key = new StringBuilder("customerize:")
				.append(cust_schedule_id).append(":room").toString();
	jedis.sadd(key, gson.toJson(member));
	jedis.close();
}
	
	public static Set<MemberDetail> getRoomMembers (String cust_schedule_id) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		String key = new StringBuilder("customerize:")
				.append(cust_schedule_id).append(":room").toString();
		System.out.println(key);
		Set<String> setString = jedis.smembers(key);
		if(setString == null || setString.size() == 0) {
			jedis.close();
			return null;
		}
		Set<MemberDetail> sets = new HashSet<MemberDetail>();
		for(String set : setString) {
			sets.add(new Gson().fromJson(set, MemberDetail.class));
		}
		jedis.close();
		return sets;
	}
	
//	public static Set<MemberDetail> getRoomMembers (String cust_schedule_id) {
//		Gson gson = new Gson();
//		Jedis jedis = new Jedis("localhost", 6379);
//		jedis.auth("123456");
//		String key = new StringBuilder("customerize").append(":").append(cust_schedule_id)
//				.append(":").append("room").toString();
//		Set<String> setString = jedis.smembers(key);
//		
//		if(setString == null || setString.size() == 0) {
//			jedis.close();
//			return null;
//		}
//		
//		Set<MemberDetail> sets = new HashSet<MemberDetail>();
//		for(String set : setString) {
//			sets.add(gson.fromJson(set, MemberDetail.class));
//		}
//		jedis.close();
//		return sets;
//	}
	
//	沒有email資訊
//	public static void setRoomMembers (String cust_schedule_id, String current_member_id) {
//		Gson gson = new Gson();
//		Jedis jedis = new Jedis("localhost", 6379);
//		jedis.auth("123456");
//		String key = new StringBuilder("customerize").append(":").append(cust_schedule_id)
//				.append(":").append("room").toString();
//		jedis.sadd(key, current_member_id);
//	}
	
//	public static Set<String> getRoomMembers (String cust_schedule_id) {
//		Gson gson = new Gson();
//		Jedis jedis = new Jedis("localhost", 6379);
//		jedis.auth("123456");
//		String key = new StringBuilder("customerize").append(":").append(cust_schedule_id)
//				.append(":").append("room").toString();
//		return jedis.smembers(key);
//	}
	
}
