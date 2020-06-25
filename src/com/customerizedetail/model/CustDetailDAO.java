package com.customerizedetail.model;

import java.util.List;
import java.util.Map;

public interface CustDetailDAO {
	public CustDetailVO insert(CustDetailVO custDetailVO);
	public CustDetailVO update(CustDetailVO custDetailVO);
	public boolean delete(String cust_Schedule_Detail_ID);
	public CustDetailVO select(String cust_Schedule_Detail_ID);
	public List<CustDetailVO> select_by_schedule(String cust_Schedule_ID);
	public List<CustDetailVO> getAll();
	public List<CustDetailVO> get_detail_join_product(Map<String, String[]> map);
}
