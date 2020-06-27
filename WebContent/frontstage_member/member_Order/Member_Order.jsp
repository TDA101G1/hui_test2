<%@page import="com.coupon.model.CouponVO"%>
<%@page import="com.coupon.model.CouponService"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Collector"%>
<%@page import="java.util.*"%>
<%@page import="com.order.model.OrderDetailVO"%>
<%@page import="com.order.model.OrderDetailService"%>
<%@page import="com.order_master.model.Order_MasterVO"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.product.model.*"%>

<%@page import="com.order_master.model.Order_MasterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/css/footer.css">
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
	hr {
		border: 1px solid rgb(13, 218, 218);
	}
	
body {
  font-size: 16px;
  font-family: Microsoft JhengHei;
  color: #343434;
  background-color: #F5F5F5;
}
	.dropdown-item:focus, .dropdown-item:hover {
	    color: #ffffff;
	    text-decoration: none;
	    text-decoration-line: none;
	    text-decoration-style: initial;
	    text-decoration-color: initial;
	    background-color: #3e7aff;
	}
	body {
	  font-size: 16;
	  font-family: Microsoft JhengHei;
	  color: #343434;
	  background-color: #F5F5F5;
	}
	
	div.star_block > span.star{
	  cursor: pointer;
	}
	div.star_block > span.star.-on{
	  color: #FFBB00;
	}
	.-none {
	display: none;
	}
	input.use_qty{
	width: 4rem;
	}
div.sidebar a.nav-link:hover{
	background-color: #007bff;
	color: #fff;
}
	</style>
</head>
<body>
			<%
				MemberVO member = (MemberVO) session.getAttribute("member");
				String member_ID = member.getMember_ID();
				Order_MasterService service = new Order_MasterService();
/* 產生orderMaster */
				Set<Order_MasterVO>oms1 = service.getOrderMasterByMemberID(member_ID);
/* 				List<Order_MasterVO>oms = new ArrayList<Order_MasterVO>();
 */				List<Order_MasterVO>oms = oms1.stream()
		 							.filter(Order_MasterVO -> Order_MasterVO.getOrder_Master_State().equals(1))
		 							.collect(Collectors.toList());
/* 				oms.addAll(oms1);
 */				
/* 按照訂單順序排列 */
				oms.sort(Comparator.comparing(Order_MasterVO::getOrder_Master_ID).reversed());
						
								
				pageContext.setAttribute("oms", oms);
/* 產生orderDetail */				
				OrderDetailService odservice = new OrderDetailService();
				List<OrderDetailVO>ods = odservice.getAll();
 				Map<String, List<OrderDetailVO>> orderMap = new HashMap<String, List<OrderDetailVO>>();
				Set<OrderDetailVO>od = new HashSet<OrderDetailVO>();

/* 把orderMaster OMID 與 orderDetail OMID 配對，放置於MAP中，key=OMID  value=List<orderDetail>  （多個)*/
				Iterator<Order_MasterVO> it = oms.iterator();
				while(it.hasNext()){
					Order_MasterVO bean = it.next();
/* 					out.print(bean.getOrder_Master_ID());
 */					List<OrderDetailVO>target = null;
					target = new ArrayList<OrderDetailVO>();
					for(int i = 0; i < ods.size(); i++){
						if(bean.getOrder_Master_ID().equals(ods.get(i).getOrder_Master_ID())){
							target.add(ods.get(i));
							od.add(ods.get(i));
						}
					}
					orderMap.put(bean.getOrder_Master_ID(), target);
				}
				pageContext.setAttribute("orderMap", orderMap);
/* 				out.print(orderMap);
				out.print("111111111111111:" + od); */
/* 產生productDetail */

				Map<String, ProductDetailVO>productDetailMap = new HashMap<String, ProductDetailVO>();
				ProductDetailService pdService = new ProductDetailService();
				List<ProductDetailVO>pdAll = pdService.getAll();
			   	for(OrderDetailVO bean : od){
			   		for(ProductDetailVO productBean : pdAll){
			   			if(bean.getProduct_Detail_ID().equals(productBean.getProduct_Detail_ID())){
			   				productDetailMap.put(productBean.getProduct_Detail_ID(), productBean);
			   			}
			   		}
			   	}
				pageContext.setAttribute("productDetailMap", productDetailMap);
/* 			   	out.print("productDetail:" + productDetailMap); */
			   	
