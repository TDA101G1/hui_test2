<%@page import="java.util.Comparator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.product.model.ProductDetailVO"%>
<%@page import="com.product.model.ProductDetailService"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.customerize.model.CustomerizeVO"%>
<%@page import="com.customerize.model.CustomerizeService"%>
<%@page import="com.product.model.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="com.product.model.ProductService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Tourism</title>
  <link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
  <link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/vendors/css/main_index.css">
  <link rel=stylesheet type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/core/main.min.css">
  <link rel=stylesheet type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/daygrid/main.min.css">
  <style>
	/* div {
	  border: 1px solid black;
	} */
	body {
	  margin: 0;
	  font-family: microsoft JhengHei !important;
	  background-color: #F5F5F5 !important;
	  z-index: -100;
	}
	
	div.title {
	  text-align: center;
	  margin-top: 100px;
	  margin-bottom: 10px;
	}
	
	/*網站優點標題*/
	div.benefit {
	  margin: 5px auto;
	  font-weight: bold;
	  font-size: 25px;
	}
	
	a.check-all {
	  margin-top: 30px;
	}
	
	.container-fluid {
	  padding-left: 0;
	  padding-right: 0;
	}
	
	.index-top-image {
	  background-image: url("<%=request.getContextPath()%>/img/david_img/index_image/3075.jpg");
	  height: 470px;
	  background-position: center;
	  background-repeat: no-repeat;
	  background-size: cover;
	}
	
	.middle-img {
	  background-image: url("<%=request.getContextPath()%>/img/david_img/index_image/middle.jpg");
	  height: 400px;
	  background-position: center;
	  background-repeat: no-repeat;
	  background-size: cover;
	  margin-top: 50px;
	}
	
	a.middle-btn{
		margin-left: 25%;
	}
	
	.location_img {
	  height: 100%;
	  background-position: center !important;
	  background-repeat: no-repeat !important;
	  background-size: cover !important;
	  border: 5px solid #F5F5F5;
	  border-radius: 20px;
	}
	div.location_img{
		justify-content: center !important;
	    align-items: center !important;
	    display: flex;
		
	}
	
	div.img_location{
		width: 100%;
    	text-align: center;
    	background-color: #ffffffa3;
    	border-radius: 5px;
   		margin-bottom: -20%;
   		color: #373b40;
	}
	
	.guide-img {
	  height: 100%;
	  background-position: center center !important;
	  background-repeat: no-repeat !important;
	  background-size: cover !important;
	}
	
	nav.navbar {
	  opacity: 0.8;
	}
	
	div.jumbotron {
	  background-color: transparent;
	  color: white;
	}
	
	/*改變箭頭位置*/
	div.arrow-position {
	  position: absolute;
	  left: -8%;
	  bottom: -8%;
	  z-index: 100;
	  color: #d88181
	}
	
	
	div.arrow-position2 {
	  position: absolute;
	  right: -8%;
	  bottom: -8%;
	  z-index: 100;
	  color: #d88181
	}
	
	/*網站標題*/
	
	div.index-title {
	  text-align: center;
	  font-weight: bold;
	  font-size: 32px;
	  margin: 15px auto;
	}
	
	div.sub {
	  font-weight: normal;
	  font-size: 25px;
	}
	
	/*自訂行程簡介*/
	
	p.step {
	  font-size: 25px;
	  position: relative;
	  margin-top: 20%;
	}
	
	div.top-icon {
	  border-radius: 75px;
	  overflow: hidden;
	  text-align: center;
	  font-size: xx-small;
	  width: 80px;
	  height: 80px;
	  vertical-align: middle;
	  color: #6e63ff;
	  background-color: #e2e2ff;
	  border-color: transparent;
	  margin: auto;
	}
	
	div.icon-info {
	  text-align: center;
	}
	
	svg.fa-map-marked-alt {
	  margin-top: 20%;
	}
	
	svg.fa-ticket-alt {
	  margin-top: 20%;
	}
	
	svg.fa-heart {
	  margin-top: 20%;
	}
	
	svg.fa-suitcase-rolling {
	  margin-top: 20%;
	}
	
	/*卡片特性*/
	div.card {
	  border: solid 1px #31C7D2;
	  -webkit-mask-image: -webkit-radial-gradient(circle, white 100%, black 100%);
	}
	
	.card-title a {
	  color: #343434;
	}
  </style>
</head>
<body>
<%
	ProductService pService = new ProductService();
	List<ProductVO>products = pService.getAll().stream()
			.filter(product -> product.getProduct_Class().equals("套裝行程"))
			.sorted(Comparator.comparing(ProductVO::getProduct_Click_Rec).reversed())
			.limit(3)
			.collect(Collectors.toList());
	pageContext.setAttribute("products", products);
