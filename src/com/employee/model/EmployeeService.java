package com.employee.model;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import com.coupon.model.CouponVO;

public class EmployeeService {

	private EmployeeDAO_interface dao;

	public EmployeeService() {
		dao = new EmployeeDAO_JDBC();
	}

	public EmployeeVO insert(EmployeeVO employeeVO) {

		EmployeeVO employee = null;
		if (employeeVO != null) {
			employee = dao.insert(employeeVO);
		}

		return employee;

	}

	public EmployeeVO update(String emp_ID, String emp_Account, String emp_Pwd, String emp_Grade, String emp_Name,
			String emp_Sex, java.sql.Date emp_Birth, String emp_Mail, String emp_Phone, String emp_Address,
			java.sql.Date emp_Est_Time, byte[] emp_Img, Integer emp_State) {

		EmployeeVO employeeVO = new EmployeeVO();

		employeeVO.setEmp_ID(emp_ID);
		employeeVO.setEmp_Account(emp_Account);
		employeeVO.setEmp_Pwd(emp_Pwd);
		employeeVO.setEmp_Grade(emp_Grade);
		employeeVO.setEmp_Name(emp_Name);
		employeeVO.setEmp_Sex(emp_Sex);
		employeeVO.setEmp_Birth(emp_Birth);
		employeeVO.setEmp_Mail(emp_Mail);
		employeeVO.setEmp_Phone(emp_Phone);
		employeeVO.setEmp_Address(emp_Address);
		employeeVO.setEmp_Est_Time(emp_Est_Time);
		employeeVO.setEmp_Img(emp_Img);
		employeeVO.setEmp_State(emp_State);

		dao.update(employeeVO);

		return employeeVO;

	}

	public EmployeeVO login(String emp_Account, String emp_Pwd) {

		EmployeeVO employeeVO = dao.select(emp_Account);
		if (employeeVO != null) {
			if (emp_Pwd != null && emp_Pwd.trim().length() != 0) {
				String pass = employeeVO.getEmp_Pwd();
				if (pass.equals(emp_Pwd)) {
					return employeeVO;
				}
			}
		}
		return employeeVO;
	}
	
	

	public void delete(String emp_ID) {
		dao.delete(emp_ID);
	}

	public EmployeeVO getOne(String emp_ID) {
		return dao.getOne(emp_ID);
	}
	
	public EmployeeVO getOneNoImg(String emp_ID) {
		return dao.getOneNoImg(emp_ID);
	}

	public List<EmployeeVO> getAll() {
		return dao.getAll();
	}

	public static void main(String[] args) {
		EmployeeService dao = new EmployeeService();

		EmployeeVO VO = new EmployeeVO();

		java.util.Date du = new java.util.Date();

		long aa = du.getTime();

		java.sql.Date date = new java.sql.Date(aa);

		byte[] image = null;
		try {
			FileInputStream fin = new FileInputStream("C:\\Users\\User\\Desktop\\S__17367045.jpg");
			BufferedInputStream bin = new BufferedInputStream(fin);
			image = new byte[bin.available()];
			fin.read(image);
		} catch (IOException e) {
			e.printStackTrace();
		}

//		VO.setEmp_Account("9999");
//		VO.setEmp_Pwd("22");
//		VO.setEmp_Grade("3");
//		VO.setEmp_Name("454");
//		VO.setEmp_Sex("5");
//		VO.setEmp_Birth(date);
//		VO.setEmp_Mail("11");
//		VO.setEmp_Phone("000");
//		VO.setEmp_Address("456456");
//		VO.setEmp_Est_Time(date);
//		VO.setEmp_Img(image);
//		VO.setEmp_State(1);

//		System.out.println(dao.insert(VO));
		
//		System.out.println(dao.login("ALEX","alex"));

		System.out.println(dao.getAll());

//		System.out.println(dao.getOne("EID000013"));

//		dao.insert("5", "1", "1", "1", "1", date, "1", "1", "1", date, null, 1);
//		dao.update("E000000","123123", "1", "1", "1", "1", date, "1", "1", "1", date, null, 1);

//	System.out.println(dao.getAll());
	}

}
