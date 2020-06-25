package com.inbox.model;

public class InboxVO {
	private  String inbox_Mail_ID;
	private String member_ID;
	private String emp_ID;
	private String inbox_Mail_Info;
	private java.sql.Timestamp inbox_Mail_TimeStamp;
	private String inbox_Mail_Title;
	private String inbox_Mail_State;

	public String getInbox_Mail_State() {
		return inbox_Mail_State;
	}
	public void setInbox_Mail_State(String inbox_Mail_State) {
		this.inbox_Mail_State = inbox_Mail_State;
	}
	public String getInbox_Mail_Title() {
		return inbox_Mail_Title;
	}
	public void setInbox_Mail_Title(String inbox_Mail_Title) {
		this.inbox_Mail_Title = inbox_Mail_Title;
	}
	public String getInbox_Mail_ID() {
		return inbox_Mail_ID;
	}
	public void setInbox_Mail_ID(String inbox_Mail_ID) {
		this.inbox_Mail_ID = inbox_Mail_ID;
	}
	public String getMember_ID() {
		return member_ID;
	}
	public void setMember_ID(String member_ID) {
		this.member_ID = member_ID;
	}
	public String getEmp_ID() {
		return emp_ID;
	}
	public void setEmp_ID(String emp_ID) {
		this.emp_ID = emp_ID;
	}
	public String getInbox_Mail_Info() {
		return inbox_Mail_Info;
	}
	public void setInbox_Mail_Info(String inbox_Mail_Info) {
		this.inbox_Mail_Info = inbox_Mail_Info;
	}
	public java.sql.Timestamp getInbox_Mail_TimeStamp() {
		return inbox_Mail_TimeStamp;
	}
	public void setInbox_Mail_TimeStamp(java.sql.Timestamp inbox_Mail_TimeStamp) {
		this.inbox_Mail_TimeStamp = inbox_Mail_TimeStamp;
	}
	@Override
	public String toString() {
		return "InboxVO [inbox_Mail_ID=" + inbox_Mail_ID + ", member_ID=" + member_ID + ", emp_ID=" + emp_ID
				+ ", inbox_Mail_Info=" + inbox_Mail_Info + ", inbox_Mail_TimeStamp=" + inbox_Mail_TimeStamp
				+ ", inbox_Mail_Title=" + inbox_Mail_Title + ", inbox_Mail_State=" + inbox_Mail_State + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((inbox_Mail_TimeStamp == null) ? 0 : inbox_Mail_TimeStamp.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		InboxVO other = (InboxVO) obj;
		if (inbox_Mail_TimeStamp == null) {
			if (other.inbox_Mail_TimeStamp != null)
				return false;
		} else if (!inbox_Mail_TimeStamp.equals(other.inbox_Mail_TimeStamp))
			return false;
		return true;
	}

	
	

}
