package com.product.model;

import java.sql.Connection;
import java.util.List;

import com.order.model.OrderDetailVO;

public interface ProductDetailDAO {
	public ProductDetailVO insert(ProductDetailVO ProductDetailVO, ProductVO productVO);
	public Integer update(ProductDetailVO productDetailVO);
	public Integer delete(String productDetail_ID);
	public ProductDetailVO select(String productDetail_ID);
	public List<ProductDetailVO> getAll();
	public String getPriceRange(String product_ID);
	public void updateWithStock(ProductDetailVO productDetailVO, java.sql.Connection con);
	
		//新加的
	public void update2(ProductDetailVO productDetailVO, Connection con);
	public void insert2(ProductDetailVO productDetailVO, Connection con);
}
