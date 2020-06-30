<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">

<title>登入頁</title>
<style type="text/css">
	
html {
  background-color: #F5F5F5;
}

body {
  font-family: Microsoft JhengHei;
  font-size: 16;
  color: #343434;
  background-color: #F5F5F5;
  height: 80vh;
}

a {
  color: #92badd;
  display:inline-block;
  text-decoration: none;
  font-weight: 400;
}

h2 {
  text-align: center;
  font-size: 16px;
  font-weight: 600;
  text-transform: uppercase;
  display:inline-block;
  margin: 40px 8px 10px 8px; 
  color: #cccccc;
}



/* STRUCTURE */

.wrapper {
  display: flex;
  align-items: center;
  flex-direction: column; 
  justify-content: center;
  width: 100%;
  min-height: 100%;
  padding: 20px;
}

#formContent {
  -webkit-border-radius: 10px 10px 10px 10px;
  border-radius: 10px 10px 10px 10px;
  background: #fff;
  padding: 30px;
  width: 90%;
  max-width: 450px;
  position: relative;
  padding: 0px;
  -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
  box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
  text-align: center;
}

#formFooter {
  background-color: #f6f6f6;
  border-top: 1px solid #dce8f1;
  padding: 25px;
  text-align: center;
  -webkit-border-radius: 0 0 10px 10px;
  border-radius: 0 0 10px 10px;
}



/* TABS */

h2.inactive {
  color: #cccccc;
}

h2.active {
  color: #0d0d0d;
  border-bottom: 2px solid #5fbae9;
}



/* FORM TYPOGRAPHY*/

input[type=button], input[type=submit], input[type=reset]  {
  background-color: #56baed;
  border: none;
  color: white;
  padding: 15px 80px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  text-transform: uppercase;
  font-size: 13px;
  -webkit-box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
  box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
  -webkit-border-radius: 5px 5px 5px 5px;
  border-radius: 5px 5px 5px 5px;
  margin: 15px auto 40px auto;
  -webkit-transition: all 0.3s ease-in-out;
  -moz-transition: all 0.3s ease-in-out;
  -ms-transition: all 0.3s ease-in-out;
  -o-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}

input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover  {
  background-color: #39ace7;
}

input[type=button]:active, input[type=submit]:active, input[type=reset]:active  {
  -moz-transform: scale(0.95);
  -webkit-transform: scale(0.95);
  -o-transform: scale(0.95);
  -ms-transform: scale(0.95);
  transform: scale(0.95);
}

input[type=text], input[type=password] {
  background-color: #f6f6f6;
  border: none;
  color: #0d0d0d;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 5px;
  width: 85%;
  border: 2px solid #f6f6f6;
  -webkit-transition: all 0.5s ease-in-out;
  -moz-transition: all 0.5s ease-in-out;
  -ms-transition: all 0.5s ease-in-out;
  -o-transition: all 0.5s ease-in-out;
  transition: all 0.5s ease-in-out;
  -webkit-border-radius: 5px 5px 5px 5px;
  border-radius: 5px 5px 5px 5px;
}

input[type=text]:focus {
  background-color: #fff;
  border-bottom: 2px solid #5fbae9;
}

input[type=text]:placeholder {
  color: #cccccc;
}



/* ANIMATIONS */

/* Simple CSS3 Fade-in-down Animation */
.fadeInDown {
  -webkit-animation-name: fadeInDown;
  animation-name: fadeInDown;
  -webkit-animation-duration: 0.5s;
  animation-duration: 0.5s;
  -webkit-animation-fill-mode: both;
  animation-fill-mode: both;
}

@-webkit-keyframes fadeInDown {
  0% {
    opacity: 0;
    -webkit-transform: translate3d(0, -100%, 0);
    transform: translate3d(0, -100%, 0);
  }
  100% {
    opacity: 1;
    -webkit-transform: none;
    transform: none;
  }
}

@keyframes fadeInDown {
  0% {
    opacity: 0;
    -webkit-transform: translate3d(0, -100%, 0);
    transform: translate3d(0, -100%, 0);
  }
  100% {
    opacity: 1;
    -webkit-transform: none;
    transform: none;
  }
}

/* Simple CSS3 Fade-in Animation */
@-webkit-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
@-moz-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
@keyframes fadeIn { from { opacity:0; } to { opacity:1; } }

.fadeIn {
  opacity:0;
  -webkit-animation:fadeIn ease-in 1;
  -moz-animation:fadeIn ease-in 1;
  animation:fadeIn ease-in 1;

  -webkit-animation-fill-mode:forwards;
  -moz-animation-fill-mode:forwards;
  animation-fill-mode:forwards;

  -webkit-animation-duration:0.5s;
  -moz-animation-duration:0.5s;
  animation-duration:0.5s;
}

.fadeIn.first {
  -webkit-animation-delay: 0.2s;
  -moz-animation-delay: 0.2s;
  animation-delay: 0.2s;
}

