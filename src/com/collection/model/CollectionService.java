package com.collection.model;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Stream;

public class CollectionService {
	private CollectionDAO_interface dao;

	public CollectionService() {
		this.dao = new CollectionDAO_JDBC();
	}

	public String addCollection(String member_ID, String product_ID) {
		if (member_ID != null && product_ID != null) {
			Optional<CollectionVO> existCollection = getCollectionByMemberID(member_ID).stream()
			.filter(c -> c.getProduct_ID().equals(product_ID))
			.findFirst();
			
			if(existCollection.isPresent()) {
				String collection_ID = existCollection.get().getCollection_ID();
				Integer deleteCollection = deleteCollection(collection_ID);
				System.out.println("收藏被移除的筆數: "+deleteCollection);
				return "移除";
			}else {
				CollectionVO collection = new CollectionVO();
				collection.setMember_ID(member_ID);
				collection.setProduct_ID(product_ID);
				collection = dao.insert(collection);
				System.out.println(member_ID+"收藏了"+product_ID);
				return "增加";
			}
		}
		return "";
	}

	public Integer deleteCollection(String collection_ID) {
		if(collection_ID != null) {
			return dao.delete(collection_ID);
			
		}
		return null;
	}

	public CollectionVO getOne(String collection_ID) {
		if(collection_ID != null) {
			return dao.getOne(collection_ID);
		}
		return null;

	}

	public List<CollectionVO> getAll() {
		return dao.getAll();
	}

	public Set<CollectionVO> getCollectionByMemberID(String member_ID) {
		if(member_ID != null) {
			
			return dao.getCollectionByMemberID(member_ID);
		}
		return null;
	}

	public static void main(String[] args) {
		CollectionService dao = new CollectionService();
		System.out.println(dao.getAll());
		System.out.println(dao.getOne("COID000023"));
		System.out.println(dao.getCollectionByMemberID("MID000000"));

		System.out.println(dao.deleteCollection("COID000001"));
//		System.out.println(dao.addCollection("MID000000", "PID000000"));
	}

}
