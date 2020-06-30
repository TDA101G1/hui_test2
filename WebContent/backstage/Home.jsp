<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.order.model.OrderDetailVO"%>
<%@page import="com.order.model.OrderDetailService"%>
<%@page import="com.coupon.model.CouponVO"%>
<%@page import="com.coupon.model.CouponService"%>
<%@page import="com.order_master.model.Order_MasterVO"%>
<%@page import="com.order_master.model.Order_MasterService"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.member.model.MemberService"%>
<%@page import="java.util.stream.Collector"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.stream.Collectors"%>

<%
	EmployeeVO in_empVO = (EmployeeVO) request.getAttribute("in_empVO");
	if (in_empVO != null) {
		session.setAttribute("in_empVO", in_empVO);
	} else {
		in_empVO = (EmployeeVO) session.getAttribute("in_empVO");
	}

	//拿會員
	MemberService mSvc = new MemberService();
	List<MemberVO> AllmVO = mSvc.getAll();
	int TotalMVO = AllmVO.size();
	//拿訂單主黨
	Order_MasterService omSvc = new Order_MasterService();
	List<Order_MasterVO> AllomVO = omSvc.getAll().stream().filter(p -> p.getOrder_Master_State() == 1)
			.collect(Collectors.toList());
	int TotalOMVO = AllomVO.size();

	//拿優惠券
	CouponService cpSvc = new CouponService();
	List<CouponVO> AllcpVO = cpSvc.getAll().stream().filter(p -> p.getCoupon_State() == 1)
			.collect(Collectors.toList());
	int TotalcpVO = AllcpVO.size();

	//取得商品
	ProductDetailService pdSvc = new ProductDetailService();

	ProductService pSvc = new ProductService();
	List<ProductVO> list = pSvc.getAll().stream().filter(p -> p.getProduct_State() == 1)
			.collect(Collectors.toList());
	int TotalpVO = list.size();
	//取得商品明細
	List<ProductDetailVO> AllpdVO = pdSvc.getAll();

	//拿訂單明細
	OrderDetailService odSvc = new OrderDetailService();
	List<OrderDetailVO> AllodVO = odSvc.getAll();

	List<OrderDetailVO> listod = new ArrayList<>();

	int TotalMoney = 0;
	//取沒有取消的訂單的總金額

	for (Order_MasterVO om : AllomVO) {
		for (OrderDetailVO od : AllodVO) {
			if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
				for (ProductDetailVO pd : AllpdVO) {
					if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
						TotalMoney += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
					}
				}

			}
		}
	}
	// 	轉成日期 本週
	SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd");
	DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	Timestamp ts = new Timestamp(System.currentTimeMillis());
	// 	String day1 = sdFormat.format(date);  
	// 	String tsStr = sdf.format(ts);  

	int TotalMoneyday1 = 0;
	int TotalMoneyday2 = 0;
	int TotalMoneyday3 = 0;
	int TotalMoneyday4 = 0;
	int TotalMoneyday5 = 0;
	int TotalMoneyday6 = 0;
	int TotalMoneyday7 = 0;
	int TotalMoneyday8 = 0;
	int TotalMoneyday9 = 0;
	int TotalMoneyday10 = 0;
	int TotalMoneyday11 = 0;
	int TotalMoneyday12 = 0;
	int TotalMoneyday13 = 0;
	int TotalMoneyday14 = 0;

	Date date = new Date();
	Date date2 = new Date();
	Date date3 = new Date();
	Date date4 = new Date();
	Date date5 = new Date();
	Date date6 = new Date();
	Date date7 = new Date();

	date2.setDate(date.getDate() - 1);
	date3.setDate(date.getDate() - 2);
	date4.setDate(date.getDate() - 3);
	date5.setDate(date.getDate() - 4);
	date6.setDate(date.getDate() - 5);
	date7.setDate(date.getDate() - 6);

	String day1 = sdFormat.format(date);
	String day2 = sdFormat.format(date2);
	String day3 = sdFormat.format(date3);
	String day4 = sdFormat.format(date4);
	String day5 = sdFormat.format(date5);
	String day6 = sdFormat.format(date6);
	String day7 = sdFormat.format(date7);
	//拿本週日期轉陣列

	List<String> Totaldate = new ArrayList<>();
	Totaldate.add(day7);
	Totaldate.add(day6);
	Totaldate.add(day5);
	Totaldate.add(day4);
	Totaldate.add(day3);
	Totaldate.add(day2);
	Totaldate.add(day1);
	// 		System.out.println(day1);

	//丟給js
	String[] str = new String[Totaldate.size()];
	Totaldate.toArray(str);
	JSONObject json = new JSONObject();
	json.put("day", Totaldate);
	//拿本週金額
	for (Order_MasterVO om : AllomVO) {
		String test = sdf.format(om.getOrder_Master_TimeStamp());
		if (test.equals(day1)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday1 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(day2)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday2 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(day3)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday3 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(day4)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday4 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(day5)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday5 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(day6)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday6 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(day7)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday7 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}
	}
	
	List<Integer> weekMoney = new ArrayList<>();
	weekMoney.add(TotalMoneyday7);
	weekMoney.add(TotalMoneyday6);
	weekMoney.add(TotalMoneyday5);
	weekMoney.add(TotalMoneyday4);
	weekMoney.add(TotalMoneyday3);
	weekMoney.add(TotalMoneyday2);
	weekMoney.add(TotalMoneyday1);
