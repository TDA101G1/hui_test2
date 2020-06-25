package com.productcmt.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Arrays;

import com.member.model.MemberVO;

public class ProductCmtVO implements Serializable{
	private String product_Cmt_ID;
	private String product_ID;
	private String member_ID;
	private Double product_Cmt_Grade;      //Integer
	private String product_Cmt_Info;
	private byte[] product_Cmt_Img1;
	private byte[] product_Cmt_Img2;
	private Timestamp product_Cmt_Timestamp;
	
	private MemberVO memberVO;
	
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	
	private Long count;
	public Long getCount() {
		return count;
	}
	public void setCount(Long count) {
		this.count = count;
	}
	public String getProduct_Cmt_ID() {
		return product_Cmt_ID;
	}
	public void setProduct_Cmt_ID(String product_Cmt_ID) {
		this.product_Cmt_ID = product_Cmt_ID;
	}
	public String getProduct_ID() {
		return product_ID;
	}
	public void setProduct_ID(String product_ID) {
		this.product_ID = product_ID;
	}
	public String getMember_ID() {
		return member_ID;
	}
	public void setMember_ID(String member_ID) {
		this.member_ID = member_ID;
	}
	public Double getProduct_Cmt_Grade() {
		return product_Cmt_Grade;
	}
	public void setProduct_Cmt_Grade(Double product_Cmt_Grade) {
		this.product_Cmt_Grade = product_Cmt_Grade;
	}
	public String getProduct_Cmt_Info() {
		return product_Cmt_Info;
	}
	public void setProduct_Cmt_Info(String product_Cmt_Info) {
		this.product_Cmt_Info = product_Cmt_Info;
	}
	public byte[] getProduct_Cmt_Img1() {
		return product_Cmt_Img1;
	}
	public void setProduct_Cmt_Img1(byte[] product_Cmt_Img1) {
		this.product_Cmt_Img1 = product_Cmt_Img1;
	}
	public byte[] getProduct_Cmt_Img2() {
		return product_Cmt_Img2;
	}
	public void setProduct_Cmt_Img2(byte[] product_Cmt_Img2) {
		this.product_Cmt_Img2 = product_Cmt_Img2;
	}
	public Timestamp getProduct_Cmt_Timestamp() {
		return product_Cmt_Timestamp;
	}
	public void setProduct_Cmt_Timestamp(Timestamp product_Cmt_Timestamp) {
		this.product_Cmt_Timestamp = product_Cmt_Timestamp;
	}
	
	@Override
	public String toString() {
		return "ProductCmtVO [product_Cmt_ID=" + product_Cmt_ID + ", product_ID=" + product_ID + ", member_ID="
				+ member_ID + ", product_Cmt_Grade=" + product_Cmt_Grade + ", product_Cmt_Info=" + product_Cmt_Info
				+ ", count=" + count + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((member_ID == null) ? 0 : member_ID.hashCode());
		result = prime * result + ((product_Cmt_ID == null) ? 0 : product_Cmt_ID.hashCode());
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
		ProductCmtVO other = (ProductCmtVO) obj;
		if (member_ID == null) {
			if (other.member_ID != null)
				return false;
		} else if (!member_ID.equals(other.member_ID))
			return false;
		if (product_Cmt_ID == null) {
			if (other.product_Cmt_ID != null)
				return false;
		} else if (!product_Cmt_ID.equals(other.product_Cmt_ID))
			return false;
		return true;
	}
}
