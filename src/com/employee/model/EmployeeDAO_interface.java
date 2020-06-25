package com.employee.model;

import java.util.List;

public interface EmployeeDAO_interface {
	public EmployeeVO insert(EmployeeVO employeeVO);

	public void update(EmployeeVO employeeVO);

	public void delete(String emp_ID);

	public EmployeeVO getOne(String emp_ID);

	public List<EmployeeVO> getAll();
	
	public EmployeeVO select(String emp_Account );
}