.fadeIn.second {
  -webkit-animation-delay: 0.3s;
  -moz-animation-delay: 0.3s;
  animation-delay: 0.3s;
}

.fadeIn.third {
  -webkit-animation-delay: 0.4s;
  -moz-animation-delay: 0.4s;
  animation-delay: 0.4s;
}

.fadeIn.fourth {
  -webkit-animation-delay: 0.5s;
  -moz-animation-delay: 0.5s;
  animation-delay: 0.5s;
}

/* Simple CSS3 Fade-in Animation */
.underlineHover:after {
  display: block;
  left: 0;
  bottom: -10px;
  width: 0;
  height: 2px;
  background-color: #56baed;
  content: "";
  transition: width 0.2s;
}

.underlineHover:hover {
  color: #0d0d0d;
}

.underlineHover:hover:after{
  width: 100%;
}



/* OTHERS */

*:focus {
    outline: none;
} 

#icon {
  width:60%;
}
 img#icon{
	max-width:30%;
	margin: 5% auto 5% auto;
} 

.-none {
	display: none;
}
</style>
</head>
<body>
<%

	session.removeAttribute("member");

%>
<%@ include file="pages/header.file"  %>
<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
      <img src="<%=request.getContextPath()%>/img/david_img/logo.png" id="icon" alt="User Icon" />
    </div>

    <!-- Login Form -->
      <form method="post" action="<c:url value="/member/login.controller" />"> 
      <input type="text" id="login" class="fadeIn second" name="account" placeholder="login" value="${account }"><br>
      <span class="fadeIn fourth text-danger">${errorMsg.account }</span>
      <input type="password" id="password" class="fadeIn third" name="password" placeholder="password"><br>
      <span class="fadeIn fourth text-danger">${errorMsg.password }</span>
      <div class="fadeIn fourth text-danger">${errorMsg.login }</div>
		<div class="fadeIn fourth text-danger">${errorMsg.other }</div>
      <input type="submit" id="memberlogin" class="fadeIn fourth d-none" name="action" value="SignIn" >
      <input type="button" id="buttonforlogin" class="fadeIn fourth" value="會員登入"> 
      <input type="submit" id="memberSign" class="fadeIn fourth d-none" name="action" value="SignUp">
	  <input type="button" class="fadeIn fourth" data-toggle="modal" data-target="#SignUpConfirm" value="會員註冊"> 
    </form>

    <!-- Remind Passowrd -->
    <div id="formFooter">
      <a class="underlineHover" href="#" data-toggle="modal" data-target="#ForgetPwd">Forgot Password?</a>
    </div>

  </div>
  
</div>
<div class="modal fade" id="SignUpConfirm" tabindex="-1" role="dialog" aria-labelledby="SignUpConfirmLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">信箱驗證</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span class="countdownarea"></span>
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="emailAddress" class="col-form-label d-block">請輸入您的信箱</label>
            <input type="text" class="col-8 form-control d-inline" id="emailAddress">
	        <button type="button" class="col-3 btn btn-primary" id="sendMail">發送驗證信</button>
	        <i class="fas fa-spinner fa-spin fa-2x -none" id="sendloading"></i>
          </div>
          <div class="form-group -none" id="confirmArea">
            <label for="confirmcode" class="col-form-label d-block">請輸入驗證碼:</label>
            <input type="text" class="col-8 form-control" id="confirmcode"></input>
	        <button type="button" class="col-3 btn btn-primary" id="checkconfirm">驗證</button>
	        <i class="fas fa-spinner fa-spin fa-2x -none" id="confirmloading"></i>  
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="ForgetPwd" tabindex="-1" role="dialog" aria-labelledby="ForgetPwdLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="ForgetPwdLabel">忘記密碼</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="forget_account" class="col-form-label">請輸入帳號:</label>
            <input type="text" class="form-control" id="forget_account">
	        <i class="fas fa-spinner fa-spin fa-2x -none"></i>
          </div>
          <div class="form-group">
            <label for="forget_emailAddress" class="col-form-label">請輸入電子郵件:</label>
            <input type="text" class="form-control" id="forget_emailAddress"></input>
	        <i class="fas fa-spinner fa-spin fa-2x -none"></i>  
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	    <button type="button" class="btn btn-primary forget_password">發送</button>
      </div>
    </div>
  </div>
