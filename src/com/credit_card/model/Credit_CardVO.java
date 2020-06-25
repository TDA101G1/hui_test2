package com.credit_card.model;

public class Credit_CardVO {
	private String credit_Card_Number;
	private String member_ID;
	private String credit_Card_Owner_Name;
	private String credit_Card_Expire_M;
	private String credit_Card_Expire_Y;
	private String credit_Card_Address;
	private String credit_Card_Postal_Code;
	private Integer credit_Card_State;
	public String getCredit_Card_Number() {
		return credit_Card_Number;
	}
	public void setCredit_Card_Number(String credit_Card_Number) {
		this.credit_Card_Number = credit_Card_Number;
	}
	public String getMember_ID() {
		return member_ID;
	}
	public void setMember_ID(String member_ID) {
		this.member_ID = member_ID;
	}
	public String getCredit_Card_Owner_Name() {
		return credit_Card_Owner_Name;
	}
	public void setCredit_Card_Owner_Name(String credit_Card_Owner_Name) {
		this.credit_Card_Owner_Name = credit_Card_Owner_Name;
	}
	public String getCredit_Card_Expire_M() {
		return credit_Card_Expire_M;
	}
	public void setCredit_Card_Expire_M(String credit_Card_Expire_M) {
		this.credit_Card_Expire_M = credit_Card_Expire_M;
	}
	public String getCredit_Card_Expire_Y() {
		return credit_Card_Expire_Y;
	}
	public void setCredit_Card_Expire_Y(String credit_Card_Expire_Y) {
		this.credit_Card_Expire_Y = credit_Card_Expire_Y;
	}
	public String getCredit_Card_Address() {
		return credit_Card_Address;
	}
	public void setCredit_Card_Address(String credit_Card_Address) {
		this.credit_Card_Address = credit_Card_Address;
	}
	public String getCredit_Card_Postal_Code() {
		return credit_Card_Postal_Code;
	}
	public void setCredit_Card_Postal_Code(String credit_Card_Postal_Code) {
		this.credit_Card_Postal_Code = credit_Card_Postal_Code;
	}
	public Integer getCredit_Card_State() {
		return credit_Card_State;
	}
	public void setCredit_Card_State(Integer credit_Card_State) {
		this.credit_Card_State = credit_Card_State;
	}
	@Override
	public String toString() {
		return "Credit_CardVO [credit_Card_Number=" + credit_Card_Number + ", member_ID=" + member_ID
				+ ", credit_Card_Owner_Name=" + credit_Card_Owner_Name + ", credit_Card_Expire_M="
				+ credit_Card_Expire_M + ", crdit_Card_Expire_Y=" + credit_Card_Expire_Y + ", credit_Card_Address="
				+ credit_Card_Address + ", credit_Card_Postal_Code=" + credit_Card_Postal_Code + ", credit_Card_State="
				+ credit_Card_State + "]";
	}
	
}
