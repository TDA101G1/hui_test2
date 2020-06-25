package com.coupon.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

public class CouponService {

	private CouponDAO_interface dao;

	public CouponService() {
		dao = new CouponDAO_JDBC();
	}

	public List<CouponVO> getAll() {
		return dao.getAll();
	}

	public CouponVO insert(CouponVO couponVO) {
		CouponVO coupon = null;
		if (couponVO != null) {
			coupon = dao.insert(couponVO);
		}
		return coupon;

	}

	public CouponVO update(String coupon_ID, String emp_ID, String member_ID, String coupon_Name, Double coupon_Class,
			String coupon_Number, String coupon_Info, Integer coupon_State,Timestamp coupon_Date) {

		CouponVO couponVO = new CouponVO();

		couponVO.setCoupon_ID(coupon_ID);
		couponVO.setEmp_ID(emp_ID);
		couponVO.setMember_ID(member_ID);
		couponVO.setCoupon_Name(coupon_Name);
		couponVO.setCoupon_Class(coupon_Class);
		couponVO.setCoupon_Number(coupon_Number);
		couponVO.setCoupon_Info(coupon_Info);
		couponVO.setCoupon_State(coupon_State);
		couponVO.setCoupon_Date(coupon_Date);

		dao.update(couponVO);

		return couponVO;

	}

	public void delete(String coupon_ID) {
		dao.delete(coupon_ID);
	}

	public CouponVO getOne(String coupon_ID) {
		return dao.getOne(coupon_ID);
	}

	public List<CouponVO> getMemberCoupon(String member_ID) {
		if (member_ID != null) {
			List<CouponVO> collect = dao.getAll().stream().filter(c -> c.getMember_ID().equals(member_ID))
					.filter(c -> c.getCoupon_State() > 0).collect(Collectors.toList());
			return collect;
		}
		return null;
	}

	public static void main(String[] args) {
		CouponService dao = new CouponService();
		CouponVO VO = new CouponVO();
//		System.out.println(dao.getAll());
		VO.setCoupon_Class(0.75);
		VO.setCoupon_Info("12132");
		VO.setCoupon_Name("NAMEAAAAA");
		VO.setCoupon_Number("1233");
		VO.setCoupon_State(1);
		VO.setEmp_ID("EID000000");
		VO.setMember_ID("MID000000");
		VO.setCoupon_ID("CNID0000");
//		System.out.println(dao.getOne("CPID000005"));
//		dao.insert("E000001","1","1",0,"1","2", 1);
//		dao.delete("CPID000005");
//		dao.update("CPID000027", "E000001", "1","123123" , 1, "1", "2323", 1);
		System.out.println(dao.insert(VO));
	}

}
