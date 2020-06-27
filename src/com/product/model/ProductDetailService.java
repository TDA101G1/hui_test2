package com.product.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONException;

public class ProductDetailService {
	private ProductDetailDAO dao;
	
	public ProductDetailService() {
		dao = new ProductDetailDAO_JDBC();
	}
	
	public ProductDetailVO insert(ProductDetailVO productDetailVO, ProductVO productVO) {
		if(productDetailVO != null && productVO!= null) {
			ProductDetailVO pd = dao.insert(productDetailVO, productVO);
			return pd;
		}
		return null;
	}
	
	public Integer update(ProductDetailVO productDetailVO) {
		if(productDetailVO != null) {
			Integer count = dao.update(productDetailVO);
			return count;
		}
		return new Integer(-1);
	}
	
	public Integer delete(ProductDetailVO productDetailVO) {
		if(productDetailVO != null) {
			Integer count = dao.delete(productDetailVO.getProduct_Detail_ID());
			return count;
		}
		return new Integer(-1);
	}
	
	public ProductDetailVO select(ProductDetailVO productDetailVO) {
		if(productDetailVO != null) {
			ProductDetailVO productDetail = dao.select(productDetailVO.getProduct_Detail_ID());
			return productDetail;
		}
		return null;
	}
	
	public List<ProductDetailVO> getAll() {
		return dao.getAll();
	}
	
	public String getPriceRange(String product_ID) {
		if(product_ID!=null) {
			return dao.getPriceRange(product_ID);
		}
		return null;
	}
	
	public Map<String, String> getPriceRange(JSONArray product_ID_Array) throws JSONException {
		List<ProductDetailVO> productDetailList = dao.getAll();
		Map<String, String> map = new HashMap<>();
		for(int i=0; i<product_ID_Array.length(); i++) {
			String product_ID = product_ID_Array.getString(i);
			List<ProductDetailVO> list = productDetailList.stream()
					.filter(p -> p.getProduct_ID().equals(product_ID))
					.sorted(Comparator.comparing(ProductDetailVO::getProduct_Detail_Money))
					.collect(Collectors.toList());
			
			if(list.size()>0 && list != null) {
				String min = String.valueOf(list.get(0).getProduct_Detail_Money());
				String max = String.valueOf(list.get(list.size()-1).getProduct_Detail_Money());
				if(min.equals(max)) {
					map.put(product_ID, min);
				}else {
					map.put(product_ID, min+" ~ "+max);
				}
			}else {
				map.put(product_ID, "0");
			}
		}
//		System.out.println(map);
		return map;
	}
	
	public List<ProductDetailVO> getOneProductInfo(String product_ID) {
//		List<ProductDetailVO> oneProductDetailInfo = dao.getAll().stream()
//				.filter(e -> e.getProduct_ID().equals(product_ID))
//				.collect(Collectors.toList());
		
		//瀏覽次數+1
		ProductVO productVO = new ProductService().select(product_ID);
		Integer click_Rec = productVO.getProduct_Click_Rec();
		productVO.setProduct_Click_Rec(++click_Rec);
		
		return dao.getAll().stream()
				.filter(e -> e.getProduct_ID().equals(product_ID))
				.collect(Collectors.toList());
	}
	
	
	public static void main(String[] args) {
		ProductDetailService service = new ProductDetailService();
		ProductVO productVO = new ProductVO();
		ProductDetailVO productDetailVO = new ProductDetailVO();
		productDetailVO.setProduct_Detail_ID("PDID000001");
		productDetailVO.setProduct_ID("PID000001");
		productDetailVO.setProduct_Detail_Spc("8人房");
		productDetailVO.setProduct_Detail_Money(30000);
		productDetailVO.setProduct_Detail_Instock(100);
		productDetailVO.setProduct_Detail_Saftystock(5);
//		productDetailVO.setProduct_Detail_Date(com.tourism.utiles.ChangeDateFormate.ChangeDateFormate_Dash("2020-02-30"));

//		System.out.println(service.insert(productDetailVO, productVO));
//		System.out.println("此次流水號ID為: "+productDetailVO.getProduct_Detail_ID());
//		System.out.println("更新筆數:" + service.update(productDetailVO));
//		System.out.println(service.select(productDetailVO));
//		System.out.println("刪除筆數:" + service.delete(productDetailVO));
//		service.getAll().forEach(System.out::println);
		System.out.println(service.getPriceRange("PID000000"));
		
		
	}
}