</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
		
	<script type="text/javascript">
		$('input#buttonforlogin').on('click', function(){
			console.log('1234432324234');
			$('input#memberlogin').click();
		})
		
		$(function(){
			$('button.forget_password').on('click', function(){
				let account = $(this).closest('div.modal-content').find('input#forget_account').val().trim();
				let emailAddress = $(this).closest('div.modal-content').find('input#forget_emailAddress').val().trim();
				let this_button = $(this);
	/* 			console.log(account + emailAddress); */
				var emailpattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
				if(emailAddress.search(emailpattern) === -1){
					Swal.fire({
						icon: 'error',
						title: '信箱異常',
						text: '請重新輸入信箱'
					});
					return;
				}else if(account.length == 0 || emailAddress.length == 0){
					Swal.fire({
						icon: 'error',
						title: '輸入錯誤',
						text: '請輸入帳號跟電子信箱'
					});
					return;
				}
				
				let form_data = {
						"action": "forgetPassword",
						"account": account,
						"emailAddress": emailAddress
				}
				
				let form_dataString = JSON.stringify(form_data);
				$.ajax({
					url: '<%=request.getContextPath()%>/member/SignUpConfirm.Api',
					type: 'POST',
					contentType:'application/json',
					dataType: 'json',
					data: form_dataString,
					beforeSend: function(){
						this_button.closest('div.modal-content').find('svg.fa-spinner').toggleClass('-none');
					},
					success: function(res){
						this_button.closest('div.modal-content').find('svg.fa-spinner').toggleClass('-none');
						if(res.result == false){
							Swal.fire({
								icon: 'error',
								title: "錯誤",
								text: res.reason
							});
						}else{
							Swal.fire({
								icon: 'success',
								title: "成功",
								text: "已將您的密碼寄送至：" + res.emailAddress
							});
						}
					}
					
				})
			});
			$('button#sendMail').on('click', function(){
				let emailAddress = $('input#emailAddress').val().trim();
				var emailpattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
				if(emailAddress.search(emailpattern) === -1){
					Swal.fire({
						icon: 'error',
						title: '信箱異常',
						text: '請重新輸入信箱或者更換信箱'
					});
					return;
				}
				let form_data = {
					"action" : "sendCode",
					"emailAddress": emailAddress	
				};
				if(emailAddress === "" || emailAddress.trim().length == 0){
					Swal.fire({
						icon: 'error',
						title: '信箱錯誤',
						text: '請輸入信箱'
					});
					return;
				}
				
				let form_dataString = JSON.stringify(form_data);
				$.ajax({
					url: '<%=request.getContextPath()%>/member/SignUpConfirm.Api',
					type: 'POST',
					contentType:'application/json',
					dataType: 'json',
					data: form_dataString,
					beforeSend: function(){
						Swal.fire({
							icon: 'warning',
							title: '驗證碼已送出，請確認您的信箱',
							text: '您輸入的信箱為:' + emailAddress
						});
						$('button#sendMail').hide();
						$('svg#sendloading').toggleClass('-none');
					},
					success: function(res){
						$('button#sendMail').show();
						$('svg#sendloading').toggleClass('-none');
/* 						$('input#emailAddress').attr('readonly', 'true');
 */						console.log(res);
						if(res.result === true){
							$('div#confirmArea').slideDown('slow');
							
							let countdown = parseInt(res.countdown);
/* 							$('input#confirmcode').prev().html("請在<p class='d-inline'>" + countdown + "</p>秒內輸入驗證碼");*/
							  for (let i = 0; i <= countdown; i++) {
							    setTimeout(function () {
							      $("span.countdownarea").html(countdown);
							      countdown -= 1;
							    }, 1000 * i);
							  }
							
						}else{
							Swal.fire({
								icon: 'error',
								title: '信箱異常',
								text: '請重新輸入信箱或者更換信箱'
							});
							return;
						}
					}
				});
			});
			
			$('button#checkconfirm').on('click', function(){
				let emailAddress = $('input#emailAddress').val().trim();
				let confirmcode = $('input#confirmcode').val().trim();
				let form_data = {
					"action" : "verify",
					"emailAddress": emailAddress,
					"confirmcode": confirmcode
				};
				
				if(confirmcode === "" || confirmcode.trim().length == 0){
					Swal.fire({
						icon: 'error',
						title: '驗證碼空白',
						text: '請輸入驗證碼'
					});
					return;
				}
				
				let form_dataString = JSON.stringify(form_data);
				$.ajax({
					url: '<%=request.getContextPath()%>/member/SignUpConfirm.Api',
					type: 'POST',
					contentType:'application/json',
					dataType: 'json',
					data: form_dataString,
					beforeSend: function(){
						Swal.fire({
							icon: 'warning',
							text: '您輸入的驗證碼為:' + confirmcode
						});
						$('button#checkconfirm').hide();
						$('svg#confirmloading').toggleClass('-none');
					},
					success: function(res){
						$('button#checkconfirm').show();
						$('svg#confirmloading').toggleClass('-none');
						console.log(res);
						if(res.result === true){
							console.log('驗證成功'); 
							$('input#memberSign').click();
						}else{
							Swal.fire({
								icon: 'error',
								title: '驗證碼錯誤',
								text: '請重新輸入驗證碼'
							});
							return;
						}
					}
				});
			});
		});
	
	
	</script>
</body>
</html>