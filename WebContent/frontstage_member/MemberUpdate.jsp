<%@page import="com.credit_card.model.Credit_CardVO"%>
<%@page import="com.credit_card.model.Credit_CardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<!DOCTYPE html>

<%-- <% 
	MemberService service = new MemberService();
	List<MemberVO> members = service.getAll();
	pageContext.setAttribute("members", members);
%> --%>
<%-- <jsp:useBean id="members" scope="page"
	class="com.member.model.MemberService" /> --%>
<html>
	<head>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	  <link rel=stylesheet type="text/css"
		href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	    <link rel=stylesheet type="text/css"
			href="<%=request.getContextPath()%>/vendors/css/footer.css">
	  <title>會員修改資料</title>
	  <style>
		body {
		  font-family: Microsoft JhengHei;
		  font-size: 16px;
		  color: #343434;
		  background-color: #F5F5F5;
		}
		
		div.sidebar a.nav-link:hover{
			background-color: #007bff;
			color: #fff;
		}
		span.input-group-addon{
			margin:auto 10px;
	
		}
		
		.input-group>.custom-select:not(:first-child), .input-group>.form-control:not(:first-child){
			border-bottom-left-radius: 0.25rem;
			border-top-left-radius: 0.25rem;
			border-bottom-right-radius: 0.25rem;
			border-top-right-radius: 0.25rem;
		}
	
	    hr {
	      border: 1px solid rgb(13, 218, 218);
	    }
	
/* 	    @media (min-width: 1201px) {
	      div.container {
	        max-width: 1320px;
	      } */
	    }
	    

	  </style>

	</head>
	<body>
		<body>
		<%@ include file="pages/header.file"  %>
		  <%-- <nav class="navbar navbar-expand navbar-light d-flex justify-content-start" style="background-color: #e3f2fd;">
		    <a class="navbar-brand mr-auto" href="#">
		      <img src="<%=request.getContextPath()%>/img/david_img/logo.png" width="30" height="30" class="d-inline-block align-top" alt="tourism">
		      Tourism</a>
		    <ul class="navbar-nav">
		      <li class="nav-item">
		        <a class="nav-link" href="#"><i class="fas fa-pen"></i>建立行程</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="#"><i class="fas fa-store"></i>商城</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="#"><i class="fas fa-shopping-cart"></i>購物車</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="#"><i class="fas fa-sign-in-alt"></i>會員中心</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="#"><i class="fas fa-user"></i>USER</a>
		      </li>
		    </ul>
		  </nav> --%>
	
		<div class="container mt-sm-4">
		    <div class="row mb-5">
		      <%-- <div class="sidebar col-lg-2 col-md-3 col-sm-4">
		        <nav class="nav nav-pills flex-column">
		          <div class="d-none d-sm-block nav-link text-center" href="#">
		            <img src="<%=request.getContextPath()%>/member/ShowMemberImage?id=${sessionScope.member.member_ID}" class="img-fluid rounded mx-auto " alt="tourism">
		            Hi ${member.member_Name }</div>
		          <a class="nav-link active" href="#">個人中心</a>
		          <a class="nav-link" href="#">管理訂單</a>
		          <a class="nav-link" href="#">我的行程</a>
		          <a class="nav-link" href="#">管理票券</a>
		          <a class="nav-link" href="#">我的信箱</a>
		          <a class="nav-link" href="#">我的購物車</a>
		          <a class="nav-link" href="#">我的評價</a>
		          <a class="nav-link" href="#">我的收藏</a>
		        </nav>
		      </div> --%>
			  <%@include file="./pages/sidebar_member.file" %>
		      <div class="content col-lg-10 col-md-9 col-sm-8">
		        <div class="title">
		          <h2>個人中心</h2>
		        </div>
		        <hr>
				<div class="card">
	                <div class="card-header">我的資料</div>
	                <div class="card-body">
	
	                    <form class="form-horizontal" method="post" action="<c:url value="/member/MemberUpdate.Controller" />" enctype="multipart/form-data">
	
	                        <div class="form-group">
	                            <label for="name" class="cols-sm-2 control-label">姓名</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
	                                    <input type="text" class="form-control" name="name" id="name" placeholder="Enter your Name" value="${member.member_Name }" required/><br>
	                                </div>
	                                <small class="form-text font-weight-bold text-danger">${errorMsg.name_empty }</small>
	                                <small class="form-text font-weight-bold text-danger">${errorMsg.name_Reg }</small>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                        	<label for="account" class="cols-sm-2 control-label">帳號</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
	                                    <input type="text" class="form-control" name="account" id="account" placeholder="Enter your Account" value="${member.member_Account }" readonly />
	                                </div>
	                                <small class="form-text font-weight-bold text-danger">${errorMsg.account_empty }</small> 
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label for="password" class="cols-sm-2 control-label">密碼</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fas fa-lock"></i></span>
	                                    <input type="password" class="form-control" name="password" id="password" placeholder="Enter your Password" value="${member.member_Pwd }" />
	                                </div>
	                                <small class="form-text font-weight-bold text-danger">${errorMsg.password_empty }</small>
	                            </div>
	                        </div>
