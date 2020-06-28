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
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/css/footer.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel=stylesheet type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/core/main.min.css">
<link rel=stylesheet type="text/css"
  href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/daygrid/main.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
	hr {
		border: 1px solid rgb(13, 218, 218);
	}

	.-none {
	display: none;
	}
	div.sidebar a.nav-link:hover{
	background-color: #007bff;
	color: #fff;
	}
	body {
	font-size: 16px;
  	font-family: Microsoft JhengHei;
  	color: #343434;
  	background-color: #F5F5F5;
	}
/* 	.popper,
.tooltip {
  position: absolute;
  z-index: 9999;
  background: #FFC107;
  color: black;
  width: 150px;
  border-radius: 3px;
  box-shadow: 0 0 2px rgba(0,0,0,0.5);
  padding: 10px;
  text-align: center;
}
.style5 .tooltip {
  background: #1E252B;
  color: #FFFFFF;
  max-width: 200px;
  width: auto;
  font-size: .8rem;
  padding: .5em 1em;
}
.popper .popper__arrow,
.tooltip .tooltip-arrow {
  width: 0;
  height: 0;
  border-style: solid;
  position: absolute;
  margin: 5px;
}

.tooltip .tooltip-arrow,
.popper .popper__arrow {
  border-color: #FFC107;
}
.style5 .tooltip .tooltip-arrow {
  border-color: #1E252B;
}
.popper[x-placement^="top"],
.tooltip[x-placement^="top"] {
  margin-bottom: 5px;
}
.popper[x-placement^="top"] .popper__arrow,
.tooltip[x-placement^="top"] .tooltip-arrow {
  border-width: 5px 5px 0 5px;
  border-left-color: transparent;
  border-right-color: transparent;
  border-bottom-color: transparent;
  bottom: -5px;
  left: calc(50% - 5px);
  margin-top: 0;
  margin-bottom: 0;
}
.popper[x-placement^="bottom"],
.tooltip[x-placement^="bottom"] {
  margin-top: 5px;
}
.tooltip[x-placement^="bottom"] .tooltip-arrow,
.popper[x-placement^="bottom"] .popper__arrow {
  border-width: 0 5px 5px 5px;
  border-left-color: transparent;
  border-right-color: transparent;
  border-top-color: transparent;
  top: -5px;
  left: calc(50% - 5px);
  margin-top: 0;
  margin-bottom: 0;
}
.tooltip[x-placement^="right"],
.popper[x-placement^="right"] {
  margin-left: 5px;
}
.popper[x-placement^="right"] .popper__arrow,
.tooltip[x-placement^="right"] .tooltip-arrow {
  border-width: 5px 5px 5px 0;
  border-left-color: transparent;
  border-top-color: transparent;
  border-bottom-color: transparent;
  left: -5px;
  top: calc(50% - 5px);
  margin-left: 0;
  margin-right: 0;
}
.popper[x-placement^="left"],
.tooltip[x-placement^="left"] {
  margin-right: 5px;
}
.popper[x-placement^="left"] .popper__arrow,
.tooltip[x-placement^="left"] .tooltip-arrow {
  border-width: 5px 0 5px 5px;
  border-top-color: transparent;
  border-right-color: transparent;
  border-bottom-color: transparent;
  right: -5px;
  top: calc(50% - 5px);
  margin-left: 0;
  margin-right: 0;
} */

	</style>
</head>
<body>
			<%

			%>
	<%-- <nav
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
		<div class="row mb-5">

			<%-- <div class="sidebar col-lg-2 col-md-3 col-sm-4">
				<nav class="nav nav-pills flex-column">
					<div class="d-none d-sm-block nav-link text-center" href="#" data-member_id="${sessionScope.member.member_ID }"> <img
						src="<%=request.getContextPath()%>/member/ShowMemberImage?id=${sessionScope.member.member_ID}"
						class="img-fluid align-top " alt="tourism"> Hi
						${member.member_Name }
					</div> 
					<a class="nav-link" href="#">個人中心</a> 
					<a class="nav-link" href="#">管理訂單</a>
					<a class="nav-link" href="#">我的行程</a> 
					<a class="nav-link  active" href="#">我的日曆</a>
					<a class="nav-link" href="#">我的信箱</a> 
					<a class="nav-link" href="#">我的購物車</a> 
					<a class="nav-link" href="#">我的評價</a> 
					<a class="nav-link" href="#">我的收藏</a>
				</nav>
			</div> --%>
			<%@include file="../pages/sidebar_member.file" %>

			<div class="content col-lg-10 col-md-9 col-sm-8">
				<div class="title">
		          <h2>我的日曆</h2>
		        </div>
		        <hr>
		        <div class="container-fluid py-3 border rounded">
					<div id="calendar"></div>
				</div>
		    </div>
		    
		</div>
	</div>
	<%@ include file="../pages/footer.file" %>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
 	<script src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>
