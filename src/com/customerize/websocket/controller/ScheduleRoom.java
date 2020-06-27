package com.customerize.websocket.controller;

public class ScheduleRoom {
	private String roomName;
	private String member_id;
	private String member_email;
	
	public ScheduleRoom() {
		
	}
	
	public ScheduleRoom(String roomName, String member_id) {
		this.roomName = roomName;
		this.member_id = member_id;
//		this.member_email = member_email;
	}
	
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	@Override
	public String toString() {
		return "ScheduleRoom [roomName=" + roomName + ", member_id=" + member_id + ", member_email=" + member_email
				+ "]";
	}
	
	
}