// 	System.out.println(weekMoney);
	
	Integer[] getMoney = new Integer[weekMoney.size()];
	weekMoney.toArray(getMoney);
	JSONObject jsonMoney = new JSONObject();
	json.put("weekMoney", weekMoney);
	
	
	
	//拿上週

	// 	System.out.println(TotalMoneyday1);

	//前一周	

	Date olddate = new Date();
	Date olddate2 = new Date();
	Date olddate3 = new Date();
	Date olddate4 = new Date();
	Date olddate5 = new Date();
	Date olddate6 = new Date();
	Date olddate7 = new Date();

	olddate.setDate(olddate.getDate() - 7);
	olddate2.setDate(olddate2.getDate() - 8);
	olddate3.setDate(olddate3.getDate() - 9);
	olddate4.setDate(olddate4.getDate() - 10);
	olddate5.setDate(olddate5.getDate() - 11);
	olddate6.setDate(olddate6.getDate() - 12);
	olddate7.setDate(olddate7.getDate() - 13);

	String oldday1 = sdFormat.format(olddate);
	String oldday2 = sdFormat.format(olddate2);
	String oldday3 = sdFormat.format(olddate3);
	String oldday4 = sdFormat.format(olddate4);
	String oldday5 = sdFormat.format(olddate5);
	String oldday6 = sdFormat.format(olddate6);
	String oldday7 = sdFormat.format(olddate7);

	
	
	for (Order_MasterVO om : AllomVO) {
		String test = sdf.format(om.getOrder_Master_TimeStamp());
		if (test.equals(oldday1)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday8 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(oldday2)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday9 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(oldday3)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday10 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(oldday4)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday11 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(oldday5)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday12 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(oldday6)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday13 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}else if (test.equals(oldday7)) {
			for (OrderDetailVO od : AllodVO) {
				if (od.getOrder_Master_ID().equals(om.getOrder_Master_ID())) {
					for (ProductDetailVO pd : AllpdVO) {
						if (od.getProduct_Detail_ID().equals(pd.getProduct_Detail_ID())) {
							TotalMoneyday14 += (od.getOrder_Detail_Qty() * pd.getProduct_Detail_Money());
						}
					}

				}
			}
		}
	}
	
	List<Integer> lastMoney = new ArrayList<>();
	lastMoney.add(TotalMoneyday14);
	lastMoney.add(TotalMoneyday13);
	lastMoney.add(TotalMoneyday12);
	lastMoney.add(TotalMoneyday11);
	lastMoney.add(TotalMoneyday10);
	lastMoney.add(TotalMoneyday9);
	lastMoney.add(TotalMoneyday8);
