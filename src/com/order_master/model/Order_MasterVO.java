package com.order_master.model;

public class Order_MasterVO {
	private String order_Master_ID;
	private String member_ID;
	private String coupon_ID;
	private String order_Master_Payment;
	private java.sql.Timestamp order_Master_TimeStamp;
	private Integer order_Master_State;
	public String getOrder_Master_ID() {
		return order_Master_ID;
	}
	public void setOrder_Master_ID(String order_Master_ID) {
		this.order_Master_ID = order_Master_ID;
	}
	public String getMember_ID() {
		return member_ID;
	}
	public void setMember_ID(String member_ID) {
		this.member_ID = member_ID;
	}
	public String getCoupon_ID() {
		return coupon_ID;
	}
	public void setCoupon_ID(String coupon_ID) {
		this.coupon_ID = coupon_ID;
	}
	public String getOrder_Master_Payment() {
		return order_Master_Payment;
	}
	public void setOrder_Master_Payment(String order_Master_Payment) {
		this.order_Master_Payment = order_Master_Payment;
	}
	public java.sql.Timestamp getOrder_Master_TimeStamp() {
		return order_Master_TimeStamp;
	}
	public void setOrder_Master_TimeStamp(java.sql.Timestamp order_Master_TimeStamp) {
		this.order_Master_TimeStamp = order_Master_TimeStamp;
	}
	public Integer getOrder_Master_State() {
		return order_Master_State;
	}
	public void setOrder_Master_State(Integer order_Master_State) {
		this.order_Master_State = order_Master_State;
	}
	@Override
	public String toString() {
		return "Order_MasterVO [order_Master_ID=" + order_Master_ID + ", member_ID=" + member_ID + ", coupon_ID="
				+ coupon_ID + ", order_Master_Payment=" + order_Master_Payment + ", order_Master_TimeStamp="
				+ order_Master_TimeStamp + ", order_Master_State=" + order_Master_State + "]";
	}
}