/* 產生product */

				Map<String, ProductVO>productMap = new HashMap<String, ProductVO>();
				ProductService pService = new ProductService();
				List<ProductVO> productAll = pService.getAll();
				for(ProductDetailVO bean : pdAll){
					for(ProductVO productBean : productAll){
						if(bean.getProduct_ID().equals(productBean.getProduct_ID())){
							productMap.put(productBean.getProduct_ID(), productBean);
						}
					}
				}
				pageContext.setAttribute("productMap", productMap);
/* 				out.print("231312314435345345435453454535345435435345435453" + productMap); */

/* 拿到所有優惠券 */
				
				CouponService cService = new CouponService();
				List<CouponVO> coupons = cService.getAll();
				Map<String, CouponVO>couponMap = new HashMap<String, CouponVO>();
				for(Order_MasterVO omBean : oms){
					for(CouponVO couponBean : coupons){
						if(omBean.getCoupon_ID() != null){
							if(omBean.getCoupon_ID().equals(couponBean.getCoupon_ID())){
								couponMap.put(omBean.getOrder_Master_ID(), couponBean);
							}	
						}
					}
				}
				pageContext.setAttribute("coupons", couponMap);
			%>
<%-- 	<nav
		class="navbar navbar-expand navbar-light d-flex justify-content-start"
		style="background-color: #e3f2fd;">
		<a class="navbar-brand mr-auto" href="#"> <img
			src="<%=request.getContextPath()%>/img/david_img/logo.png" width="30"
			height="30" class="d-inline-block align-top" alt="tourism">
			Tourism
		</a>
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-pen"></i>建立行程</a></li>
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-store"></i>商城</a></li>
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-shopping-cart"></i>購物車</a></li>
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-sign-in-alt"></i>會員中心</a></li>
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-user"></i>USER</a></li>
		</ul>
	</nav> --%>
	<%@ include file="../pages/header.file" %>
	<div class="container mt-sm-4">
		<div class="row">

			<%-- <div class="sidebar col-lg-2 col-md-3 col-sm-4">
				<nav class="nav nav-pills flex-column">
					<div class="d-none d-sm-block nav-link text-center" href="#"> <img
						src="<%=request.getContextPath()%>/member/ShowMemberImage?id=${sessionScope.member.member_ID}"
						class="img-fluid align-top " alt="tourism"> Hi
						${member.member_Name }
					</div> 
					<a class="nav-link" href="#">個人中心</a> 
					<a class="nav-link active" href="#">管理訂單</a>
					<a class="nav-link" href="#">我的行程</a> 
					<a class="nav-link" href="#">管理票券</a>
					<a class="nav-link" href="#">我的信箱</a> 
					<a class="nav-link" href="#">我的購物車</a> 
					<a class="nav-link" href="#">我的評價</a> 
					<a class="nav-link" href="#">我的收藏</a>
				</nav>
			</div> --%>
			<%@include file="../pages/sidebar_member.file" %>
			<div class="content col-lg-10 col-md-9 col-sm-8">
				<div class="title">
		          <h2>我的訂單</h2>
		        </div>
		        <hr>
		        <div class="container-fluid py-3 border rounded">
					<c:if test="${!empty errorMsg}">
					<div class="row">
						<c:forEach var="error" items="${errorMsg }">
							<p class="text-danger mx-1">${error.value }</p>
						</c:forEach>
					</div>
					</c:if>
					<div class="row">
						<table class="table table-hover">
						  <thead>
						    <tr>
						      <th scope="col">訂單編號</th>
						      <th scope="col">日期</th>
						      <th scope="col">訂單狀態</th>
						      <th scope="col">商品總數</th>
						      <th scope="col">優惠券</th>
						      <th scope="col">付款方式</th>
						      <th scope="col" >功能</th>
						    </tr>
						  </thead>
						  
						  <tbody>
						  <c:forEach var="om" items="${oms }" varStatus="status">
								  <tr>
							      <th scope="row">${om.order_Master_ID }</th>
							      <fmt:parseDate var="timestamp" value="${om.order_Master_TimeStamp }" pattern="yyyy-MM-dd HH:mm:ss"></fmt:parseDate>
							      <td><fmt:formatDate value="${timestamp }" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							      <td>${om.order_Master_State }</td>
							      <td>
  							      	<c:forEach var="order" items="${orderMap }" >
 							      			<c:if test="${om.order_Master_ID eq order.key }">
									      		${fn:length(order.value) }
	 								       </c:if> 
							      	</c:forEach>  
							      </td>
							      <td>
							      	<c:forEach var="coupon" items="${coupons }">
							      		<c:if test="${om.order_Master_ID eq coupon.key }">
							      			${coupon.value.coupon_Name }
							      		</c:if>
							      	</c:forEach>
							      </td>
							      <td>${om.order_Master_Payment }</td>
							      <td>
								      <div class="dropdown">
								      	<button type="button" class="btn btn-primary dropdown-toggle" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="drop_title">功能鍵</span><i class="fas fa-spinner fa-spin fa-2x loading -none"></i></button>
								      	  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
										    <a class="dropdown-item" data-toggle="modal" data-target="#${om.order_Master_ID }" href="#">看明細</a>
										    <a class="cancel_order dropdown-item" data-order_master_id="${om.order_Master_ID }" href="#">取消訂單	</a>
										  </div>
								      </div>
							      </td>
							      
							    </tr>
						  </c:forEach>
						  </tbody>
						  
						</table>
					</div>
				</div>
		    </div>
		    
		</div>
	</div>
