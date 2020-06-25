package com.coupon.model;

import java.util.List;

import com.coupon.model.CouponVO;

public interface CouponDAO_interface {

	public CouponVO insert(CouponVO couponVO);

	public void update(CouponVO couponVO);

	public void delete(String coupon_ID);

	public CouponVO getOne(String coupon_ID);

	public List<CouponVO> getAll();
}
