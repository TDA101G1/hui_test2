package com.product.model;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

import com.customerizedetail.model.CustDetailVO;
import com.productcmt.model.ProductCmtVO;

public class ProductVO implements Serializable, Comparable<ProductVO>{
	private static final long serialVersionUID = 1L;
	private String product_ID;
	private String product_Name;
	private String product_Intro;
	private Double product_Staytime;
	private String product_Address;
	private Double product_Latitutde;
	private Double product_Longitude;
	private String product_County;
	private String product_Class;
	private String product_Style;
	private Integer product_Seq;
	private Integer product_State;
	private Integer product_Sale_Rec;
	private Integer product_Click_Rec;
	private String product_Info;
	private String product_Total_Schedule;
	private byte[] product_Img1;
	private byte[] product_Img2;
	private byte[] product_Img3;
	private byte[] product_Img4;
	private byte[] product_Img5;
	 
	private ProductCmtVO productCmtVO; 
	public ProductCmtVO getProductCmtVO() {
		return productCmtVO;
	}
	public void setProductCmtVO(ProductCmtVO productCmtVO) {
		this.productCmtVO = productCmtVO;
	}
	
	private List<ProductDetailVO> productDetailVOs;
	public List<ProductDetailVO> getProductDetailVOs() {
		return productDetailVOs;
	}
	public void setProductDetailVOs(List<ProductDetailVO> productDetailVOs) {
		this.productDetailVOs = productDetailVOs;
	}


	
	public String getProduct_ID() {
		return product_ID;
	}
	public void setProduct_ID(String product_ID) {
		this.product_ID = product_ID;
	}
	public String getProduct_Name() {
		return product_Name;
	}
	public void setProduct_Name(String product_Name) {
		this.product_Name = product_Name;
	}
	public String getProduct_Intro() {
		return product_Intro;
	}
	public void setProduct_Intro(String product_Intro) {
		this.product_Intro = product_Intro;
	}
	public Double getProduct_Staytime() {
		return product_Staytime;
	}
	public void setProduct_Staytime(Double product_Staytime) {
		this.product_Staytime = product_Staytime;
	}
	public String getProduct_Address() {
		return product_Address;
	}
	public void setProduct_Address(String product_Address) {
		this.product_Address = product_Address;
	}
	public Double getProduct_Latitutde() {
		return product_Latitutde;
	}
	public void setProduct_Latitutde(Double product_Latitutde) {
		this.product_Latitutde = product_Latitutde;
	}
	public Double getProduct_Longitude() {
		return product_Longitude;
	}
	public void setProduct_Longitude(Double product_Longitude) {
		this.product_Longitude = product_Longitude;
	}
	public String getProduct_County() {
		return product_County;
	}
	public void setProduct_County(String product_County) {
		this.product_County = product_County;
	}
	public String getProduct_Class() {
		return product_Class;
	}
	public void setProduct_Class(String product_Class) {
		this.product_Class = product_Class;
	}
	public String getProduct_Style() {
		return product_Style;
	}
	public void setProduct_Style(String product_Style) {
		this.product_Style = product_Style;
	}
	public Integer getProduct_Seq() {
		return product_Seq;
	}
	public void setProduct_Seq(Integer product_Seq) {
		this.product_Seq = product_Seq;
	}
	public Integer getProduct_State() {
		return product_State;
	}
	public void setProduct_State(Integer product_State) {
		this.product_State = product_State;
	}
	public Integer getProduct_Sale_Rec() {
		return product_Sale_Rec;
	}
	public void setProduct_Sale_Rec(Integer product_Sale_Rec) {
		this.product_Sale_Rec = product_Sale_Rec;
	}
	public Integer getProduct_Click_Rec() {
		return product_Click_Rec;
	}
	public void setProduct_Click_Rec(Integer product_Click_Rec) {
		this.product_Click_Rec = product_Click_Rec;
	}
	public String getProduct_Info() {
		return product_Info;
	}
	public void setProduct_Info(String product_Info) {
		this.product_Info = product_Info;
	}
	public String getProduct_Total_Schedule() {
		return product_Total_Schedule;
	}
	public void setProduct_Total_Schedule(String product_Total_Schedule) {
		this.product_Total_Schedule = product_Total_Schedule;
	}
	public byte[] getProduct_Img1() {
		return product_Img1;
	}
	public void setProduct_Img1(byte[] product_Img1) {
		this.product_Img1 = product_Img1;
	}
	public byte[] getProduct_Img2() {
		return product_Img2;
	}
	public void setProduct_Img2(byte[] product_Img2) {
		this.product_Img2 = product_Img2;
	}
	public byte[] getProduct_Img3() {
		return product_Img3;
	}
	public void setProduct_Img3(byte[] product_Img3) {
		this.product_Img3 = product_Img3;
	}
	public byte[] getProduct_Img4() {
		return product_Img4;
	}
	public void setProduct_Img4(byte[] product_Img4) {
		this.product_Img4 = product_Img4;
	}
	public byte[] getProduct_Img5() {
		return product_Img5;
	}
	public void setProduct_Img5(byte[] product_Img5) {
		this.product_Img5 = product_Img5;
	}
	@Override
	public String toString() {
		return "ProductVO [product_ID=" + product_ID + ", product_Name=" + product_Name + ", product_Intro="
				+ product_Intro + ", product_Staytime=" + product_Staytime + ", product_Address=" + product_Address
				+ ", product_Latitutde=" + product_Latitutde + ", product_Longitude=" + product_Longitude
				+ ", product_County=" + product_County + ", product_Class=" + product_Class + ", product_Style="
				+ product_Style + ", product_Seq=" + product_Seq + ", product_State=" + product_State
				+ ", product_Sale_Rec=" + product_Sale_Rec + ", product_Click_Rec=" + product_Click_Rec
				+ ", product_Info=" + product_Info + ", product_Total_Schedule=" + product_Total_Schedule;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((product_Address == null) ? 0 : product_Address.hashCode());
		result = prime * result + ((product_Class == null) ? 0 : product_Class.hashCode());
		result = prime * result + ((product_Click_Rec == null) ? 0 : product_Click_Rec.hashCode());
		result = prime * result + ((product_County == null) ? 0 : product_County.hashCode());
		result = prime * result + ((product_ID == null) ? 0 : product_ID.hashCode());
		result = prime * result + Arrays.hashCode(product_Img1);
		result = prime * result + Arrays.hashCode(product_Img2);
		result = prime * result + Arrays.hashCode(product_Img3);
		result = prime * result + Arrays.hashCode(product_Img4);
		result = prime * result + Arrays.hashCode(product_Img5);
		result = prime * result + ((product_Info == null) ? 0 : product_Info.hashCode());
		result = prime * result + ((product_Intro == null) ? 0 : product_Intro.hashCode());
		result = prime * result + ((product_Latitutde == null) ? 0 : product_Latitutde.hashCode());
		result = prime * result + ((product_Longitude == null) ? 0 : product_Longitude.hashCode());
		result = prime * result + ((product_Name == null) ? 0 : product_Name.hashCode());
		result = prime * result + ((product_Sale_Rec == null) ? 0 : product_Sale_Rec.hashCode());
		result = prime * result + ((product_Seq == null) ? 0 : product_Seq.hashCode());
		result = prime * result + ((product_State == null) ? 0 : product_State.hashCode());
		result = prime * result + ((product_Staytime == null) ? 0 : product_Staytime.hashCode());
		result = prime * result + ((product_Style == null) ? 0 : product_Style.hashCode());
		result = prime * result + ((product_Total_Schedule == null) ? 0 : product_Total_Schedule.hashCode());
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
		ProductVO other = (ProductVO) obj;
		if (product_Address == null) {
			if (other.product_Address != null)
				return false;
		} else if (!product_Address.equals(other.product_Address))
			return false;
		if (product_Class == null) {
			if (other.product_Class != null)
				return false;
		} else if (!product_Class.equals(other.product_Class))
			return false;
		if (product_Click_Rec == null) {
			if (other.product_Click_Rec != null)
				return false;
		} else if (!product_Click_Rec.equals(other.product_Click_Rec))
			return false;
		if (product_County == null) {
			if (other.product_County != null)
				return false;
		} else if (!product_County.equals(other.product_County))
			return false;
		if (product_ID == null) {
			if (other.product_ID != null)
				return false;
		} else if (!product_ID.equals(other.product_ID))
			return false;
		if (!Arrays.equals(product_Img1, other.product_Img1))
			return false;
		if (!Arrays.equals(product_Img2, other.product_Img2))
			return false;
		if (!Arrays.equals(product_Img3, other.product_Img3))
			return false;
		if (!Arrays.equals(product_Img4, other.product_Img4))
			return false;
		if (!Arrays.equals(product_Img5, other.product_Img5))
			return false;
		if (product_Info == null) {
			if (other.product_Info != null)
				return false;
		} else if (!product_Info.equals(other.product_Info))
			return false;
		if (product_Intro == null) {
			if (other.product_Intro != null)
				return false;
		} else if (!product_Intro.equals(other.product_Intro))
			return false;
		if (product_Latitutde == null) {
			if (other.product_Latitutde != null)
				return false;
		} else if (!product_Latitutde.equals(other.product_Latitutde))
			return false;
		if (product_Longitude == null) {
			if (other.product_Longitude != null)
				return false;
		} else if (!product_Longitude.equals(other.product_Longitude))
			return false;
		if (product_Name == null) {
			if (other.product_Name != null)
				return false;
		} else if (!product_Name.equals(other.product_Name))
			return false;
		if (product_Sale_Rec == null) {
			if (other.product_Sale_Rec != null)
				return false;
		} else if (!product_Sale_Rec.equals(other.product_Sale_Rec))
			return false;
		if (product_Seq == null) {
			if (other.product_Seq != null)
				return false;
		} else if (!product_Seq.equals(other.product_Seq))
			return false;
		if (product_State == null) {
			if (other.product_State != null)
				return false;
		} else if (!product_State.equals(other.product_State))
			return false;
		if (product_Staytime == null) {
			if (other.product_Staytime != null)
				return false;
		} else if (!product_Staytime.equals(other.product_Staytime))
			return false;
		if (product_Style == null) {
			if (other.product_Style != null)
				return false;
		} else if (!product_Style.equals(other.product_Style))
			return false;
		if (product_Total_Schedule == null) {
			if (other.product_Total_Schedule != null)
				return false;
		} else if (!product_Total_Schedule.equals(other.product_Total_Schedule))
			return false;
		return true;
	}
	@Override
	public int compareTo(ProductVO obj) {
		System.out.println(this.product_ID.compareTo(obj.product_ID));
		return this.product_ID.compareTo(obj.product_ID);
	}

}
