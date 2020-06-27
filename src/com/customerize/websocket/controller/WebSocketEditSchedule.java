package com.customerize.websocket.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;

@ServerEndpoint("/TogetherWS/{cust_schedule_id}/{current_member_id}/{owner_member_id}/{member_email}")
public class WebSocketEditSchedule {

//	private static final Set<Session> connectedSessions = Collections.synchronizedSet(new HashSet<>());
	private static Map<String, Session> sessionMap = new ConcurrentHashMap<>();
//	private static Map<String, Map<String, Session>> roomMap = new HashMap<>();
//	private static int roomNumber = 1;
	Gson gson = new Gson();
	/*
	 * 如果想取得HttpSession與ServletContext必須實作
	 * ServerEndpointConfig.Configurator.modifyHandshake()，
	 * 參考https://stackoverflow.com/questions/21888425/accessing-servletcontext-and-
	 * httpsession-in-onmessage-of-a-jsr-356-serverendpoint
	 */
	@OnOpen
	public void onOpen(@PathParam("current_member_id") String current_member_id, @PathParam("owner_member_id") String owner_member_id,
			@PathParam("member_email") String member_email, @PathParam("cust_schedule_id") String cust_schedule_id, Session userSession) throws IOException {
		
		MemberDetail member = new MemberDetail(current_member_id, member_email);
		JedisEditSchedule.setRoomMembers(cust_schedule_id, member);
//		JedisEditSchedule.setRoomMembers(cust_schedule_id, current_member_id);
		if(!owner_member_id.equals(current_member_id)) {
			JedisEditSchedule.setShareSchedule(current_member_id, cust_schedule_id);
		}
		sessionMap.put(current_member_id, userSession);
		
		String text = String.format("Session ID = %s, connected;, userName = %s", userSession.getId(), current_member_id);
		System.out.println(text);
		
//		List<String> scheduleRoom = JedisEditSchedule.getRoomMembers(cust_schedule_id);       //先檢查此行程主檔ID有沒有創建過房間
//		String roomName = null;
//		System.out.println("master_scheduleRoom = " +scheduleRoom);
//		if(scheduleRoom.size() == 0) {
//			roomName = "ScheduleRoom" + roomNumber;
//			System.out.println("此"+cust_schedule_id+"產生新的room ="+roomName);
//			ScheduleRoom room = new ScheduleRoom(roomName, current_member_id);
//			JedisEditSchedule.setRoomName(cust_schedule_id, room);
//			roomNumber++;
//		}else {
//			ScheduleRoom room = new ScheduleRoom(scheduleRoom.get(0).getRoomName(), current_member_id);
//			JedisEditSchedule.setRoomName(cust_schedule_id, room);
//		}
		
//		roomMap.put(roomName, sessionMap);
		
//		Collection<Session> sessions = roomMap.get(roomName).values();
//		String roomNameJson = gson.toJson(roomName);
//		for(Session session: sessions) {
//			if(session.isOpen()) {
//				session.getAsyncRemote().sendText(roomNameJson);
//				System.out.println(session);
//			}
//		}
//		connectedSessions.add(userSession);
		
	}

	@OnMessage
	public void onMessage(Session userSession, @PathParam("cust_schedule_id") String cust_schedule_id, String message) {
//		List<ScheduleRoom> master_scheduleRoom = JedisEditSchedule.getRoomName(cust_schedule_id);       //先檢查此行程主檔ID有沒有創建過房間
		Set<MemberDetail> rooms = JedisEditSchedule.getRoomMembers(cust_schedule_id);
		Set<String> member_ids = sessionMap.keySet();
		for(MemberDetail room : rooms) {
			for(String member_id : member_ids) {
				if(room.getMember_id().equals(member_id)) {
					Session session = sessionMap.get(member_id);
					if(session.isOpen()) {
						session.getAsyncRemote().sendText(message);
					}
				}
			}
		}
//		Collection<Session> sessions = roomMap.get(roomName).values();
//		System.out.println("sessions = " + sessions );
//		for(Session session: sessions) {
//			if(session.isOpen()) {
//				session.getAsyncRemote().sendText(message);
//				System.out.println(session);
//			}
//		}
		System.out.println("Message received: " + message);
//		for (Session session : connectedSessions) {
//			if (session.isOpen())
//				session.getAsyncRemote().sendText(message);
//		}
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
//		connectedSessions.remove(userSession);
		String text = String.format("session ID = %s, disconnected; close code = %d; reason phrase = %s",
				userSession.getId(), reason.getCloseCode().getCode(), reason.getReasonPhrase());
		System.out.println(text);
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

}
