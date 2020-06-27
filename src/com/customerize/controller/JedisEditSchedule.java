package com.customerize.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.customerize.websocket.controller.ScheduleRoom;
import com.google.gson.Gson;

import redis.clients.jedis.Jedis;

public class JedisEditSchedule {
	
	public static void setRoomMembers (String cust_schedule_id, String current_member_id) {
		Gson gson = new Gson();
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		String key = new StringBuilder("customerize").append(":").append(cust_schedule_id)
				.append(":").append("room").toString();
		jedis.sadd(key, current_member_id);
	}
	
	public static Set<String> getRoomMembers (String cust_schedule_id) {
		Gson gson = new Gson();
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		String key = new StringBuilder("customerize").append(":").append(cust_schedule_id)
				.append(":").append("room").toString();
		return jedis.smembers(key);
	}
	
	public static void setShareSchedule(String member_id, String cust_schedule_id) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		String key = new StringBuilder("member").append(":").append(member_id).toString();
		jedis.sadd(key, cust_schedule_id);
	}
	
//	public static void setRoomName (String cust_schedule_id, ScheduleRoom scheduleRoom) {
//	Gson gson = new Gson();
//	Jedis jedis = new Jedis("localhost", 6379);
//	jedis.auth("123456");
//	String key = new StringBuilder("customerize").append(":").append(cust_schedule_id)
//			.append(":").append("room").toString();
//	jedis.rpush(key, gson.toJson(scheduleRoom));
//}
	
//	public static List<ScheduleRoom> getRoomName (String cust_schedule_id) {
//		List<ScheduleRoom> list = null;
//		Gson gson = new Gson();
//		Jedis jedis = new Jedis("localhost", 6379);
//		jedis.auth("123456");
//		String key = new StringBuilder("customerize").append(":").append(cust_schedule_id)
//				.append(":").append("roomName").toString();
//		List<String> lrange = jedis.lrange(key, 0, -1);
//		
//		if(lrange != null || lrange.size() > 0) {
//			list = new ArrayList<ScheduleRoom>();
//			for(String i : lrange) {
//				list.add(gson.fromJson(i, ScheduleRoom.class));
//			}
//		}
//		return list;
//	}
	
}