<%-- 	                        <div class="form-group">
	                            <label for="confirm" class="cols-sm-2 control-label">確認密碼</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fas fa-lock"></i></span>
	                                    <input type="password" class="form-control" name="confirm" id="confirm" placeholder="Confirm your Password" value="${member.member_Pwd }" />
	                                </div>
	                            </div>
	                        </div> --%>
	                        <div class="form-group">
	                        	<label for="sex" class="cols-sm-2 control-label">性別</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
	                                    <div class="custom-control custom-radio custom-control-inline">
	                                    	<input type="radio" class="custom-control-input" name="sex" id="male" value="M" ${(member.member_Sex == "M")?'checked':'' }/>
	                                    	<label for="male" class="custom-control-label">男</label>
	                                    </div>          
	                                    <div class="custom-control custom-radio custom-control-inline">
	                                    	<input type="radio" class="custom-control-input" name="sex" id="female" value="F" ${(member.member_Sex == "F")?'checked':'' } />
	                                    	<label for="female" class="custom-control-label">女</label>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        
	                        <div class="form-group">
	                            <label for="phone" class="cols-sm-2 control-label">電話</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fas fa-phone-alt"></i></span>
	                                    <input type="text" class="form-control" name="phone" id="phone" placeholder="Enter your Phone" value="${member.member_Phone }" />
	                                </div>
	                                <small class="form-text font-weight-bold text-danger">${errorMsg.phone_empty }</small> 
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label for="email" class="cols-sm-2 control-label">信箱</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
	                                    <input type="text" class="form-control" name="email" id="email" placeholder="Enter your Email" value="${member.member_Mail }" />
	                                </div>
	                                <small class="form-text font-weight-bold text-danger">${errorMsg.mail_empty }</small> 
	                                
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label for="address" class="cols-sm-2 control-label">地址</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fas fa-map-marked-alt"></i></span>
	                                    <p id="zipcode2"></p>
	                                    <% 
	                                    	MemberVO bean = (MemberVO)session.getAttribute("member"); 
	                                    	String member_Address = bean.getMember_Address();
	                            			String member_Main = member_Address.substring(0, 6);
	                            			String member_Detail = member_Address.substring(6);
	                            			pageContext.setAttribute("member_Main", member_Main);
	                            			pageContext.setAttribute("member_Detail", member_Detail);
	                                    %>
	                                    <input type="text" class="form-control col-sm-12" name="address_main" id="address_main" placeholder="Enter your Address" value="${member_Main }" readonly/>
	                                    <input type="text" class="form-control col-sm-10" name="address_detail" id="address_detail" placeholder="Enter your Address" value="${member_Detail }"  />
	                                </div>
	                                <small class="form-text font-weight-bold text-danger">${errorMsg.addressDetail_empty }</small>
	                            </div>
	                        </div>
	                       
	                        <div class="form-group">
	                            <label for="birthday" class="cols-sm-2 control-label">生日</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fas fa-birthday-cake"></i></span>
	                                    <input type="text" class="form-control col-sm-6" name="birthday" id="birthday" placeholder="Enter your Birthday" value="${member.member_Birth}"/>
	                                </div>
	                                <small class="form-text font-weight-bold text-danger">${errorMsg.birthday_empty }</small>
	                            </div>
	                        </div>
	                        <%
                        		MemberVO bean1 = (MemberVO)session.getAttribute("member"); 
								String member_ID = bean1.getMember_ID();
	                        	Credit_CardService service = new Credit_CardService();
	                        	Set<Credit_CardVO>cards = service.getCredit_CardByMember_ID(member_ID);
	                        	pageContext.setAttribute("creditcard", cards);
	                        %>
	                        <div class="form-group">
	                            <label for="creditcard" class="cols-sm-2 control-label">已登錄信用卡</label>
	                            <div class="cols-sm-10">
	                                <div class="input-group">
	                                    <span class="input-group-addon"><i class="fas fa-credit-card"></i></span>
	                                    <select class="form-control" name="creditcard" id="creditcard" >
	                                    	<c:forEach var="card" items="${creditcard }">
	                                    		<option value="${card.credit_Card_Number }">${card.credit_Card_Number }</option>
	                                    	</c:forEach>
	                                    </select>
	                                <a class= "btn btn-primary" href="<%=request.getContextPath() %>/frontstage_member/member_Credit_Card/Member_Credit_Card.jsp" type="button">新增</a>
	                                </div>
	                            </div>
	                        </div>
                            <div class="form-group">
						      <label for="file1" class="cols-sm-2 control-label">照片</label>
                           		<div class="input-group mb-3">
								  <div class="input-group-prepend">
								  	  <span class="input-group-addon"><i class="fas fa-camera"></i></span>
								  	  <span class="input-group-text">上傳照片</span>
								  </div>
								  <div class="custom-file">
									  <label class="custom-file-label" for="file1">請選擇檔案</label>
									  <input type="file" class="custom-file-input" name="img" id="file1">
								  </div>
								</div>
								<img id="file1_img" class="img-fluid rounded mx-auto d-block mt-3">
                            </div>
	                        <div class="form-group ">
	                        	<input type="hidden" name="id" value="${member.member_ID }">
	                        	<input type="hidden" name="action" value="Update">
	                            <button type="submit" class="btn btn-primary btn-lg btn-block login-button">修改確認</button>
	                        </div>
	                    </form>
	                </div>
	
	            </div>
		 
		
		      </div>
		    </div>
		  </div>
		<%@include file="./pages/footer.file" %>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
		<script src="<%=request.getContextPath()%>/vendors/addressZip/twzipcode.js"></script>
		<script type="text/javascript">
		
		$("#birthday").flatpickr({
		    altInput: true,
		    altFormat: "Y年 m月 j日",
		    dateFormat: "Y/m/d",
		    maxDate: "today",
		});
		
		$("#zipcode2").twzipcode({
	    	countySel: "臺北市", // 城市預設值, 字串一定要用繁體的 "臺", 否則抓不到資料
	        districtSel: "大安區", // 地區預設值
	        zipcodeIntoDistrict: true, // 郵遞區號自動顯示在地區
	        css: ["city form-control", "town form-control"], // 自訂 "城市"、"地區" class 名稱
	        countyName: "city", // 自訂城市 select 標籤的 name 值
	        districtName: "town" // 自訂地區 select 標籤的 name 值
	    });
		
		$('select.town').on('change', function(){
			let city = $('select.city').val();
			let town = $('select.town').val();
			let zip = $('select.town').text().slice(0,3);
			$('input#address_main').val(city + town);
			
	
		})
//========================預覽圖片===================================	
	var file1 = document.getElementById("file1")
    var file1_img = document.getElementById("file1_img");

    file1.addEventListener("change", function () {
      let reader = new FileReader;
      reader.readAsDataURL(this.files[0]);
      reader.addEventListener("load", function () {
        file1_img.setAttribute("src", reader.result);
      })
    })

//========================預覽圖片結束===================================	
		</script>
	</body>
	
</html>