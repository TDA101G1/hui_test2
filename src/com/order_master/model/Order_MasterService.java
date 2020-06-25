package com.order_master.model;

import java.util.List;
import java.util.Set;

import com.order.model.OrderDetailVO;
public class Order_MasterService {
	private Order_MasterDAO_interface dao;
	public Order_MasterService() {
		this.dao = new Order_MasterDAO_JDBC();
	}
	
	public Order_MasterVO getOne(String order_Master_ID) {
		if(order_Master_ID != null) {
			return dao.select(order_Master_ID);
			
		}
		return null;
	}
	
	public List<Order_MasterVO> getAll(){
		return dao.selectAll();
	}
	public Set<Order_MasterVO> getOrderMasterByMemberID(String member_ID){
		if(member_ID != null) {
			
			return dao.selectByMember(member_ID);
		}
		return null;
	}

	public Order_MasterVO addOrder_Master(String member_ID, String coupon_ID, String order_Master_Payment,
			Integer order_Master_State) {
		if (order_Master_Payment != null && order_Master_State != null && member_ID != null) {
			Order_MasterVO OM = new Order_MasterVO();
			OM.setCoupon_ID(coupon_ID);
			OM.setMember_ID(member_ID);
			OM.setOrder_Master_Payment(order_Master_Payment);
			OM.setOrder_Master_State(order_Master_State);

			dao.insert(OM);

			return OM;

		}
		return null;
	}

	// 新增的
	public String inserWithOrder_Ditel(Order_MasterVO omVO, List<OrderDetailVO> list) {
		if(omVO != null && list != null && list.size()>0) {
			return dao.inserWithOrder_Ditel(omVO, list);
		}
		return "fail to insert Order";
	}
	
	public Order_MasterVO updateOrder_Master_State(String order_Master_ID) {
		if(!dao.select(order_Master_ID).getOrder_Master_State().equals(1)) {
			return null;
		}else {
			return dao.updateOrderMasterWithProdetail(order_Master_ID);
		}
	}
	
	public Order_MasterVO  update(Order_MasterVO order_Master){
		if(order_Master != null){
		
			return dao.update(order_Master);
		}
		return null;
	}
	
//	public Order_MasterVO updateOrder_Master(String order_Master_ID, String member_ID, String coupon_ID, String order_Master_Payment, java.sql.Timestamp order_Master_TimeStamp, Integer order_Master_State) {
//		Order_MasterVO OM = new Order_MasterVO();
//		OM.setCoupon_ID(coupon_ID);
//		OM.setMember_ID(member_ID);
//		OM.setOrder_Master_ID(order_Master_ID);
//		OM.setOrder_Master_Payment(order_Master_Payment);
//		OM.setOrder_Master_State(order_Master_State);
//		OM.setOrder_Master_TimeStamp(order_Master_TimeStamp);
//		dao.update(OM);
//		return OM;
//	}
	
	public static void main(String[] args) {
		Order_MasterService dao = new Order_MasterService();
//		System.out.println(dao.getOne("OMID00010"));
//		System.out.println(dao.getAll());
//		System.out.println(dao.getOrderMasterByMemberID("MID000000"));
//		System.out.println(dao.addOrder_Master("MID000000", "CNID000000", "信用卡", 1));
//		dao.updateOrder_Master("OMID000020", "MID000000", "CNID000000", "信用卡1", null, 0);
		System.out.println(dao.updateOrder_Master_State("OMID000010"));
		
	}
	
}
