package com.product.model;

import java.io.Serializable;

public class ProductDetailVO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String product_Detail_ID;
	private String product_ID;
	private String product_Detail_Spc;
	private Integer product_Detail_Money;
	private Integer product_Detail_Instock;
	private Integer product_Detail_Saftystock;
	private java.sql.Date product_Detail_Date;
	
	public String getProduct_Detail_ID() {
		return product_Detail_ID;
	}
	public void setProduct_Detail_ID(String product_Detail_ID) {
		this.product_Detail_ID = product_Detail_ID;
	}
	public String getProduct_ID() {
		return product_ID;
	}
	public void setProduct_ID(String product_ID) {
		this.product_ID = product_ID;
	}
	public String getProduct_Detail_Spc() {
		return product_Detail_Spc;
	}
	public void setProduct_Detail_Spc(String product_Detail_Spc) {
		this.product_Detail_Spc = product_Detail_Spc;
	}
	public Integer getProduct_Detail_Money() {
		return product_Detail_Money;
	}
	public void setProduct_Detail_Money(Integer product_Detail_Money) {
		this.product_Detail_Money = product_Detail_Money;
	}
	public Integer getProduct_Detail_Instock() {
		return product_Detail_Instock;
	}
	public void setProduct_Detail_Instock(Integer product_Detail_Instock) {
		this.product_Detail_Instock = product_Detail_Instock;
	}
	public Integer getProduct_Detail_Saftystock() {
		return product_Detail_Saftystock;
	}
	public void setProduct_Detail_Saftystock(Integer product_Detail_Saftystock) {
		this.product_Detail_Saftystock = product_Detail_Saftystock;
	}
	public java.sql.Date getProduct_Detail_Date() {
		return product_Detail_Date;
	}
	public void setProduct_Detail_Date(java.sql.Date product_Detail_Date) {
		this.product_Detail_Date = product_Detail_Date;
	}
	@Override
	public String toString() {
		return "Product_DetailVO [product_Detail_ID=" + product_Detail_ID + ", product_ID=" + product_ID
				+ ", product_Detail_Spc=" + product_Detail_Spc + ", product_Detail_Money=" + product_Detail_Money
				+ ", product_Detail_Instock=" + product_Detail_Instock + ", product_Detail_Saftystock="
				+ product_Detail_Saftystock + ", product_Detail_Date=" + product_Detail_Date + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((product_Detail_Date == null) ? 0 : product_Detail_Date.hashCode());
		result = prime * result + ((product_Detail_ID == null) ? 0 : product_Detail_ID.hashCode());
		result = prime * result + ((product_Detail_Instock == null) ? 0 : product_Detail_Instock.hashCode());
		result = prime * result + ((product_Detail_Money == null) ? 0 : product_Detail_Money.hashCode());
		result = prime * result + ((product_Detail_Saftystock == null) ? 0 : product_Detail_Saftystock.hashCode());
		result = prime * result + ((product_Detail_Spc == null) ? 0 : product_Detail_Spc.hashCode());
		result = prime * result + ((product_ID == null) ? 0 : product_ID.hashCode());
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
		ProductDetailVO other = (ProductDetailVO) obj;
		if (product_Detail_Date == null) {
			if (other.product_Detail_Date != null)
				return false;
		} else if (!product_Detail_Date.equals(other.product_Detail_Date))
			return false;
		if (product_Detail_ID == null) {
			if (other.product_Detail_ID != null)
				return false;
		} else if (!product_Detail_ID.equals(other.product_Detail_ID))
			return false;
		if (product_Detail_Instock == null) {
			if (other.product_Detail_Instock != null)
				return false;
		} else if (!product_Detail_Instock.equals(other.product_Detail_Instock))
			return false;
		if (product_Detail_Money == null) {
			if (other.product_Detail_Money != null)
				return false;
		} else if (!product_Detail_Money.equals(other.product_Detail_Money))
			return false;
		if (product_Detail_Saftystock == null) {
			if (other.product_Detail_Saftystock != null)
				return false;
		} else if (!product_Detail_Saftystock.equals(other.product_Detail_Saftystock))
			return false;
		if (product_Detail_Spc == null) {
			if (other.product_Detail_Spc != null)
				return false;
		} else if (!product_Detail_Spc.equals(other.product_Detail_Spc))
			return false;
		if (product_ID == null) {
			if (other.product_ID != null)
				return false;
		} else if (!product_ID.equals(other.product_ID))
			return false;
		return true;
	}
}
