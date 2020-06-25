<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<title>Insert title here</title>
<style>
	span.input-group-addon{
		margin:auto 10px;

	}
	
	.input-group>.custom-select:not(:first-child), .input-group>.form-control:not(:first-child){
		border-bottom-left-radius: 0.25rem;
		border-top-left-radius: 0.25rem;
		border-bottom-right-radius: 0.25rem;
		border-top-right-radius: 0.25rem;
	}
	
	.-none {
		display: none;
	}
	
body {
  font-family: Microsoft JhengHei;
  font-size: 16;
  color: #343434;
  background-color: #F5F5F5;
}
	
/* 	input{
	-webkit-border-radius: 50px;
	-moz-border-radius: 50px;
	border-radius: 50px;
	}
 */
 

/* .custom-control-lg .custom-control-label::before,
.custom-control-lg .custom-control-label::after {
    top: 0.1rem !important;
    left: -2rem !important;
    width: 1.25rem !important;
    height: 1.25rem !important;
}

.custom-control-lg .custom-control-label {
    margin-left: 0.5rem !important;
    font-size: 1rem !important;
} */
</style>
</head>
<body>

	<%@ include file="pages/header.file"  %>
	<div class="container">
		<div class="row justify-content-center my-5">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">會員註冊</div>
                            <div class="card-body">

                                <form class="form-horizontal" method="post" action="<c:url value="/member/SignUp.Controller" />" enctype="multipart/form-data">

                                    <div class="form-group">
                                        <label for="name" class="cols-sm-2 control-label">姓名</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                                                <input type="text" class="form-control " name="name" id="name" placeholder="輸入您的姓名" value="${member.member_Name }"/><br>
                                            </div>
                                            <small class="form-text font-weight-bold text-danger">${errorMsg.name_empty }</small>
                                            <small class="form-text font-weight-bold text-danger">${errorMsg.name_Reg }</small>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                    	<label for="account" class="cols-sm-2 control-label">帳號</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group account_group" data-check_account ="0">
                                                <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
                                                <input type="text" class="form-control" name="account" id="account" placeholder="輸入您的帳號" value="${member.member_Account }" />
                                                <button class= "check_account btn btn-primary btn-sm" type="button">check</button>
                                                <i class="fas fa-spinner fa-spin fa-2x -none" id="loading" style="color: #5f5ff7;"></i>
                                                <i class="fas fa-check fa-2x -none" style="color: #5f5ff7;"></i>
                                                <i class="fas fa-times fa-2x -none" style="color: red;"></i>
                                            </div>
                                            <small class="form-text font-weight-bold text-danger">${errorMsg.account_empty }</small> 
                                        </div>
                                    </div>
                                     <div class="form-group">
                                        <label for="password" class="cols-sm-2 control-label">密碼</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-lock"></i></span>
                                                <input type="password" class="form-control" name="password" id="password" placeholder="輸入您的密碼" />
                                            </div>
                                            <small class="form-text font-weight-bold text-danger">${errorMsg.password_empty }</small>
                                        </div>
                                    </div>
 <!--                                    <div class="form-group">
                                        <label for="confirm" class="cols-sm-2 control-label">Confirm Password</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-lock"></i></span>
                                                <input type="password" class="form-control" name="confirm" id="confirm" placeholder="確認密碼" />
                                            </div>
                                        </div>
                                    </div> -->
                                    <c:choose>
                                    <c:when test="${not empty errorMsg}">
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
	                                                	<input type="radio" class="custom-control-input" name="sex" id="female" value="F" ${(member.member_Sex == "F")?'checked':'' }/>
	                                                	<label for="female" class="custom-control-label">女</label>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </c:when>
	                                <c:when test="${!not empty errorMsg}">
	                                    <div class="form-group">
	                                    	<label for="sex" class="cols-sm-2 control-label">性別</label>
	                                        <div class="cols-sm-10">
	                                            <div class="input-group">
	                                                <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
	                                                <div class="custom-control custom-radio custom-control-inline">
	                                                	<input type="radio" class="custom-control-input" name="sex" id="male" value="M" checked/>
	                                                	<label for="male" class="custom-control-label">男</label>
	                                                </div>          
	                                                <div class="custom-control custom-radio custom-control-inline">
	                                                	<input type="radio" class="custom-control-input" name="sex" id="female" value="F"/>
	                                                	<label for="female" class="custom-control-label">女</label>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
                                    </c:when>
                                    </c:choose>
                                    
                                    <div class="form-group">
                                        <label for="phone" class="cols-sm-2 control-label">電話</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-phone-alt"></i></span>
                                                <input type="text" class="form-control" name="phone" id="phone" placeholder="輸入您的電話" value="${member.member_Phone }" />
                                            </div>
                                            <small class="form-text font-weight-bold text-danger">${errorMsg.phone_empty }</small>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="email" class="cols-sm-2 control-label">你的信箱</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
                                                <input type="text" class="form-control" name="email" id="email" placeholder="輸入您的電子信箱" value="${member.member_Mail }" />
                                            </div>
                                            <small class="form-text font-weight-bold text-danger">${errorMsg.mail_empty }</small>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="address" class="cols-sm-2 control-label">你的地址</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-map-marked-alt"></i></span>
                                                <p id="zipcode2"></p>
                                                <input type="text" class="form-control col-sm-12" name="address_main" id="address_main" placeholder="" readonly/>
                                                <input type="text" class="form-control col-sm-10" name="address_detail" id="address_detail" placeholder="輸入您的地址" />
                                            </div>
                                            <small class="form-text font-weight-bold text-danger">${errorMsg.addressDetail_empty }</small>
                                        </div>
                                    </div>
                                   
                                    <div class="form-group">
                                        <label for="birthday" class="cols-sm-2 control-label">生日</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-birthday-cake"></i></span>
                                                <input type="text" class="form-control col-sm-6" name="birthday" id="birthday" placeholder="輸入您的生日" value="${member.member_Birth}" />