<c:forEach var="order" items="${orderMap }">
<c:set var="totalprice" value="${0 }"></c:set>
<!-- 彈出視窗---訂單明細 -->
	<div class="modal fade" id="${order.key }" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">訂單編號：${order.key }</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <table class="table table-hover">
			  <thead>
			    <tr>
			      <th scope="col">商品名稱</th>
			      <th scope="col">商品樣式</th>
			      <th scope="col">商品單價</th>
			      <th scope="col">商品小計</th>
			      <th scope="col">購買數量</th>
			      <th scope="col">剩餘數量</th>
			      <th scope="col">使用票券</th>
			      <th scope="col">商品評價</th>
			      
			    </tr>
			  </thead>
			  
			  
			  <tbody>
			  <c:forEach var="orderDetail" items="${order.value }">
			  <c:forEach var="productDetail" items="${productDetailMap }" varStatus="pdStatus">
			    <c:if test="${orderDetail.product_Detail_ID eq productDetail.key }">
			    <tr data-order_detail_id="${orderDetail.order_Detail_ID }">
			    <c:forEach var="product" items="${productMap }">
			    	<c:if test="${productDetail.value.product_ID eq product.key }">
			    		<th scope="row">${product.value.product_Name }</th>
			    		
			    	</c:if>
			    </c:forEach>
			      <fmt:parseNumber var="qty" type="number" value="${orderDetail.order_Detail_Qty }"></fmt:parseNumber>
			      <td>${productDetail.value.product_Detail_Spc }</td>
			      <td>${productDetail.value.product_Detail_Money }</td>
			      <fmt:parseNumber var="price" type="number" value="${productDetail.value.product_Detail_Money }"></fmt:parseNumber>
			      <td>${qty * price }</td>
			      <fmt:parseNumber var="usedQty" type="number" value="${orderDetail.order_Detail_Used_Qty }"></fmt:parseNumber>
			      <td>${orderDetail.order_Detail_Qty }</td>
			      <td class="ticket_remaining">${qty - usedQty }</td>
			      <c:set var="totalprice" value="${totalprice + qty * price }"></c:set>
			      <td><button class="check_ticket btn btn-light" type="button"><i class="fas fa-ticket-alt"></i></button></td>
			      <td>
				      <button type="button" class="btn btn-light" id="write" data-toggle="collapse" data-target="#collapse${productDetail.key += pdStatus.index}" aria-expanded="false" aria-controls="collapseExample">
							<i class="fas fa-pen"></i>
					  </button>
			      </td>
			    </tr>

			    <tr class="order d-none">
			    	<td colspan="8">
			    		<div class="collapse" id="collapse${productDetail.key += pdStatus.index }">
				    		<div class="container border rounded">
							 <div class="row">
							 	<div class="col-sm-4 d-flex">
							 		<c:forEach var="product" items="${productMap }">
							 			<c:if test="${productDetail.value.product_ID eq product.key }">
										    <img class="img-fluid my-auto" src="<%=request.getContextPath()%>/util/ShowProductImage?id=${product.value.product_ID}" alt="Card image">
							 			</c:if>
							 		</c:forEach>
							 	</div>
							 		
								  <div class="col-sm-8">
								    <form class="productcomment" method="POST" action="<c:url value="/comment/Product_Comment.Controller" />" enctype="multipart/form-data">
								    <input type="hidden" name="productID" value="${productDetail.value.product_ID }">
								    <div class="card">
								      <div class="card-body">
								      <div class="row">
								      	<c:forEach var="product" items="${productMap }">
			    						<c:if test="${productDetail.value.product_ID eq product.key }">
								        <h5 class="card-title col-4">${product.value.product_Name }</h5>
								        </c:if>
								        </c:forEach>
								        <div class="ml-2 star_block">
									        <span class="star" data-star="1"><i class="fas fa-star"></i></span>
									        <span class="star" data-star="2"><i class="fas fa-star"></i></span>
									        <span class="star" data-star="3"><i class="fas fa-star"></i></span>
									        <span class="star" data-star="4"><i class="fas fa-star"></i></span>
									        <span class="star" data-star="5"><i class="fas fa-star"></i></span>
								        </div>
								        <input class="pgrade" type="hidden" name="pgrade" placeholder="等級">
								      </div>
							            <div class="form-group">
									      <label>請留下您的評價</label>
									      <textarea class="form-control" name="pcomment" rows="3"></textarea>
									    </div>
									    
									    <div class="input-group mb-3">
										  <div class="custom-file">
										    <input type="file" class="custom-file-input pfile1" name="pfile1" aria-describedby="inputGroupFileAddon01">
										    <label class="custom-file-label">Choose file</label>
										  </div>
										  <div class="custom-file">
										    <input type="file" class="custom-file-input pfile2" name="pfile2" aria-describedby="inputGroupFileAddon02">
										    <label class="custom-file-label">Choose file</label>
										  </div>
			
									    </div>
									    <img  class="img-fluid rounded file1_img" width="100">
									    <img  class="img-fluid rounded file2_img" width="100">
								    </div>
								    <div class="card-footer">
								    	<input type="hidden" name="action" value="writecomment">
								        <button type="button" class="btn btn-primary psubmmit">確定</button>
								        <button type="button" class="collapseclose btn btn-secondary" data-toggle="collapse" data-target="#collapse${productDetail.key += pdStatus.index}">取消</button>
								    
              						</div>
								  </div>
								  </form>
							</div>
						  </div>
					  </div>
					  </div>
			    	</td>
			    </tr>
			   </c:if>			    				    
			  </c:forEach>
			  </c:forEach>
			  </tbody>
			</table>
	      </div>
	      <div class="modal-footer">
	      	<div class="p-2 bg-warning text-dark">金額總計：${totalprice }</div>
	      	<c:forEach var="coupon" items="${coupons }">
				<c:if test="${order.key eq coupon.key }">
					<fmt:parseNumber type="number" var="discount" value="${coupon.value.coupon_Class }"></fmt:parseNumber>
			      	<div class="p-2 bg-warning text-dark">優惠金額總計：${totalprice * discount }</div>
				</c:if>
			</c:forEach>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
	      </div>
	    </div>
	  </div>
	</div>
