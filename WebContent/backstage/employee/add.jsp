<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>
<%@ page import="java.util.*"%>
<%
EmployeeVO empVO = (EmployeeVO) request.getAttribute("empVO");

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
.paginationa:hover:not(.active){
background-color:#ddd;
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

.btn {
	margin-left: 50px;
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

.search_area{
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

.search_area input#search{
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

.search_area input#search::-moz-placeholder {  /* Firefox 19+ */
   color: #65737e;
}

.search_area input#search:-ms-input-placeholder {
   color: #65737e;
}

.search_area .searchIcon{
  max-width: auto;
  /* border: solid 2px; */
  display: fixed;
  position: absolute;
  right: 10px;
  top: 8px;

  z-index: 1;
  color: #4f5b66;
}

.search_area input#search:hover, .search_area input#search:focus, .search_area input#search:active{
    outline:none;
    background: #f0f0f0;
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

<%
	EmployeeService empSvc = new EmployeeService();
	List<EmployeeVO> list = empSvc.getAll();
	pageContext.setAttribute("list", list);
	int length = 0;
	int count = 0;
	int number = 0;
// 	List<EmployeeVO> work = null;
// 	for(EmployeeVO emp : list){
// 		if(emp.getEmp_State().equals("1")){
			
// 		}
// 	}
%>
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

						<li class="nav-item has-treeview"><a href="#"
							class="nav-link"> <i class="fas fa-shopping-cart"></i>
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
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
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

							<li class="nav-item has-treeview menu-open"><a href="#"
								class="nav-link active"> <i class="fas fa-address-book"></i>
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
										class="nav-link active"> <i class="far fa-circle nav-icon"></i>
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
							<h1 class="m-0 text-dark">新增員工</h1>

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
				
					<br>
					<br>
					
					</div>
					
					
				
						
						<div class="card col-12">
						
							<div class="card-header">

							</div>
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
					ACTION="<%=request.getContextPath()%>/backstage/employee/employee.do"
					name="form1" enctype="multipart/form-data">
					<table>


						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">員工姓名:</span>
							</div>

							<input type="text" class="form-control col-6 "
								placeholder="Username" aria-describedby="basic-addon1"
								value="<%=(empVO == null) ? "" : empVO.getEmp_Name()%>"  id="emp_Name"
								name="emp_Name" />
						</div>
						<p style="color: red">${errorMsgs.emp_Name}</p>



						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">員工帳號:</span>
							</div>

							<input type="text" class="form-control col-6 "
								placeholder="Account" aria-describedby="basic-addon1"
								value="<%=(empVO == null) ? "" : empVO.getEmp_Account()%>" id="emp_Account"
								name="emp_Account" />
						</div>
						<p style="color: red">${errorMsgs.emp_Account}</p>


						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">員工密碼:</span>
							</div>

							<input type="text" class="form-control col-6 "
								placeholder="Password" aria-describedby="basic-addon1"
								value="<%=(empVO == null) ? "" : empVO.getEmp_Pwd()%>" id="emp_Pwd"
								name="emp_Pwd" />
						</div>
						<p style="color: red">${errorMsgs.emp_Pwd}</p>


						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">員工狀態:</span>

								<div class="input-group-prepend">
									<div class="input-group-text">
										<input type="radio" name="emp_State"
											aria-label="Radio button for following text input" value="1"
											<%=(empVO == null) ? "checked" : (empVO.getEmp_State() == 1) ? "checked" : ""%> />使用中
										<input type="radio" name="emp_State"
											aria-label="Radio button for following text input" value="0"
											<%=(empVO != null && empVO.getEmp_State() == 0) ? "checked" : ""%> />停用中
									</div>
								</div>
							</div>
						</div>

						<br>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">員工權限:</span>

								<div class="input-group-prepend">
									<div class="input-group-text">
										<input type="radio" name="emp_Grade"
											aria-label="Radio button for following text input" value="0"
											<%=(empVO == null) ? "checked" : (empVO.getEmp_Grade().equals("0")) ? "checked" : ""%> />員工
										<input type="radio" name="emp_Grade"
											aria-label="Radio button for following text input" value="1"
											<%=(empVO != null && empVO.getEmp_Grade().equals("1")) ? "checked" : ""%> />主管
									</div>
								</div>
							</div>
						</div>

						<br>

						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">員工性別:</span>

								<div class="input-group-prepend">
									<div class="input-group-text">
										<input type="radio" name="emp_Sex"
											aria-label="Radio button for following text input" value="M"
											<%=(empVO == null) ? "checked" : (empVO.getEmp_Sex().equals("M")) ? "checked" : ""%> />男
										<input type="radio" name="emp_Sex"
											aria-label="Radio button for following text input" value="F"
											<%=(empVO != null && empVO.getEmp_Sex().equals("F")) ? "checked" : ""%> />女
									</div>
								</div>
							</div>
						</div>

						<br>

						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">員工信箱:</span>
							</div>

							<input type="text" class="form-control col-6 "
								placeholder="E-mail" aria-describedby="basic-addon1"
								value="<%=(empVO == null) ? "" : empVO.getEmp_Mail()%>" id="emp_Mail"
								name="emp_Mail" />
						</div>
						<p style="color: red">${errorMsgs.emp_Mail}</p>


						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">員工電話:</span>
							</div>

							<input type="text" class="form-control col-6 "
								placeholder="Phone" aria-describedby="basic-addon1"
								value="<%=(empVO == null) ? "0919336720" : empVO.getEmp_Phone()%>"
								name="emp_Phone" />
						</div>
						<p style="color: red">${errorMsgs.emp_Phone}</p>



						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<label class="input-group-text" for="inputGroupSelect01">地區</label>
							</div>
							<a id="zipcode2" class="input-group-prepend"></a>

						</div>



						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">地址:</span>
							</div>

							<input type="text" class="form-control col-6 "
								placeholder="Address" aria-describedby="basic-addon1"
								id="Address"
								value="<%=(empVO == null) ? "" : empVO.getEmp_Address()%>" id="emp_Address"
								name="emp_Address" />
						</div>
						<p style="color: red">${errorMsgs.emp_Address}</p>





						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">員工生日:</span>
							</div>

							<input type="text" class="form-control col-6 " id="f_date2"
								placeholder="Address" aria-describedby="basic-addon1"
								name="emp_Birth" />
						</div>
						<p style="color: red">${errorMsgs.emp_Birth}</p>


						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">入職時間:</span>
							</div>

							<input type="text" class="form-control col-6 " id="f_date1"
								placeholder="Address" aria-describedby="basic-addon1"
								value="<%=(empVO == null) ? "" : empVO.getEmp_Est_Time()%>"
								name="emp_Est_Time" />
						</div>
						<p style="color: red">${errorMsgs.emp_Est_Time}</p>



						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">上傳檔案</span>
							</div>
							<div class="custom-file ">
								<input type="file" class="custom-file-input" name="emp_img"
									accept="image/*" id="p_file"> <label
									class="custom-file-label" for="p_file">Choose file</label>
							</div>
						</div>

						<p style="color: red">${errorMsgs.emp_img}</p>


						<img id="demo" width="100">


					</table>
<button type="button" class="btn">

						<input type="hidden" name="action" value="insert">
						<input class="btn btn-secondary active" type="submit" value="送出">
				
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




<%
	java.sql.Date emp_Est_Time = null;
	try {
		emp_Est_Time = empVO.getEmp_Est_Time();
	} catch (Exception e) {
		emp_Est_Time = new java.sql.Date(System.currentTimeMillis());
	}
%>


<%
	java.sql.Date emp_Brith = null;
	try {
		emp_Brith = empVO.getEmp_Birth();
	} catch (Exception e) {
		emp_Est_Time = new java.sql.Date(System.currentTimeMillis());
	}
%>
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
		src="<%=request.getContextPath()%>/backstage/Home/plugins/chart.js/Chart.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/backstage/Home/dist/js/demo.js"></script>
	<script
		src="<%=request.getContextPath()%>/backstage/Home/dist/js/pages/dashboard3.js"></script>
	
	<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/backstage/datetimepicker/jquery.datetimepicker.css" />
<script
	src="<%=request.getContextPath()%>/backstage/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/backstage/datetimepicker/jquery.datetimepicker.full.js"></script>
<script
	src="<%=request.getContextPath()%>/backstage/jquery/twzipcode.js"></script>
	<script>
	$.datetimepicker.setLocale('zh');
	$('#f_date1').datetimepicker({
		theme : '', //theme: 'dark',
		timepicker : false, //timepicker:true,
		step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)
		format : 'Y-m-d', //format:'Y-m-d H:i:s',
		// 		   value:''
		value :'<%=emp_Est_Time%>',
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

	$.datetimepicker.setLocale('zh');
	$('#f_date2').datetimepicker({
		theme : '', //theme: 'dark',
		timepicker : false, //timepicker:true,
		step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)
		format : 'Y-m-d', //format:'Y-m-d H:i:s',
		// 		value : '',
		value :'<%=emp_Brith%>' ,
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

	// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

	//      1.以下為某一天之前的日期無法選擇
	//      var somedate1 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      2.以下為某一天之後的日期無法選擇
	//      var somedate2 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
	//      var somedate1 = new Date('2017-06-15');
	//      var somedate2 = new Date('2017-06-25');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//		             ||
	//		            date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	$("#zipcode2").twzipcode({
		countySel : true, // 城市預設值, 字串一定要用繁體的 "臺", 否則抓不到資料
		districtSel : false, // 地區預設值
		zipcodeIntoDistrict : true, // 郵遞區號自動顯示在地區
		css : [ "city", "town" ], // 自訂 "城市"、"地區" class 名稱
		countyName : "city", // 自訂城市 select 標籤的 name 值
		districtName : "town" // 自訂地區 select 標籤的 name 值
	});

	let address;
	let addressval;

	$('select').on(
			'change',
			function() {
				address = $('select.city').find('option:selected').html()
						+ $('select.town').find('option:selected').val();
				$('#Address').val(address);

			});

	$('#p_file').change(function() {
		var file = $('#p_file')[0].files[0];
		var reader = new FileReader;
		reader.onload = function(e) {
			$('#demo').attr('src', e.target.result);
		};
		reader.readAsDataURL(file);
	});
	
	$('#getval').on("click",function(){
		$('#emp_Account').val("TDA101G1")
		$('#emp_Name').val("王小明")
		$('#emp_Pwd').val('gogo123')
		$('#emp_Mail').val('qqp15601560@yahoo.com.tw')
		$('#emp_Address').val('新北市板橋區民生路一段20號')
		
	})
	

<!--  	$('#title').css("color", "black"); -->
<!-- 	$('#title').css("text-decoration", "none"); -->
	

	</script>
</body>
</html>
