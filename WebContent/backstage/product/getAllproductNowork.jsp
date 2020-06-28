<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.stream.Collectors"%>

<%
// 	ProductVO pVO = (ProductVO) request.getAttribute("pVO");
EmployeeVO in_empVO = (EmployeeVO) session.getAttribute("in_empVO");

	
	String getID = (String)request.getAttribute("ID");
	System.out.println(getID);
	ProductService pSvc = new ProductService();
	ProductDetailService pdSvc = new ProductDetailService();
	
	

	List<ProductDetailVO> AllpdVO = pdSvc.getAll();

	List<ProductVO> list = pSvc.getAll().stream().filter(p -> p.getProduct_State() == 0)
			.collect(Collectors.toList());
	
	  Collections.reverse(list);
      for (int i=0;i<list.size();i++){
        
      }
	pageContext.setAttribute("AllpdVO", AllpdVO);
	pageContext.setAttribute("list", list);

	int length = 0;
	int count = 0;
	int number = 0;
	
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
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/backstage/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<style>
table {
	display: table;
	table-layout: fixed;
	white-space: nowrap;
}

td {
	overflow: hidden;
	text-overflow: ellipsis;
}

.modal-backdrop {
	z-index: -100;
}

img {
	width: 100px;
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
									class="nav-link active"> <i class="far fa-circle nav-icon"></i>
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
							<h1 class="m-0 text-dark">商品查詢</h1>

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
				<div class="container-fluid">
					<div class="row">
						<!-- 搜尋欄 -->
						<div class="search_area">
							<FORM METHOD="post"
								ACTION="<%=request.getContextPath()%>/backstage/ProductServlet.do">

								<input type="text" id="search" name="p_ID"
									placeholder="請輸入商品編號"
<%-- 									value="<%=(pVO == null) ? "" : pVO.getProduct_ID()%>" /> --%>
									value="${p_ID}" />
								<input type="hidden" name="action" value="getOne"> <span
									class="searchIcon"><button class="btn btn-navbar"
										type="submit">
										<i class="fas fa-search"></i>
									</button> </span>


							</FORM>
							<br> <br> <a class="col" style="color: red">${errorMsgs.p_ID}</a>

						</div>

						<div class="card">

							<div class="card-header">

								<%@ include file="pages/page1.file"%>

							</div>
							<div class="card-title">
								<div class="col">
									<div class="card card-primary card-tabs">
										<br> <br>
										<div class="card-header p-0 pt-1">
											<ul class="nav nav-tabs" id="custom-tabs-one-tab"
												role="tablist">
												<li class="nav-item"><a class="nav-link "
													href="<%=request.getContextPath()%>/backstage/product/getAllproduct.jsp">上架中</a></li>
												<li class="nav-item"><a class="nav-link active"
													href="<%=request.getContextPath()%>/backstage/product/getAllproductNowork.jsp">下架中</a></li>

											</ul>


										</div>
									</div>
								</div>

								<div class="card-body" style="overflow: auto">
									<div class="col-lg">
										<table class="table table-sm-12 ">

											<thead>
												<tr>
													<th style="width: 2.5%" scope="col">#</th>
													<th style="width: 12.5%" scope="col">編號</th>
													<th style="width: 15%" scope="col">名稱</th>
													<th style="width: 10%" scope="col">照片</th>
													<th style="width: 30%" scope="col">簡介</th>
													<th style="width: 7%" scope="col">點擊數</th>
													<th style="width: 7%" scope="col">購買數</th>
													<th style="width: 8%" scope="col">類別</th>
													<th style="width: 8%" scope="col">規格</th>

												</tr>
											</thead>
											<tbody>


												<c:forEach var="pVO" items="${list}" begin="<%=pageIndex%>"
													end="<%=pageIndex+rowsPerPage-1%>">


													<%
														/* 號碼 */
															length = whichPage * rowsPerPage - rowsPerPage;
															count++;
															number = count + length;
													%>

													<tr data-toggle="modal" data-target="#exampleModal">
														<th scope="row"><%=number%></th>

														<td>${pVO.product_ID}</span></td>
														<td>${pVO.product_Name}</span></td>
														<td><img id="myImg"
															src="<%=request.getContextPath()%>/product/ShowImage?product_ID=${pVO.product_ID}"
															alt="商品的第一張照片">

															<div id="myModal" class="modal">
																<span class="close">&times;</span> <img
																	class="modal-content" id="img01">
																<div id="caption"></div></td>
														<td>${pVO.product_Intro}</td>
														<td>${pVO.product_Click_Rec}</td>
														<td>${pVO.product_Sale_Rec}</td>
														<td>${pVO.product_Class}</td>
														<td>
															<FORM METHOD="post"
																ACTION="<%=request.getContextPath()%>/backstage/ProductServlet.do"
																style="margin-bottom: 0px;">
																<input type="submit" value="規格"> 
																<input
																	type="hidden" name="p_ID" value="${pVO.product_ID}">	
																	 
																<input type="hidden" name="action"
																	value="get_SPC">
															</FORM>
														</td>

													</tr>

												</c:forEach>


											</tbody>
										</table>
									</div>

								</div>
								<%@ include file="pages/page2.file"%>





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









			<%-- 	<c:forEach var="pdVO" items="${AllpdVO}"> --%>

			<%-- 																<c:if test="${pdVO.product_ID eq pVO.product_ID}">	 --%>
			<%-- 		</c:if>	 --%>
			<%-- 		</c:forEach> --%>
			<!-- 					<th scope="col">商品庫存</th> -->
			<!-- 													<th scope="col">安全庫存</th> -->
			<!-- 													<th scope="col">價格</th> -->
			<%-- 																<td>${pdVO.product_Detail_Instock}</td> --%>
			<%-- 																<td>${pdVO.product_Detail_Saftystock}</td> --%>
			<%-- 																<td>${pdVO.product_Detail_Money}</td> --%>
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
				src="<%=request.getContextPath()%>/backstage/Home/plugins/chart.js/Chart.min.js"></script>
			<script
				src="<%=request.getContextPath()%>/backstage/Home/dist/js/demo.js"></script>
			<script
				src="<%=request.getContextPath()%>/backstage/Home/dist/js/pages/dashboard3.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

			<script>
				$('tbody').on('click', 'tr', function() {
				
					let name = $(this).closest('tr').find('span.pv_ID').text().trim();
				
					
					 let form_dataString = JSON.stringify(form_data);
					 console.log(form_dataString);
					
					$.ajax({
						url: "<%=request.getContextPath()%>/backstage/ProductServlet.do",
						type : 'POST',
						dataType : 'json',
						data :{
							"action":"getID",
							"ID":name
						}
						
					});


		
				});

				let modal = document.getElementById('myModal');
				let modalImg = document.getElementById("img01");
				let captionText = document.getElementById("caption");
				$("img#myImg").on("click", function() {
					modal.style.display = "block";
					modalImg.src = this.src;
					captionText.innerHTML = this.alt;
				});

				modal.onclick = function() {
					modal.style.display = "none";
				}
			</script>
</body>
</html>
