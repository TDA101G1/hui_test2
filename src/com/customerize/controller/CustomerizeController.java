package com.customerize.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Remove;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.customerize.model.CustomerizeService;
import com.customerize.model.CustomerizeVO;
import com.customerizedetail.model.CustDetailService;
import com.customerizedetail.model.CustDetailVO;
import com.member.model.MemberVO;
import com.product.model.ProductDetailService;
import com.product.model.ProductDetailVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;

import javafx.beans.binding.StringBinding;

@WebServlet("/CustomerizeController")
public class CustomerizeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
//接收資料
		if ("create_schedule".equals(action)) {
			String date = req.getParameter("cust_date"); // 前端有設定相對應的name，會判斷是否要增加value值
			String quantity = req.getParameter("cust_quantity");
			String position = req.getParameter("cust_position"); // 這是存一份經緯度到資料庫後續使用
			String address = req.getParameter("cust_address"); // 這是存一份地址字串，如輸入資料有錯誤，會返回以輸入的地址
			String[] county = req.getParameterValues("product_county");
			String selected_schedule = req.getParameter("selected_schedule");
			System.out.println(address);
			System.out.println(date);
			System.out.println(quantity);
			System.out.println(position);
			System.out.println(selected_schedule);
//			System.out.println(selected_style);								         暫時沒有要做
			Map<String, String> errors = new HashMap<String, String>();
			req.setAttribute("errors", errors);

//驗證資料		
//轉換資料

			StringBuilder uset_insert_date = new StringBuilder();
			String[] cust_dates = null;
			if (date.trim().length() != 0 || date != "") { // 前端有設定相對應的name，會判斷是否要增加value值
				try { // 所以這邊不會碰到null，而是空字串
					JSONObject obj = new JSONObject(date);
					JSONArray array = obj.getJSONArray("listDate");
					System.out.println(array);
					cust_dates = new String[array.length()];
					for (int i = 0; i < array.length(); i++) {
						cust_dates[i] = array.getString(i);
					}
					uset_insert_date.append(array.getString(0)); // 因為傳來的格式是JSON，所以用StringBuilder串接...
					uset_insert_date.append(" to ");
					uset_insert_date.append(array.getString(array.length() - 2));
				} catch (JSONException e) {
					e.printStackTrace();
				}
			} else {
				System.out.println("日期空白");
				errors.put("date", "日期空白，請選擇日期");
			}

			Integer cust_quantity = null;
			if (quantity != null && quantity.trim().length() != 0) {
				try {
					cust_quantity = Integer.parseInt(quantity.trim());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					errors.put("quantity", "人數必須是數字");
				}
			} else {
				errors.put("quantity", "人數空白，請輸入數字");
			}

			String cust_position = null;
			if (position != null && position.trim().length() != 0) {
				cust_position = position;
			} else {
				errors.put("position", "地點空白或錯誤，請輸入地址");
			}

			String selected_county = null;
			if (county != null && county.length != 0) {
				selected_county = Arrays.toString(county);
				System.out.println("selected_county = " + selected_county);
			} else {
				errors.put("county", "請選擇想去的縣市");
			}

			if (errors != null && !errors.isEmpty()) {
				System.out.println(errors);
				CustomerizeVO returnBean = new CustomerizeVO(); // 這裡的Bean只會在有錯誤時用到...就是把使用者輸入的值再吐回去
				returnBean.setCust_Schedule_Name(uset_insert_date.toString()); // 因為沒有欄位可以塞這個日期的字串...
				returnBean.setCust_Quantity(cust_quantity);
				returnBean.setCust_Position(address); // 另外存一份地址字串，資料庫則是轉換成經緯度
				returnBean.setCust_Selected_County(selected_county);
				req.setAttribute("errorReturnBean", returnBean);
				req.getRequestDispatcher("/hui_project/index.jsp").forward(req, res);
				return;
			}
//呼叫Model
			CustomerizeService dao = new CustomerizeService();
			CustomerizeVO bean = new CustomerizeVO();
			HttpSession session = req.getSession();
			MemberVO member = (MemberVO) session.getAttribute("member");
			bean.setMember_ID(member.getMember_ID());
			bean.setCust_Schedule_Name("我的行程");
			bean.setCust_Schedule_Click_Record(0);
			bean.setCust_Schedule_Start_Time(Date.valueOf(cust_dates[0]));
			bean.setCust_Schedule_End_Time(Date.valueOf(cust_dates[1]));
			bean.setCust_Schedule_Total_Day(Integer.parseInt(cust_dates[2]));
			bean.setCust_Schedule_Share(0);
			bean.setCust_Schedule_State(1);
			bean.setCust_Quantity(cust_quantity);
			bean.setCust_Position(cust_position);
			bean.setCust_Selected_County(selected_county);
			CustomerizeVO custVO = dao.insert(bean);

			req.setAttribute("custVO", custVO);
			
			if ("Auto_schedule".equals(selected_schedule)) {
				String selected_style = req.getParameter("selected_style");        //改成安排行程的方式
				int hr = 0;
				int schedule = 0;
				switch(selected_style){
				case "lazy":
					hr = 6;
					schedule = 3;
					break;	
				case "general":
					hr = 9;
					schedule = 4;
					break;	
				case "compact":
					hr = 12;
					schedule = 5;
					break;	
				default:
					hr = 9;
					schedule = 4;
				}
				ProductService productDao = new ProductService();
				ProductDetailService productDetailDao = new ProductDetailService();
				List<String> autoMode_county = Arrays.asList(county);
				List<ProductVO> listProducts = productDao.getAll();
				List<ProductDetailVO> listProductDetails = productDetailDao.getAll();

				List<ProductVO> filter_products = listProducts.stream()
						.filter(p -> autoMode_county.contains(p.getProduct_County()))
						.filter(p -> !p.getProduct_Class().equals("套裝行程")).collect(Collectors.toList());
				List<String> product_id = filter_products.stream().map(p_id -> p_id.getProduct_ID())
						.collect(Collectors.toList());
				List<ProductDetailVO> productDetails = listProductDetails.stream()
						.filter(p_id -> product_id.contains(p_id.getProduct_ID())).collect(Collectors.toList());

				for (ProductVO product : filter_products) {
					List<ProductDetailVO> list = new ArrayList<>();
					for (ProductDetailVO productDetail : productDetails) {
						if (product.getProduct_ID().equals(productDetail.getProduct_ID())) {
							list.add(productDetail);
						}
					}
					if (list.size() != 0) {
						product.setProductDetailVOs(list);
					}
				}

				int totalTime = 0;
				List<Set<ProductVO>> total_schedule = new ArrayList<>();
				List<List<ProductVO>> total_schedule_list = new ArrayList<>();
				while (total_schedule.size() < custVO.getCust_Schedule_Total_Day()) {
					List<ProductVO> daySchedule = new ArrayList<ProductVO>();
					Set<ProductVO> set = new HashSet<>();
					int i = total_schedule.size();
					while (set.size() < schedule) {
						if(i > 0) {
							i -= 1;
							filter_products.removeAll(total_schedule.get(i));  //Collection.removeAll，若有相同的ProductVO會刪除,前提是泛型一樣
						}
						int randomProduce = (int) (Math.random() * filter_products.size() - 1);
						set.add(filter_products.get(randomProduce));
						totalTime += filter_products.get(randomProduce).getProduct_Staytime();
						if (totalTime > hr) {
							set.clear();
							totalTime = 0;
						}
					}
 					total_schedule.add(set);
					daySchedule.addAll(set);         		//將Set轉為List
					total_schedule_list.add(daySchedule);	//將List再加入total_schedule_list
				} 
				
				List<CustDetailVO> custDetails = new ArrayList<CustDetailVO>(); // 記得要驗證
				CustDetailService custDetailDao = new CustDetailService();
				Date startDate = custVO.getCust_Schedule_Start_Time();
				long millisecond = 0;
				for(int x = 0; x < total_schedule_list.size(); x++) {
					if(x == 0) {
						millisecond = startDate.getTime();
					}else {
						millisecond = startDate.getTime() + 60*60*24*1000;
					}
					for(int y = 0; y < total_schedule_list.get(x).size(); y++) {
						CustDetailVO custDetailVO = new CustDetailVO();
						custDetailVO.setProduct_ID(total_schedule_list.get(x).get(y).getProduct_ID());
						custDetailVO.setCust_Schedule_Detail_Info("");
						custDetailVO.setCust_Schedule_ID(custVO.getCust_Schedule_ID());
						custDetailVO.setCust_Schedule_Detail_Seq(y);
						custDetailVO.setCust_Schedule_Detail_Date(new Date(millisecond));
						custDetailVO.setProductVO(total_schedule_list.get(x).get(y));
						custDetails.add(custDetailVO);
						custDetailDao.insert(custDetailVO);
					}
				}
				ProductVO productVO = new ProductVO();
				productVO.setProduct_ID(total_schedule_list.get(0).get(0).getProduct_ID());
				custVO = dao.select(custVO);  //傳回選擇的VO
				custVO.setCust_Schedule_Img(productDao.select(productVO).getProduct_Img1());
				custVO = dao.update(custVO);
				req.setAttribute("custDetails", custDetails);
				req.getRequestDispatcher("/hui_project/produce_schedule.jsp").forward(req, res);
			} else if ("DIY_schedule".equals(selected_schedule)) {
				req.getRequestDispatcher("/hui_project/schedule.jsp").forward(req, res);
			}
		}

		
