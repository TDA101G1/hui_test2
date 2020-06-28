<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <!-- Google Map -->
  <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
  <link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/css/footer.css">
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAbXslbdHryJFaivbDzQzHhvwo4bxM9hpc&callback=initMap&libraries=&v=weekly" defer></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
        integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <!-- 載入 Font Awesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
    <style>
        * {
            font-family: 微軟正黑體;
        }
        .navbar-light .navbar-nav .nav-link {
	    color: rgba(0,0,0,.5) !important;
	    font-weight: normal;
		}
        button,
        img,
        .btn_overlay_schedule_close,
        .btn_overlay_style_close,
        span.trash,
        span.position {
            cursor: pointer;
        }
        nav.navbar {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 10;
            opacity: 0.8;
        }
        footer {
            background-color: black;
            height: 164px;
            font-size: 24px;
            font-weight: bold;
        }
        .jumbotron {
            background-image: url("<%=request.getContextPath()%>/img/david_img/3075.jpg");
            background-position: center;
      		background-repeat: no-repeat;
     		background-size: cover;
            color: white;
            margin-bottom: 0;
            height: 350px;
        }
        div.container-fluid {
            margin-top: 20px;
        }
        /*----------------左側欄位----------------*/
        main.main {
            border: 1px solid white;
            width: 550px;
            height: 700px;
            max-width: 100%;
            border-radius: 4px;
            box-shadow: 0px 6px 6px gray;
            margin: 20px auto;
            position: relative;
            /* overflow:hidden; */
            background-color: white;
        }
        aside.aside1 {
            font-size: 20px;
            font-weight: bold;
            color: #343434;
            /* vertical-align: center; */
            text-align: center;
            /* margin-left: 60px; */
        }
        aside.aside1 input {
            font-size: 20px;
            width: 300px;
            height: 50px;
            max-width: 100%;
            border-radius: 4px;
            margin-top: 10px;
            padding: 6px 12px;
            border: 1px solid black;
        }
        span.select_text {
            border: 1px solid #E6903B;
            background-color: #E6903B;
            border-radius: 4px;
            height: 68px;
            display: block;
            position: sticky;
            top: 0;
            z-index: 2;
        }
        p.text {
            /* position: relative;
            bottom: 20px; */
            font-size: 32px;
            font-weight: bold;
            color: #343434;
            text-align: center;
            line-height: 68px;
        }
        div.select_content {
            overflow-y: scroll;
            height: 100%;
            max-height: 560px;
        }
        ul.selected_location {
            padding-left: 0px;
            list-style: none;
            text-align: center;
        }
        ul.selected_location div.col-10,
        div.col-2 {
            padding: 0px;
        }
        @media screen and (max-width: 1200px) {
            ul.selected_location span.trash {
                font-size: 10px;
            }
        }
        @media screen and (max-width: 767px) and (min-width: 578px) {
            ul.selected_location span.trash {
                font-size: 20px;
            }
        }
        ul.selected_location img {
            width: 370px;
            /* height: 205px; */
            max-width: 100%;
            margin-top: 20px;
        }
        div.btn_submit input {
            height: 68px;
            width: 100%;
            max-width: 100%;
            max-height: 100%;
            background-color: #556FFF;
            color: white;
            font-size: 32px;
            border-radius: 4px;
            margin-top: 20px;
            padding: 0;
            position: absolute;
            bottom: 0;
            z-index: 2;
        }
        /*----------------右側欄位----------------*/
        aside.aside2 {
            margin-right: 10px;
        }
        aside.aside2 img {
            max-width: 100%;
            max-height: 100%;
            margin-bottom: 30px;
            box-shadow: 0px 6px 6px gray;
        }
        aside.aside2 img:hover {
            transform: scale(1.1);
        }
        .-on {
            display: none;
        }
        div.overlay_schedule,
        div.overlay_style {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-color: hsla(0, 0%, 0%, .5);
            /* 預設：完全透明；設定 z-index: -1 會在整個頁面的後方，看不到，才不會擋到頁面元素。 */
            opacity: 0;
            z-index: -1;
            transition: opacity 1s;
        }
        div.overlay_schedule.-on1,
        div.overlay_style.-on1 {
            /* 加上 -on1 之後，Modal 漸漸出現，因為有設定 transition */
            opacity: 1;
            z-index: 20;
        }
        div.overlay_schedule.-opacity-zero,
        div.overlay_style-opacity-zero {
            /*關閉 Modal 時，先讓 opacity設定0，就會慢慢變成完全透明，但這時會擋到後面的元素，所以要再移除 -on 及 -opacity-zero 這兩個 class */
            opacity: 0;
        }
        /* 元素 article 置中及基本樣式 */
        div.overlay_schedule>article,
        div.overlay_style>article {
            background-color: white;
            width: 1320px;
            /* width: 900px; */
            height: 450px;
            /* max-width: 800px; */
            border-radius: 4px;
            box-shadow: 0 6px 6px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        div.overlay_content {
            height: 100%;
        }
        div.overlay_header {
            border-radius: 4px 4px 0px 0px;
            background-color: #E5B280;
            height: 92px;
            /* height: 70px; */
            font-size: 32px;
            font-weight: bold;
            border-bottom: 2px solid #343434;
            position: relative;
        }
        div.overlay_header p {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        div.overlay_header span {
            position: absolute;
            top: 50%;
            right: 3%;
            transform: translate(-50%, -50%);
        }
        div.overlay_body {
            position: relative;
            max-width: 100%;
            height: calc(100% - 92px);
            display: block;
        }
        div.body_content {
            width: 100%;
            height: 205px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }
        div.body_content button {
            position: relative;
            width: 320px;
            height: 205px;
            font-size: 32px;
            color: #343434;
            display: inline-block;
            background-color: #E0DFDF;
            border: 1px solid #E0DFDF;
            border-radius: 4px;
            margin: 0 30px;
            box-shadow: 0px 6px 6px gray;
        }
        div.body_content p {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        button.confirm {
            display: none;
        }
        .form-control {
            display: inline-block;
        }
        /*-----------------定位圖像-----------------*/
        div.geolocation {
            position: relative;
            display: inline-block;
        }
        span.position {
            position: absolute;
            top: 59%;
            right: 0%;
            transform: translate(-50%, -50%);
        }
        /*-----------------日期欄位-----------------*/
        .form-control[readonly]{
            background-color: white;
            border: 1px solid black;
        }
    </style>
    <!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"> -->
    <link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_orange.css">
</head>

<body>

    <%-- <nav class="navbar navbar-expand navbar-light d-flex justify-content-start" style="background-color: #e3f2fd;">
        <a class="navbar-brand mr-auto" href="#">
          <img src="<%=request.getContextPath()%>/img/hui/logo.png" width="30" height="30" class="d-inline-block align-top" alt="tourism">
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
	<%@include file="../frontstage_member/pages/header.file" %>
    <div class="jumbotron jumbotron-fluid">
        <div class="container">
            <h1 class="display-4" align="center">台灣第一旅遊網站</h1>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row">
            <div class="col-12 col-md-4">
                <form id="confirm" action="<%=request.getContextPath()%>/CustomerizeController" method="POST">
                    <div class="row">
                        <div class="col-12 col-sm-12">
                            <aside class="aside1">
                                <c:choose>
								 <c:when test="${errors.date == null}">
								 	<span>&emsp;&emsp;日期：</span><input class="user_date" type="text" name="date" value="${errorReturnBean.cust_Schedule_Name}"><br>
								 </c:when>
                                 <c:otherwise>
                                 	<span>&emsp;&emsp;日期：</span><input class="user_date" type="text" name="date" placeholder="${errors.date}"><br>
                                 </c:otherwise>
                                </c:choose>
                                
                                <c:choose>
								 <c:when test="${errors.quantity == null}">
								 	<span>&emsp;&emsp;人數：</span><input type="text" name="cust_quantity" value="${errorReturnBean.cust_Quantity}"><br>
								 </c:when>
                                 <c:otherwise>
                                 	<span>&emsp;&emsp;人數：</span><input type="text" name="cust_quantity" placeholder="${errors.quantity}"><br>
                                 </c:otherwise>
                                </c:choose>
                                
                                <c:choose>
								 <c:when test="${errors.position == null}">
								 	<span>起始地點：</span><input id="geolocation" type="text" name="cust_address" value="${errorReturnBean.cust_Position}"><br>
								 </c:when>
                                 <c:otherwise>
                                 	<span>起始地點：</span><input id="geolocation" type="text" name="cust_address" placeholder="${errors.position}"><br>
                                 </c:otherwise>
                                </c:choose>
                                <input id="geolocation_number" type="hidden" name="cust_position">
                            </aside>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 col-sm-12">
                            <main class="main">
                                <span class="select_text">
                                    <p class="text">選取地點</p>
                                </span>
                                <div class="select_content">
                                    <ul class="selected_location">
                                        <!-- 動態新增資料 -->
                                        <c:choose>
											 <c:when test="${errors.county == null}">
											 	<input id="return_bean" type="hidden" value="${errorReturnBean.cust_Selected_County}"><br>
											 </c:when>
			                                 <c:otherwise>
                                                 <p style="line-height: 560px; font-size: 24px;">${errors.county}</p>
                                                 <input id="return_bean" type="hidden" value="${errorReturnBean.cust_Selected_County}"><br>
			                                 </c:otherwise>
		                                </c:choose>
                                    </ul>
                                </div>
                                <div class="btn_submit">
                                    <input type="button" class="btn_cloose_style" value="送出">
                                    <input type="hidden" name="action" value="create_schedule">
                                    <input type="hidden" class="user_dates" name="cust_date">
                                </div>
                            </main>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-12 col-md-8">
                <aside class="aside2">
                    <div class="row">
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block0">
                                <img class="基隆市" name="基隆市"
                                    src="<%=request.getContextPath()%>/img/hui/基隆市.png" data-sort="0">
                            </div>
                        </div>
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block1">
                                <img class="臺北市" name="臺北市"
                                    src="<%=request.getContextPath()%>/img/hui/臺北市.png" data-sort="1">
                            </div>
                        </div>
                        <div class="col-12 col-md-12 col-lg-4">
                            <div class="img_block2">
                                <img class="桃園市" name="桃園市"
                                    src="<%=request.getContextPath()%>/img/hui/桃園市.png" data-sort="2">
                            </div>
                        </div>
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block3">
                                <img class="新竹市" name="新竹市"
                                    src="<%=request.getContextPath()%>/img/hui/新竹市.png" data-sort="3">
                            </div>
                        </div>
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block4">
                                <img class="苗栗市" name="苗栗市"
                                    src="<%=request.getContextPath()%>/img/hui/苗栗市.png" data-sort="4">
                            </div>
                        </div>
                        <div class="col-12 col-md-12 col-lg-4">
                            <div class="img_block5">
                                <img class="臺中市" name="臺中市"
                                    src="<%=request.getContextPath()%>/img/hui/臺中市.png" data-sort="5">
                            </div>
                        </div>
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block6">
                                <img class="南投市" name="南投市"
                                    src="<%=request.getContextPath()%>/img/hui/南投市.png" data-sort="6">
                            </div>
                        </div>
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block7">
                                <img class="雲林市" name="雲林市"
                                    src="<%=request.getContextPath()%>/img/hui/雲林市.png" data-sort="7">
                            </div>
                        </div>
                        <div class="col-12 col-md-12 col-lg-4">
                            <div class="img_block8">
                                <img class="嘉義市" name="嘉義市"
                                    src="<%=request.getContextPath()%>/img/hui/嘉義市.png" data-sort="8">
                            </div>
                        </div>
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block9">
                                <img class="臺南市" name="臺南市"
                                    src="<%=request.getContextPath()%>/img/hui/臺南市.png" data-sort="9">
                            </div>
                        </div>
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block10">
                                <img class="高雄市" name="高雄市"
                                    src="<%=request.getContextPath()%>/img/hui/高雄市.png" data-sort="10">
                            </div>
                        </div>
                        <div class="col-12 col-md-12 col-lg-4">
                            <div class="img_block11">
                                <img class="屏東市" name="屏東市"
                                    src="<%=request.getContextPath()%>/img/hui/屏東市.png" data-sort="11">
                            </div>
                        </div>
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block12">
                                <img class="宜蘭市" name="宜蘭市"
                                    src="<%=request.getContextPath()%>/img/hui/宜蘭市.png" data-sort="12">
                            </div>
                        </div>
                        <div class="col-6 col-md-6 col-lg-4">
                            <div class="img_block13">
                                <img class="花蓮市" name="花蓮市"
                                    src="<%=request.getContextPath()%>/img/hui/花蓮市.png" data-sort="13">
                            </div>
                        </div>
                        <div class="col-12 col-md-12 col-lg-4">
                            <div class="img_block14">
                                <img class="台東市" name="台東市"
                                    src="<%=request.getContextPath()%>/img/hui/台東市.png" data-sort="14">
                            </div>
                        </div>
                    </div>
            </div>
            </aside>
        </div>
    </div>

    <!-- 選擇行程的Modal -->
    <div class="overlay_schedule">
        <article>
            <div class="overlay_content">
                <div class="overlay_header">
                    <p>選擇行程</p>
                    <span class="btn_overlay_schedule_close"><i class="fas fa-times"></i></span>
                </div>
                <div class="overlay_body">
                    <div class="body_content">
                        <button class="body_content1" value="Auto_schedule">
                            <p>自動行程</p>
                        </button>
                        <button class="body_content2" value="DIY_schedule">
                            <p>手動行程</p>
                        </button>
                        <!-- <button class="body_content3" value="Other_schedule">
                            <p>參考行程</p>
                        </button> -->
                    </div>
                </div>
            </div>
        </article>
    </div>

    <!-- 選擇風格的Modal -->
    <div class="overlay_style">
        <article>
            <div class="overlay_content">
                <div class="overlay_header">
                    <p>行程安排</p>
                    <span class="btn_overlay_style_close"><i class="fas fa-times"></i></span>
                </div>
                <div class="overlay_body">
                    <div class="body_content">
                        <button class="body_content1" value="lazy">
                            <p>寬鬆行程</p>
                        </button>
                        <button class="body_content2" value="general">
                            <p>適中行程</p>
                        </button>
                        <button class="body_content3" value="compact">
                            <p>緊湊行程</p>
                        </button>
                    </div>
                </div>
            </div>
        </article>
    </div>

 <!--    <footer class="footer mt-auto py-3">
        <div class="container">
            <span class="text-muted">WEB DEVELOPER</span>
        </div>
    </footer> -->
	<%@ include file="../frontstage_member/pages/footer.file" %>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous">
    </script>
    <script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        function initMap(){}
        $(function () {
            /*==================================================若輸入資料有錯誤，原本選取的地點回復==================================================*/
            let return_county = $("input#return_bean").val()
            if(return_county != "" && return_county.length != 0){
                return_county = return_county.substring(1, return_county.length -1).split(",");
                $.each(return_county, function(i, value){
                    let name = value.trim();
                    $("aside.aside2 img."+name).closest("div.col-lg-4").toggleClass("-on");
                    let insertHtml = `<li style="padding-left: 15px; padding-right: 15px;">
                                        <div class="row">
                                            <div class="col-10">
                                                <img class="` + name + `"name="` + name +
                                                    `" src="<%=request.getContextPath()%>/img/hui/` + name + `.png">
                                                <input type="hidden" name="product_county" value="` + name + `">
                                            </div>
                                            <div class="col-2 align-self-center">
                                                <span class="trash"><i class="fas fa-trash-alt fa-3x"></i></span>
                                            </div>
                                        </div>
                                    </li>`;
                $("ul.selected_location").append(insertHtml);
                });
            }
            /*==================================================日期樣式載入==================================================*/
            var selectedDate = $("input.user_date").flatpickr({
                altInput: true,
                altFormat: "Y-m-d",
                dateFormat: "Y/m/d",
                minDate: "today",
                mode: "range",
            });
            /*==================================================送出鈕的動作==================================================*/
            $("input.btn_cloose_style").click(function () {
                $("div.overlay_schedule").addClass("-on1");
                listDateResult(selectedDate.selectedDates);
                let geocoder = new google.maps.Geocoder();
                let address = $("input#geolocation").val();
                geocoder.geocode({
                    'address': address
                }, function (results, status) {
                    if (status == 'OK') {
                        let lat = results[0].geometry.location.lat();
                        let lng = results[0].geometry.location.lng();
                        $("input#geolocation_number").val(lat+","+lng);
                    } else {
                        console.log('Geocode was not successful for the following reason: ' + status);
                    }
                }); 
            });
            /*==================================================點選右邊縣市時的動作==================================================*/
            $("aside.aside2 img").on("click", function () {
                $(this).closest("div.col-lg-4").toggleClass("-on");
                $("ul.selected_location p").text("");
                let name = $(this).attr("class");
                let sort = $(this).attr("data-sort");
                let insertHtml = `<li style="padding-left: 15px; padding-right: 15px;">
                                        <div class="row">
                                            <div class="col-10">
                                                <img class="` + name + `"name="` + name +
                                                    `" src="<%=request.getContextPath()%>/img/hui/` + name + `.png">
                                                <input type="hidden" name="product_county" value="` + name + `">
                                            </div>
                                            <div class="col-2 align-self-center">
                                                <span class="trash"><i class="fas fa-trash-alt fa-3x"></i></span>
                                            </div>
                                        </div>
                                    </li>`;
                $("ul.selected_location").append(insertHtml);
            });
            //迴圈方式(較差)
            // let data = $(this).closest("li").find("img").attr("name");
            // let sort = $(this).closest("li").find("img").attr("data-sort");
            // let insertHtml = `<img class="`+ data +`" name="`+ data +`" src="/img/`+ data +`.png" data-sort="`+sort +`">`;
            // $(this).closest("li").remove();
            // $("aside.aside2").find("img").each(function(index, items){
            //     let test = $(items).attr("data-sort");
            //     if(sort < test){                                                    //列表內圖片的sort值大於刪除地點的sort值，將重新定位
            //         //let clone = $(this).clone();
            //         // $(this).remove();
            //         $("aside.aside2 div.img_block"+test).append(items);                
            //     }
            // });
            // $("aside.aside2 div.img_block"+sort).append(insertHtml);             //將刪除的地點還原到列表去
            // $("aside.aside2").find("img").each(function(index, items){              //重新排列不空格
            //     $("aside.aside2 div.img_block"+index).prepend(items);
            // });
            /*==================================================刪除左側已選縣市的動作==================================================*/
            $("ul.selected_location").on("click", "span.trash", function () {
                let data = $(this).closest("li").find("img").attr("name");
                $("aside.aside2").find("img").each(function (index, items) {
                    if ($(items).attr("name") === data) {
                        $(this).closest("div.col-lg-4").toggleClass("-on");
                    }
                });
                $(this).closest("li").remove();
            });
            //迴圈方式(較差)
            // $(this).remove();
            // $("aside.aside2").find("img").each(function(index, items){                 
            //     $("aside.aside2 div.img_block"+index).prepend(items);
            // });
            /*==================================================行程彈跳視窗各個按鈕的動作(手動會submit)=================================================*/
            $("div.overlay_schedule button").on("click", function () {              //自動行程、手動行程、參考行程
                let schedule = $(this).attr("value");
                let insertHtml = `<input type="hidden" name="selected_schedule" value="` + schedule + `">`;
                $("form div.btn_submit").append(insertHtml);
                if(schedule === "DIY_schedule"){
                    $("form#confirm").submit();                                     //如果按的是手動行程，轉跳至編輯行程頁面
                }else{
                    setTimeout(function () {
                        $("div.overlay_schedule").removeClass("-on1");
                    }, 1000);
                    $("div.overlay_style").addClass("-on1");
                }   
            });
            /*----------關閉行程的彈跳視窗----------*/
            // 關閉 Modal
            $("span.btn_overlay_schedule_close").on("click", function () {
                $("div.overlay_schedule").addClass("-opacity-zero");
                // 設定隔一秒後，移除相關 class
                setTimeout(function () {
                    $("div.overlay_schedule").removeClass("-on1 -opacity-zero");
                }, 1000);
            });
            /*==================================================安排行程彈跳視窗各個按鈕的動作(這也會submit)==================================================*/
            $("div.overlay_style button").on("click", function () {
                let style = $(this).attr("value");
                let insertHtml = `<input type="hidden" name="selected_style" value="` + style + `">`;
                $("form div.btn_submit").append(insertHtml);
                $("div.overlay_style").addClass("-opacity-zero");
                setTimeout(function () {
                    $("div.overlay_style").removeClass("-on1 -opacity-zero");
                }, 1000);
                $("form#confirm").submit();    
            });
                /*----------關閉風格的彈跳視窗----------*/
                $("span.btn_overlay_style_close").on("click", function () {
                $("div.overlay_style").addClass("-opacity-zero");
                // 設定隔一秒後，移除相關 class
                setTimeout(function () {
                    $("div.overlay_style").removeClass("-on1 -opacity-zero");
                }, 1000);
                });
            });
            /*==================================================使用者選取的日期轉換格式的function==================================================*/
            function listDateResult(startDateObj) {
                var allDate = [];
                let startTime = "";
                let endTime = "";
                $.each(startDateObj, function (index, items) { //宣告變數承接所有日期
                    let time = new Date(items); //宣告一個日期變數
                    if (index == 0) {
                        startTime = items;
                        let flatDate = flatpickr.formatDate(startTime, 'Y-m-d'); //格式化日期
                        allDate.push(flatDate)
                    } else {
                        endTime = items;
                        let flatDate = flatpickr.formatDate(endTime, 'Y-m-d');
                        allDate.push(flatDate)
                    }
                });
                if (startTime.length != 0 && endTime != "") {
                    result = ((endTime - startTime) / (60 * 60 * 24 * 1000)) + 1; //沒有轉換為毫秒，也可相減
                    allDate.push(result.toString());
                    let dateJSON = {
                        "listDate": allDate,
                    };
                    $("input.user_dates").attr("value", JSON.stringify(dateJSON)); //將資料轉成JSON格式，放入隱藏的input
                }
            /*==================================================定位icon的動作(目前沒使用)==================================================*/
            let return_county = $("input#return_bean").val()
            $("div.geolocation").find("span.position").on("click", function () {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function (position) {
                        let geolocation = position.coords.latitude + "," + position.coords.longitude;
                            $("input#geolocation").val(geolocation);
                    }, function (error) {
                        // 使用者不同意取得位置資訊時
                        alert("使用者不同意取得位置資訊\u000d請自行輸入地址");
                    });
                }
            });
        };
    </script>
</body>

</html>