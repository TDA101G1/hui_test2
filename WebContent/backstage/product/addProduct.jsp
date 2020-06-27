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
									class="nav-link active"> <i class="far fa-circle nav-icon"></i>
										<p>新增一般商品</p>

										<li class="nav-item"><a
											href="<%=request.getContextPath()%>/backstage/product/addSchedule.jsp"
											class="nav-link"> <i class="far fa-circle nav-icon"></i>
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
											name="form1" enctype="multipart/form-data">
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



												<br>
												<p style="color: red">${errorMsgs.product_Img1}</p>
												<p style="color: red">${errorMsgs.product_Img2}</p>
												<p style="color: red">${errorMsgs.product_Img3}</p>
												<p style="color: red">${errorMsgs.product_Img4}</p>
												<p style="color: red">${errorMsgs.product_Img5}</p>

												<br>
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
															value="<%=(pVO == null) ? "123" : pVO.getProduct_Name()%>"
															name="product_Name" />
													</div>
													<p style="color: red">${errorMsgs.product_Name}</p>


													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">景點類別:</span>
														</div>

														<select name="product_Class" class="city">
															<option value="景點">景點</option>
															<option value="住宿">住宿</option>
															<option value="餐廳">餐廳</option>
														</select>
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
															<option value="">縣市</option>
															<option value="基隆市">基隆市</option>
															<option value="臺北市">臺北市</option>
															<option value="新北市">新北市</option>
															<option value="宜蘭縣">宜蘭縣</option>
															<option value="新竹市">新竹市</option>
															<option value="新竹縣">新竹縣</option>
															<option value="桃園市">桃園市</option>
															<option value="苗栗縣">苗栗縣</option>
															<option value="臺中市">臺中市</option>
															<option value="彰化縣">彰化縣</option>
															<option value="南投縣">南投縣</option>
															<option value="嘉義市">嘉義市</option>
															<option value="嘉義縣">嘉義縣</option>
															<option value="雲林縣">雲林縣</option>
															<option value="臺南市">臺南市</option>
															<option value="高雄市">高雄市</option>
															<option value="屏東縣">屏東縣</option>
															<option value="臺東縣">臺東縣</option>
															<option value="花蓮縣">花蓮縣</option>
															<option value="金門縣">金門縣</option>
															<option value="連江縣">連江縣</option>
															<option value="澎湖縣">澎湖縣</option>
														</select>


														<p style="color: red">${errorMsgs.product_County}</p>

														<br>
														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1">景點地址:</span>
															</div>

															<input type="text" class="form-control col-6 "
																placeholder="Address" aria-describedby="basic-addon1"
																id="Address"
																value="<%=(pVO == null) ? "吳鳳路81巷20號1樓" : pVO.getProduct_Address()%>"
																name="product_Address" />

															<p style="color: red">${errorMsgs.product_Address}</p>

															<button type="button" id="getGPS"
																class="btn btn-secondary ">取得經緯度</button>

															</button>


														</div>
														<div>
															<p style="color: red">${errorMsgs.emp_Address}</p>
														</div>



														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1">經度:</span>
															</div>

															<input type="text" class="form-control col-1 "
																placeholder="log" aria-describedby="basic-addon1"
																id="lng"
																value="<%=(pVO == null) ? "" : pVO.getProduct_Longitude()%>"
																name="product_Longitude" />
														</div>
														<p style="color: red">${errorMsgs.product_Longitude}</p>


														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1">緯度:</span>
															</div>

															<input type="text" class="form-control col-1 "
																placeholder="lat" aria-describedby="basic-addon1"
																id="lat"
																value="<%=(pVO == null) ? "" : pVO.getProduct_Latitutde()%>"
																name="product_Latitutde" />
														</div>
														<p style="color: red">${errorMsgs.product_Latitutde}</p>


														<div id="googleMap">
															<iframe width="600" height="450" frameborder="0"
																style="border: 0"
																src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBPJRhviSK2E8-7hm5IIc1HLh0PbmPeTEA&q=台灣省"
																allowfullscreen> </iframe>
														</div>

														<br>

														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1">平均停留時間:</span>
															</div>

															<input type="text" class="form-control col-1 "
																placeholder="Staytime" aria-describedby="basic-addon1"
																value="<%=pVO == null ? 0.0 : pVO.getProduct_Staytime()%>"
																name="product_Staytime" />
														</div>
														<p style="color: red">${errorMsgs.product_Staytime}</p>






														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1">景點簡介:</span>
															</div>

															<input type="text" class="form-control col-6 "
																placeholder="Name" aria-describedby="basic-addon1"
																value="<%=(pVO == null) ? "123" : pVO.getProduct_Intro()%>"
																name="product_Intro" />
														</div>
														<p style="color: red">${errorMsgs.product_Intro}</p>


														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1">行程總覽:</span>
															</div>
															<textarea class="form-control"
																name="product_Total_Schedule"
																id="exampleFormControlTextarea1" rows="1"><%=(pVO == null) ? "123" : pVO.getProduct_Total_Schedule()%></textarea>

														</div>
														<p style="color: red">${errorMsgs.product_Total_Schedule}</p>


														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1">景點詳情:</span>
															</div>
															<textarea class="form-control" name="product_Info"
																id="exampleFormControlTextarea1" rows="3"><%=(pVO == null) ? "123" : pVO.getProduct_Info()%></textarea>

														</div>
														<p style="color: red">${errorMsgs.product_Info}</p>

														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1">景點規格:</span>
															</div>

															<input type="text" class="form-control col-2 "
																placeholder="Spc" aria-describedby="basic-addon1"
																value="<%=(pdVO == null) ? "" : pdVO.getProduct_Detail_Spc()%>"
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
																value="<%=(pdVO == null) ? "123" : pdVO.getProduct_Detail_Money()%>"
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
																value="<%=(pdVO == null) ? "123" : pdVO.getProduct_Detail_Instock()%>"
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
																value="<%=(pdVO == null) ? "123" : pdVO.getProduct_Detail_Saftystock()%>"
																name="product_Detail_Saftystock" />
														</div>
														<p style="color: red">${errorMsgs.product_Detail_Saftystock}</p>
											</table>


											<button type="button" class="btn">

												<input type="hidden" name="action" value="insert"> <input
													class="btn btn-secondary active" type="submit" value="送出">

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

			$('#select').on("change", function() {
				if($(this).val()=='遊玩'){
					alert('1');
				}else if($(this).val()=='景點'){
					alert('2');
				}else{
					alert('1');
				}
			});

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
		
	
		
		
		
		
// 		google map按鈕
		  $("button#getGPS").on("click", function () {
            let geocoder = new google.maps.Geocoder();
            let address = $("#Address").val();
            geocoder.geocode({
                'address': address
            }, function (results, status) {
                if (status == 'OK') {
                    $("#lat").val(results[0].geometry.location.lat())
                    $("#lng").val(results[0].geometry.location.lng())
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        });
        
			$('#Address').on('change', function() {
				var address=$(this).val();
				console.log(address);
				$('#googleMap').html(`
				<iframe width="600" height="450" frameborder="0"
					style="border: 0"
					src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBPJRhviSK2E8-7hm5IIc1HLh0PbmPeTEA&q=`+address+`"
					allowfullscreen> </iframe>
				
					`)

			});
			
			//商品詳情相關
			$('#exampleFormControlTextarea1').on('click',function(){
// 				alert($(this).val());
			})
		
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
