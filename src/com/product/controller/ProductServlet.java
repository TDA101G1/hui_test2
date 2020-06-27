package com.product.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.collection.model.CollectionService;
import com.collection.model.CollectionVO;
import com.member.model.MemberVO;
import com.order.model.OrderDetailVO;
import com.order_master.model.Order_MasterService;
import com.order_master.model.Order_MasterVO;
import com.product.model.ProductDetailService;
import com.product.model.ProductDetailVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.productcmt.model.ProductCmtService;
import com.productcmt.model.ProductCmtVO;


/**
 * Servlet implementation class ProductServlet
 */
@WebServlet(name = "ProductServlet.do", urlPatterns = { "/ProductServlet.do" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 25)
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//		System.out.println(new java.util.Date().getTime());
		res.setContentType("text/html;charset=UTF-8");
		
		req.setCharacterEncoding("UTF-8");
		res.addHeader("Access-Control-Allow-Origin","*");
		HttpSession session = req.getSession();
		
		String action = req.getParameter("action");
		System.out.println("此次請求action為: " + action);
		
//		if("getRating".equals(action)) {
////			res.setContentType("application/json;charset=UTF-8");
//			Map<String, String> map = new HashMap<>();
//			JSONArray product_ID_Array = new JSONArray(req.getParameter("product_ID"));
//			for(int i=0; i<product_ID_Array.length(); i++) {
//				String product_ID = product_ID_Array.getString(i);
//				String rating = new ProductCmtService().getRating(product_ID);
//				map.put(product_ID, rating);
//			}
//			res.getWriter().write(new JSONObject().put("rating", map).toString());
//		}
		
		//new servlet
		if("getRating".equals(action)) {
			res.getWriter().write(new JSONObject().put(
					"rating", new ProductCmtService()
					.getRating(new JSONArray(req.getParameter("product_ID")))).toString());
		}

		if("getPriceRange".equals(action)) {
			res.getWriter().write(new JSONObject().put(
					"priceRange", new ProductDetailService()
					.getPriceRange(new JSONArray(req.getParameter("product_ID")))).toString());
		}
		
		if("filterClass".equals(action)) {
			String product_Class = req.getParameter("product_Class");
			res.getWriter().write(new JSONObject().put(
					"filtedClass", new ProductService().getFilterClass(product_Class)).toString());
		}
		
		if("goDetailPage".equals(action)) {
			String product_ID = req.getParameter("product_ID");
			List<ProductDetailVO> oneProductDetailInfo = new ProductDetailService().getOneProductInfo(product_ID);
			List<ProductCmtVO> productCmtFilted = new ProductCmtService().getComment(product_ID);
			ProductVO product = new ProductService().select(product_ID);
			String scheduleArr[] = product.getProduct_Total_Schedule().split("Dayys");
			req.setAttribute("product", product);
			req.setAttribute("oneProductDetailInfo", oneProductDetailInfo);
			req.setAttribute("productCmtFilted", productCmtFilted);
			req.setAttribute("scheduleArr", scheduleArr);
			req.getRequestDispatcher("/product/productDetail.jsp").forward(req, res);
		}
		
		if("addCollection".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				String reply = new CollectionService().addCollection(member.getMember_ID(), req.getParameter("product_ID"));
				res.getWriter().write(new JSONObject().put("reply", reply).toString());
			}else {
				String location = req.getParameter("location");
				System.out.println(location);
				session.setAttribute("location", location);
				res.getWriter().write(new JSONObject().put("reply", false).toString());
			}
		}
		
		if("getCollections".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				System.out.println("執行getCollections");
				Set<CollectionVO> collectionByMemberID = new CollectionService().getCollectionByMemberID(member.getMember_ID());
				res.getWriter().write(new JSONObject().put("collectionByMemberID", collectionByMemberID).toString());
			}
		}
		
		if("addShoppingCar".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				System.out.println(member.getMember_ID()+"addShoppingCar");
				String member_ID = member.getMember_ID();
				String product_ID = req.getParameter("product_ID");
				String product_Name = req.getParameter("product_Name");
				String productDetail_ID = req.getParameter("productDetail_ID");
				System.out.println("addSHPOOING測試" + productDetail_ID);
				String quantity = req.getParameter("quantity");
				String spc = req.getParameter("spc");
				String price = req.getParameter("price");
				String start;
				String end;
				if(req.getParameter("start")==null || req.getParameter("end")==null) {
					start = "";
					end = "";
				}else {
					start = req.getParameter("start");
					end = req.getParameter("end");
				}
				System.out.println(product_ID+product_Name);
				String reply = new JedisShoppingCar().add(member_ID, product_ID, 
						product_Name, productDetail_ID, quantity, spc, start, end, price);
				res.getWriter().write(new JSONObject().put("reply", reply).toString());
//				Set<CollectionVO> collectionByMemberID = new CollectionService().getCollectionByMemberID(member.getMember_ID());
//				res.getWriter().write(new JSONObject().put("collectionByMemberID", collectionByMemberID).toString());
			}
		}
		
		if("getMemberSelected".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				res.getWriter().write(new JedisShoppingCar().getMemberSelected(member.getMember_ID()).toString());
			}
		}
		
		if("updateMemberCar".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				System.out.println("into updateMemberCar");
				String member_ID = member.getMember_ID();
				String product_ID = req.getParameter("product_ID");
				String product_Name = req.getParameter("product_Name");
				String productDetail_ID = req.getParameter("productDetail_ID");
				String quantity = req.getParameter("quantity");
				String spc = req.getParameter("spc");
				String price = req.getParameter("price");
				String start;
				String end;
				String index = req.getParameter("index");
				String addTime = req.getParameter("addTime");
				if(req.getParameter("start")==null || req.getParameter("end")==null) {
					start = "";
					end = "";
				}else {
					start = req.getParameter("start");
					end = req.getParameter("end");
				}
				res.getWriter().write(new JedisShoppingCar().
						update(member_ID, product_ID, product_Name, productDetail_ID, 
								quantity, spc, start, end, price, index, addTime).toString());
			}
		}
		
		if("delectOneItem".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				System.out.println("into delectOneItem");
				String member_ID = member.getMember_ID();
				String product_ID = req.getParameter("product_ID");
				String product_Name = req.getParameter("product_Name");
				String productDetail_ID = req.getParameter("productDetail_ID");
				String quantity = req.getParameter("quantity");
				String spc = req.getParameter("spc");
				String start;
				String end;
				String index = req.getParameter("index");
				String addTime = req.getParameter("addTime");
				if(req.getParameter("start")==null || req.getParameter("end")==null) {
					start = "";
					end = "";
				}else {
					start = req.getParameter("start");
					end = req.getParameter("end");
				}
				res.getWriter().write(new JedisShoppingCar().
						delete(member_ID, index, addTime, start, end).toString());
			}
		}
		
		if("removeGoods".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				System.out.println("into removeItems");
				String member_ID = member.getMember_ID();
				String jsonArr = req.getParameter("jsonArr");
				res.getWriter().write(new JedisShoppingCar().
						removeGoods(member_ID, jsonArr).toString());
			}
		}
		
		if("removeFailureGoods".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				System.out.println("into removeFailureGoods");
				String member_ID = member.getMember_ID();
				String jsonArr = req.getParameter("jsonArr");
				res.getWriter().write(new JedisShoppingCar().
						removeFailureGoods(member_ID, jsonArr).toString());
			}
		}
		
		
		if("goCheckout".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				System.out.println("into goCheckout");
				String member_ID = member.getMember_ID();
				String jsonArr = req.getParameter("goods");
				String msg = new JedisShoppingCar().goCheckout(member_ID, jsonArr);
				System.out.println(msg);
				if(msg.equals("比對失敗")) {
					req.setAttribute("msg", msg);
					req.getRequestDispatcher("/product/shoppingCar.jsp").forward(req, res);
					return;
				}
				req.setAttribute("msg", msg);
				res.sendRedirect(req.getContextPath()+"/product/checkout.jsp");
				return;
			}
		}
		
		
		if("checkout".equals(action)) {
			MemberVO member = (MemberVO)session.getAttribute("member");
			if(member != null) {
				System.out.println("into checkout");
				String member_ID = member.getMember_ID();
				String jsonArr = req.getParameter("checkoutInfo");
				String payment = req.getParameter("payment");
				String couponID = req.getParameter("couponID");
				List<OrderDetailVO> createOrderDetailList = new JedisShoppingCar().createOrderDetaillList(member_ID, jsonArr);
				
				if(createOrderDetailList == null || createOrderDetailList.size() < 1) {
					res.getWriter().write(new JSONObject().put("reply", "資料比對失敗，請聯絡客服人員").toString());
					return;
				}
				
				Order_MasterVO order_MasterVO = new Order_MasterVO();
				order_MasterVO.setMember_ID(member_ID);
				order_MasterVO.setCoupon_ID(couponID);
				order_MasterVO.setOrder_Master_Payment(payment);
				order_MasterVO.setOrder_Master_TimeStamp(new java.sql.Timestamp(new java.util.Date().getTime()));
				order_MasterVO.setOrder_Master_State(new Integer(1));
				String reply = new Order_MasterService().inserWithOrder_Ditel(order_MasterVO, createOrderDetailList);
				if(reply.equals("success")) {
					System.out.println(new JedisShoppingCar().removeGoods(member_ID, jsonArr));
				}
				res.getWriter().write(new JSONObject().put("reply", reply).toString());
			}
		}
		
		
