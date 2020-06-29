<%@page import="java.util.stream.Collectors"%>
<%@page import="com.customerizedetail.model.CustDetailVO"%>
<%@page import="com.customerizedetail.model.CustDetailService"%>
<%@page import="com.customerize.model.CustomerizeVO"%>
<%@page import="com.customerize.model.CustomerizeService"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.productcmt.model.ProductCmtVO"%>
<%@page import="com.productcmt.model.ProductCmtService"%>
<%@page import="com.product.model.ProductDetailVO"%>
<%@page import="com.product.model.ProductDetailService"%>
<%@page import="com.product.model.ProductService"%>
<%@page import="com.product.model.ProductVO"%>
<%@page import="com.collection.model.CollectionVO"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.collection.model.CollectionService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>

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
<style type="text/css">
body {
  font-size: 16px;
  font-family: Microsoft JhengHei;
  color: #343434;
  background-color: #F5F5F5;
}
.-none {
	display: none;
}
div.sidebar a.nav-link:hover{
	background-color: #007bff;
	color: #fff;
}
hr.top_hr {
	border: 1px solid rgb(13, 218, 218);
	
body nav.bg-dark {
  /* background-color: #707070 !important; */
  background: -webkit-linear-gradient(#E0DFDF,#F5F5F5);
  background: -o-linear-gradient(#E0DFDF,#F5F5F5);
  background: -moz-linear-gradient(#E0DFDF,#F5F5F5);
  background: linear-gradient(#E0DFDF,#F5F5F5);
}
div.card {
  border: solid 1px #31C7D2;
  -webkit-mask-image: -webkit-radial-gradient(circle, white 100%, black 100%);
}
.card-title a{
  color: #343434;
}
div.sidebar a.nav-link:hover{
	background-color: #007bff;
	color: #fff;
}
</style>
<title>Insert title here</title>

</head>
<body>
<%
	//取得當天登入會員ID
	MemberVO member = (MemberVO) session.getAttribute("member");
	String member_ID = member.getMember_ID();
//取得所有某一個會員的customerMaster
	CustomerizeService cService = new CustomerizeService();
	List<CustomerizeVO> custs = cService.getAll().stream()
	.filter(cust -> cust.getMember_ID().equals(member_ID))
	.filter(cust -> cust.getCust_Schedule_State().equals(1))
	.sorted(Comparator.comparing(CustomerizeVO::getCust_Schedule_ID).reversed())
	.collect(Collectors.toList());
	pageContext.setAttribute("custsMaster", custs);
	
//取得custMaster的custsDetail資訊（主要是product ID)
//找出collection中的所有productID
	CustDetailService cdService = new CustDetailService();
	List<CustDetailVO>custDetails = cdService.getAll();
	Map<String, Integer>custDetailMap = new HashMap<String, Integer>();
	for(CustomerizeVO bean : custs){
		List<String>product_ID = custDetails.stream()
		.filter(custDetail -> custDetail.getCust_Schedule_ID().equals(bean.getCust_Schedule_ID()))
		.map(custDetail -> custDetail.getProduct_ID())
		.collect(Collectors.toList());
		custDetailMap.put(bean.getCust_Schedule_ID(), product_ID.size());
	}
	pageContext.setAttribute("custDetailMap", custDetailMap);
%>
	<%@ include file="../pages/header.file" %>
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
	<div class="container mt-sm-4">
		<div class="row mb-5">

			<%-- <div class="sidebar col-lg-2 col-md-3 col-sm-4">
				<nav class="nav nav-pills flex-column">
					<div class="d-none d-sm-block nav-link text-center"> <img
						src="<%=request.getContextPath()%>/member/ShowMemberImage?id=${sessionScope.member.member_ID}"
						class="img-fluid align-top " alt="tourism"> Hi
						${member.member_Name }
					</div> 
					<a class="nav-link" href="#">個人中心</a> 
					<a class="nav-link" href="#">管理訂單</a>
					<a class="nav-link  active" href="#">我的行程</a> 
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
		          <h2>我的行程</h2>
		        </div>
		        <hr class="top_hr">
		        <div class="container-fluid py-3 border rounded">
					
					<div class="row">
					
					<c:forEach var="custMaster" items="${custsMaster }">
						  <div class="col-lg-4 col-md-6 mb-4">
				            <div class="card h-100" data-schedule_id="${custMaster.cust_Schedule_ID }">
				              <a href=""><img class="card-img-top" src="<%=request.getContextPath()%>/util/ShowCustImage?id=${custMaster.cust_Schedule_ID}" height="200px"></a>
				              <div class="card-body">
				                <h4 class="card-title">
				                  <a href="<%=request.getContextPath()%>/CustomerizeController?action=produce_schedule&cust_schedule_id=${custMaster.cust_Schedule_ID}">${custMaster.cust_Schedule_Name }</a>
				                </h4>
				                <fmt:parseNumber var="days" type="number" integerOnly="true" value="${custMaster.cust_Schedule_Total_Day }"></fmt:parseNumber>
				                <p class="card-text"><i class="far fa-calendar-alt"></i>安排天數: ${days }</p>
				                <p class="card-text"><i class="fas fa-hourglass-start"></i>起始時間: ${custMaster.cust_Schedule_Start_Time }</p>
				                <p class="card-text"><i class="fas fa-hourglass-end"></i>結束時間: ${custMaster.cust_Schedule_End_Time }</p>
				                <p class="card-text"><i class="fas fa-map-marker-alt"></i>安排景點: 
				                <c:forEach var="DetailMap" items="${custDetailMap }">
				                	<c:if test="${custMaster.cust_Schedule_ID eq DetailMap.key}">
		                				${DetailMap.value}
				                	</c:if>
				                </c:forEach>
				                </p>	
<%-- 				              <c:forEach var="grade" items="${gradeMap }" >
				              <p class="scoreToStar d-inline"></p>
				              <c:if test="${product.product_ID eq grade.key }">
							  <p class="score d-inline card-text" >${grade.value }</p>
							  </c:if>
				              </c:forEach> --%> 
				              </div>
				              <div class="card-footer">
				              <c:forEach var="collection" items="${collections }">
				              	<c:if test="${collection.product_ID eq product.product_ID }">
					              	<input type="hidden" class="collectionid" value="${collection.collection_ID }" class="">
				              	</c:if>
				              </c:forEach>
				              	<button type="button" name="button" class="removeSchedule" STYLE="background-color: transparent; border:2px blue none; outline:none;">
				              	<i class="fas fa-heart fa-1x" style="color: #E93F3F; font-size: 1.5em;"></i>移除行程
				              	</button>
				                <i class="fas fa-spinner fa-spin fa-2x loading -none"></i>  
				              </div>
				            </div>
				          </div>
					</c:forEach>




					</div>
				</div>
		    </div>
		    
		</div>
	</div>

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
		loadStar();
	
	
		function loadStar(){
		  $(".score").each(function(index, item){
		    let score = $(this).html();
		    let star = "";
		    let count = 0;
		    for(score; score>0; score--){
		      if(score-1<0){
		        star += `<i class="fas fa-star-half-alt" style="color:#FFDD26;"></i>`
		        score--;
		        count++;
		      }else{
		        star += `<i class="fas fa-star" style="color:#FFDD26;"></i>`;
		        count++;
		      }
		    }
		  let i = 5-count;
		  for(i; i>0; i--){
		    star += `<i class="far fa-star" style="color:#FFDD26;"></i>`;
		  }
		  $(this).prev("p").html(star);
		  });
		}
		
		$('button.removeSchedule').on('click', function(){
			let buttonRemove = $(this);
			let schedule_id = $(this).closest('div.card').data('schedule_id');
			console.log(schedule_id);
			let form_data = {
					"schedule_id" : schedule_id 
			}
			
			let form_dataString = JSON.stringify(form_data);
			$.ajax({
				url: "<%=request.getContextPath()%>/collection/RemoveSchedule.Api",
				type: 'POST',
				contentType: 'json',
				data: form_dataString,
				beforeSend: function(){
					buttonRemove.hide();
					buttonRemove.closest('div.card-footer').find('svg.loading').show();	
				},
				success: function(res){
					buttonRemove.show();
					buttonRemove.closest('div.card-footer').find('svg.loading').hide();	
					console.log(res);
					console.log(res.reason);
					if(res.result === true){
						Swal.fire({
							icon: 'success',
							text: '成功刪除'
						});
					buttonRemove.closest('div.col-lg-4').remove();	
					}
					else{
						Swal.fire({
							icon: 'error',
							text: '刪除失敗'
						});
					}
				} 
				
			});
		});
		
		$(document).on('click', ".card", function(){
			let product_ID= $(this).data('product_id');
			let product_Class = $(this).data('product_class');
/* 	    	window.location.href='../ProductServlet.do?action=goDetailPage&product_ID='+product_ID+"&product_Class="+product_Class;
 */
		})
</script>
</body>
</html>