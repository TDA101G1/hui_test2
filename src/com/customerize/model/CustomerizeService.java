package com.customerize.model;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class CustomerizeService {
	private CustomerizeDAO dao;
	
	public CustomerizeService(){
		dao = new CustomerizeDAO_JDBC();
	}
	
	public CustomerizeVO insert(CustomerizeVO custVO) {
		CustomerizeVO cust = null;
		if(custVO != null) {
			cust = dao.insert(custVO);
		}
		return cust;
	}
	
	public CustomerizeVO update(CustomerizeVO custVO) {
		CustomerizeVO cust = null;
		if(custVO != null) {
			cust = dao.update(custVO);
		}
		return cust;
	}
	
	public boolean delete(CustomerizeVO custVO) {
		boolean result = false;
		if(custVO != null) {
			result = dao.delete(custVO.getCust_Schedule_ID());
		}
		return result;
	}
	
	public CustomerizeVO select(CustomerizeVO custVO) {
		return dao.select(custVO.getCust_Schedule_ID());
	}
	
	public List<CustomerizeVO> getAll(){
		return dao.getAll();
	}
	
	public static void main(String[] args) {
		CustomerizeService service = new CustomerizeService();
		CustomerizeVO custVO = new CustomerizeVO();
//		custVO.setCust_Schedule_ID("CID000009");
//		System.out.println(service.select(custVO));
		
//		List<CustVO> lists = service.getAll();
//		for(CustVO list: lists) {
//			System.out.println(list);
//		}
		byte[] image = null;
		try {
			FileInputStream fin = new FileInputStream("C:\\Users\\Hui\\Desktop\\�Ϥ�4.jfif");
			BufferedInputStream bin = new BufferedInputStream(fin);
			image = new byte[bin.available()];
			fin.read(image);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	
		custVO.setCust_Schedule_ID("CID000043");
		custVO.setMember_ID("MID000000");
		custVO.setCust_Schedule_Name("��456456�L�m�U����456789");
		custVO.setCust_Schedule_Click_Record(125);
		custVO.setCust_Schedule_Start_Time(Date.valueOf("2020-07-30"));
		custVO.setCust_Schedule_End_Time(Date.valueOf("2020-08-02"));
		custVO.setCust_Schedule_Total_Day(3);
		custVO.setCust_Schedule_Share(0);
		custVO.setCust_Schedule_State(1);
		custVO.setCust_Schedule_Img(image);
		System.out.println(service.insert(custVO));
		//System.out.println(service.update(custVO));
		//System.out.println(service.delete(custVO));

	}
}
