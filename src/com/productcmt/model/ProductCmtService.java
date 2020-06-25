package com.productcmt.model;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.OptionalDouble;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONException;

public class ProductCmtService {
	private ProductCmtDAO dao;

	public ProductCmtService() {
		dao = new ProductCmtDAO_JDBC();
	}
	
	public ProductCmtVO insert(ProductCmtVO productCmtVO) {
		ProductCmtVO cmtVO = null;
		if(productCmtVO != null) {
			cmtVO = dao.insert(productCmtVO);
		}
		return cmtVO;
	}
	
	public ProductCmtVO update(ProductCmtVO productCmtVO) {
		ProductCmtVO cmtVO = null;
		if(productCmtVO != null) {
			cmtVO = dao.update(productCmtVO);
		}
		return cmtVO;
	}
	
	public boolean delete(ProductCmtVO productCmtVO) {
		boolean cmtVO = false;
		if(productCmtVO != null) {
			cmtVO = dao.delete(productCmtVO.getProduct_Cmt_ID());
		}
		return cmtVO;
	}
	
	public ProductCmtVO select(ProductCmtVO productCmtVO) {
		return dao.select(productCmtVO.getProduct_Cmt_ID());
	}
	
	public List<ProductCmtVO> select_by_member(String member_id) {
		return dao.select_by_member(member_id);
	}
	
	public List<ProductCmtVO> select_by_product(ProductCmtVO productCmtVO) {
		return dao.select_by_product(productCmtVO.getProduct_ID());
	}
	
	public List<ProductCmtVO> getAll() {
		return dao.getAll();
	}
	public List<ProductCmtVO> getComment(String product_ID) {
		List<ProductCmtVO> productCmtList = new ProductCmtService().getAll();
		List<ProductCmtVO> productCmtFilted = productCmtList.stream()
				.filter(p -> p.getProduct_ID().equals(product_ID))
				.collect(Collectors.toList());
		
		return productCmtFilted;
	}
	public Map<String, String> getRating(JSONArray product_ID_Array) throws JSONException {
		List<ProductCmtVO> productCmtList = new ProductCmtService().getAll();
		Map<String, String> map = new HashMap<>();
		for(int i=0; i<product_ID_Array.length(); i++) {
			String product_ID = product_ID_Array.getString(i);
			OptionalDouble result = productCmtList.stream()
					.filter(p -> p.getProduct_ID().equals(product_ID))
					.mapToDouble(p -> p.getProduct_Cmt_Grade())
					.average();
			
			if(result.isPresent()) {
				DecimalFormat df = new DecimalFormat("0.0");
				String rating = df.format((result.getAsDouble()));
				
				map.put(product_ID, rating);
			}else {
				map.put(product_ID, "0");
			}
		}
		return map;
	}
	public static void main(String[] args) {
		ProductCmtService service = new ProductCmtService();
		ProductCmtVO VO = new ProductCmtVO();
		VO.setProduct_Cmt_ID("CMT000010");
		VO.setProduct_ID("PID000002");
		VO.setMember_ID("MID000000");
//		VO.setProduct_Cmt_Info("456786��54645656�մ���12454567863");
		//service.delete(VO);
//		System.out.println(service.update(VO));
		//System.out.println(service.insert(VO));
		//System.out.println(service.getAll());
		//System.out.println(service.select(VO));
//		System.out.println(service.select_by_member(VO));
//		System.out.println(service.select_by_product(VO));
	}
}