// 	System.out.println(weekMoney);
	
	Integer[] getlastMoney = new Integer[lastMoney.size()];
	lastMoney.toArray(getlastMoney);
	JSONObject jsonlastMoney = new JSONObject();
	json.put("lastMoney", lastMoney);
	
	
	
	

	//反排
	Collections.reverse(list);

	List<ProductDetailVO> listPd = new ArrayList<>();
	while (listPd.size() < 5) {
		for (ProductDetailVO Pd : AllpdVO) {
			if (listPd.size() == 5) {
				break;
			}
			for (ProductVO pvo : list) {
				if (Pd.getProduct_ID().equals(pvo.getProduct_ID())) {
					listPd.add(Pd);
					break;
				}
			}
		}
	}
	// 		listPd.forEach(p -> System.out.println(p));

	//拿前五
	// 	List<ProductVO> top5 = list.subList(0, 5);
	//取得商品明細(目前只能不顧狀態取到前五)
	// 	System.out.println(top5pd);
	pageContext.setAttribute("listpd", listPd);
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("TotalMoney", TotalMoney);
	pageContext.setAttribute("Totaldate", json.get("day"));
	pageContext.setAttribute("weekMoney", json.get("weekMoney"));
	pageContext.setAttribute("lastMoney", json.get("lastMoney"));

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
<!-- Google Font: Source Sans Pro -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
	rel="stylesheet">

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
						<a href="#" class="d-block">歡迎，${in_empVO.emp_Name}</a>
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
							<h1 class="m-0 text-dark">數據統計</h1>

							<!-- Left navbar links -->

						</div>

						<!-- /.col -->

						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->

			<!-- 			small-box相關 -->
			<div class="card">
				<div class="card-header border-0"></div>
				<div class="card-body">


					<div class="d-flex justify-content-between align-items-center mb-0">

						<div class="col-lg-3 col-6">
							<!-- small box -->
							<div class="small-box bg-success">
								<div class="inner">
									<h3>
										<%=TotalOMVO%>
									</h3>

									<p>成交訂單數</p>
								</div>
								<div class="icon">
									<i class="ion ion-stats-bars"></i>
								</div>
								<a
									href="<%=request.getContextPath()%>/backstage/Order_Master/getAllOrder_Master.jsp"
									class="small-box-footer">查看更多 <i
									class="fas fa-arrow-circle-right"></i></a>
							</div>
						</div>

						<div class="col-lg-3 col-6">
							<!-- small box -->
							<div class="small-box bg-info">
								<div class="inner">
									<h3><%=TotalpVO%></h3>

									<p>上架商品總數</p>
								</div>
								<div class="icon">
									<i class="ion ion-bag"></i>
								</div>
								<a
									href="<%=request.getContextPath()%>/backstage/product/getAllproduct.jsp"
									class="small-box-footer">查看更多 <i
									class="fas fa-arrow-circle-right"></i></a>
							</div>
						</div>

						<div class="col-lg-3 col-6">
							<!-- small box -->
							<div class="small-box bg-warning">
								<div class="inner">
									<h3><%=TotalMVO%></h3>

									<p>用戶總數</p>
								</div>
								<div class="icon">
									<i class="ion ion-person-add"></i>
								</div>
								<a
									href="<%=request.getContextPath()%>/backstage/member/getAllMember.jsp"
									class="small-box-footer">查看更多 <i
									class="fas fa-arrow-circle-right"></i></a>
							</div>
						</div>

						<div class="col-lg-3 col-6">
							<!-- small box -->
							<div class="small-box bg-danger">
								<div class="inner">
									<h3><%=TotalcpVO%></h3>

									<p>活動優惠券</p>
								</div>
								<div class="icon">
									<i class="ion ion-pie-graph"></i>
								</div>
								<a
									href="<%=request.getContextPath()%>/backstage/coupon/getAllCoupon.jsp"
									class="small-box-footer">查看更多 <i
									class="fas fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>

				</div>
			</div>
			<!-- 			small-box相關結束 -->

			<!-- Main content -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-6">
							<div class="card">
								<div class="card-header border-0">
									<h3 class="card-title">最新近期商品</h3>

								</div>
								<div class="card-body table-responsive p-0">
									<table class="table table-striped table-valign-middle">
										<thead>
											<tr>
												<th>名稱</th>
												<th>價錢</th>
												<th>規格</th>
												<th>庫存</th>
												<th>查看</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="pdVO" items="${listpd}">
												<c:forEach var="pVO" items="${list}">
													<c:if test="${pdVO.product_ID eq pVO.product_ID}">
														<tr>

															<td><img id="myImg"
																src="<%=request.getContextPath()%>/product/ShowImage?product_ID=${pVO.product_ID}"
																class="img-circle img-size-32 mr-2">
																${pVO.product_Name}</td>
															<td>$${pdVO.product_Detail_Money}</td>
															<td>${pdVO.product_Detail_Spc}</td>
															<td>${pdVO.product_Detail_Instock}</td>
															<td>
																<FORM METHOD="post"
																	ACTION="<%=request.getContextPath()%>/backstage/ProductServlet.do">
																	<input type="hidden" name="p_ID"
																		value="${pVO.product_ID}"> <input
																		type="hidden" name="action" value="get_SPC"> <span
																		class="searchIcon"><button
																			class="btn btn-navbar" type="submit">
																			<i class="fas fa-search"></i>
																		</button> </span>
															</td>
															</FORM>
													</c:if>

													</tr>

												</c:forEach>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<!-- /.card -->


							<!-- /.card -->
						</div>
						<!-- /.col-md-6 -->
						<div class="col-lg-6">
							<div class="card">
								<div class="card-header border-0">
									<div class="d-flex justify-content-between">
										<h3 class="card-title">營業分析</h3>

									</div>
								</div>
								<div class="card-body">
									<div class="d-flex">
										<p class="d-flex flex-column">
											<span class="text-bold text-lg">$${TotalMoney}</span> <span>訂單總收入</span>
										</p>

									</div>
									<!-- /.d-flex -->

									<div class="position-relative mb-4">
										<canvas id="sales-chart" height="200"></canvas>
									</div>

									<div class="d-flex flex-row justify-content-end">
										<span class="mr-2"> <i
											class="fas fa-square text-primary"></i> 本週
										</span> <span> <i class="fas fa-square text-gray"></i> 上週
										</span>
									</div>
								</div>
							</div>
							<!-- /.card -->


						</div>
						<!-- /.col-md-6 -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Control Sidebar -->
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
		src="<%=request.getContextPath()%>/backstage/Home/plugins/chart.js/Chart.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/backstage/Home/dist/js/demo.js"></script>
	<!-- 	<script -->
	<%-- 		src="<%=request.getContextPath()%>/backstage/Home/dist/js/pages/dashboard3.js"></script> --%>

	<script>
		$(function() {
			'use strict'

			var ticksStyle = {
				fontColor : '#495057',
				fontStyle : 'bold'
			}
			
			var mode = 'index'
			var intersect = true
			var $salesChart = $('#sales-chart')
			var salesChart = new Chart($salesChart, {
				type : 'bar',
				data : {
					labels :  ${Totaldate},
					datasets : [ {
						backgroundColor : '#007bff',
						borderColor : '#007bff',
						data : ${weekMoney}
					}, {
						backgroundColor : '#ced4da',
						borderColor : '#ced4da',
						data : ${lastMoney}
					} ]
				},
				options : {
					maintainAspectRatio : false,
					tooltips : {
						mode : mode,
						intersect : intersect
					},
					hover : {
						mode : mode,
						intersect : intersect
					},
					legend : {
						display : false
					},
					scales : {
						yAxes : [ {
							// display: false,
							gridLines : {
								display : true,
								lineWidth : '4px',
								color : 'rgba(0, 0, 0, .2)',
								zeroLineColor : 'transparent'
							},
							ticks : $.extend({
								beginAtZero : true,

								// Include a dollar sign in the ticks
								callback : function(value, index, values) {
									if (value >= 1000) {
										value /= 1000
										value += 'k'
									}
									return '$' + value
								}
							}, ticksStyle)
						} ],
						xAxes : [ {
							display : true,
							gridLines : {
								display : false
							},
							ticks : ticksStyle
						} ]
					}
				}
			})

			var $visitorsChart = $('#visitors-chart')
			var visitorsChart = new Chart($visitorsChart, {
				data : {
					labels : [ '18th', '20th', '22nd', '24th', '26th', '28th',
							'30th' ],
					datasets : [ {
						type : 'line',
						data : [ 100, 120, 170, 167, 180, 177, 160 ],
						backgroundColor : 'transparent',
						borderColor : '#007bff',
						pointBorderColor : '#007bff',
						pointBackgroundColor : '#007bff',
						fill : false
					// pointHoverBackgroundColor: '#007bff',
					// pointHoverBorderColor    : '#007bff'
					}, {
						type : 'line',
						data : [ 60, 80, 70, 67, 80, 77, 100 ],
						backgroundColor : 'tansparent',
						borderColor : '#ced4da',
						pointBorderColor : '#ced4da',
						pointBackgroundColor : '#ced4da',
						fill : false
					// pointHoverBackgroundColor: '#ced4da',
					// pointHoverBorderColor    : '#ced4da'
					} ]
				},
				options : {
					maintainAspectRatio : false,
					tooltips : {
						mode : mode,
						intersect : intersect
					},
					hover : {
						mode : mode,
						intersect : intersect
					},
					legend : {
						display : false
					},
					scales : {
						yAxes : [ {
							// display: false,
							gridLines : {
								display : true,
								lineWidth : '4px',
								color : 'rgba(0, 0, 0, .2)',
								zeroLineColor : 'transparent'
							},
							ticks : $.extend({
								beginAtZero : true,
								suggestedMax : 200
							}, ticksStyle)
						} ],
						xAxes : [ {
							display : true,
							gridLines : {
								display : false
							},
							ticks : ticksStyle
						} ]
					}
				}
			})
		})
	</script>

</body>
</html>