</c:forEach>
	<%@ include file="../pages/footer.file" %>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
	<script src="https://unpkg.com/@popperjs/core@2"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>
	<script>
	
		$('button#write').on('click', function(){
/* 			console.log('123');
 */			$(this).closest("tr").next("tr.order").toggleClass("d-none");
		});
		
		$('button.collapseclose').on('click', function(){
			console.log('123');
			$(this).closest("tr.order").toggleClass("d-none");
		});
		
		$('button.psubmmit').on('click', function(){
			$(this).closest("form.productcomment").submit();
		})
//========================取消訂單ＡＪＡＸ===================================
		$(function(){
			$('a.cancel_order').on('click', function(){
				let cancel_order = $(this);
				Swal.fire({
					  icon: 'warning',
					  title: '確認取消訂單？',
					  text: '按下確認鍵您的剩餘票券將無法再度使用',
					  showCancelButton: true,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: '確認刪除!'
					}).then((result) =>{
						if(result.value){
							let order_Master_ID = $(this).data('order_master_id');
							console.log(order_Master_ID);
							let form_data = {
									"action": "cancelOrder",
									"order_Master_ID": order_Master_ID
							};
							let form_dataString = JSON.stringify(form_data);
							$.ajax({
								url:"<%=request.getContextPath()%>/order_master/UpdateOrder_Master.Api",
								type: 'POST',
								dataType: 'json',
								data: form_dataString,
								beforeSend: function(){
									console.log('ajax');
									console.log(cancel_order);
									cancel_order.closest('div.dropdown').find('span.drop_title').toggleClass('-none');
									cancel_order.closest('div.dropdown').find('svg.loading').show();
								},
								success: function(res){
									cancel_order.closest('div.dropdown').find('span.drop_title').toggleClass('-none');
									cancel_order.closest('div.dropdown').find('svg.loading').hide();
									if(res.result === true){
										Swal.fire({
											icon: 'success',
											title: '成功',
											text: res.reason
										})
										cancel_order.closest('tr').remove(); 
									}else{
										Swal.fire({
											icon: 'error',
											title: '訂單取消失敗',
											text: res.reason
										});
										return;
									}
								}
							})
	 					}
					});
			});	
		})
