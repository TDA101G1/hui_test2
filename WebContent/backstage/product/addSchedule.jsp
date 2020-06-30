<%@page import="com.employee.model.EmployeeVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product.model.*"%>
<%@ page import="java.util.*"%>
<%
	ProductVO pVO = (ProductVO) request.getAttribute("pVO");
	ProductDetailVO pdVO = (ProductDetailVO) request.getAttribute("pdVO");
	EmployeeVO in_empVO = (EmployeeVO) session.getAttribute("in_empVO");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<title>後台管理系統</title>

<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/backstage/Home/plugins/fontawesome-free/css/all.min.css">
<!-- IonIcons -->
<link rel="stylesheet"
	href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/backstage/Home/dist/css/adminlte.min.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/backstage/Home/plugins/summernote/summernote-bs4.css">
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
	rel="stylesheet">



<style>
img {
	width: 150px;
}

.btn {
	margin-left: 50px;
}

div.pagination {
	/* display: block; */
	margin-top: 80px;
	margin-bottom: 200px;
	/* margin-left: 24%; */
}
/* Pagination links */
.pagination a {
	color: black;
	font-family: roboto;
	font-size: 16px;
	float: left;
	padding-top: 4px;
	text-decoration: none;
	transition: background-color .3s;
	margin-left: 2px;
	margin-right: 2px;
	border: 1px solid #E2E2E2;
	border-radius: 4px;
	height: 32px;
	width: 32px;
	box-sizing: border-box;
	text-align: center;
}

/* Style the active/current link */
.pagination a.active {
	background-color: #E6903B;
	color: white;
}

/* Add a grey background color on mouse-over */
.paginationa








:hover




































































:not


































 


































(
.active


































 


































){
background-color




































































:


































 


































#ddd




































































;
}
label.label_area {
	display: block;
	font-size: 16px;
}

label.label_area input {
	display: inline-block;
	position: relative;
	top: 5px;
	font-size: 20px;
	width: 21px;
	height: 21px;
}

label.label_area a {
	display: inline-block;
}

/* Style the Image Used to Trigger the Modal */
#myImg {
	border-radius: 5px;
	cursor: pointer;
	transition: 0.3s;
}

#myImg:hover {
	opacity: 0.7;
}

/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.9); /* Black w/ opacity */
}

/* Modal Content (Image) */
.modal-content {
	margin: auto;
	display: block;
	width: 80%;
	max-width: 700px;
}

/* Caption of Modal Image (Image Text) - Same Width as the Image */
#caption {
	margin: auto;
	display: block;
	width: 80%;
	max-width: 700px;
	text-align: center;
	color: #ccc;
	padding: 10px 0;
	height: 150px;
}

/* Add Animation - Zoom in the Modal */
.modal-content, #caption {
	animation-name: zoom;
	animation-duration: 0.6s;
}

@
keyframes zoom {
	from {transform: scale(0)
}

to {
	transform: scale(1)
}

}

/* The Close Button */
.close {
	position: absolute;
	top: 15px;
	right: 35px;
	color: #f1f1f1;
	font-size: 40px;
	font-weight: bold;
	transition: 0.3s;
}

.close:hover, .close:focus {
	color: #bbb;
	text-decoration: none;
	cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px) {
	.modal-content {
		width: 100%;
	}
}

/*   搜尋欄相關      */
.search_area {
	width: 60%;
	vertical-align: middle;
	white-space: nowrap;
	position: relative;
	display: inline-block;
	margin-left: 5%;
	margin-bottom: 50px;
	margin-top: 50px;

	/* left: 10%; */
	/* border: solid 2px; */
}

.search_area input#search {
	width: 100%;
	height: 40px;
	/* border: solid 1px; */
	font-size: 10pt;
	float: left;
	color: #63717f;
	padding-left: 10px;
	/* -webkit-border-radius: 5px;
  -moz-border-radius: 5px; */
	border-radius: 20px;
	display: block;
	border: solid 1px;
	/* -webkit-transition: background .55s ease;
  -moz-transition: background .55s ease;
  -ms-transition: background .55s ease;
  -o-transition: background .55s ease; */
	transition: background .55s ease;
}

.search_area input#search::-webkit-input-placeholder {
	color: #65737e;
}

.search_area input#search:-moz-placeholder { /* Firefox 18- */
	color: #65737e;
}

.search_area input#search::-moz-placeholder { /* Firefox 19+ */
	color: #65737e;
}

.search_area input#search:-ms-input-placeholder {
	color: #65737e;
}

.search_area .searchIcon {
	max-width: auto;
	/* border: solid 2px; */
	display: fixed;
	position: absolute;
	right: 10px;
	top: 8px;
	z-index: 1;
	color: #4f5b66;
}

.search_area input#search:hover, .search_area input#search:focus,
	.search_area input#search:active {
	outline: none;
	background: #f0f0f0;
}

/* 預覽圖 */
input[disabled] {
	background-color: #eee;
	cursor: not-allowed;
}

#drop_zone {
	border: 1px dashed #ccc;
	height: 50px;
	position: relative;
}

#drop_zone span.text {
	position: absolute;
	display: inline-block;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	z-index: -1;
	color: lightgray;
}

#preview.-on {
	border: 1px dashed lightblue;
	box-shadow: 3px 3px 5px lightblue inset, -3px -3px 5px lightblue inset;
}

