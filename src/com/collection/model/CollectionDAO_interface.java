package com.collection.model;

import java.util.List;
import java.util.Set;

public interface CollectionDAO_interface {
	public CollectionVO getOne(String collection_Number);
	public List<CollectionVO> getAll();
	public CollectionVO insert(CollectionVO collection);
	public Integer delete(String collection_ID);
	public Set<CollectionVO>getCollectionByMemberID(String member_ID);
}
