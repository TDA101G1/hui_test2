package com.employee.model;

import java.sql.Date;
import java.util.Arrays;

public class EmployeeVO implements java.io.Serializable {

	private String emp_ID;
	private String emp_Account;
	private String emp_Pwd;
	private String emp_Grade;
	private String emp_Name;
	private String emp_Sex;
	private Date emp_Birth;
	private String emp_Mail;
	private String emp_Phone;
	private String emp_Address;
	private Date emp_Est_Time;
	private byte[] emp_Img;
	private Integer emp_State;

	public String getEmp_Address() {
		return emp_Address;
	}

	public void setEmp_Address(String emp_Address) {
		this.emp_Address = emp_Address;
	}

	public String getEmp_ID() {
		return emp_ID;
	}

	public void setEmp_ID(String emp_ID) {
		this.emp_ID = emp_ID;
	}

	public String getEmp_Account() {
		return emp_Account;
	}

	public void setEmp_Account(String emp_Account) {
		this.emp_Account = emp_Account;
	}

	public String getEmp_Pwd() {
		return emp_Pwd;
	}

	public void setEmp_Pwd(String emp_Pwd) {
		this.emp_Pwd = emp_Pwd;
	}

	public String getEmp_Grade() {
		return emp_Grade;
	}

	public void setEmp_Grade(String emp_Grade) {
		this.emp_Grade = emp_Grade;
	}

	public String getEmp_Name() {
		return emp_Name;
	}

	public void setEmp_Name(String emp_Name) {
		this.emp_Name = emp_Name;
	}

	public String getEmp_Sex() {
		return emp_Sex;
	}

	public void setEmp_Sex(String emp_Sex) {
		this.emp_Sex = emp_Sex;
	}

	public Date getEmp_Birth() {
		return emp_Birth;
	}

	public void setEmp_Birth(Date emp_Birth) {
		this.emp_Birth = emp_Birth;
	}

	public String getEmp_Mail() {
		return emp_Mail;
	}

	public void setEmp_Mail(String emp_Mail) {
		this.emp_Mail = emp_Mail;
	}

	public String getEmp_Phone() {
		return emp_Phone;
	}

	public void setEmp_Phone(String emp_Phone) {
		this.emp_Phone = emp_Phone;
	}

	public Date getEmp_Est_Time() {
		return emp_Est_Time;
	}

	public void setEmp_Est_Time(Date emp_Est_Time) {
		this.emp_Est_Time = emp_Est_Time;
	}

	public byte[] getEmp_Img() {
		return emp_Img;
	}

	public void setEmp_Img(byte[] emp_Img) {
		this.emp_Img = emp_Img;
	}

	public Integer getEmp_State() {
		return emp_State;
	}

	public void setEmp_State(Integer emp_State) {
		this.emp_State = emp_State;
	}

	@Override
	public String toString() {
		return "EmployeeVO [emp_ID=" + emp_ID + ", emp_Account=" + emp_Account + ", emp_Pwd=" + emp_Pwd + ", emp_Grade="
				+ emp_Grade + ", emp_Name=" + emp_Name + ", emp_Sex=" + emp_Sex + ", emp_Birth=" + emp_Birth
				+ ", emp_Mail=" + emp_Mail + ", emp_Phone=" + emp_Phone + ", emp_Address=" + emp_Address
				+ ", emp_Est_Time=" + emp_Est_Time + ", emp_Img=" + Arrays.toString(emp_Img) + ", emp_State="
				+ emp_State + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((emp_Account == null) ? 0 : emp_Account.hashCode());
		result = prime * result + ((emp_Address == null) ? 0 : emp_Address.hashCode());
		result = prime * result + ((emp_Birth == null) ? 0 : emp_Birth.hashCode());
		result = prime * result + ((emp_Est_Time == null) ? 0 : emp_Est_Time.hashCode());
		result = prime * result + ((emp_Grade == null) ? 0 : emp_Grade.hashCode());
		result = prime * result + ((emp_ID == null) ? 0 : emp_ID.hashCode());
		result = prime * result + Arrays.hashCode(emp_Img);
		result = prime * result + ((emp_Mail == null) ? 0 : emp_Mail.hashCode());
		result = prime * result + ((emp_Name == null) ? 0 : emp_Name.hashCode());
		result = prime * result + ((emp_Phone == null) ? 0 : emp_Phone.hashCode());
		result = prime * result + ((emp_Pwd == null) ? 0 : emp_Pwd.hashCode());
		result = prime * result + ((emp_Sex == null) ? 0 : emp_Sex.hashCode());
		result = prime * result + ((emp_State == null) ? 0 : emp_State.hashCode());
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
		EmployeeVO other = (EmployeeVO) obj;
		if (emp_Account == null) {
			if (other.emp_Account != null)
				return false;
		} else if (!emp_Account.equals(other.emp_Account))
			return false;
		if (emp_Address == null) {
			if (other.emp_Address != null)
				return false;
		} else if (!emp_Address.equals(other.emp_Address))
			return false;
		if (emp_Birth == null) {
			if (other.emp_Birth != null)
				return false;
		} else if (!emp_Birth.equals(other.emp_Birth))
			return false;
		if (emp_Est_Time == null) {
			if (other.emp_Est_Time != null)
				return false;
		} else if (!emp_Est_Time.equals(other.emp_Est_Time))
			return false;
		if (emp_Grade == null) {
			if (other.emp_Grade != null)
				return false;
		} else if (!emp_Grade.equals(other.emp_Grade))
			return false;
		if (emp_ID == null) {
			if (other.emp_ID != null)
				return false;
		} else if (!emp_ID.equals(other.emp_ID))
			return false;
		if (!Arrays.equals(emp_Img, other.emp_Img))
			return false;
		if (emp_Mail == null) {
			if (other.emp_Mail != null)
				return false;
		} else if (!emp_Mail.equals(other.emp_Mail))
			return false;
		if (emp_Name == null) {
			if (other.emp_Name != null)
				return false;
		} else if (!emp_Name.equals(other.emp_Name))
			return false;
		if (emp_Phone == null) {
			if (other.emp_Phone != null)
				return false;
		} else if (!emp_Phone.equals(other.emp_Phone))
			return false;
		if (emp_Pwd == null) {
			if (other.emp_Pwd != null)
				return false;
		} else if (!emp_Pwd.equals(other.emp_Pwd))
			return false;
		if (emp_Sex == null) {
			if (other.emp_Sex != null)
				return false;
		} else if (!emp_Sex.equals(other.emp_Sex))
			return false;
		if (emp_State == null) {
			if (other.emp_State != null)
				return false;
		} else if (!emp_State.equals(other.emp_State))
			return false;
		return true;
	}

	
	
}