<!-- 	<script src="https://unpkg.com/@popperjs/core@2"></script>
 -->	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/core/main.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/daygrid/main.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/timegrid/main.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/interaction/main.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/rrule/main.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/moment/main.min.js"></script>
  	<script src="https://unpkg.com/tooltip.js/dist/umd/tooltip.min.js"></script>
  	
	<script>
		document.addEventListener('DOMContentLoaded', function () {
			  var member_id = $('div.sidebar').find('div.d-sm-block').data('member_id');
			  console.log(member_id);
			  let form_data = {
					  "action": "getSchedule",
					  "member_id": member_id
			  }
			  let form_dataString = JSON.stringify(form_data);
			  $.ajax({
				  	url: "<%=request.getContextPath()%>/collection/Member_Calendar.Api",
					type: 'POST',
					contentType: 'json',
					data: form_dataString,
					beforeSend: function(){
						console.log("get schedule");
					},
					success: function(res){
					 	console.log(res);
 						/* console.log(res.schedule);  */
 						var test = Object.keys(res.schedule);
 						console.log(test[0]);
 						let schedule_data = [];
						
						$(test).each(function(index, value){
							let custMaster = JSON.parse(value);
							let detail = res.schedule[test[index].toString()];
							let finalDetail = "行程：";
							$(detail).each(function(index, value){
								finalDetail += ((index+1) + "." + value + "\n")
							});
/* 							console.log(finalDetail);
							console.log('endtime=' + custMaster.cust_Schedule_End_Time); */
							let endtime = flatpickr.parseDate(custMaster.cust_Schedule_End_Time, 'Y-m-d');
							let endtime_hour = endtime.setTime(endtime.setHours(endtime.getHours() + 20));
							let singleEvent = {
									id: custMaster.cust_Schedule_ID,
									title: custMaster.cust_Schedule_Name,
									description: finalDetail,
									start: custMaster.cust_Schedule_Start_Time,
									end: endtime_hour
							}
							schedule_data.push(singleEvent);
						});
						console.log(schedule_data);
					      var calendarEl = document.getElementById('calendar');
					  	
					      var calendar = new FullCalendar.Calendar(calendarEl, {
					        plugins: ['dayGrid', 'interaction', 'timeGrid', 'rrule'],
					        editable: true,
					        header: {
					            left: 'prev,next today',
					            center: 'title',
					            right: 'dayGridMonth,timeGridWeek,timeGridDay'
					         },
					      /*   dateClick: function (info) {
					          alert('Clicked on: ' + info.dateStr);
					          alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
					          alert('Current view: ' + info.view.type);
					          // change the day's background color just for fun
					          info.dayEl.style.backgroundColor = 'red';
					        }, */
					        events: schedule_data,
					        eventRender: function(info){
					        	$(info.el).tooltip({
					        		title: info.event.extendedProps.description,
					        		placement: 'top',
					        		trigger: 'hover',
					        		container: 'body'
					        	});
					        },
				
					        eventTextColor: 'white',
					        displayEventTime: false,
					        eventDurationEditable: false,
			        		eventDrop: function(info) {
			        			let startdate = flatpickr.formatDate(info.event.start, 'Y-m-d');
			        			let enddate = flatpickr.formatDate(info.event.end, 'Y-m-d');
			        			let cust_id = info.event.id;
			        			
			        			let form_data = {
			        					"action":"updateCust",
			        					"cust_id": cust_id,
			        					"startdate": startdate,
			        					"enddate": enddate,	
			        			}
			        			let form_dataString = JSON.stringify(form_data);
			        			console.log(form_data);
/* 			        		    alert(info.event.title + " was dropped on " + info.event.start.toISOString());
			        		    alert(info.event.title + " was dropped on " + info.event.end); */

			        		    if (!confirm("確認進行修改嗎?")) {
			        		      info.revert();
			        		    }else{
			        		    	$.ajax({
			        		    		url: "<%=request.getContextPath()%>/collection/Member_Calendar.Api",
			        					type: 'POST',
			        					contentType: 'json',
			        					data: form_dataString,
			        					beforeSend: function(){
			        						console.log("update schedule");
			        					},
			        					success: function(res){
			        						if(res.result == true){
			        							Swal.fire({
			        								icon: 'success',
			        								title: '更新成功',
			        								text: res.update.cust_Schedule_Name + '更新至' + res.update.cust_Schedule_Start_Time + " ~ " + res.update.cust_Schedule_End_Time
			        							});
			        						}else{
			        							Swal.fire({
			        								icon: 'error',
			        								title: '更新失敗',
			        								text: '請聯繫管理員'
			        							});
			        						}
			        					}
			        		    	})
			        		    }
			        		  }
					      });
					      calendar.render();
				
					}
					
			  });

	
		    });
	</script>
</body>
</html>