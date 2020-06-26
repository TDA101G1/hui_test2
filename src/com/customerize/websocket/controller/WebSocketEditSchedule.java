package com.customerize.websocket.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
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

@ServerEndpoint("/TogetherWS/{roomName}/{userName}")
public class WebSocketEditSchedule {

	private static final Set<Session> connectedSessions = Collections.synchronizedSet(new HashSet<>());
	private static Map<String, Session> sessionMap = new ConcurrentHashMap<>();
	private static Map<String, Map<String, Session>> roomMap = new HashMap<>();
	private static int roomNumber = 1;
	Gson gson = new Gson();
	/*
	 * 如果想取得HttpSession與ServletContext必須實作
	 * ServerEndpointConfig.Configurator.modifyHandshake()，
	 * 參考https://stackoverflow.com/questions/21888425/accessing-servletcontext-and-
	 * httpsession-in-onmessage-of-a-jsr-356-serverendpoint
	 */
	@OnOpen
	public void onOpen(@PathParam("userName") String userName, @PathParam("roomName") String roomName, Session userSession) throws IOException {
		if("null".equals(roomName)) {
			roomName = "ScheduleRoom" + this.roomNumber;
			System.out.println(roomName);
			this.roomNumber++;
		}
		sessionMap.put(userName, userSession);
		roomMap.put(roomName, sessionMap);
		
//		Set<String> key = roomMap.get(roomName).keySet();	
		Collection<Session> sessions = roomMap.get(roomName).values();
		Map<String, String> json = new HashMap<>();
		json.put("roomName", roomName);
		String roomNameJson = gson.toJson(roomName);
		for(Session session: sessions) {
			if(session.isOpen()) {
				session.getAsyncRemote().sendText(roomNameJson);
				System.out.println(session);
			}
		}
//		connectedSessions.add(userSession);
		String text = String.format("Session ID = %s, connected; , roomName = %s, userName = %s", userSession.getId(), roomName, userName);
		System.out.println(text);
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {
		for (Session session : connectedSessions) {
			if (session.isOpen())
				session.getAsyncRemote().sendText(message);
		}
		System.out.println("Message received: " + message);
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		connectedSessions.remove(userSession);
		String text = String.format("session ID = %s, disconnected; close code = %d; reason phrase = %s",
				userSession.getId(), reason.getCloseCode().getCode(), reason.getReasonPhrase());
		System.out.println(text);
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

}
