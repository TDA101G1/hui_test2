package com.collection.model;

public class CollectionVO {
	private String collection_ID;
	private String member_ID;
	private String product_ID;
	@Override
	public String toString() {
		return "CollectionVO [collection_ID=" + collection_ID + ", member_ID=" + member_ID + ", product_ID="
				+ product_ID + "]";
	}
	public String getCollection_ID() {
		return collection_ID;
	}
	public void setCollection_ID(String collection_ID) {
		this.collection_ID = collection_ID;
	}
	public String getMember_ID() {
		return member_ID;
	}
	public void setMember_ID(String member_ID) {
		this.member_ID = member_ID;
	}
	public String getProduct_ID() {
		return product_ID;
	}
	public void setProduct_ID(String product_ID) {
		this.product_ID = product_ID;
	}
}