//========================預覽圖片===================================	
		
	
	    $('input.pfile1').on("change", function () {
    	  let file1 = $(this).closest('div.card-body').find("input.pfile1");
	      let file1_img = $(this).closest('div.card-body').find("img.file1_img");
	      console.log("upload");
	      let reader = new FileReader;
	      reader.readAsDataURL(this.files[0]);
	      reader.addEventListener("load", function () {
	        file1_img.attr("src", reader.result);
	      })
	    })
	    
		 $('input.pfile2').on("change", function () {
    	  let file1 = $(this).closest('div.card-body').find("input.pfile2");
	      let file1_img = $(this).closest('div.card-body').find("img.file2_img");
	      console.log("upload");
	      let reader = new FileReader;
	      reader.readAsDataURL(this.files[0]);
	      reader.addEventListener("load", function () {
	        file1_img.attr("src", reader.result);
	      })
	    })
//========================預覽圖片結束===================================	
	
		$('tr.order').on('click', '.star', function(){
			let temp = $(this).data('star');
/* 			console.log(temp); */
 			$(this).closest('div.star_block').find('span.star').each(function(index, item){
				if($(item).data('star') <= temp){
					$(item).addClass("-on");
				}else{
					$(item).removeClass("-on");
				}
			});
			
			$(this).closest('div.card-body').find('input.pgrade').val(temp);
		})
//===========================使用票券====================================
//==========================確認票券數量===============================		
	$('tr').on('click', 'button.check_ticket', function(){
	
			if($(this).closest('tr').find('td.ticket_remaining').text() === "0"){
				Swal.fire({
					icon: 'error',
					title: '票券用畢',
					text: '您的票券已使用完畢，請再次購買'		
				});
			}else{
				let node = `<div class="row"><input type="text" class="use_qty form-control d-inline"><button class="use_ticket btn btn-primary mx-1">使用</button></div><i class="fas fa-spinner fa-spin fa-2x loading -none"></i>`;
				$(this).closest('td').html(node);
				
			}			
		});
//===========================輸入數量  使用票券===========================
	$('tr').on('click', 'button.use_ticket', function(){
		let this_button = $(this);
		let order_Detail_ID = $(this).closest('tr').data('order_detail_id');
		console.log(order_Detail_ID);
		let use_qty = $(this).closest('tr').find('input.use_qty').val().trim();
		
		
		if(use_qty != parseInt(use_qty) || use_qty <= 0){
			Swal.fire({
				icon: 'error',
				title: '格式錯誤',
				text: '請輸入正確的數量'		
			});	
		}else{
			if(use_qty > parseInt($(this).closest('tr').find('td.ticket_remaining').text())){
				Swal.fire({
					icon: 'error',
					title: '數量錯誤',
					text: '請確認您的剩餘數量'		
				});
			}else{
				let form_data = {
						'action': 'use_ticket',
						'order_Detail_ID': order_Detail_ID,
						'use_qty': use_qty
				}
				let form_dataString = JSON.stringify(form_data);
<%-- 				let path = "<%=request.getServerName() + ":" + request.getServerPort() + request.getContextPath()%>" ;
 --%>				let path = "<%=request.getRequestURL()%>" ;
				let param = '/order_detail/UpdateOrder_Detail.Api?action=use_ticket&order_Detail_ID=' + order_Detail_ID.toString() + '&use_qty=' + use_qty.toString();
				let final = path + param;
				console.log(path);
				console.log(param);
				console.log(final);
				this_button.closest('div.modal-content').find('div.modal-footer').prepend(`<img class="img" src="<%=request.getContextPath()%>/util/ShowTicketBarcode?path=` + final + `" height="200px" ">`);
<%-- 				$.ajax({
					url:'<%=request.getContextPath()%>/order_detail/UpdateOrder_Detail.Api',
					type: 'POST',
					dataType: 'json',
					data: form_dataString,
					beforeSend: function(){
						this_button.closest('div.row').toggleClass('-none');
						this_button.closest('td').find('svg.loading').show();
					},
					success: function(res){
						this_button.closest('td').find('svg.loading').hide();
						this_button.closest('div.row').toggleClass('-none');
						if(res.result === false){
							Swal.fire({
								icon: 'error',
								title: '使用失敗',
								text: '原因：' + res.reason
							});
						}else{
							Swal.fire({
								icon: 'success',
								title: '使用成功',
								text: res.reason
							});
						let node = `<button class="check_ticket btn btn-light" type="button"><i class="fas fa-ticket-alt"></i></button>`;	
						this_button.closest('tr').find('td.ticket_remaining').text(res.remaining);
						this_button.closest('td').html(node);	
						}
					}
				}) --%>
			}
		}
	});
	</script>
</body>
</html>