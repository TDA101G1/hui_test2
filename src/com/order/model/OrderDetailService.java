package com.order.model;

import java.util.List;

import com.order_master.model.Order_MasterVO;
import com.product.model.ProductDetailVO;

public class OrderDetailService {
	private OrderDetailDAO dao;

	public OrderDetailService() {
		dao = new OrderDetailDAO_JDBC();
	}

	public OrderDetailVO inset(OrderDetailVO orderDetailVO, Order_MasterVO orderMasterVO,
			ProductDetailVO productDetailVO) {
		if (orderDetailVO != null && orderMasterVO != null && productDetailVO != null) {
			OrderDetailVO rderDetail = dao.insert(orderDetailVO, orderMasterVO, productDetailVO);
			return rderDetail;
		}
		return null;
	}

	public Integer update(OrderDetailVO orderDetailVO) {
		if (orderDetailVO != null) {
			Integer count = dao.update(orderDetailVO);
			return count;
		}
		return new Integer(-1);
	}

	public Integer delete(OrderDetailVO orderDetailVO) {
		if (orderDetailVO != null) {
			Integer count = dao.delete(orderDetailVO.getOrder_Detail_ID());
			return count;
		}
		return new Integer(-1);
	}

	public OrderDetailVO select(OrderDetailVO orderDetailVO) {
		if (orderDetailVO != null) {
			OrderDetailVO orderDetail = dao.select(orderDetailVO.getOrder_Detail_ID());
			return orderDetail;
		}
		return null;
	}

	public List<OrderDetailVO> getAll() {
		return dao.getAll();
	}

	public static void main(String[] args) {
//		OrderDetailService service = new OrderDetailService();
//		OrderDetailVO orderDetailVO = new OrderDetailVO();
//		Order_MasterVO order_MasterVO = new Order_MasterVO();
//		ProductDetailVO productDetailVO = new ProductDetailVO();
//		order_MasterVO.setOrder_Master_ID("OMID000001");
//		productDetailVO.setProduct_Detail_ID("PDID000001");
//
//		orderDetailVO.setOrder_Detail_ID("ODID000001");
//		orderDetailVO.setOrder_Master_ID(order_MasterVO.getOrder_Master_ID());
//		orderDetailVO.setProduct_Detail_ID(productDetailVO.getProduct_Detail_ID());
//		orderDetailVO.setOrder_Detail_Qty((int) (Math.random() * 100));
//		orderDetailVO.setOrder_Detail_Used_Qty((int) (Math.random() * 100));
//		
//		System.out.println(service.inset(orderDetailVO, order_MasterVO, productDetailVO));
//		System.out.println(service.update(orderDetailVO));
////		System.out.println(service.delete(orderDetailVO));
//		System.out.println(service.select(orderDetailVO));
//		service.getAll().forEach(System.out::println);
		
	}
}
