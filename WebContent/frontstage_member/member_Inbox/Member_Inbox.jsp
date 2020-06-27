<%@page import="com.inbox.model.InboxService"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.inbox.model.InboxVO"%>
<%@page import="com.employee.model.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/css/footer.css">
<style>
body {
  font-size: 16px;
  font-family: Microsoft JhengHei;
  color: #343434;
  background-color: #F5F5F5;
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

hr {
	border: 1px solid rgb(13, 218, 218);
}

/*     @media (min-width: 1201px) {
      div.container {
        max-width: 1320px;
}
      } */
      
 div.pagination{
	  /* display: block; */
	  margin-top: 20px;
	  margin-bottom: 20px;
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
	.pagination a:hover:not(.active) {
	  background-color: #ddd;
	}
	
div.sidebar a.nav-link:hover{
	background-color: #007bff;
	color: #fff;
}
div.tab-content{
	max-height: 600px;
	overflow: scroll;
}
</style>

</head>
<body>
	<%
		MemberVO member = (MemberVO) session.getAttribute("member");
		String member_ID = member.getMember_ID();
		InboxService service = new InboxService();
		Set<InboxVO> inboxs = service.getInboxByMemberID("4", member_ID);		//4是會員收件夾
		pageContext.setAttribute("inboxs", inboxs);
		Set<InboxVO> outboxs = service.getInboxByMemberID("1", member_ID);		//1是會員寄件夾
		pageContext.setAttribute("outboxs", outboxs);
	%>
	<jsp:useBean id="empService" scope="page" class="com.employee.model.EmployeeService"/>
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
		<div class="row mb-5">
			<%-- <div class="sidebar col-lg-2 col-md-3 col-sm-4">
				<nav class="nav nav-pills flex-column">
					<div class="d-none d-sm-block nav-link text-center" href="#"> <img
						src="<%=request.getContextPath()%>/member/ShowMemberImage?id=${sessionScope.member.member_ID}"
						class="img-fluid align-top " alt="tourism"> Hi
						${member.member_Name }
					</div> 
					<a class="nav-link" href="#">個人中心</a> 
					<a class="nav-link" href="#">管理訂單</a>
					<a class="nav-link" href="#">我的行程</a> 
					<a class="nav-link" href="#">管理票券</a>
					<a class="nav-link active" href="#">我的信箱</a> 
					<a class="nav-link" href="#">我的購物車</a> 
					<a class="nav-link" href="#">我的評價</a> 
					<a class="nav-link" href="#">我的收藏</a>
				</nav>
			</div> --%>
			<%@include file="../pages/sidebar_member.file" %>
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
									<form class="inbox" method="POST" action="<c:url value="/inbox/WriteMail.Controller" />">
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
														      <c:forEach var="emp1" items="${empService.all }">
															      <option value="${emp1.emp_ID }">${emp1.emp_Name }</option>
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
													<c:forEach var="emp" items="${empService.all }">
														<c:if test="${inbox.emp_ID==emp.emp_ID }">
															${emp.emp_Name }
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
										<form class="inbox" method="POST" action="<c:url value="/inbox/WriteMail.Controller" />">
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
														      <c:forEach var="emp1" items="${empService.all }">
															      <option value="${emp1.emp_ID }">${emp1.emp_Name }</option>
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
													<c:forEach var="emp" items="${empService.all }">
														<c:if test="${outbox.emp_ID==emp.emp_ID }">
															${emp.emp_Name }
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
	
<!-- 新增信件 -->

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
          <form method="POST" action="<c:url value="/inbox/WriteMail.Controller" />">
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
			      <c:forEach var="emp1" items="${empService.all }">
				      <option value="${emp1.emp_ID }">${emp1.emp_Name }</option>
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
          <input type="hidden" name="state" id="write_state" value="1">
          <input type="hidden" id="write_id" value="${member.member_ID }">
         <!--  <button type="submit" name="action" value="writeMail" class="btn btn-primary">送出</button> -->
          <button class="writeMail btn btn-primary" type="button">送出</button>
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

	<%--         <div class="title">
          <h2>我的信箱</h2>
        </div>
        <hr>
        <div class="tool my-2">
          <button type="button" class="btn btn-primary mx-2"><i class="fas fa-pen fa-2x"></i></button>
          <button type="button" class="btn btn-primary"><i class="fas fa-trash-alt fa-2x"></i></button>
        </div>
        <table class="table table-hover">
          <thead>
            <tr>
              <th style="width:5%" scope="col">#</th>
              <th style="width:10%" scope="col">選擇</th>
              <th style="width:10%" scope="col">姓名</th>
              <th style="width:20%" scope="col">標題</th>
              <th style="width:55%" scope="col">內容</th>
            </tr>
          </thead>
          <c:forEach var="inbox" items="${inboxs }" varStatus="loop">
          
	          <tbody>
	            <tr>
	              <th scope="row">${loop.count }</th>
	              <td><input type="checkbox"></td>
	              <td>${inbox.emp_ID }</td>
	              <td>${inbox.inbox_Mail_Title }</td>
	              <td>${inbox.inbox_Mail_Info }</td>
	            </tr>
	          </tbody>
          
          </c:forEach>
        </table> --%>






	<%@ include file="../pages/footer.file" %>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>
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
		
/* 		$('tbody').on('click', 'input.checkbox_delete', function(){
			$('div#readModal').modal('hide');
		}); */
		
		
		
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
				url: "<%=request.getContextPath()%>/inbox/Inbox.Api",
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
						/* $('select#write_name').val(""); */
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
					url: "<%=request.getContextPath()%>/inbox/InboxSearch.Api",
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
					url: "<%=request.getContextPath()%>/inbox/InboxSearch.Api",
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