<!--                                                 <span class="my-auto mx-1">年</span>
                                                <input type="password" class="form-control col-sm-3" name="birthday-M" id="birthday-M" placeholder="Confirm your Password" />
                                                <span class="my-auto mx-1">月</span>
                                                <input type="password" class="form-control col-sm-3" name="birthday-D" id="birthday-D" placeholder="Confirm your Password" />
                                                <span class="my-auto mx-1">日</span> -->
                                            </div>
                                            <small class="form-text font-weight-bold text-danger">${errorMsg.birthday_empty }</small>
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
										<img src="" id="file1_img" class="img-fluid rounded mx-auto d-block mt-3">
                                    </div>
 
                                    <div class="form-group ">
                                    	<input type="hidden" name="action" value="SignUp">
                                        <button type="submit" class="btn btn-primary btn-lg btn-block login-button">Register</button>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
</div>
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
	
	  function checkAccount(){
		  if($('div.account_group').data('check_account') === 0) {
			  $('button.login-button').attr('disabled', true);
		  }else{
			  $('button.login-button').attr('disabled', false);
		  }
	  }
	  
	  checkAccount();
	  
	  
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
	
	$('select').on('change', function(){
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

//========================驗證帳號是否重複================================    
	$(function(){
		$('div.input-group').on('click', 'button.check_account', function(){
			var account = $('input#account').val();
			var form_data = {
		    	"account": account
		    };
		    var form_dataString = JSON.stringify(form_data);		//後端接收參數為String type的JSON
			let this_button = $(this);
			alert('begin ajax');
			$.ajax({
				url: "<%=request.getContextPath()%>/member/Login.Api",
				type : 'POST',
				contentType:'application/json',
				dataType : 'json',
/* 				data : {											傳送text方式 !基本!
					account: $('input#account').val()
				}, */
				data : form_dataString,
				beforeSend: function(){
					$('div.account_group').find('button.check_account').hide();
					$('div.account_group').find('svg#loading').show();
				},
				success: function(res){
					$('div.account_group').find('svg#loading').hide();
					
					console.log(res);
					if(res.result === 'OK'){
						$('div.account_group').find('svg.fa-check').show();
						$('div.account_group').data('check_account', 1);
						checkAccount();
					}else{
						$('div.account_group').find('svg.fa-times').show();
						$('div.account_group').data('check_account', 0);
						checkAccount();
					}
					
				}
				
			});
		});
	});
    
	  $('input#account').on('change', function(){
		  $('div.account_group').data('check_account', 0);
		  $(this).closest('div').find('button.check_account').show();
		  $(this).closest('div').find('svg#loading').hide();
		  $(this).closest('div').find('svg.fa-times').hide();
		  $(this).closest('div').find('svg.fa-check').hide();
		  checkAccount();
		  
	  })  
	  

	 
	  
	</script>
</body>
</html>