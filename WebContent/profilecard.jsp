<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Team Member</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
	
<style>
    body {
      font-family: Microsoft JhengHei;
    }

    *:hover {
      -webkit-transition: all 1s ease;
      transition: all 1s ease;
    }

    section {
      float: left;
      width: 100%;
      background: #fff;
      /* fallback for old browsers */
      padding: 30px 0;
    }

    h1 {
      float: left;
      width: 100%;
      color: #232323;
      margin-bottom: 30px;
      font-size: 14px;
    }

    h1 span {
      font-family: 'Libre Baskerville', serif;
      display: block;
      font-size: 45px;
      text-transform: none;
      margin-bottom: 20px;
      margin-top: 30px;
      font-weight: 700
    }

    h1 a {
      color: #131313;
      font-weight: bold;
    }

    /*Profile card 2*/
    .profile-card-2 .card-img-block {
      float: left;
      width: 100%;
      height: 150px;
      overflow: hidden;
    }

    .profile-card-2 .card-body {
      position: relative;
    }

    .profile-card-2 .profile {
      border-radius: 50%;
      position: absolute;
      top: -42px;
      left: 15%;
      max-width: 75px;
      border: 3px solid rgba(255, 255, 255, 1);
      -webkit-transform: translate(-50%, 0%);
      transform: translate(-50%, 0%);
    }

    .profile-card-2 h5 {
      font-weight: 600;
      color: #6ab04c;
    }

    .profile-card-2 .card-text {
      font-weight: 300;
      font-size: 15px;
    }

    .profile-card-2 .icon-block {
      float: left;
      width: 100%;
    }

    .profile-card-2 .icon-block a {
      text-decoration: none;
    }

    .profile-card-2 svg {
      display: inline-block;
      font-size: 30px;
      color: #6ab04c;
      text-align: center;
      line-height: 30px;
      margin: 0 5px;
      overflow: hidden;
    }

    .profile-card-2 svg:hover {
      background-color: #6ab04c;
      color: #fff;
    }
  </style>
</head>
<body>
<section>
    <div class="container">
      <div class="row">
        <h1 class="text-center"><span>Tourism Team Member</span></h1>



        <div class="col-md-3">
          <div class="card profile-card-2">
            <div class="card-img-block">
              <img class="img-fluid" src="<%=request.getContextPath()%>/img/profileCard/jumpu3.jpg" alt="Card image cap">
            </div>
            <div class="card-body pt-5">
              <img src="<%=request.getContextPath()%>/img/profileCard/Jumpu.png" alt="profile-image" class="profile" />
              <h5 class="card-title">劉耀升</h5>
              <h5 class="card-text">負責項目:</h5>
              <p class="card-text">- 商城</p>
              <p class="card-text">- 購物車</p>
              <p class="card-text">- 結帳功能</p>
              <div class="icon-block"><a href="https://drive.google.com/drive/folders/13wBWk8bn1B1YTYMvwns334fNkJyfyrdt?usp=sharing"><i class="far fa-file-pdf" style="font-size:1.8em"></i></a><a href="https://www.facebook.com/da1117"><i class="fab fa-facebook fa-2x"></i></a><a href="https://github.com/sunset1117/productDetailPage/tree/master/product"> <i
                    class="fab fa-github fa-2x"></i></a><a href="https://linkedin.com/in/jumpu1117"> <i class="fab fa-linkedin fa-2x"></i></a><a href="http://tda101g1.tk/TDA101G1_final_V3/index.jsp"><i
                    class="fab fa-internet-explorer"></i></a></div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card profile-card-2">
            <div class="card-img-block">
              <img class="img-fluid" src="<%=request.getContextPath()%>/img/profileCard/Queenstown.jpg" alt="Card image cap">
            </div>
            <div class="card-body pt-5">
              <img src="<%=request.getContextPath()%>/img/profileCard/IMG_Hui.jpg" alt="profile-image" class="profile" style="min-height:75px"/>
              <h5 class="card-title">陳人輝</h5>
              <h5 class="card-text">負責項目:</h5>
              <p class="card-text">- 行程頁面</p>
              <p class="card-text">- 行程總覽</p>
              <p class="card-text">- 行程功能</p>
              <div class="icon-block"><a href="https://drive.google.com/drive/u/0/folders/1CU6v2zWw8_TTTgxz6YkpwC1SQbdBLsf9"><i class="far fa-file-pdf" style="font-size:1.8em"></i></a><a href="https://www.facebook.com/jenhui.chen.77/"><i class="fab fa-facebook fa-2x"></i></a><a href="#"> <i
                    class="fab fa-github fa-2x"></i></a><a href="#"> <i class="fab fa-linkedin fa-2x"></i></a><a href="http://tda101g1.tk/TDA101G1_final_V3/index.jsp"><i
                    class="fab fa-internet-explorer"></i></a></div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card profile-card-2">
            <div class="card-img-block">
              <img class="img-fluid" src="<%=request.getContextPath()%>/img/profileCard/IMG_5242.JPG" alt="Card image cap">
            </div>
            <div class="card-body pt-5">
              <img src="<%=request.getContextPath()%>/img/profileCard/IMG_6475.JPG" alt="profile-image" class="profile" />
              <h5 class="card-title">楊博文</h5>
              <h5 class="card-text">負責項目:</h5>
              <p class="card-text">- 首頁</p>
              <p class="card-text">- 前台整合</p>
              <p class="card-text">- 會員功能</p>
              <div class="icon-block"><a href="#"><i class="far fa-file-pdf" style="font-size:1.8em"></i></a><a href="https://www.facebook.com/profile.php?id=100000119706380"><i class="fab fa-facebook fa-2x"></i></a><a href="#"> <i
                    class="fab fa-github fa-2x"></i></a><a href="#"> <i class="fab fa-linkedin fa-2x"></i></a><a href="http://tda101g1.tk/TDA101G1_final_V3/index.jsp"><i
                    class="fab fa-internet-explorer"></i></a></div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card profile-card-2">
            <div class="card-img-block">
              <img class="img-fluid" src="<%=request.getContextPath()%>/img/profileCard/lin3.jpg" alt="Card image cap">
            </div>
            <div class="card-body pt-5">
              <img src="<%=request.getContextPath()%>/img/profileCard/lin2.jpg" alt="profile-image" class="profile" />
              <h5 class="card-title">林鈺凱</h5>
              <h5 class="card-text">負責項目:</h5>
              <p class="card-text">- 後台功能</p>
              <p class="card-text">- sql語法建立資料表格</p>
              <p class="card-text">- 後台首頁</p>
              <div class="icon-block"><a href="#"><i class="far fa-file-pdf" style="font-size:1.8em"></i></a><a href="https://www.facebook.com/profile.php?id=100002913804069"><i class="fab fa-facebook fa-2x"></i></a><a href="https://github.com/Ttaehee520"> <i
                    class="fab fa-github fa-2x"></i></a><a href="https://www.linkedin.com/in/lin-kevin0323"> <i class="fab fa-linkedin fa-2x"></i></a><a href="http://tda101g1.tk/TDA101G1_final_V3/backstage/login.jsp"><i
                    class="fab fa-internet-explorer"></i></a></div>
            </div>
          </div>
        </div>

       






      </div>
    </div>
  </section>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
<script src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
<script src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
<script src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
</body>
</html>