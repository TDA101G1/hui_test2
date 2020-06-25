package com.customerizedetail.model;

import java.sql.Date;
import java.util.List;
import java.util.Map;

public class CustDetailService {
	private CustDetailDAO dao;
	
	public CustDetailService() {
		dao = new CustDetailDAO_JDBC();
	}
	
	public CustDetailVO insert(CustDetailVO custDetailVO) {
		CustDetailVO cust = null;
		if(custDetailVO != null) {
			cust = dao.insert(custDetailVO);
		}
		return cust;
	}
	
	public CustDetailVO update(CustDetailVO custDetailVO) {
		CustDetailVO cust = null;
		if(custDetailVO != null) {
			cust = dao.update(custDetailVO);
		}
		return cust;
	}
	
	public boolean delete(CustDetailVO custDetailVO) {
		boolean cust = false;
		if(custDetailVO != null) {
			cust = dao.delete(custDetailVO.getCust_Schedule_ID());
		}
		return cust;
	}
	
	public CustDetailVO select(CustDetailVO custDetailVO) {
		return dao.select(custDetailVO.getCust_Schedule_Detail_ID());
	}
	
	public List<CustDetailVO> select_by_schedule(String cust_Schedule_ID){
		return dao.select_by_schedule(cust_Schedule_ID);
	}
	
	public List<CustDetailVO> getAll() {
		return dao.getAll();
	}
	
	public List<CustDetailVO> get_detail_join_product(Map<String, String[]> map) {
		return dao.get_detail_join_product(map);
	}
	
	public static void main(String[] args) {
		CustDetailService service = new CustDetailService();
		CustDetailVO VO = new CustDetailVO();
		VO.setCust_Schedule_Detail_ID("CSD000015");
		VO.setCust_Schedule_ID("CID000003");
		VO.setProduct_ID("PID000004");
		VO.setCust_Schedule_Detail_Seq(6);
		VO.setCust_Schedule_Detail_Date(Date.valueOf("2020-08-01"));
		VO.setCust_Schedule_Detail_Info("2200床上躺平趕快睡覺1453453");
		//System.out.println(service.insert(VO));
		System.out.println(service.getAll());
	}
	
}
