package com.coupon.model;

import java.sql.Timestamp;

public class CouponVO implements java.io.Serializable {

	private String coupon_ID;
	private String emp_ID;
	private String member_ID;
	private String coupon_Name;
	private Double coupon_Class;
	private String coupon_Number;
	private String coupon_Info;
	private Timestamp coupon_Date;
	private Integer coupon_State;

	public String getCoupon_ID() {
		return coupon_ID;
	}

	public void setCoupon_ID(String coupon_ID) {
		this.coupon_ID = coupon_ID;
	}

	public String getEmp_ID() {
		return emp_ID;
	}

	public void setEmp_ID(String emp_ID) {
		this.emp_ID = emp_ID;
	}

	public String getMember_ID() {
		return member_ID;
	}

	public void setMember_ID(String member_ID) {
		this.member_ID = member_ID;
	}

	public String getCoupon_Name() {
		return coupon_Name;
	}

	public void setCoupon_Name(String coupon_Name) {
		this.coupon_Name = coupon_Name;
	}

	public Double getCoupon_Class() {
		return coupon_Class;
	}

	public void setCoupon_Class(Double coupon_Class) {
		this.coupon_Class = coupon_Class;
	}

	public String getCoupon_Number() {
		return coupon_Number;
	}

	public void setCoupon_Number(String coupon_Number) {
		this.coupon_Number = coupon_Number;
	}

	public String getCoupon_Info() {
		return coupon_Info;
	}

	public void setCoupon_Info(String coupon_Info) {
		this.coupon_Info = coupon_Info;
	}

	public Timestamp getCoupon_Date() {
		return coupon_Date;
	}

	public void setCoupon_Date(Timestamp coupon_Date) {
		this.coupon_Date = coupon_Date;
	}

	public Integer getCoupon_State() {
		return coupon_State;
	}

	public void setCoupon_State(Integer coupon_State) {
		this.coupon_State = coupon_State;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((coupon_Class == null) ? 0 : coupon_Class.hashCode());
		result = prime * result + ((coupon_Date == null) ? 0 : coupon_Date.hashCode());
		result = prime * result + ((coupon_ID == null) ? 0 : coupon_ID.hashCode());
		result = prime * result + ((coupon_Info == null) ? 0 : coupon_Info.hashCode());
		result = prime * result + ((coupon_Name == null) ? 0 : coupon_Name.hashCode());
		result = prime * result + ((coupon_Number == null) ? 0 : coupon_Number.hashCode());
		result = prime * result + ((coupon_State == null) ? 0 : coupon_State.hashCode());
		result = prime * result + ((emp_ID == null) ? 0 : emp_ID.hashCode());
		result = prime * result + ((member_ID == null) ? 0 : member_ID.hashCode());
		return result;
	}

	
	
	
	
	@Override
	public String toString() {
		return "CouponVO [coupon_ID=" + coupon_ID + ", emp_ID=" + emp_ID + ", member_ID=" + member_ID + ", coupon_Name="
				+ coupon_Name + ", coupon_Class=" + coupon_Class + ", coupon_Number=" + coupon_Number + ", coupon_Info="
				+ coupon_Info + ", coupon_Date=" + coupon_Date + ", coupon_State=" + coupon_State + "]";
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CouponVO other = (CouponVO) obj;
		if (coupon_Class == null) {
			if (other.coupon_Class != null)
				return false;
		} else if (!coupon_Class.equals(other.coupon_Class))
			return false;
		if (coupon_Date == null) {
			if (other.coupon_Date != null)
				return false;
		} else if (!coupon_Date.equals(other.coupon_Date))
			return false;
		if (coupon_ID == null) {
			if (other.coupon_ID != null)
				return false;
		} else if (!coupon_ID.equals(other.coupon_ID))
			return false;
		if (coupon_Info == null) {
			if (other.coupon_Info != null)
				return false;
		} else if (!coupon_Info.equals(other.coupon_Info))
			return false;
		if (coupon_Name == null) {
			if (other.coupon_Name != null)
				return false;
		} else if (!coupon_Name.equals(other.coupon_Name))
			return false;
		if (coupon_Number == null) {
			if (other.coupon_Number != null)
				return false;
		} else if (!coupon_Number.equals(other.coupon_Number))
			return false;
		if (coupon_State == null) {
			if (other.coupon_State != null)
				return false;
		} else if (!coupon_State.equals(other.coupon_State))
			return false;
		if (emp_ID == null) {
			if (other.emp_ID != null)
				return false;
		} else if (!emp_ID.equals(other.emp_ID))
			return false;
		if (member_ID == null) {
			if (other.member_ID != null)
				return false;
		} else if (!member_ID.equals(other.member_ID))
			return false;
		return true;
	}



}