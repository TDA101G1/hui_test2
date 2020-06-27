package com.customerize.websocket.controller;

public class MemberDetail {
	private String member_id;
	private String member_email;
	
	public MemberDetail() {
		
	}
	
	public MemberDetail(String member_id, String member_email) {
		this.member_id = member_id;
		this.member_email = member_email;
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
		return "MemberDetail [member_id=" + member_id + ", member_email=" + member_email + "]";
	}

	
	
}