#preview1.-on {
	border: 1px dashed lightblue;
	box-shadow: 3px 3px 5px lightblue inset, -3px -3px 5px lightblue inset;
}

#preview2.-on {
	border: 1px dashed lightblue;
	box-shadow: 3px 3px 5px lightblue inset, -3px -3px 5px lightblue inset;
}

#preview3.-on {
	border: 1px dashed lightblue;
	box-shadow: 3px 3px 5px lightblue inset, -3px -3px 5px lightblue inset;
}

#preview4.-on {
	border: 1px dashed lightblue;
	box-shadow: 3px 3px 5px lightblue inset, -3px -3px 5px lightblue inset;
}

#preview, #preview1, #preview2, #preview3, #preview4 {
	border: 1px solid lightgray;
	display: inline-block;
	width: 250px;
	min-height: 150px;
	position: relative;
	margin-left: 30px;
	margin-bottom: 20px;
}

#preview img.preview_img {
	width: 100%;
}

#preview1 img.preview_img {
	width: 100%;
}

#preview2 img.preview_img {
	width: 100%;
}

#preview3 img.preview_img {
	width: 100%;
}

#preview4 img.preview_img {
	width: 100%;
}

#p_file, #p_file2, #p_file3, #p_file4, #p_file1 {
	margin-left: 30px;
}
</style>
<style type="text/css">
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}

/* Optional: Makes the sample page fill the window. */
html, body {
	height: 50%;
	margin: 0;
	padding: 0;
}
</style>

</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to to the body tag
to get the desired effect
|---------------------------------------------------------|
|LAYOUT OPTIONS | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->