//======================================================================================
		if ("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String product_ID = req.getParameter("product_ID");
				if (product_ID == null || (product_ID.trim()).length() == 0) {
					errorMsgs.add("請輸入商品編號");
				}

				if (!errorMsgs.isEmpty()) {
					req.getRequestDispatcher("#").forward(req, res);
					return;
				}

				ProductService pSvc = new ProductService();
				ProductVO productVO = pSvc.select(product_ID);
				if (productVO == null) {
					errorMsgs.add("查無資料");
				}

				if (!errorMsgs.isEmpty()) {
					req.getRequestDispatcher("#").forward(req, res);
					return;
				}

				req.setAttribute("product_ID", product_ID);
				req.getRequestDispatcher("#").forward(req, res);
				return;
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得資料: " + e.getMessage());
				req.getRequestDispatcher("#").forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String product_ID = req.getParameter("product_ID");
				ProductService pSvc = new ProductService();
				ProductVO productVO = pSvc.select(product_ID);
				req.setAttribute("productVO", productVO);
				req.getRequestDispatcher("/product/productUpdate.jsp").forward(req, res);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String product_ID = req.getParameter("product_ID").trim();
				String product_Name = req.getParameter("product_Name").trim();
				String product_NameReg = "^[(\\u4e00-\\u9fa5)(a-zA-Z0-9_)]{2,30}$";
				if (product_Name == null || product_Name.trim().length() == 0) {
					errorMsgs.add("商品名稱請勿空白");
				} else if (!product_Name.trim().matches(product_NameReg)) {
					errorMsgs.add("商品名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String product_Intro = req.getParameter("product_Intro").trim();
				if (product_Intro == null || product_Intro.trim().length() == 0) {
					errorMsgs.add("商品簡介請勿空白");
				}

				Double product_Staytime = null;
				try {
					product_Staytime = new Double(req.getParameter("product_Staytime"));
				} catch (Exception e) {
					e.printStackTrace();
					errorMsgs.add("product_Staytime請填入數字");
				}

				String product_Address = req.getParameter("product_Intro").trim();
				if (product_Address == null || product_Address.trim().length() == 0) {
					errorMsgs.add("地址請勿空白");
				}

//				Double product_Latitutde = null; 
//				try {
//					product_Latitutde = new Double(req.getParameter("product_Latitutde"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Latitutde請填入數字");
//				}
//				
//				Double product_Longitude = null; 
//				try {
//					product_Longitude = new Double(req.getParameter("product_Longitude"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Longitude請填入數字");
//				}

				String product_County = req.getParameter("product_County").trim();
				if (product_County == null || product_County.trim().length() == 0) {
					errorMsgs.add("縣市請勿空白");
				}

				String product_Class = req.getParameter("product_Class").trim();
				if (product_Class == null || product_Class.trim().length() == 0) {
					errorMsgs.add("商品類別請勿空白");
				}

				String product_Style = req.getParameter("product_Style").trim();
				if (product_Style == null || product_Style.trim().length() == 0) {
					errorMsgs.add("商品風格請勿空白");
				}

//				Integer product_Seq = null; 
//				try {
//					product_Seq = new Integer(req.getParameter("product_Seq"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Seq請填入數字");
//				}

				Integer product_State = null;
				try {
					product_State = new Integer(req.getParameter("product_State"));
				} catch (Exception e) {
					e.printStackTrace();
					errorMsgs.add("product_State請填入數字");
				}

//				Integer product_Sale_Rec = null; 
//				try {
//					product_Sale_Rec = new Integer(req.getParameter("product_Sale_Rec"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Sale_Rec請填入數字");
//				}

//				Integer product_Click_Rec = null; 
//				try {
//					product_Click_Rec = new Integer(req.getParameter("product_Click_Rec"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Click_Rec請填入數字");
//				}

				String product_Info = req.getParameter("product_Info").trim();
				if (product_Info == null || product_Info.trim().length() == 0) {
					errorMsgs.add("product_Info請勿空白");
				}

				String product_Total_Schedule = req.getParameter("product_Total_Schedule").trim();
				if (product_Total_Schedule == null || product_Total_Schedule.trim().length() == 0) {
					errorMsgs.add("product_Total_Schedule請勿空白");
				}

				ProductVO productVO = new ProductVO();
				productVO.setProduct_ID(product_ID);
				productVO.setProduct_Name(product_Name);
				productVO.setProduct_Intro(product_Intro);
				productVO.setProduct_Staytime(product_Staytime);
				productVO.setProduct_Address(product_Address);
				productVO.setProduct_Latitutde(25D);
				productVO.setProduct_Longitude(122D);
				productVO.setProduct_County(product_County);
				productVO.setProduct_Class(product_Class);
				productVO.setProduct_Style(product_Style);
				productVO.setProduct_Seq(0);
				productVO.setProduct_State(product_State);
				productVO.setProduct_Sale_Rec(0);
				productVO.setProduct_Click_Rec(0);
				productVO.setProduct_Total_Schedule(product_Total_Schedule);
				productVO.setProduct_Info(product_Info);

				InputStream is1 = null;
				InputStream is2 = null;
				InputStream is3 = null;
				InputStream is4 = null;
				InputStream is5 = null;

				try {
					if (req.getPart("product_Img1") != null) {
						is1 = req.getPart("product_Img1").getInputStream();
						byte[] imgByte1 = new byte[is1.available()];
						is1.read(imgByte1);
						productVO.setProduct_Img1(imgByte1);
					}

					if (req.getPart("product_Img2") != null) {
						is2 = req.getPart("product_Img2").getInputStream();
						byte[] imgByte2 = new byte[is2.available()];
						is2.read(imgByte2);
						productVO.setProduct_Img2(imgByte2);
					}

					if (req.getPart("product_Img3") != null) {
						is3 = req.getPart("product_Img3").getInputStream();
						byte[] imgByte3 = new byte[is3.available()];
						is3.read(imgByte3);
						productVO.setProduct_Img3(imgByte3);
					}

					if (req.getPart("product_Img4") != null) {
						is4 = req.getPart("product_Img4").getInputStream();
						byte[] imgByte4 = new byte[is4.available()];
						is4.read(imgByte4);
						productVO.setProduct_Img4(imgByte4);
					}

					if (req.getPart("product_Img5") != null) {
						is5 = req.getPart("product_Img5").getInputStream();
						byte[] imgByte5 = new byte[is5.available()];
						is5.read(imgByte5);
						productVO.setProduct_Img5(imgByte5);
					}

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if (is1 != null) {
							is1.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}

					try {
						if (is2 != null) {
							is2.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}

					try {
						if (is3 != null) {
							is3.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}

					try {
						if (is4 != null) {
							is4.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}

					try {
						if (is5 != null) {
							is5.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}
				}

				if (!errorMsgs.isEmpty()) {
					System.out.println(errorMsgs);
					req.setAttribute("productVO", productVO);
					req.getRequestDispatcher("#").forward(req, res);
					return;
				}

				ProductService pSvc = new ProductService();
				System.out.println("成功修改的筆數+ " + pSvc.update(productVO));
				req.setAttribute("productVO", productVO);
				req.getRequestDispatcher("/product/productList.jsp").forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				req.getRequestDispatcher("#").forward(req, res);
			}

		}

		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
//				String product_ID = req.getParameter("product_ID").trim();
				String product_Name = req.getParameter("product_Name").trim();
				String product_NameReg = "^[(\\u4e00-\\u9fa5)(a-zA-Z0-9_)]{2,30}$";
				if (product_Name == null || product_Name.trim().length() == 0) {
					errorMsgs.add("商品名稱請勿空白");
				} else if (!product_Name.trim().matches(product_NameReg)) {
					errorMsgs.add("商品名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String product_Intro = req.getParameter("product_Intro").trim();
				if (product_Intro == null || product_Intro.trim().length() == 0) {
					errorMsgs.add("商品簡介請勿空白");
				}

				Double product_Staytime = null;
				try {
					product_Staytime = new Double(req.getParameter("product_Staytime"));
				} catch (Exception e) {
					e.printStackTrace();
					errorMsgs.add("product_Staytime請填入數字");
				}

				String product_Address = req.getParameter("product_Intro").trim();
				if (product_Address == null || product_Address.trim().length() == 0) {
					errorMsgs.add("地址請勿空白");
				}

//				Double product_Latitutde = null; 
//				try {
//					product_Latitutde = new Double(req.getParameter("product_Latitutde"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Latitutde請填入數字");
//				}
//				
//				Double product_Longitude = null; 
//				try {
//					product_Longitude = new Double(req.getParameter("product_Longitude"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Longitude請填入數字");
//				}

				String product_County = req.getParameter("product_County").trim();
				if (product_County == null || product_County.trim().length() == 0) {
					errorMsgs.add("縣市請勿空白");
				}

				String product_Class = req.getParameter("product_Class").trim();
				if (product_Class == null || product_Class.trim().length() == 0) {
					errorMsgs.add("商品類別請勿空白");
				}

				String product_Style = req.getParameter("product_Style").trim();
				if (product_Style == null || product_Style.trim().length() == 0) {
					errorMsgs.add("商品風格請勿空白");
				}

//				Integer product_Seq = null; 
//				try {
//					product_Seq = new Integer(req.getParameter("product_Seq"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Seq請填入數字");
//				}

				Integer product_State = null;
				try {
					product_State = new Integer(req.getParameter("product_State"));
				} catch (Exception e) {
					e.printStackTrace();
					errorMsgs.add("product_State請填入數字");
				}

//				Integer product_Sale_Rec = null; 
//				try {
//					product_Sale_Rec = new Integer(req.getParameter("product_Sale_Rec"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Sale_Rec請填入數字");
//				}

//				Integer product_Click_Rec = null; 
//				try {
//					product_Click_Rec = new Integer(req.getParameter("product_Click_Rec"));
//				} catch (Exception e) {
//					e.printStackTrace();
//					errorMsgs.add("product_Click_Rec請填入數字");
//				}

				String product_Info = req.getParameter("product_Info").trim();
				if (product_Info == null || product_Info.trim().length() == 0) {
					errorMsgs.add("product_Info請勿空白");
				}

				String product_Total_Schedule = req.getParameter("product_Total_Schedule").trim();
				if (product_Total_Schedule == null || product_Total_Schedule.trim().length() == 0) {
					errorMsgs.add("product_Total_Schedule請勿空白");
				}

				ProductVO productVO = new ProductVO();
//				productVO.setProduct_ID(product_ID);
				productVO.setProduct_Name(product_Name);
				productVO.setProduct_Intro(product_Intro);
				productVO.setProduct_Staytime(product_Staytime);
				productVO.setProduct_Address(product_Address);
				productVO.setProduct_Latitutde(25D);
				productVO.setProduct_Longitude(122D);
				productVO.setProduct_County(product_County);
				productVO.setProduct_Class(product_Class);
				productVO.setProduct_Style(product_Style);
				productVO.setProduct_Seq(0);
				productVO.setProduct_State(product_State);
				productVO.setProduct_Sale_Rec(0);
				productVO.setProduct_Click_Rec(0);
				productVO.setProduct_Total_Schedule(product_Total_Schedule);
				productVO.setProduct_Info(product_Info);

				InputStream is1 = null;
				InputStream is2 = null;
				InputStream is3 = null;
				InputStream is4 = null;
				InputStream is5 = null;

				try {
					if (req.getPart("product_Img1") != null) {
						is1 = req.getPart("product_Img1").getInputStream();
						byte[] imgByte1 = new byte[is1.available()];
						is1.read(imgByte1);
						productVO.setProduct_Img1(imgByte1);
					}

					if (req.getPart("product_Img2") != null) {
						is2 = req.getPart("product_Img2").getInputStream();
						byte[] imgByte2 = new byte[is2.available()];
						is2.read(imgByte2);
						productVO.setProduct_Img2(imgByte2);
					}

					if (req.getPart("product_Img3") != null) {
						is3 = req.getPart("product_Img3").getInputStream();
						byte[] imgByte3 = new byte[is3.available()];
						is3.read(imgByte3);
						productVO.setProduct_Img3(imgByte3);
					}

					if (req.getPart("product_Img4") != null) {
						is4 = req.getPart("product_Img4").getInputStream();
						byte[] imgByte4 = new byte[is4.available()];
						is4.read(imgByte4);
						productVO.setProduct_Img4(imgByte4);
					}

					if (req.getPart("product_Img5") != null) {
						is5 = req.getPart("product_Img5").getInputStream();
						byte[] imgByte5 = new byte[is5.available()];
						is5.read(imgByte5);
						productVO.setProduct_Img5(imgByte5);
					}

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if (is1 != null) {
							is1.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}

					try {
						if (is2 != null) {
							is2.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}

					try {
						if (is3 != null) {
							is3.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}

					try {
						if (is4 != null) {
							is4.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}

					try {
						if (is5 != null) {
							is5.close();
						}
					} catch (Exception e2) {
						e2.printStackTrace();
					}
				}

				if (!errorMsgs.isEmpty()) {
					System.out.println(errorMsgs);
					req.setAttribute("productVO", productVO);
					req.getRequestDispatcher("#").forward(req, res);
					return;
				}

				ProductService pSvc = new ProductService();
				productVO = pSvc.insert(productVO);
				req.setAttribute("productVO", productVO);
				req.getRequestDispatcher("/product/productList.jsp").forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				req.getRequestDispatcher("#").forward(req, res);
			}

		}

		if ("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			try {
				ProductService pSvc = new ProductService();
				String product_ID = req.getParameter("product_ID");
				ProductVO productVO = pSvc.select(product_ID);
				productVO.setProduct_State(0);	//假刪除
				int count = pSvc.update(productVO); //假刪除
				System.out.println("成功下架的筆數: " + count);
				if (productVO != null) {
					req.setAttribute("productVO", productVO);
					req.getRequestDispatcher("#").forward(req, res);
					return;
				}
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				req.getRequestDispatcher("#").forward(req, res);
			}
		}

		if ("getAll".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				ProductService pSvc = new ProductService();
				List<ProductVO> productList = pSvc.getAll();
				req.setAttribute("productList", productList);
				req.getRequestDispatcher("#").forward(req, res);
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("getALL失敗:" + e.getMessage());
				req.getRequestDispatcher("#").forward(req, res);
			}
		}

	}
}