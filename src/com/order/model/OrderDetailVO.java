package com.order.model;

import java.io.Serializable;

public class OrderDetailVO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String order_Detail_ID;
	private String Order_Master_ID;
	private String product_Detail_ID;
	private Integer order_Detail_Qty;
	private Integer order_Detail_Used_Qty;
	
	public String getOrder_Detail_ID() {
		return order_Detail_ID;
	}
	public void setOrder_Detail_ID(String order_Detail_ID) {
		this.order_Detail_ID = order_Detail_ID;
	}
	public String getOrder_Master_ID() {
		return Order_Master_ID;
	}
	public void setOrder_Master_ID(String order_Master_ID) {
		Order_Master_ID = order_Master_ID;
	}
	public String getProduct_Detail_ID() {
		return product_Detail_ID;
	}
	public void setProduct_Detail_ID(String product_Detail_ID) {
		this.product_Detail_ID = product_Detail_ID;
	}
	public Integer getOrder_Detail_Qty() {
		return order_Detail_Qty;
	}
	public void setOrder_Detail_Qty(Integer order_Detail_Qty) {
		this.order_Detail_Qty = order_Detail_Qty;
	}
	public Integer getOrder_Detail_Used_Qty() {
		return order_Detail_Used_Qty;
	}
	public void setOrder_Detail_Used_Qty(Integer order_Detail_Used_Qty) {
		this.order_Detail_Used_Qty = order_Detail_Used_Qty;
	}
	@Override
	public String toString() {
		return "Order_DetailVO [order_Detail_ID=" + order_Detail_ID + ", Order_Master_ID=" + Order_Master_ID
				+ ", product_Detail_ID=" + product_Detail_ID + ", order_Detail_Qty=" + order_Detail_Qty
				+ ", order_Detail_Used_Qty=" + order_Detail_Used_Qty + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((Order_Master_ID == null) ? 0 : Order_Master_ID.hashCode());
		result = prime * result + ((order_Detail_ID == null) ? 0 : order_Detail_ID.hashCode());
		result = prime * result + ((order_Detail_Qty == null) ? 0 : order_Detail_Qty.hashCode());
		result = prime * result + ((order_Detail_Used_Qty == null) ? 0 : order_Detail_Used_Qty.hashCode());
		result = prime * result + ((product_Detail_ID == null) ? 0 : product_Detail_ID.hashCode());
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
		OrderDetailVO other = (OrderDetailVO) obj;
		if (Order_Master_ID == null) {
			if (other.Order_Master_ID != null)
				return false;
		} else if (!Order_Master_ID.equals(other.Order_Master_ID))
			return false;
		if (order_Detail_ID == null) {
			if (other.order_Detail_ID != null)
				return false;
		} else if (!order_Detail_ID.equals(other.order_Detail_ID))
			return false;
		if (order_Detail_Qty == null) {
			if (other.order_Detail_Qty != null)
				return false;
		} else if (!order_Detail_Qty.equals(other.order_Detail_Qty))
			return false;
		if (order_Detail_Used_Qty == null) {
			if (other.order_Detail_Used_Qty != null)
				return false;
		} else if (!order_Detail_Used_Qty.equals(other.order_Detail_Used_Qty))
			return false;
		if (product_Detail_ID == null) {
			if (other.product_Detail_ID != null)
				return false;
		} else if (!product_Detail_ID.equals(other.product_Detail_ID))
			return false;
		return true;
	}
}
