package com.order.model;

import java.sql.Connection;
import java.util.List;

import com.order_master.model.Order_MasterVO;
import com.product.model.ProductDetailVO;

public interface OrderDetailDAO {
	public OrderDetailVO insert(OrderDetailVO orderDetailVO, Order_MasterVO orderMasterVO, ProductDetailVO productDetailVO);
	public Integer update(OrderDetailVO orderDetailVO);
	public Integer delete(String orderDetailVO_ID);
	public OrderDetailVO select(String orderDetailVO_ID);
	public List<OrderDetailVO> getAll();
	//新加的
	public void insert2(OrderDetailVO orderDetailVO, Connection con);
}
