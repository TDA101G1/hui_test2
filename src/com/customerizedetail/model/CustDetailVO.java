package com.customerizedetail.model;

import java.io.Serializable;
import java.sql.Date;

import com.product.model.ProductVO;

public class CustDetailVO implements Serializable{						//TABLE = CUSTOMERIZE_SCHEDULE_DETAIL
	private String cust_Schedule_Detail_ID;
	private String cust_Schedule_ID;
	private String product_ID;
	private Integer cust_Schedule_Detail_Seq;
	private Date cust_Schedule_Detail_Date;
	private String cust_Schedule_Detail_Info;
	
	private ProductVO productVO;
	
	public ProductVO getProductVO() {
		return productVO;
	}
	public void setProductVO(ProductVO productVO) {
		this.productVO = productVO;
	}
	
	
	public String getCust_Schedule_Detail_ID() {
		return cust_Schedule_Detail_ID;
	}
	public void setCust_Schedule_Detail_ID(String cust_Schedule_Detail_ID) {
		this.cust_Schedule_Detail_ID = cust_Schedule_Detail_ID;
	}
	public String getCust_Schedule_ID() {
		return cust_Schedule_ID;
	}
	public void setCust_Schedule_ID(String cust_Schedule_ID) {
		this.cust_Schedule_ID = cust_Schedule_ID;
	}
	public String getProduct_ID() {
		return product_ID;
	}
	public void setProduct_ID(String product_ID) {
		this.product_ID = product_ID;
	}
	public Integer getCust_Schedule_Detail_Seq() {
		return cust_Schedule_Detail_Seq;
	}
	public void setCust_Schedule_Detail_Seq(Integer cust_Schedule_Detail_Seq) {
		this.cust_Schedule_Detail_Seq = cust_Schedule_Detail_Seq;
	}
	public Date getCust_Schedule_Detail_Date() {
		return cust_Schedule_Detail_Date;
	}
	public void setCust_Schedule_Detail_Date(Date cust_Schedule_Detail_Date) {
		this.cust_Schedule_Detail_Date = cust_Schedule_Detail_Date;
	}
	public String getCust_Schedule_Detail_Info() {
		return cust_Schedule_Detail_Info;
	}
	public void setCust_Schedule_Detail_Info(String cust_Schedule_Detail_Info) {
		this.cust_Schedule_Detail_Info = cust_Schedule_Detail_Info;
	}
	@Override
	public String toString() {
		return "CustDetailVO [cust_Schedule_Detail_ID=" + cust_Schedule_Detail_ID + ", cust_Schedule_ID="
				+ cust_Schedule_ID + ", product_ID=" + product_ID + ", cust_Schedule_Detail_Seq="
				+ cust_Schedule_Detail_Seq + ", cust_Schedule_Detail_Date=" + cust_Schedule_Detail_Date
				+ ", cust_Schedule_Detail_Info=" + cust_Schedule_Detail_Info + ", productVO=" + productVO + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cust_Schedule_Detail_Date == null) ? 0 : cust_Schedule_Detail_Date.hashCode());
		result = prime * result + ((cust_Schedule_Detail_ID == null) ? 0 : cust_Schedule_Detail_ID.hashCode());
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
		CustDetailVO other = (CustDetailVO) obj;
		if (cust_Schedule_Detail_Date == null) {
			if (other.cust_Schedule_Detail_Date != null)
				return false;
		} else if (!cust_Schedule_Detail_Date.equals(other.cust_Schedule_Detail_Date))
			return false;
		if (cust_Schedule_Detail_ID == null) {
			if (other.cust_Schedule_Detail_ID != null)
				return false;
		} else if (!cust_Schedule_Detail_ID.equals(other.cust_Schedule_Detail_ID))
			return false;
		return true;
	}
	
}
