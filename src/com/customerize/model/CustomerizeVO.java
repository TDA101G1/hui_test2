package com.customerize.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;


public class CustomerizeVO implements Serializable{       //Table = CUSTOMERIZE_SCHEDULE
	private String cust_Schedule_ID;
	private String member_ID;
	private String cust_Schedule_Name;
	private Integer cust_Schedule_Click_Record;
	private Date cust_Schedule_Start_Time;
	private Date cust_Schedule_End_Time;
	private Integer cust_Schedule_Total_Day;
	private Integer cust_Schedule_Share;
	private Integer cust_Schedule_State;
	private Timestamp cust_Schedule_Last_Timestamp;
	private byte[] cust_Schedule_Img;
	private String cust_Position;
	private Integer cust_Quantity;
	private String cust_Selected_County;
	public String getCust_Schedule_ID() {
		return cust_Schedule_ID;
	}
	public void setCust_Schedule_ID(String cust_Schedule_ID) {
		this.cust_Schedule_ID = cust_Schedule_ID;
	}
	public String getMember_ID() {
		return member_ID;
	}
	public void setMember_ID(String member_ID) {
		this.member_ID = member_ID;
	}
	public String getCust_Schedule_Name() {
		return cust_Schedule_Name;
	}
	public void setCust_Schedule_Name(String cust_Schedule_Name) {
		this.cust_Schedule_Name = cust_Schedule_Name;
	}
	public Integer getCust_Schedule_Click_Record() {
		return cust_Schedule_Click_Record;
	}
	public void setCust_Schedule_Click_Record(Integer cust_Schedule_Click_Record) {
		this.cust_Schedule_Click_Record = cust_Schedule_Click_Record;
	}
	public Date getCust_Schedule_Start_Time() {
		return cust_Schedule_Start_Time;
	}
	public void setCust_Schedule_Start_Time(Date cust_Schedule_Start_Time) {
		this.cust_Schedule_Start_Time = cust_Schedule_Start_Time;
	}
	public Date getCust_Schedule_End_Time() {
		return cust_Schedule_End_Time;
	}
	public void setCust_Schedule_End_Time(Date cust_Schedule_End_Time) {
		this.cust_Schedule_End_Time = cust_Schedule_End_Time;
	}
	public Integer getCust_Schedule_Total_Day() {
		return cust_Schedule_Total_Day;
	}
	public void setCust_Schedule_Total_Day(Integer cust_Schedule_Total_Day) {
		this.cust_Schedule_Total_Day = cust_Schedule_Total_Day;
	}
	public Integer getCust_Schedule_Share() {
		return cust_Schedule_Share;
	}
	public void setCust_Schedule_Share(Integer cust_Schedule_Share) {
		this.cust_Schedule_Share = cust_Schedule_Share;
	}
	public Integer getCust_Schedule_State() {
		return cust_Schedule_State;
	}
	public void setCust_Schedule_State(Integer cust_Schedule_State) {
		this.cust_Schedule_State = cust_Schedule_State;
	}
	public Timestamp getCust_Schedule_Last_Timestamp() {
		return cust_Schedule_Last_Timestamp;
	}
	public void setCust_Schedule_Last_Timestamp(Timestamp cust_Schedule_Last_Timestamp) {
		this.cust_Schedule_Last_Timestamp = cust_Schedule_Last_Timestamp;
	}
	public byte[] getCust_Schedule_Img() {
		return cust_Schedule_Img;
	}
	public void setCust_Schedule_Img(byte[] cust_Schedule_Img) {
		this.cust_Schedule_Img = cust_Schedule_Img;
	}
	public String getCust_Position() {
		return cust_Position;
	}
	public void setCust_Position(String cust_Position) {
		this.cust_Position = cust_Position;
	}
	public Integer getCust_Quantity() {
		return cust_Quantity;
	}
	public void setCust_Quantity(Integer cust_Quantity) {
		this.cust_Quantity = cust_Quantity;
	}
	public String getCust_Selected_County() {
		return cust_Selected_County;
	}
	public void setCust_Selected_County(String cust_Selected_County) {
		this.cust_Selected_County = cust_Selected_County;
	}
	@Override
	public String toString() {
		return "CustVO [cust_Schedule_ID=" + cust_Schedule_ID + ", member_ID=" + member_ID + ", cust_Schedule_Name="
				+ cust_Schedule_Name + ", cust_Schedule_Click_Record=" + cust_Schedule_Click_Record
				+ ", cust_Schedule_Start_Time=" + cust_Schedule_Start_Time + ", cust_Schedule_End_Time="
				+ cust_Schedule_End_Time + ", cust_Schedule_Total_Day=" + cust_Schedule_Total_Day
				+ ", cust_Schedule_Share=" + cust_Schedule_Share + ", cust_Schedule_State=" + cust_Schedule_State
				+ ", cust_Schedule_Last_Timestamp=" + cust_Schedule_Last_Timestamp + ", cust_Position=" + cust_Position
				+ ", cust_Quantity=" + cust_Quantity + ", cust_Selected_County=" + cust_Selected_County + "]";
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CustomerizeVO other = (CustomerizeVO) obj;
		if (cust_Schedule_ID == null) {
			if (other.cust_Schedule_ID != null)
				return false;
		} else if (!cust_Schedule_ID.equals(other.cust_Schedule_ID))
			return false;
		if (member_ID == null) {
			if (other.member_ID != null)
				return false;
		} else if (!member_ID.equals(other.member_ID))
			return false;
		return true;
	}
	
	
}
