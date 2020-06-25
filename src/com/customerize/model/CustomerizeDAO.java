package com.customerize.model;

import java.util.List;

public interface CustomerizeDAO {
	public CustomerizeVO insert(CustomerizeVO custVO);
	public CustomerizeVO update(CustomerizeVO custVO);
	public boolean delete(String cust_Schedule_ID);
	public CustomerizeVO select(String cust_Schedule_ID);
	public List<CustomerizeVO> getAll();
}
