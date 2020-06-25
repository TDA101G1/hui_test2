<%@page import="com.member.model.MemberService"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.inbox.model.InboxService"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.inbox.model.InboxVO"%>
<%@page import="com.employee.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.stream.Collectors"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	
	
<style>

.modal-backdrop{
z-index:-100;
}

table {
	display: table;
	table-layout: fixed;
	white-space: nowrap;
}

td {
	overflow: hidden;
	text-overflow:ellipsis;
}


      



	
div.sidebar a.nav-link:hover{
	background-color: #007bff;
	color: #fff;
}



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
.paginationa:hover:not (.active ){
	background-color: #ddd;
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

<%

//	MemberVO member = (MemberVO) session.getAttribute("member");
//	MemberVO member2 = new MemberVO();
//	member2.setMember_ID("MID000000");
//	session.setAttribute("member", member2);
//	String member_ID = member2.getMember_ID();
//	InboxService service = new InboxService();
//	Set<InboxVO> inboxs = service.getInboxByMemberID("2", member_ID);		//2是員工收件夾
//	pageContext.setAttribute("inboxs", inboxs);
//	Set<InboxVO> outboxs = service.getInboxByMemberID("3", member_ID);		//1是員工寄件夾
//	pageContext.setAttribute("outboxs", outboxs);

EmployeeVO employee = new EmployeeVO();
employee.setEmp_ID("EID000000");
session.setAttribute("employee", employee);
String employee_ID = employee.getEmp_ID();


InboxService service = new InboxService();
Set<InboxVO> inboxs = service.getAll().stream()
		.filter(inbox -> inbox.getEmp_ID().equals(employee_ID))
		.filter(inbox -> inbox.getInbox_Mail_State().equals("2"))
		.collect(Collectors.toSet());

//	Set<InboxVO> inboxs = service.getInboxByMemberID("2", member_ID);		//2是員工收件夾
pageContext.setAttribute("inboxs", inboxs);
Set<InboxVO> outboxs = service.getAll().stream()
		.filter(inbox -> inbox.getEmp_ID().equals(employee_ID))
		.filter(inbox -> inbox.getInbox_Mail_State().equals("3"))
		.collect(Collectors.toSet());
//	Set<InboxVO> outboxs = service.getInboxByMemberID("3", member_ID);		//3是員工寄件夾
pageContext.setAttribute("outboxs", outboxs);
 MemberService mSvc = new MemberService();
List<MemberVO> memAll =  mSvc.getAll();
pageContext.setAttribute("memAll", memAll);
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

						<li class="nav-item has-treeview menu-open"><a href="#"
							class="nav-link active"> <i class="far fa-envelope"></i>
								<p>
									信件 <i class="fas fa-angle-left right"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a
									href="<%=request.getContextPath()%>/backstage/inbox/Email.jsp"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>信件查詢</p>
								</a></li>
								<li class="nav-item"><a
									href="<%=request.getContextPath()%>/backstage/inbox/Email.jsp"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>新增信件</p>
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
						<div class="col">

							<br> <br>

						</div>




						<div class="card col-12">

							<div class="card-header"></div>
							<div class="card-title">
								<div class="col">
									<div class="card">
										<div class="card-head "></div>
									</div>
								</div>

								<div class="card-body" style="overflow: auto">
								<div class="content col-lg-10 col-md-9 col-sm-8">
				<div class="title">
		          <h2>我的信箱</h2>
		        </div>
		        <hr>
				<div class="container-fluid py-3 border rounded">
					
					<div class="row">

						<!--main-->
						<div class="col-sm-12 col-md-12">
							<!-- tabs -->
							<ul class="nav nav-tabs border-0">
								<li class="nav-item"><a class="nav-link active"
									href="#inbox" data-toggle="tab"> <i
										class="fa fa-inbox mr-1"></i> 收件夾
								</a></li>
								<li><a href="#outbox" class="nav-link" data-toggle="tab">
										<i class="fas fa-paper-plane"></i> 寄件夾
								</a></li>
								<li><a href="#settings" class="nav-link" data-toggle="tab">
										<i class="fa fa-plus"></i>
								</a></li>
							</ul>
							<!-- tab panes -->
							<div class="tab-content py-4">
					<!-- 這邊是收件夾 -->
								<div class="tab-pane in active" id="inbox">
									<form class="inbox" method="POST" action="<c:url value="/inbox/WriteMail.Controllerforbackstage" />">
									<table class="table table-striped table-hover">
										<tbody>
					<!-- inbox header -->
											<tr>
												<td style="width:5%"><btn class="btn btn-outline-primary"> <input
														type="checkbox" class="all" title="select all">
													All </btn></td>
												<td style="width:8%">
													<button type="button" class="btn btn-light delete">
													
														<i title="delete selected" class="fa fa-trash"></i>
													</button>
													<button type="button" class="btn btn-light" data-toggle="modal" data-target="#exampleModal" >
														<i class="fas fa-pen"></i>
													</button>
												</td>
					<!-- 收件夾搜尋 -->
												<td style="width:25%">
													<div class="form-row">
														<div class="col-3">
															<select class="form-control" name="searchreceiver" id="inbox_search_name" >
														      <c:forEach var="mem1" items="${memAll }">
															      <option value="${mem1.member_ID }">${mem1.member_Name }</option>
														      </c:forEach>
														      	  <option value="">不選擇</option>  
														    </select>
														
														</div>
														<div class="col-3">
														    <input type="text" class="form-control searchtime" name="searchdate" id="inbox_search_date" placeholder="Search Date" />
														</div>
														<div class="col-6">
														    <input type="text" class="form-control" name="searchtitle" id="inbox_search_title" placeholder="Search Title" />
														    <input type="hidden" name="state" id="inbox_search_state" value="4">
          													<input type="hidden" id="inbox_search_id" value="${member.member_ID }">
														</div>	
													</div>
												</td>
												<td style="width:5%">
													<button type="button" class="btn btn-primary inmailSearch">搜尋</button>
												</td>
											</tr>
							<!-- inbox item -->
											<c:forEach var="inbox" items="${inboxs }" varStatus="loop">
												<tr data-toggle="modal" data-target="#readModal">
													<td><label> <input class="checkbox_delete" type="checkbox" name="mail_ID" value="${inbox.inbox_Mail_ID }"></label> <span class="name text-truncate">
													<c:forEach var="mem" items="${memAll }">
														<c:if test="${inbox.member_ID==mem.member_ID }">
															${mem.member_Name }
														</c:if>
													</c:forEach>
													</span></td>
													<td><span class="subject title">${inbox.inbox_Mail_Title }</span></td>
													<td><span class="subject message">${inbox.inbox_Mail_Info }</span></td>
													<fmt:parseDate var="parseDate" value="${inbox.inbox_Mail_TimeStamp }" pattern="yyyy-MM-dd HH:mm:ss"  />
													<td><span class="badge time" data-timestamp="${inbox.inbox_Mail_TimeStamp }"><fmt:formatDate value="${parseDate }" pattern="yyyy-MM-dd HH:mm:ss"/></span> 
												</tr>
											
											</c:forEach>
										</tbody>
									</table>
									</form>
								</div>
					<!-- 這邊是寄件夾 -->
								<div class="tab-pane in" id="outbox">
										<form class="inbox" method="POST" action="<c:url value="/inbox/WriteMail.Controllerforbackstage" />">
									<table class="table table-striped table-hover">
										<tbody>
											<!-- inbox header -->
											<tr>
												<td style="width:5%"><btn class="btn btn-outline-primary"> <input
														type="checkbox" class="all" title="select all">
													All </btn></td>
												<td style="width:8%">
													<button type="button" class="btn btn-light delete">
														<i title="delete selected" class="fa fa-trash"></i>
													</button>
													<button type="button" class="btn btn-light" data-toggle="modal" data-target="#exampleModal">
														<i class="fas fa-pen"></i>
													</button>
												</td>
					<!-- 這邊是信件搜尋 -->
												<td style="width:25%">
													<div class="form-row">
														<div class="col-3">
															<select class="form-control" name="searchreceiver" id="outbox_search_name" >
														      <c:forEach var="mem1" items="${memAll }">
															      <option value="${mem1.member_ID }">${mem1.member_Name }</option>
														      </c:forEach>
														      	  <option value="">不選擇</option>  
														    </select>
														
														</div>
														<div class="col-3">
														    <input type="text" class="form-control searchtime" name="searchdate" id="outbox_search_date" placeholder="Search Date" />
														</div>
														<div class="col-6">
														    <input type="text" class="form-control" name="searchtitle" id="outbox_search_title" placeholder="Search Title" />
														    <input type="hidden" name="state" id="outbox_search_state" value="1">
          													<input type="hidden" id="outbox_search_id" value="${member.member_ID }">
														</div>	
													</div>
												</td>
												<td style="width:5%">
													<!-- <button type="submit" name="action" value="searchMail" class="btn btn-primary">搜尋</button> -->
													<button type="button" class="btn btn-primary outmailSearch">搜尋</button>
												</td>
											</tr>
							<!-- outbox item -->
											<c:forEach var="outbox" items="${outboxs }" varStatus="loop">
												<tr data-toggle="modal" data-target="#readModal">
													<td><label> <input type="checkbox" class="checkbox_delete" name="mail_ID" value="${outbox.inbox_Mail_ID }"></label> <span class="name text-truncate">
													<c:forEach var="mem" items="${memAll}">
														<c:if test="${outbox.member_ID==mem.member_ID }">
															${mem.member_Name }
														</c:if>
													</c:forEach>
													</span></td>
													<td><span class="subject title">${outbox.inbox_Mail_Title }</span></td>
													<td><span class="subject message">${outbox.inbox_Mail_Info }</span></td>
													<fmt:parseDate var="parseDate" value="${outbox.inbox_Mail_TimeStamp }" pattern="yyyy-MM-dd HH:mm:ss"  />
													<td><span class="badge time" data-timestamp="${outbox.inbox_Mail_TimeStamp }"><fmt:formatDate value="${parseDate }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
													
												</tr>
											
											</c:forEach>
										</tbody>
									</table>
										</form>
								</div>
							</div>
							<div class="row-md-12">
								<div class="card card-body d-flex flex-row justify-content-between">
									<c:forEach var="error" items="${errorMsg }">
										<small class="text-danger">${error.value }</small>
									</c:forEach>
									<jsp:useBean id="date" class="java.util.Date">
									<small>現在時間: <fmt:formatDate value="${date }" type="both"/></small>
									</jsp:useBean>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
								
								
								
									<div class="col-lg"></div>
								</div>

							</div>
						</div>
					</div>
				</div>
<!-- 			</div> -->
<!-- 		</div> -->

		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->

		<!-- Main Footer -->
		<footer class="main-footer">
			<strong>Copyright &copy; 2020/07/02 <a href="#">Tourism</a>.
			</strong>
			<div class="float-right d-none d-sm-inline-block">
				<b>Tibame讚喔</b>
			</div>
		</footer>
	</div>
	
<!-- 新增信件 -->

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
          <form method="POST" action="<c:url value="/inbox/WriteMail.Controllerforbackstage" />">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">新增信件</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
 <!--            <div class="form-group">
              <label for="recipient-name" class="col-form-label">收件者:</label>
              <input type="text" class="form-control" name="receiver" id="write_name">
              <input type="text" class="form-control" name="emp_ID" id="write_name">      
            </div> -->
            
            <div class="form-group">
			    <label for="write_name" class="col-form-label">收件者:</label>
			    <select class="form-control" name="receiver" id="write_name" >
			      <c:forEach var="member" items="${memAll }">
				      <option value="${member.member_ID }">${member.member_Name }</option>
			      </c:forEach>
			      
			    </select>
			</div>
            <div class="form-group">
              <label for="recipient-name" class="col-form-label">標題:</label>
              <input type="text" class="form-control" name="title" id="write_title">
            </div>
            <div class="form-group">
              <label for="message-text" class="col-form-label">內容:</label>
              <textarea class="form-control" rows="10" name="message" id="write_message"></textarea>
            </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
          <input type="hidden" name="state" id="write_state" value="3">
          <input type="hidden" id="write_id" value="${employee.emp_ID }">
          <button type="submit" name="action" value="writeMail" class="btn btn-primary">送出</button>
          <button class="writeMail btn btn-primary" type="button">送出Ajax</button>
        </div>
          </form>
      </div>
    </div>
  </div>
  
  <!-- 閱讀信件 -->
  
  <div class="modal fade" id="readModal" tabindex="-1" role="dialog" aria-labelledby="readModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="readModalLabel">查看信件</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group">
              <label for="recipient-name" class="col-form-label">寄件者:</label>
              <input type="text" class="form-control" id="read_sender" readonly>
            </div>
            <div class="form-group">
              <label for="recipient-name" class="col-form-label">標題:</label>
              <input type="text" class="form-control" id="read_title" readonly>
            </div>
            <div class="form-group">
              <label for="message-text" class="col-form-label">內容:</label>
              <textarea class="form-control" rows="10" id="read_message" readonly></textarea>
            </div>
          </form>
        </div>
        <div class="modal-footer d-flex justify-content-between">
			<small class="time"></small>
	        <button type="button" class="btn btn-primary " data-dismiss="modal">確認</button>
        </div>
      </div>
    </div>
  </div>

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
		src="<%=request.getContextPath()%>/backstage/jquery/twzipcode.js"></script>
	<script src="<%=request.getContextPath()%>/backstage/Home/plugins/jquery/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>

	<script
		src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

	<script type="text/javascript">
	
	$(".time").flatpickr({
	    altInput: false,
	    clickOpens: false,
	    altFormat: "Y-m-j hh-mm-ss",
	    dateFormat: "Y/m/d",
	    maxDate: "today",
	});
	
	$("input.searchtime").flatpickr({
	    altInput: true,
	    clickOpens: true,
	    altFormat: "Y-m-d",
	    dateFormat: "Y/m/d",
	    maxDate: "today",
	});
	$('tbody').on('click', 'tr', function(){
		let name = $(this).closest('tr').find('span.name').text().trim();
		$('div#readModal').find('input#read_sender').val($(this).text().trim());
		
		let title = $(this).closest('tr').find('span.title').text().trim();
		$('div#readModal').find('input#read_title').val(title);
		
		let message = $(this).closest('tr').find('span.message').text().trim();
		$('div#readModal').find('textarea#read_message').val(message);
		
		let time =  $(this).closest('tr').find('span.time').text();
		let mailDate = new Date(time);
		flatpickr.formatDate(mailDate, "Y-m-d h:i K")
		$('div#readModal').find('small.time').text("Last updated: " + flatpickr.formatDate(mailDate, "Y-m-d h:i K"));
		console.log(title);
	});
	
	$('tbody').on('click', 'input.checkbox_delete', function(){
		$('div#readModal').modal('hide');
	});
	
	
	
$(function(){
	$('table').on('click', 'input.checkbox_delete',function(e){
		e.stopImmediatePropagation();
	});
	$('button.writeMail').on('click', function(){
		let name = $('select#write_name').val();
		let title = $('input#write_title').val();
		let message = $('textarea#write_message').val();
		let id = $('input#write_id').val();
		let state = $('input#write_state').val();

		let form_data = {
			"id": id,				//會員ＩＤ
	    	"name": name,			//員工ＩＤ
	    	"title": title,
	    	"message": message,
	    	"state": state
	    };
	    let form_dataString = JSON.stringify(form_data);		//後端接收參數為String type的JSON

		alert('begin ajax');
		$.ajax({
			url: "<%=request.getContextPath()%>/inbox/Inbox.Apiforbackstage",
			type : 'POST',
			contentType:'application/json',
			dataType : 'json',
/* 				data : {											傳送text方式 !基本!
				account: $('input#account').val()
			}, */
			data : form_dataString,
			beforeSend: function(){
				let timerInterval
				Swal.fire({
				  title: 'Auto close alert!',
				  html: 'I will close in <b></b> milliseconds.',
				  timer: 2000,
				  timerProgressBar: true,
				  onBeforeOpen: () => {
				    Swal.showLoading()
				    timerInterval = setInterval(() => {
				      const content = Swal.getContent()
				      if (content) {
				        const b = content.querySelector('b')
				        if (b) {
				          b.textContent = Swal.getTimerLeft()
				        }
				      }
				    }, 100)
				  },
				  onClose: () => {
				    clearInterval(timerInterval)
				  }
				}).then((result) => {
				  /* Read more about handling dismissals below */
				  if (result.dismiss === Swal.DismissReason.timer) {
				    console.log('I was closed by the timer')
				  }
				})
			},
			success: function(res){
				console.log(res);
				if(res.result === 'OK'){
					Swal.fire({
						  icon: 'success',
						  title: '成功',
						  text: res.resultDetail,
						})
					$('select#write_name').val("");
					$('input#write_title').val("");
					$('textarea#write_message').val("");

				}else{
					let error = "";
/* 						for(var prop in res.resultDetail){
						error.push(res.resultDetail[prop])
					} */
					$.each(res.resultDetail, function(index, value){
						error += value +"\n";
					});
					console.log(error);
					Swal.fire({
						  icon: 'error',
						  title: '失敗',
						  html: '<pre class="text-danger text-uppercase font-weight-bold">' + error + '</pre>',
						});
				}
				
			}
			
		});
	});
}); 
	
//Serach outmail Ajax		
	$(function(){
		$('button.outmailSearch').on('click', function(){
			let buttonsearch = $(this);
			let emp_id = $('select#outbox_search_name').val();
			let member_id = $('input#outbox_search_id').val();
			let title = $('input#outbox_search_title').val();
			let date = $('input#outbox_search_date').val();
			let state = $('input#outbox_search_state').val();
			let form_data = {
				"emp_id": emp_id,		//會員ＩＤ
				"member_id": member_id,
		    	"title": title,
		    	"date": date,
		    	"state": state
		    };
		    let form_dataString = JSON.stringify(form_data);		//後端接收參數為String type的JSON
			console.log(form_data);
			alert('begin ajax');
			$.ajax({
				url: "<%=request.getContextPath()%>/inbox/InboxSearch.Apiforbackstage",
				type : 'POST',
				contentType:'application/json',
				dataType : 'json',
				data : form_dataString,
				beforeSend: function(){
					let timerInterval
					Swal.fire({
					  title: 'Auto close alert!',
					  html: 'I will close in <b></b> milliseconds.',
					  timer: 2000,
					  timerProgressBar: true,
					  onBeforeOpen: () => {
					    Swal.showLoading()
					    timerInterval = setInterval(() => {
					      const content = Swal.getContent()
					      if (content) {
					        const b = content.querySelector('b')
					        if (b) {
					          b.textContent = Swal.getTimerLeft()
					        }
					      }
					    }, 100)
					  },
					  onClose: () => {
					    clearInterval(timerInterval)
					  }
					}).then((result) => {
					  /* Read more about handling dismissals below */
					  if (result.dismiss === Swal.DismissReason.timer) {
					    console.log('I was closed by the timer')
					  }
					})
				},
				success: function(res){
					console.log(res);
					Swal.fire({
						  icon: 'success',
						  title: '成功',
						  text: '搜尋成功'
						})
					let newHtml = ""; 
					let empName ;
					$.each(res.key, function(index, value){
						$.each(res.emps, function(indexEmp, valueEmp){
							if(value.emp_ID === valueEmp.emp_ID){
								empName = valueEmp.emp_Name
							}
						});
						newHtml += `<tr data-toggle="modal" data-target="#readModal">
										<td><label> <input type="checkbox" name="mail_ID" class="checkbox_delete" value="` + value.inbox_Mail_ID +`"></label> <span class="name text-truncate">
												`+ empName +`
										</span></td>
										<td><span class="subject title">`+ value.inbox_Mail_Title +`</span></td>
										<td><span class="subject message">`+value.inbox_Mail_Info +`</span></td>
										<td><span class="badge time" data-timestamp="${outbox.inbox_Mail_TimeStamp }">`+ value.inbox_Mail_TimeStamp +`</span>
										
									</tr>`

					})
					buttonsearch.closest('tr').nextAll().html("");
					buttonsearch.closest('tr').after(newHtml);
					$(".time").flatpickr({
					    altInput: false,
					    clickOpens: false,
					    altFormat: "Y-m-j hh-mm-ss",
					    dateFormat: "Y/m/d",
					    maxDate: "today",
					});
					
					
				}
				
			}); 
		});
	});
	
//Serach inmail Ajax		
	$(function(){
		$('button.inmailSearch').on('click', function(){
			let buttonsearch = $(this);
			let emp_id = $('select#inbox_search_name').val();
			let member_id = $('input#inbox_search_id').val();
			let title = $('input#inbox_search_title').val();
			let date = $('input#inbox_search_date').val();
			let state = $('input#inbox_search_state').val();
			let form_data = {
				"emp_id": emp_id,		//會員ＩＤ
				"member_id": member_id,
		    	"title": title,
		    	"date": date,
		    	"state": state
		    };
		    let form_dataString = JSON.stringify(form_data);		//後端接收參數為String type的JSON
			console.log(form_data);
			alert('begin ajax');
			$.ajax({
				url: "<%=request.getContextPath()%>/inbox/InboxSearch.Apiforbackstage",
				type : 'POST',
				contentType:'application/json',
				dataType : 'json',
				data : form_dataString,
				beforeSend: function(){
					let timerInterval
					Swal.fire({
					  title: 'Auto close alert!',
					  html: 'I will close in <b></b> milliseconds.',
					  timer: 2000,
					  timerProgressBar: true,
					  onBeforeOpen: () => {
					    Swal.showLoading()
					    timerInterval = setInterval(() => {
					      const content = Swal.getContent()
					      if (content) {
					        const b = content.querySelector('b')
					        if (b) {
					          b.textContent = Swal.getTimerLeft()
					        }
					      }
					    }, 100)
					  },
					  onClose: () => {
					    clearInterval(timerInterval)
					  }
					}).then((result) => {
					  /* Read more about handling dismissals below */
					  if (result.dismiss === Swal.DismissReason.timer) {
					    console.log('I was closed by the timer')
					  }
					})
				},
				success: function(res){
					console.log(res);
					Swal.fire({
						  icon: 'success',
						  title: '成功',
						  text: '搜尋成功'
						});
					let newHtml = ""; 
					let empName ;
					console.log(res);
					$.each(res.key, function(index, value){
						$.each(res.emps, function(indexEmp, valueEmp){
							if(value.emp_ID === valueEmp.emp_ID){
								empName = valueEmp.emp_Name
							}
						});
						newHtml += `<tr data-toggle="modal" data-target="#readModal" >
										<td><label> <input type="checkbox" class="checkbox_delete" name="mail_ID" value="` + value.inbox_Mail_ID +`"></label> <span class="name text-truncate">
												`+ empName +`
										</span></td>
										<td><span class="subject title">`+ value.inbox_Mail_Title +`</span></td>
										<td><span class="subject message">`+value.inbox_Mail_Info +`</span></td>
										<td><span class="badge time">`+ value.inbox_Mail_TimeStamp +`</span>
										
									</tr>`
					})
					buttonsearch.closest('tr').nextAll().html("");
					buttonsearch.closest('tr').after(newHtml);
					$(".time").flatpickr({
					    altInput: false,
					    clickOpens: false,
					    altFormat: "Y-m-j hh-mm-ss",
					    dateFormat: "Y/m/d",
					    maxDate: "today",
					});
					
					
				}
				
			}); 
		});
	});
	
	$("button.delete").on('click', function(){
		Swal.fire({
			  icon: 'warning',
			  title: '確認刪除信件？',
			  text: '按下確認鍵您的信件將永久刪除',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '確認刪除!'
			}).then((result) =>{
				if(result.value){
					Swal.fire({
						title:'您選擇刪除',
						text:'請確認下方訊息確認信件是否刪除',
					    icon:'info'
					});
					let a = `<input type="hidden" name="action" value="delete">`;
					$(this).closest("form.inbox").prepend(a);
						$(this).closest("form.inbox").submit();
					}
			});
	
	});
	</script>
</body>
</html>