//產生行程
		if ("produce_schedule".equals(action)) {
			System.out.println("產生行程");
			String cust_schedule_id = req.getParameter("cust_schedule_id");
			System.out.println(cust_schedule_id);
			CustomerizeService custDao = new CustomerizeService();
			CustDetailService custDetailDao = new CustDetailService();
			ProductDetailService productDetailDao = new ProductDetailService();
			ProductService productDao = new ProductService();
			CustomerizeVO custResult = new CustomerizeVO();

			if (cust_schedule_id != null) {
				custResult.setCust_Schedule_ID(cust_schedule_id);
				custResult = custDao.select(custResult);

				List<ProductVO> listProducts = productDao.getAll();
				List<ProductDetailVO> listProductDetails = productDetailDao.getAll();
				List<CustDetailVO> custDetails = custDetailDao.select_by_schedule(custResult.getCust_Schedule_ID());  //用剛剛的行程主檔ID查細節行程
				custDetails.sort(Comparator.comparing(CustDetailVO::getCust_Schedule_Detail_Date) // Comparator<CustDetailVO> byDate = Comparator.comparing(CustDetailVO::getCust_Schedule_Detail_Date);
						.thenComparing(CustDetailVO::getCust_Schedule_Detail_Seq));
						
				List<String> product_id = custDetails.stream() // 取使用者行程細節的產品ID
						.map(detail -> detail.getProduct_ID()).collect(Collectors.toList());
				List<ProductVO> products = listProducts.stream() // 所有商品篩選ID
						.filter(p -> product_id.contains(p.getProduct_ID())).collect(Collectors.toList());
				List<ProductDetailVO> productDetails = listProductDetails.stream() // 所有行程細節篩選ID
						.filter(pd -> product_id.contains(pd.getProduct_ID())).collect(Collectors.toList());

				for (CustDetailVO custDetail : custDetails) {
					for (ProductVO product : products) {
						if (custDetail.getProduct_ID().equals(product.getProduct_ID())) {
							custDetail.setProductVO(product);
							List<ProductDetailVO> list = new ArrayList<>();
							for (ProductDetailVO productDetail : productDetails) {
								if (product.getProduct_ID().equals(productDetail.getProduct_ID())) {
									list.add(productDetail);
								}
							}
							if (list.size() != 0) {						//為了不讓沒有值的list加入
								product.setProductDetailVOs(list);
								break;
							}
						}
					}
				}
				req.setAttribute("custVO", custResult);
				req.setAttribute("custDetails", custDetails);
				custDetails.forEach(p -> System.out.println("產生的行程 = " + p));
				req.getRequestDispatcher("/hui_project/produce_schedule.jsp").forward(req, res);
			}
		}

		if ("edit_schedule".equals(action)) {
			System.out.println("進來了edit_schedule");
			String cust_schedule_id = req.getParameter("cust_schedule_id");
			CustomerizeService dao = new CustomerizeService();
			CustomerizeVO custVO = new CustomerizeVO();
			custVO.setCust_Schedule_ID(cust_schedule_id);
			custVO = dao.select(custVO);
//			System.out.println("edit_schedule的custVO = " + custVO);
			req.setAttribute("custVO", custVO);
			req.getRequestDispatcher("/hui_project/schedule.jsp").forward(req, res);
		}

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

	public static void main(String[] args) {
		int randomProduce = (int) (Math.random() * 100);
		System.out.println(randomProduce);
	}

}