<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!-- Navbar -->
		<nav
			class="main-header navbar navbar-expand navbar-white navbar-light">
			<!-- Left navbar links -->
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" data-widget="pushmenu"
					href="#" role="button"><i class="fas fa-bars"></i></a></li>

			</ul>

			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath()%>/backstage/login.jsp"><i
						class="fas fa-sign-out-alt"></i> 登出</a></li>
				<!--  顏色按鈕 -->
				<li class="nav-item"><a class="nav-link"
					data-widget="control-sidebar" data-slide="true" href="#"
					role="button"><i class="fas fa-th-large"></i></a></li>
			</ul>

		</nav>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<aside class="main-sidebar sidebar-dark-primary elevation-4">
			<!-- Brand Logo -->
			<a href="<%=request.getContextPath()%>/backstage/Home.jsp"
				class="brand-link"> <img
				src="<%=request.getContextPath()%>/backstage/img/logo.jpg"
				alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
				style="opacity: .8"> <span
				class="brand-text font-weight-light">tourism</span>
			</a>

			<!-- Sidebar -->
			<div class="sidebar">
				<!-- Sidebar user panel (optional) -->
				<div class="user-panel mt-3 pb-3 mb-3 d-flex">
					<div class="image">
						<img
							src="<%=request.getContextPath()%>/employee/ShowImage?emp_ID=${in_empVO.emp_ID}"
							class="img-circle elevation-2" alt="User Image">
					</div>
					<div class="info">
						<a href="#" class="d-block">${in_empVO.emp_Name}</a>
					</div>
				</div>

				<!-- Sidebar Menu -->
				<nav class="mt-2">
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->

						<!-- 						<li class="nav-item"><a href="pages/widgets.html" -->
						<!-- 							class="nav-link"> <i class="nav-icon fas fa-th"></i> -->
						<!-- 								<p> -->

						<!-- 									 <span class="right badge badge-danger">New</span> 新訊息提示 -->
						<!-- 								</p> -->
						<!-- 						</a></li> -->
						<li class="nav-item has-treeview"><a href="#"
							class="nav-link"> <i class="fas fa-users"></i>
								<p>
									會員 <i class="fas fa-angle-left right"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a
									href="<%=request.getContextPath()%>/backstage/member/getAllMember.jsp"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>會員查詢</p>
								</a></li>

							</ul></li>

						<li class="nav-item has-treeview"><a href="#"
							class="nav-link"> <i class="far fa-envelope"></i>
								<p>
									信件 <i class="fas fa-angle-left right"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a
									href="<%=request.getContextPath()%>/backstage/inbox/Email.jsp"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>信箱</p>
								</a></li>


							</ul></li>

						<li class="nav-item has-treeview"><a href="#"
							class="nav-link"><i class="fas fa-percent"></i>
								<p>
									優惠券 <i class="fas fa-angle-left right"></i>
								</p> </a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a
									href="<%=request.getContextPath()%>/backstage/coupon/getAllCoupon.jsp"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>優惠券查詢</p>
								</a></li>
								<li class="nav-item"><a
									href="<%=request.getContextPath()%>/backstage/coupon/addCoupon.jsp"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>新增優惠券</p>
								</a></li>
							</ul></li>

						<!-- 						<li class="nav-item has-treeview"><a href="#" -->
						<!-- 							class="nav-link"> <i class="fas fa-fire-alt"></i> -->
						<!-- 								<p> -->
						<!-- 									人氣排行 <i class="fas fa-angle-left right"></i> -->
						<!-- 								</p> -->
						<!-- 						</a> -->
						<!-- 							<ul class="nav nav-treeview"> -->
						<!-- 								<li class="nav-item"><a -->
						<%-- 									href="<%=request.getContextPath()%>/backstage/employee/add.jsp" --%>
						<!-- 									class="nav-link"> <i class="far fa-circle nav-icon"></i> -->
						<!-- 										<p>調整人氣商品</p> -->
						<!-- 								</a></li> -->
						<!-- 							</ul></li> -->

						<li class="nav-item has-treeview menu-open"><a href="#"
							class="nav-link active"> <i class="fas fa-shopping-cart"></i>
								<p>
									商品 <i class="fas fa-angle-left right"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a
									href="<%=request.getContextPath()%>/backstage/product/getAllproduct.jsp"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>商品查詢</p>
								</a></li>
								<li class="nav-item"><a
									href="<%=request.getContextPath()%>/backstage/product/addProduct.jsp"
									class="nav-link "> <i class="far fa-circle nav-icon"></i>
										<p>新增一般商品</p>

										<li class="nav-item"><a
											href="<%=request.getContextPath()%>/backstage/product/addSchedule.jsp"
											class="nav-link active"> <i
												class="far fa-circle nav-icon"></i>
												<p>新增套裝行程</p>
										</a></li>
							</ul></li>


						<li class="nav-item has-treeview"><a href="#"
							class="nav-link"> <i class="far fa-edit"></i>
								<p>
									訂單 <i class="fas fa-angle-left right"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a
									href="<%=request.getContextPath()%>/backstage/Order_Master/getAllOrder_Master.jsp"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>查詢訂單</p>
								</a></li>
							</ul></li>

						<c:if test="${(in_empVO.emp_Grade)==1}">

							<li class="nav-item has-treeview"><a href="#"
								class="nav-link"> <i class="fas fa-address-book"></i>
									<p>
										員工管理 <i class="fas fa-angle-left right"></i>
									</p>
							</a>
								<ul class="nav nav-treeview">
									<li class="nav-item"><a
										href="<%=request.getContextPath()%>/backstage/employee/getAllEMP.jsp"
										class="nav-link"> <i class="far fa-circle nav-icon"></i>
											<p>員工查詢</p>
									</a></li>
									<li class="nav-item"><a
										href="<%=request.getContextPath()%>/backstage/employee/add.jsp"
										class="nav-link"> <i class="far fa-circle nav-icon"></i>
											<p>新增員工</p>
									</a></li>
						</c:if>
				</nav>
				<!-- /.sidebar-menu -->
			</div>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">

				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0 text-dark">新稱商品</h1>

							<!-- Left navbar links -->

						</div>

					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->

			<!-- Main content -->
			<div class="content">
				<div class="container-fluid col-12">
					<div class="row col-12">
						<!-- 搜尋欄 -->
						<div class="col">

							<br> <br>

						</div>




						<div class="card col-12">

							<div class="card-header"></div>
							<div class="card-title">

								<div class="col">
									<div class="card  card-tabs">
										<div class="card-header ">
											<h2>請填入相關資料</h2>
										</div>
									</div>
								</div>

								<div class="card-body" style="overflow: auto">
									<div class="col-lg">

										<FORM METHOD="post"
											ACTION="<%=request.getContextPath()%>/backstage/ProductServlet.do"
											class="form1" enctype="multipart/form-data">
											<table>

												<label>商品圖片：</label>
												<br>
												<input type="file" id="p_file" accept="image/*"
													name="product_Img1" class="col-2">

												<input type="file" id="p_file1" accept="image/*"
													name="product_Img2" class="col-2">

												<input type="file" id="p_file2" accept="image/*"
													name="product_Img3" class="col-2">
												<input type="file" id="p_file3" accept="image/*"
													name="product_Img4" class="col-2">
												<input type="file" id="p_file4" accept="image/*"
													name="product_Img5" class="col-2">



											
												<p style="color: red">${errorMsgs.product_Img1}</p>
										
												<p style="color: red">${errorMsgs.product_Img2}</p>
											
												<p style="color: red">${errorMsgs.product_Img3}</p>
										
												<p style="color: red">${errorMsgs.product_Img4}</p>
										
												<p style="color: red">${errorMsgs.product_Img5}</p>

												
												<div class="row">


													<div id="preview" class="col-2">
														<span class="text">預覽圖</span>
													</div>


													<div id="preview1" class="col-2">
														<span class="text">預覽圖</span>
													</div>

													<div id="preview2" class="col-2">
														<span class="text">預覽圖</span>
													</div>

													<div id="preview3" class="col-2">
														<span class="text">預覽圖</span>
													</div>

													<div id="preview4" class="col-2">
														<span class="text">預覽圖</span>
													</div>
												</div>

												<hr>
												<br>
												<div class="container">


													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">商品名稱:</span>
														</div>

														<input type="text" class="form-control col-6 "
															placeholder="Name" aria-describedby="basic-addon1"
															value="<%=(pVO == null) ? "" : pVO.getProduct_Name()%>"
															id="product_Name" name="product_Name" />
													</div>
													<p style="color: red">${errorMsgs.product_Name}</p>


													<div class="input-group mb-3">

														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">景點類別:套裝行程
															</span>

														</div>
													</div>



													<div class="input-group">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">景點狀態:</span>

															<div class="input-group-prepend">
																<div class="input-group-text">
																	<input type="radio" name="product_State"
																		aria-label="Radio button for following text input"
																		value="1"
																		<%=(pVO == null) ? "checked" : (pVO.getProduct_State() == 1) ? "checked" : ""%> />上架
																	<input type="radio" name="product_State"
																		aria-label="Radio button for following text input"
																		value="0"
																		<%=(pVO != null && pVO.getProduct_State() == 0) ? "checked" : ""%> />下架
																</div>
															</div>
														</div>
													</div>

													<br>

													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">景點縣市:</span>
														</div>

														<select name="product_County" class="city">
															<option value="縣市"
																${(pVO.product_County eq ('縣市')) ? 'selected' : ''}>縣市</option>
															<option value="基隆市"
																${(pVO.product_County eq ('基隆市')) ? 'selected' : ''}>基隆市</option>
															<option value="新北市"
																${(pVO.product_County eq ('新北市')) ? 'selected' : ''}>新北市</option>
															<option value="臺北市"
																${(pVO.product_County eq ('臺北市')) ? 'selected' : ''}>臺北市</option>
															<option value="桃園市"
																${(pVO.product_County eq ('桃園市')) ? 'selected' : ''}>桃園市</option>
															<option value="新竹市"
																${(pVO.product_County eq ('新竹市')) ? 'selected' : ''}>新竹市</option>
															<option value="苗栗市"
																${(pVO.product_County eq ('苗栗市')) ? 'selected' : ''}>苗栗市</option>
															<option value="臺中市"
																${(pVO.product_County eq ('臺中市')) ? 'selected' : ''}>臺中市</option>
															<option value="南投市"
																${(pVO.product_County eq ('南投市')) ? 'selected' : ''}>南投市</option>
															<option value="雲林市"
																${(pVO.product_County eq ('雲林市')) ? 'selected' : ''}>雲林市</option>
															<option value="嘉義市"
																${(pVO.product_County eq ('嘉義市')) ? 'selected' : ''}>嘉義市</option>
															<option value="臺南市"
																${(pVO.product_County eq ('臺南市')) ? 'selected' : ''}>臺南市</option>
															<option value="高雄市"
																${(pVO.product_County eq ('高雄市')) ? 'selected' : ''}>高雄市</option>
															<option value="屏東市"
																${(pVO.product_County eq ('屏東市')) ? 'selected' : ''}>屏東市</option>
															<option value="宜蘭市"
																${(pVO.product_County eq ('宜蘭市')) ? 'selected' : ''}>宜蘭市</option>
															<option value="花蓮市"
																${(pVO.product_County eq ('花蓮市')) ? 'selected' : ''}>花蓮市</option>
															<option value="臺東市"
																${(pVO.product_County eq ('臺東市')) ? 'selected' : ''}>臺東市</option>
														</select>
													</div>
													<p style="color: red">${errorMsgs.product_County}</p>


													<div id="googleMap">
														<iframe width="600" height="450" frameborder="0"
															style="border: 0"
															src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBPJRhviSK2E8-7hm5IIc1HLh0PbmPeTEA&q=台灣省"
															allowfullscreen> </iframe>
													</div>


													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">景點數量:</span>
														</div>

														<input type="text" class="form-control col-1"
															placeholder="Quantity" aria-describedby="basic-addon1"
															value="<%=(pVO == null) ? "" : pVO.getProduct_Address()%>"
															id="product_Address" name="product_Address" />

													</div>
													<p style="color: red">${errorMsgs.product_Address}</p>


													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">安排天數:</span>
														</div>
														<select name="product_Staytime" class="day">


															<option value="1.0"
																${(pVO.product_Staytime==1.0) ? 'selected' : ''}>1</option>
															<option value="2.0"
																${(pVO.product_Staytime==2.0) ? 'selected' : ''}>2</option>
															<option value="3.0"
																${(pVO.product_Staytime==3.0) ? 'selected' : ''}>3</option>

														</select>
													</div>








													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">景點簡介:</span>
														</div>

														<input type="text" class="form-control col-6 "
															placeholder="product_Intro" aria-describedby="basic-addon1"
															value="<%=(pVO == null) ? "" : pVO.getProduct_Intro()%>"
															id="product_Intro" name="product_Intro" />
													</div>
													<p style="color: red">${errorMsgs.product_Intro}</p>



													<c:choose>

														<c:when test="${pVO.product_Staytime== 3.0}">
															<div class="whoday">
																<div class="input-group mb-3">
																	<div class="input-group-prepend">
																		<span class="input-group-text" id="basic-addon1">第一天行程:</span>
																	</div>
																	<textarea class="form-control" name="day1" id="day1"
																		rows="1">${day1}</textarea>
																</div>

																<p style="color: red">${errorMsgs.day1}</p>
																<br>

																<div class="input-group mb-3">
																	<div class="input-group-prepend">
																		<span class="input-group-text" id="basic-addon1">第二天行程:</span>
																	</div>
																	<textarea class="form-control" name="day2" id="day2"
																		rows="1">${day2}</textarea>
																</div>
																<p style="color: red">${errorMsgs.day2}</p>

																<br>

																<div class="input-group mb-3">
																	<div class="input-group-prepend">
																		<span class="input-group-text" id="basic-addon1">第三天行程:</span>
																	</div>
																	<textarea class="form-control" name="day3" id="day3"
																		rows="1">${day3}</textarea>
																</div>

																<p style="color: red">${errorMsgs.day3}</p>
															</div>
														</c:when>
														<c:when test="${pVO.product_Staytime == 2.0}">
															<div class="whoday">
																<div class="input-group mb-3">
																	<div class="input-group-prepend">
																		<span class="input-group-text" id="basic-addon1">第一天行程:</span>
																	</div>
																	<textarea class="form-control" id="day1" rows="1"
																		name="day1">${day1}</textarea>
																</div>
																<p style="color: red">${errorMsgs.day1}</p>

																<br>

																<div class="input-group mb-3">
																	<div class="input-group-prepend">
																		<span class="input-group-text" id="basic-addon1">第二天行程:</span>
																	</div>
																	<textarea class="form-control" name="day2" id="day2"
																		rows="1" name="day2">${day2}</textarea>
																</div>
																<p style="color: red">${errorMsgs.day2}</p>
															</div>

														</c:when>
														<c:otherwise>
															<div class="whoday">
																<div class="input-group mb-3">
																	<div class="input-group-prepend">
																		<span class="input-group-text" id="basic-addon1">行程總覽:</span>
																	</div>
																	<textarea class="form-control" name="day1"
																		id="exampleFormControlTextarea1" rows="1">${day1}</textarea>
																</div>
																<p style="color: red">${errorMsgs.day1}</p>


															</div>
														</c:otherwise>
													</c:choose>


													<p style="color: red">${errorMsgs.product_Total_Schedule}</p>



													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">景點詳情:</span>
														</div>
														<textarea class="form-control product_Info"
															name="product_Info" id="exampleFormControlTextarea1"
															rows="3"><%=(pVO == null) ? "" : pVO.getProduct_Info()%></textarea>

													</div>
													<p style="color: red">${errorMsgs.product_Info}</p>

													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">景點規格:</span>
														</div>

														<input type="text" class="form-control col-2 "
															placeholder="Spc" aria-describedby="basic-addon1"
															value="<%=(pdVO == null) ? "" : pdVO.getProduct_Detail_Spc()%>" id="product_Detail_Spc"
															name="product_Detail_Spc" />
													</div>
													<p style="color: red">${errorMsgs.product_Detail_Spc}</p>


													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">商品價錢:</span>
														</div>

														<input type="number" min="0" max="99999"
															class="form-control col-1 " placeholder="Money"
															aria-describedby="basic-addon1"
															value="<%=(pdVO == null) ? "" : pdVO.getProduct_Detail_Money()%>" id="product_Detail_Money"
															name="product_Detail_Money" />
													</div>
													<p style="color: red">${errorMsgs.product_Detail_Money}</p>



													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">商品庫存量:</span>
														</div>

														<input type="number" min="0" max="999"
															class="form-control col-1 " placeholder="INSTOCK"
															aria-describedby="basic-addon1"
															value="<%=(pdVO == null) ? "" : pdVO.getProduct_Detail_Instock()%>" id="product_Detail_Instock"
															name="product_Detail_Instock" />
													</div>
													<p style="color: red">${errorMsgs.product_Detail_Instock}</p>


													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">商品安全量:</span>
														</div>

														<input type="number" min="0" max="999"
															class="form-control col-1 " placeholder="SAFTYSTOCK"
															aria-describedby="basic-addon1"
															value="<%=(pdVO == null) ? "" : pdVO.getProduct_Detail_Saftystock()%>" id="product_Detail_Saftystock"
															name="product_Detail_Saftystock" />
													</div>
													<p style="color: red">${errorMsgs.product_Detail_Saftystock}</p>
											</table>


											<button type="button" class="btn">
												<input type="hidden" name="product_Class" value="套裝行程">
												<input type="hidden" name="action" value="insertSchedule">
												<input class="btn btn-secondary active" id="gogo"
													type="submit" value="送出">

											</button>

											<button type="button" id="getval" class="btn btn-secondary ">神奇按鈕!</button>

											</button>


										</FORM>



									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->

		<!-- Main Footer -->
		<footer class="main-footer">
			<strong>Copyright &copy; 2020 <a href="#">Tourism</a>.
			</strong>
			<div class="float-right d-none d-sm-inline-block">
				<b>Tibame讚喔</b>
			</div>
		</footer>
	</div>



	<!-- ./wrapper -->

	<!-- REQUIRED SCRIPTS -->

	<!-- icon -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
	<!-- jQuery -->
	<script
		src="<%=request.getContextPath()%>/backstage/Home/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script
		src="<%=request.getContextPath()%>/backstage/Home/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE -->
	<script
		src="<%=request.getContextPath()%>/backstage/Home/dist/js/adminlte.js"></script>

	<!-- OPTIONAL SCRIPTS -->
	<script
		src="<%=request.getContextPath()%>/backstage/Home/dist/js/demo.js"></script>
	<script
		src="<%=request.getContextPath()%>/backstage/Home/dist/js/pages/dashboard3.js"></script>
	<!-- 	日歷相關 -->
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/backstage/datetimepicker/jquery.datetimepicker.css" />
	<script
		src="<%=request.getContextPath()%>/backstage/datetimepicker/jquery.js"></script>
	<script
		src="<%=request.getContextPath()%>/backstage/datetimepicker/jquery.datetimepicker.full.js"></script>
	<!-- summernote -->
	<script
		src="<%=request.getContextPath()%>/backstage/Home/plugins/summernote/summernote-bs4.min.js"></script>

	<script>
	

		// 	$('#p_file').change(function() {
		// 		var file = $('#p_file')[0].files[0];
		// 		var reader = new FileReader;
		// 		reader.onload = function(e) {
		// 			$('#demo').attr('src', e.target.result);
		// 		};
		// 		reader.readAsDataURL(file);
		// 	});

		window.addEventListener("load", function(e) {

			// =========================== 元素 ========================= //
			var drop_zone_el = document.getElementById("drop_zone");
			var preview_el = document.getElementById("preview");
			var preview_el1 = document.getElementById("preview1");
			var preview_el2 = document.getElementById("preview2");
			var preview_el3 = document.getElementById("preview3");
			var preview_el4 = document.getElementById("preview4");
			var p_file_el = document.getElementById("p_file");
			var p_file_el1 = document.getElementById("p_file1");
			var p_file_el2 = document.getElementById("p_file2");
			var p_file_el3 = document.getElementById("p_file3");
			var p_file_el4 = document.getElementById("p_file4");

			// =========================== Drag and Drop ========================= //
			preview.addEventListener("dragover", function(e) {
				e.preventDefault();
				e.target.classList.add("-on");
			});
			preview.addEventListener("dragleave", function(e) {
				e.target.classList.remove("-on");
			});
			preview.addEventListener("drop", function(e) {
				e.preventDefault();
				e.target.classList.remove("-on");

				console.log(e.dataTransfer.files); // 取得 files
				preview_img(e.dataTransfer.files[0]);
				p_file_el.value = ""; // 將 type="file" 那個清空
			});

			preview1.addEventListener("dragover", function(e) {
				e.preventDefault();
				e.target.classList.add("-on");
			});
			preview1.addEventListener("dragleave", function(e) {
				e.target.classList.remove("-on");
			});
			preview1.addEventListener("drop", function(e) {
				e.preventDefault();
				e.target.classList.remove("-on");

				console.log(e.dataTransfer.files); // 取得 files
				preview_img1(e.dataTransfer.files[0]);
				p_file_el1.value = ""; // 將 type="file" 那個清空
			});

			preview2.addEventListener("dragover", function(e) {
				e.preventDefault();
				e.target.classList.add("-on");
			});
			preview2.addEventListener("dragleave", function(e) {
				e.target.classList.remove("-on");
			});
			preview2.addEventListener("drop", function(e) {
				e.preventDefault();
				e.target.classList.remove("-on");

				console.log(e.dataTransfer.files); // 取得 files
				preview_img2(e.dataTransfer.files[0]);
				p_file_el2.value = ""; // 將 type="file" 那個清空
			});

			preview3.addEventListener("dragover", function(e) {
				e.preventDefault();
				e.target.classList.add("-on");
			});
			preview3.addEventListener("dragleave", function(e) {
				e.target.classList.remove("-on");
			});
			preview3.addEventListener("drop", function(e) {
				e.preventDefault();
				e.target.classList.remove("-on");

				console.log(e.dataTransfer.files); // 取得 files
				preview_img3(e.dataTransfer.files[0]);
				p_file_el3.value = ""; // 將 type="file" 那個清空
			});

			preview4.addEventListener("dragover", function(e) {
				e.preventDefault();
				e.target.classList.add("-on");
			});
			preview4.addEventListener("dragleave", function(e) {
				e.target.classList.remove("-on");
			});
			preview4.addEventListener("drop", function(e) {
				e.preventDefault();
				e.target.classList.remove("-on");

				console.log(e.dataTransfer.files); // 取得 files
				preview_img4(e.dataTransfer.files[0]);
				p_file_el4.value = ""; // 將 type="file" 那個清空
			});

			// =========================== 透過 File 取得預覽圖 ========================= //
			var preview_img = function(file) {
				var img_node = document.createElement("img");
				var reader = new FileReader(); // 用來讀取檔案
				reader.addEventListener("load", function() {
					//console.log(reader.result);
					let img_node = document.createElement("img");
					img_node.setAttribute("src", reader.result);
					img_node.setAttribute("class", "preview_img");
					preview_el.innerHTML = '';
					preview_el.append(img_node);
				});
				reader.readAsDataURL(file); // 讀取檔案
			};

			var preview_img1 = function(file) {
				var img_node = document.createElement("img");
				var reader = new FileReader(); // 用來讀取檔案
				reader.addEventListener("load", function() {
					//console.log(reader.result);
					let img_node = document.createElement("img");
					img_node.setAttribute("src", reader.result);
					img_node.setAttribute("class", "preview_img");
					preview_el1.innerHTML = '';
					preview_el1.append(img_node);
				});
				reader.readAsDataURL(file); // 讀取檔案
			};

			var preview_img2 = function(file) {
				var img_node = document.createElement("img");
				var reader = new FileReader(); // 用來讀取檔案
				reader.addEventListener("load", function() {
					//console.log(reader.result);
					let img_node = document.createElement("img");
					img_node.setAttribute("src", reader.result);
					img_node.setAttribute("class", "preview_img");
					preview_el2.innerHTML = '';
					preview_el2.append(img_node);
				});
				reader.readAsDataURL(file); // 讀取檔案
			};

			var preview_img3 = function(file) {
				var img_node = document.createElement("img");
				var reader = new FileReader(); // 用來讀取檔案
				reader.addEventListener("load", function() {
					//console.log(reader.result);
					let img_node = document.createElement("img");
					img_node.setAttribute("src", reader.result);
					img_node.setAttribute("class", "preview_img");
					preview_el3.innerHTML = '';
					preview_el3.append(img_node);
				});
				reader.readAsDataURL(file); // 讀取檔案
			};

			var preview_img4 = function(file) {
				var img_node = document.createElement("img");
				var reader = new FileReader(); // 用來讀取檔案
				reader.addEventListener("load", function() {
					//console.log(reader.result);
					let img_node = document.createElement("img");
					img_node.setAttribute("src", reader.result);
					img_node.setAttribute("class", "preview_img");
					preview_el4.innerHTML = '';
					preview_el4.append(img_node);
				});
				reader.readAsDataURL(file); // 讀取檔案
			};



			p_file_el.addEventListener("change", function(e) {
				if (this.files.length > 0) {
					preview_img(this.files[0]);
				} else {
					preview_el.innerHTML = '<span class="text">預覽圖</span>';
				}
			});

			p_file_el1.addEventListener("change", function(e) {
				if (this.files.length > 0) {
					preview_img1(this.files[0]);
				} else {
					preview_el1.innerHTML = '<span class="text">預覽圖</span>';
				}
			});

			p_file_el2.addEventListener("change", function(e) {
				if (this.files.length > 0) {
					preview_img2(this.files[0]);
				} else {
					preview_el2.innerHTML = '<span class="text">預覽圖</span>';
				}
			});

			p_file_el3.addEventListener("change", function(e) {
				if (this.files.length > 0) {
					preview_img3(this.files[0]);
				} else {
					preview_el3.innerHTML = '<span class="text">預覽圖</span>';
				}
			});

			p_file_el4.addEventListener("change", function(e) {
				if (this.files.length > 0) {
					preview_img4(this.files[0]);
				} else {
					preview_el4.innerHTML = '<span class="text">預覽圖</span>';
				}
			});

		});
		
		$('.city').on('change', function() {
			var address=$(this).val();
			console.log(address);
			$('#googleMap').html(`
			<iframe width="600" height="450" frameborder="0"
				style="border: 0"
				src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBPJRhviSK2E8-7hm5IIc1HLh0PbmPeTEA&q=`+address+`"
				allowfullscreen> </iframe>
			
				`)
	

		});
		

			$('.day').on('change', function() {
				if($(this).val()==1.0){
		
					$('.whoday').html(`
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">行程總覽:</span>
								</div>
								<textarea class="form-control"
									name="day1"
									id="exampleFormControlTextarea1" rows="1">${day1}</textarea>
							</div>
							<p style="color: red">${errorMsgs.day1}</p>

					
						`)
					}else if($(this).val()==2.0){
						$('.whoday').html(`
								<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">第一天行程:</span>
								</div>
								<textarea class="form-control"
									
									id="day1" rows="1" name="day1">${day1}</textarea>
								</div>
								<p style="color: red">${errorMsgs.day1}</p>
								
								<br>
								
								<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">第二天行程:</span>
								</div>
								<textarea class="form-control"
									name="day2"
									id="day2" rows="1" name="day2">${day2}</textarea>
								</div>
								<p style="color: red">${errorMsgs.day2}</p>
							`)
						
						
					}else{
						$('.whoday').html(`
								<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">第一天行程:</span>
								</div>
								<textarea class="form-control"
									name="day1"
									id="day1" rows="1">${day1}</textarea>
								</div>
								<p style="color: red">${errorMsgs.day1}</p>
								<br>
								
								<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">第二天行程:</span>
								</div>
								<textarea class="form-control"
									name="day2"
									id="day2" rows="1">${day2}</textarea>
								</div>
								<p style="color: red">${errorMsgs.day2}</p>
								
								<br>
								
								<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">第三天行程:</span>
								</div>
								<textarea class="form-control"
									name="day3"
									id="day3" rows="1">${day3}</textarea>
								</div>
								<p style="color: red">${errorMsgs.day3}</p>
									
							`)
						
						
					}
			});
			
			
			$('#getval').on("click",function(){
				
				$('#product_Name').val("台中懶人包兩天一夜玩遍2020台中最新秘境景點")
				$('#product_Address').val('13個')
				$('#product_Intro').val('最新拍照景點一覽，直接帶你體驗最好玩的台中之旅!')
				$('#day1').val('中社觀光花市花海->外埔忘憂谷->獵犬不打獵->紙博館 紙的空間->大雅小麥田->靜宜大學主顧聖母堂->逢甲夜市 ->台中 逢甲商圈 微行旅(民宿)')
				$('#day2').val('一支毛->工家美術館->帝國製糖廠->Bacitali 小義大利威尼斯宮->北屯大坑紙箱王創意園區->結束')
				$('.product_Info').val(`第一天 中社觀光花市花海
						台中中社觀光花市每到花季時期便吸引許多遊客前往賞花，而從12月開始便進入鬱金香花期，多達50種30萬株的繽紛鬱金香，約8公頃的七彩花田同時盛開，還有當季花卉一串紅、萬壽菊、鼠尾草、玫瑰花等花海百花齊放，一路開至3月中旬，宛若置身荷蘭，此外更有多個藝術裝置營造浪漫氛圍。外埔忘憂谷
						小麥栽植面積僅次於大雅的外埔地區，出現了神秘的麥田圈圖騰，猶如外星人飛碟降落的痕跡，吸引許多攝影迷前往拍攝，難以相信這些如幽浮圖案的麥田圈，是一步一腳印踩出來的，一共有五種圖案供遊客欣賞，為此農友們還特別延後收割，也建議大家要實際走入麥田才能看到麥田圈，或是以空拍「上帝視角」才能飽覽完整的田野風光，這樣的地景藝術預計展至3月28日喔！
				獵犬不打獵
						獵犬不打獵是一家寵物友善餐廳，老闆養了10隻黃金獵犬和一隻臘腸狗，每一隻都很乖很親近人不怕生，也可以帶著你家的毛小孩跟牠們一起玩，能被這麼多陽光笑容的黃金獵犬及呆萌短腿的臘腸狗包圍根本置身幸福天堂！差點沒被療癒的狗狗們融化啦~ (未來擬改為預約制)
				紙博館 紙的空間
						喜歡DIY手作的你一定要去！紙博館的老闆非常熱愛紙張，花費4年在神岡打造了260坪的紙博館，展示了各式各樣的紙製作品，一邊逛著一邊不禁在內心讚嘆，難以想像如何把一張紙變成一件美麗又精緻的立體作品，對於沒有什麼美術天分的我來說，真的是打從心底佩服。館內最吸引我的便是這彩色PAPER字樣，每個字母都是由兩種顏色組成，從側面看更有一種延伸感，也是IG上熱門的打卡場景。
				大雅小麥田
						來到大雅小麥田一定要拍的就是這個可愛的土角厝，這裡的小麥田都是私人土地，欣賞可以千萬不要為了拍照而隨意踐踏，麥田間有小路可以走到土角厝，放眼望去一大片黃澄澄麥浪，搭配一瓶熟悉的麥香最對味了！台中大雅小麥文化節是每年熱門的追麥賞浪景點，今年(2020年)因為疫情的影響而停辦，但免費開放參觀的黃金稻田，依舊掀起一波IG打卡潮。
				靜宜大學主顧聖母堂
						除了東海大學的路思義教堂、霧峰的圓滿教堂等，台中現在又多了一個靜宜大學主顧聖母堂，結合了魚、竹子、竹筍等意象，是近期最火紅的拍照打卡景點。主顧聖母堂的外型特殊，由四個圓弧形牆板組成，屋頂的玻璃連接著十字架，讓陽光從玻璃灑落，不管是從正面、背面或者側面看，每個角度都有著截然不同的面貌，是一棟優美浪漫的特殊建築。
				逢甲夜市
						來到台中，還是要逛一下逢甲夜市才有到此一遊的踏實感。逢甲夜市商圈的店家競爭激烈，店面攤位一家家地開，又一家家地倒.，似乎每次去都會有新選擇
				第二天
						一支毛
						隱藏在勤美附近的巷子裡，是最近新開的特色氣泡水專賣店，有一個機器人沒有嘴巴，只用燈號表達喜歡或不喜歡，它是「一支毛」，是這隻機器人的名字，也是店名的由來。盛裝氣泡水的容器更是特別設計過，瓶身是機器人的頭，蓋子則是他的天線，俏皮又活潑的小店，超吸睛的外觀快速的在IG上爆紅。
						工家美術館
						「工」代表工程、「家」則代表歸屬感，用台語來念「ㄍㄨㄥ ㄍㄟ」 有共享之意。「工家美術館」是全球第一座結合工地、展覽的複合式共享藝術空間，具開放精神、共享概念，以工地裡習以為常的鐵桿支架為基底，在 18×18 的方形基地中將建築結合老樹，創造出不完全封閉的綠地空間，內部的三角錐吧檯椅、鷹架桌子，濃厚的工業風中夾帶著創新，重新定義了工地美學。
						帝國製糖廠
						有著悠久歷史的老建物「帝國製糖廠」，是台中東區重要的產業地標，整建修復後以展演空間的形式重新開放，將糖廠注入了新的元素與活力，除了保有古色古香的日治時期建築，還有純白色的玻璃建築餐廳，搭配周邊的星泉湖，寬廣舒適的空間，視野十分遼闊，成為台中最新的打卡景點。
						BACITALI 小義大利威尼斯宮
						Bacitali 小義大利是台中近期很夯新開幕的餐廳，打造了威尼斯夏宮般800坪大的歐風唯美建築，搭配諾大的庭院造景，充滿了異國風情，歐式噴水池加上粉橘色的城堡建築，在南屯區龍富路上亮眼又突出，餐廳內部的玻璃、地板及吊燈也都瀰漫著濃郁的歐式華麗，從門口到室內再到後花園，每個角落任意取景都浪漫，除此之外，Bacitali 小義大利還是間寵物友善餐廳，建議用餐要事先訂位哦！
						北屯大坑紙箱王創意園區
						位於台中大坑的紙箱王創意園區占地約1600坪，園區內展示著各式各樣的紙藝品，更特別的是紙箱餐廳桌椅、火鍋還有火車都是用紙做成！園區內還有世界各國的大型地標，來到這裡就好像環遊世界一樣，不僅適合親子同遊，增進感情，也很適合情侶來這邊打卡拍照，就好像一起環遊世界般。`)
				$('#product_Detail_Spc').val('景點門票包辦遊')
				$('#product_Detail_Money').val(1200)
				$('#product_Detail_Instock').val(20)
				$('#product_Detail_Saftystock').val(10)
				
				
			});
			
			  
			
			  
			  
	</script>


	<!-- 	google map相關 -->
	<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPJRhviSK2E8-7hm5IIc1HLh0PbmPeTEA"
		defer></script>
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</body>
</html>