//產生 所有productDetail
		ProductDetailService pdService = new ProductDetailService();
		List<ProductDetailVO>productDetails = pdService.getAll();
	 	pageContext.setAttribute("productDetails", productDetails);
	 	
//產生價錢範圍  MAP key = productID   value=價錢範圍     
		Map<String, String> map = new HashMap<String, String>();
		for(int i = 0; i < products.size(); i++){
			for(int j = 0; j < productDetails.size(); j++){
				if(products.get(i).getProduct_ID().equals(productDetails.get(j).getProduct_ID())){
					map.put(products.get(i).getProduct_ID(), pdService.getPriceRange(products.get(i).getProduct_ID()));
				}
			}
		}
		pageContext.setAttribute("pdMaps", map);
	/* 	out.print(map); */
%>
<div class="container-fluid index-top-image">

    <!-- <nav class="navbar navbar-expand navbar-light d-flex justify-content-start" style="background-color: #e3f2fd;">
      <a class="navbar-brand mr-auto" href="#"> <img src="../practice/img/logo.png" width="30" height="30"
          class="d-inline-block align-top" alt="tourism">
        Tourism
      </a>
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-pen"></i>建立行程</a></li>
        <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-store"></i>商城</a></li>
        <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-shopping-cart"></i>購物車</a></li>
        <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-sign-in-alt"></i>會員中心</a></li>
        <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-user"></i>USER</a></li>
      </ul>
    </nav> -->
    <%@ include file="./frontstage_member/pages/header.file" %>
    <!--首頁上方大字-->
    <div class="jumbotron jumbotron-fluid mt-5">
      <div class="container">
        <h1 class="display-4 d-flex justify-content-center">台灣旅遊專門網站</h1>
      </div>
    </div>
  </div>
  <div class="container">
    <div class="row my-1">
      <div class="col-12">
        <div class="index-title">
          去旅遊 找Tourism 
        </div>
        <div class="index-title sub d-none d-sm-block">
          我們致力於開發優質的旅遊網站，提供良好的使用者體驗。
        </div>
      </div>
    </div>
    <div class="row mb-5">
      <div class="col-3 col-lg-3 col-sm-6">
        <div class="top-icon">
          <a href="<%=request.getContextPath()%>/hui_project/index.jsp"><i class="fas fa-map-marked-alt fa-5x"></i></a>
        </div>
        <div class="icon-info">
          <div class="benefit">
            	自訂行程
          </div>
          <div class="d-none d-sm-block">
            簡易又方便的客製化您的專屬行程
          </div>
        </div>
      </div>
      <div class="col-3 col-lg-3 col-sm-6">
        <div class="top-icon">
          <a href="<%=request.getContextPath()%>/mall/mall.jsp"><i class="fas fa-ticket-alt fa-5x"></i></a>
        </div>
        <div class="icon-info">
          <div class="benefit">
            電子票券
          </div>
          <div class="d-none d-sm-block">
            即買即用，方便又快速
          </div>
        </div>
      </div>
      <div class="col-3 col-lg-3 col-sm-6">
        <div class="top-icon">
          <a href="<%=request.getContextPath()%>/frontstage_member/member_Collection/Member_Collection.jsp"><i class="fas fa-heart fa-5x"></i></a>
        </div>
        <div class="icon-info">
          <div class="benefit">
            加入最愛
          </div>
          <div class="d-none d-sm-block">
            將喜歡的商品加到最愛，永不錯過
          </div>
        </div>
      </div>
      <div class="col-3 col-lg-3 col-sm-6">
        <div class="top-icon">
          <a href="<%=request.getContextPath()%>/mall/mall.jsp?action=1"><i class="fas fa-suitcase-rolling fa-5x"></i></a>
        </div>
        <div class="icon-info">
          <div class="benefit">
            套裝行程
          </div>
          <div class="d-none d-sm-block">
            不必動腦，也可以玩得開心
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="container">
    <div class="swiper-container main-slider" id="myCarousel">
      <div class="swiper-wrapper">
        <div class="swiper-slide slider-bg-position"
          style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/swiper3.jpg')" data-hash="slide1">
          <h2>九份風情</h2>
        </div>
        <div class="swiper-slide slider-bg-position"
          style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/swiper4.jpg')" data-hash="slide2">
          <h2>國家音樂廳</h2>
        </div>
      </div>
      <!-- Add Pagination -->
      <div class="swiper-pagination"></div>
      <!-- Add Navigation -->
      <div class="swiper-button-prev"><i class="fa fa-chevron-left"></i></div>
      <div class="swiper-button-next"><i class="fa fa-chevron-right"></i></div>
    </div>

  </div>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12 title">
        <div>
          <h2 class="font-weight-bold">熱門地點</h2>
        </div>
        <div>
          <h4>全台熱門縣市供你選擇</h4>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="location_img col-12 col-lg-8 col-sm-12" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/taipei.jpg'); height: 300px; ">
        <div class="img_location"><h4>台北</h4></div>
      </div>
      <div class="col-12 col-lg-4">
        <div class="row">
          <div class="location_img col col-lg-12 col-sm-6 " style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/kaohsiung.jpg'); height: 150px;">
            <div class="img_location"><h5>高雄</h5></div>
          </div>
          <div class=" location_img col col-lg-12 col-sm-6" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/hsinchu.jpg'); height: 150px;">
            <div class="img_location"><h5>新竹</h5></div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="location_img col col-lg-3 d-none d-sm-flex" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/tainan.jpg'); height: 150px;">
        <div class="img_location"><h5>苗栗</h5></div>
      </div>
      <div class="location_img col col-lg-3 d-none d-sm-flex" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/taoyuan.jpg'); height: 150px;">
        <div class="img_location"><h5>桃園</h5></div>
      </div>
      <div class="location_img col col-lg-3 d-none d-sm-flex" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/taichung.jpg'); height: 150px;">
        <div class="img_location"><h5>台中</h5></div>
      </div>
      <div class="location_img col col-lg-3 d-none d-sm-flex" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/taroko.jpg'); height: 150px;">
        <div class="img_location"><h5>花蓮</h5></div>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col col-lg-4 col-sm-6 d-flex justify-content-center">
        <a href="<%=request.getContextPath()%>/mall/mall.jsp" class="btn btn-primary btn-lg btn-block check-all"><i class="fas fa-map-marker-alt mr-2"></i>看全部商品</a>
      </div>
    </div>

    <!--推薦行程-->
     <div class="row justify-content-center">
      <div class="col-12 title">
        <div>
          <h2 class="font-weight-bold">
            推薦行程
          </h2>
        </div>
        <div>
          <h4>選擇我們為您精心挑選的行程</h4>
        </div>
      </div>
      <c:forEach var="product" items="${products }">
      <div class="col-lg-4 col-md-6 col-sm-8 mb-5">
        <div class="card h-100" data-product_id="${product.product_ID }" data-product_class="${product.product_Class }">
          <a href=""><img class="card-img-top" src="<%=request.getContextPath()%>/util/ShowProductImage?id=${product.product_ID}" height="200px"></a>
          <div class=" card-body">
            <h4 class="card-title">
              <a href="#">${product.product_Name }</a>
            </h4>
            <fmt:parseNumber var="days" type="number" integerOnly="true" value="${product.product_Staytime }">
            </fmt:parseNumber>
            <p class="card-text"><i class="far fa-calendar-alt"></i>安排天數: ${days }</p>
            <p class="card-text"><i class="fas fa-dollar-sign"></i>金額:
              <c:forEach var="pdMap" items="${pdMaps }">

                <c:if test="${product.product_ID == pdMap.key }">
                  ${pdMap.value }
                </c:if>
              </c:forEach>
            </p>
            <p class="card-text"><i class="fab fa-gripfire"></i>瀏覽次數: ${product.product_Click_Rec}</p>
            <p class="card-text"><i class="fas fa-map-marker-alt"></i>安排景點: ${product.product_Address }</p>
          </div>

        </div>
      </div>
      </c:forEach>
      


 	</div>
  </div>

  <div class="d-none d-sm-block middle-img container-fluid">
    <div class="jumbotron jumbotron-fluid">
      <div class="container">
        <h1 class="display-4 d-flex justify-content-center">Ready for next travel?</h1>
        <a class="middle-btn btn btn-light" href="<%=request.getContextPath()%>/hui_project/index.jsp" role="button">點我體驗</a>
      </div>
    </div>
  </div>  

  <!--客製化行程步驟-->
  <div class="container">
    <div class="row justify-content-center">
      <div class="col col-lg-12 title">
        <div>
          <h2 class="font-weight-bold">
            客製化行程
          </h2>
        </div>
        <div>
          <h5>如果不喜歡我們替您準備的行程，您也可以自行規劃</h5>
        </div>
        <div>
          <h5>只需要簡單四步驟，你也可以</h5>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="guide-img col-6 col-sm-6 d-none d-sm-block" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/step1.jpg'); height: 300px;">
        1-1
      </div>
      <div class="col-12 col-sm-6 text-center">
        <div>
          <p class="step">步驟一 選擇地點</p>
          <p class="detail">點選您要旅行的地點 如 高雄</p>

        </div>
        <div class="arrow-position d-none d-sm-block"><i class="fas fa-arrow-down fa-5x"
            data-fa-transform="rotate--45"></i></div>
        <div class="d-block d-sm-none" style="color: #d88181"><i class="fas fa-arrow-down fa-5x"></i></div>
      </div>
      <div class="col-12 col-sm-6 text-center">
        <p class="step">步驟二 選擇景點</p>
        <p class="detail">選擇即將旅行地點的相關景點</p>
        <div class="arrow-position2 d-none d-sm-block"><i class="fas fa-arrow-down fa-5x"
            data-fa-transform="rotate-45"></i></div>
        <div class="d-block d-sm-none" style="color: #d88181"><i class="fas fa-arrow-down fa-5x"></i></div>
      </div>
      <div class="guide-img col-6 col-sm-6 d-none d-sm-block" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/step2.jpg'); height: 300px;">
        2-2
      </div>
      <div class="guide-img col-6 col-sm-6 d-none d-sm-block" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/step3.jpg'); height: 300px;">
        3-1
      </div>
      <div class="col-12 col-sm-6 text-center">
        <p class="step">步驟三 確認路線</p>
        <p class="detail">點選地圖，確認景點與景點間的路線與距離</p>

        <div class="arrow-position d-none d-sm-block"><i class="fas fa-arrow-down fa-5x"
            data-fa-transform="rotate--45"></i></div>
        <div class="d-block d-sm-none" style="color: #d88181"><i class="fas fa-arrow-down fa-5x"></i></div>
     </div>
      <div class="col-12 col-sm-6 text-center">
        <p class="step">步驟四 確認金額 and 儲存金額</p>
        <p class="detail">最後點擊送出即可簡單又方便地購買相關票券囉</p>
        <div class="row justify-content-center">
          <div class="col col-lg-4 col-sm-6 d-flex justify-content-center">
            <a href="<%=request.getContextPath()%>/hui_project/index.jsp" class="btn btn-primary btn-lg btn-block check-all">去試試</a>
          </div>
        </div>
      </div>
      <div class="guide-img col-6 col-sm-6 d-none d-sm-block" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/step4.jpg'); height: 300px;">
        4-2
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col-12 title">
        <div>
          <h2 class="font-weight-bold">
            熱門美食分類
          </h2>
        </div>
        <div>
          <h4>你今天想吃什麼這邊都有</h4>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="location_img col col-lg-4 col-sm-12" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/food1.jpg'); height: 250px;">
        <div class="img_location"><h4>台北美食</h4></div>
      </div>
      <div class="location_img col col-lg-4 col-sm-12" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/food2.jpg'); height: 250px;">
        <div class="img_location"><h4>台中美食</h4></div>
      </div>
      <div class="d-sm-none d-md-flex location_img col col-lg-4" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/food6.jpg'); height: 250px;">
        <div class="img_location"><h4>台南美食</h4></div>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col col-lg-4 col-sm-6 d-flex justify-content-center">
        <a href="<%=request.getContextPath()%>/mall/mall.jsp?action=3" class="btn btn-primary btn-lg btn-block check-all"><i class="fas fa-map-marker-alt mr-2"></i>看全部美食</a>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col-12 title">
        <div>
          <h2 class="font-weight-bold">
            熱門地區住宿
          </h2>
        </div>
        <div>
          <h4>想住哪邊 這邊看看</h4>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="location_img col col-lg-3 col-md-6 col-sm-12" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/hotel1.jpg'); height: 200px;">
        <div class="img_location"><h5>台北住宿</h5></div>
      </div>
      <div class="location_img col col-lg-3 col-md-6 col-sm-12" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/hotel2.jpg'); height: 200px;">
        <div class="img_location"><h5>南投住宿</h5></div>
      </div>
      <div class="d-sm-none d-md-flex location_img col col-lg-3 col-md-6" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/hotel3.jpg'); height: 200px;">
        <div class="img_location"><h5>台東住宿</h5></div>
      </div>
      <div class="d-sm-none d-md-flex location_img col col-lg-3 col-md-6" style="background:url('<%=request.getContextPath()%>/img/david_img/index_image/hotel4.jpg'); height: 200px;">
        <div class="img_location"><h5>台中住宿</h5></div>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col col-lg-4 col-sm-6 d-flex justify-content-center">
        <a href="<%=request.getContextPath()%>/mall/mall.jsp?action=4" class="btn btn-primary btn-lg btn-block check-all"><i class="fas fa-map-marker-alt mr-2"></i>看全部住宿</a>
      </div>
    </div>
  </div>
  <%@include file="./frontstage_member/pages/footer.file" %>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
  <script src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
  <script src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
  <script src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
  <script src="https://unpkg.com/@popperjs/core@2"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
  <script src="<%=request.getContextPath()%>/vendors/js/main_index.js"></script>


  <script>
	$(document).on('click', ".card", function(){
		let product_ID= $(this).data('product_id');
		let product_Class = $(this).data('product_class');
	    window.location.href='<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID='+product_ID+"&product_Class="+product_Class;

	})





  </script>

</body>

</html>