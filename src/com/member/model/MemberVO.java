package com.member.model;

public class MemberVO {

	private String member_ID;
	private String member_Account;
	private String member_Pwd;
	private String member_Name;
	private String member_Phone;
	private String member_Sex;
	private java.sql.Date member_Birth;
	private String member_Mail;
	private String member_Address;
	private byte[] member_Img;
	private java.sql.Date member_Est_Time;
	private Integer member_State;

	public String getMember_ID() {
		return member_ID;
	}

	public void setMember_ID(String member_ID) {
		this.member_ID = member_ID;
	}

	public String getMember_Account() {
		return member_Account;
	}

	public void setMember_Account(String member_Account) {
		this.member_Account = member_Account;
	}

	public String getMember_Pwd() {
		return member_Pwd;
	}

	public void setMember_Pwd(String member_Pwd) {
		this.member_Pwd = member_Pwd;
	}

	public String getMember_Name() {
		return member_Name;
	}

	public void setMember_Name(String member_Name) {
		this.member_Name = member_Name;
	}

	public String getMember_Phone() {
		return member_Phone;
	}

	public void setMember_Phone(String member_Phone) {
		this.member_Phone = member_Phone;
	}

	public String getMember_Sex() {
		return member_Sex;
	}

	public void setMember_Sex(String member_Sex) {
		this.member_Sex = member_Sex;
	}

	public java.sql.Date getMember_Birth() {
		return member_Birth;
	}

	public void setMember_Birth(java.sql.Date member_Birth) {
		this.member_Birth = member_Birth;
	}

	public String getMember_Mail() {
		return member_Mail;
	}

	public void setMember_Mail(String member_Mail) {
		this.member_Mail = member_Mail;
	}

	public String getMember_Address() {
		return member_Address;
	}

	public void setMember_Address(String member_Address) {
		this.member_Address = member_Address;
	}

	public byte[] getMember_Img() {
		return member_Img;
	}

	public void setMember_Img(byte[] member_Img) {
		this.member_Img = member_Img;
	}

	public java.sql.Date getMember_Est_Time() {
		return member_Est_Time;
	}

	public void setMember_Est_Time(java.sql.Date member_Est_Time) {
		this.member_Est_Time = member_Est_Time;
	}

	public Integer getMember_State() {
		return member_State;
	}

	public void setMember_State(Integer member_State) {
		this.member_State = member_State;
	}
	
	@Override
	public String toString() {
		return "MemberVO [member_ID=" + member_ID + ", member_Account=" + member_Account + ", member_Pwd=" + member_Pwd
				+ ", member_Name=" + member_Name + ", member_Phone=" + member_Phone + ", member_Sex=" + member_Sex
				+ ", member_Birth=" + member_Birth + ", member_Mail=" + member_Mail + ", member_Address="
				+ member_Address + ", member_Est_Time=" + member_Est_Time + ", member_State=" + member_State + "]";
	}
	
	

}
