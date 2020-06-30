<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.member.model.MemberService"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="productList" scope="page" class="com.product.model.ProductService"></jsp:useBean>



<%
	/* session.setAttribute("member", new MemberService().getOne("MID000000")); */
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
  <title>Shop Homepage - Start Bootstrap Template</title>
  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="css/shop-homepage.css" rel="stylesheet">
  <script src="./vendor/jquery/jquery-3.4.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
  <link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/vendors/css/footer.css">
  <style>
  	body{
  		padding-top: 0;
  	}
  	
  	.navbar-light .navbar-nav .nav-link {
    color: rgba(0,0,0,.5) !important;
	}
  </style>
</head>

<body>





  <!-- Navigation -->
  <%@ include file="../frontstage_member/pages/header.file" %>
<!--   <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="#">Tourism</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Services</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Contact</a>
          </li>
        </ul>
      </div>
    </div>
  </nav> -->

  <!-- container -->
  <div class="container">

    <div class="row">
      <div class="col-lg-3">

        <div class="list-group">
          <h1 class="my-4">商城</h1>
          <p><i class="fas fa-map"></i>目前位置</p>
          <button type="button" class="list-group-item action1" data-product_Class="套裝行程">套裝行程</button>
          <button type="button" class="list-group-item action2" data-product_Class="景點">旅遊景點</button>
          <button type="button" class="list-group-item action3" data-product_Class="餐廳">美食餐廳</button>
          <button type="button" class="list-group-item action4" data-product_Class="住宿">旅館住宿</button>


          <div class="filter_area">
            <p><i class="fas fa-filter"></i>偏好篩選</p>
            <label class="label_area">
              <input type="checkbox" name="" value="" class="checkbox_area Taipei">
              <a data-county="台北市_臺北市">台北</a>
            </label>
            <label class="label_area">
              <input type="checkbox" name="" value="" class="checkbox_area new_Taipei">
              <a data-county="新北市_台北縣">新北</a>
            </label>
            <label class="label_area">
              <input type="checkbox" name="" value="" class="checkbox_area Taoyuan">
              <a data-county="桃園市_桃園縣">桃園</a>
            </label>
            <label class="label_area">
              <input type="checkbox" name="" value="" class="checkbox_area Taichung">
              <a data-county="台中市_臺中市_台中縣_臺中縣">台中</a>
            </label>
            <label class="label_area">
              <input type="checkbox" name="" value="" class="checkbox_area Nantou">
              <a data-county="南投市_南投縣">南投</a>
            </label>
            <label class="label_area">
              <input type="checkbox" name="" value="" class="checkbox_area Chiayi">
              <a data-county="嘉義市_嘉義縣">嘉義</a>
            </label>
            <label class="label_area">
              <input type="checkbox" name="" value="" class="checkbox_area Tainan">
              <a data-county="台南市_臺南市_台南縣_臺南縣">台南</a>
            </label>
            <label class="label_area">
              <input type="checkbox" name="" value="" class="checkbox_area Kaohsiung">
              <a data-county="高雄市_高雄縣">高雄</a>
            </label>
          </div>
        </div>

      </div>

      <!-- /.col-lg-3 -->


      <div class="col-lg-9">

        <!-- <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" role="listbox">
            <div class="carousel-item active">
              <img class="d-block img-fluid" src="http://placehold.it/900x350" alt="First slide">
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" src="http://placehold.it/900x350" alt="Second slide">
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" src="http://placehold.it/900x350" alt="Third slide">
            </div>
          </div>
          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div> -->


<!--         <form class="" action="" method="post"> -->
<!--           <a href="#"></a> -->
        <!-- 資料來源 -->
        <!-- https://webdesign.tutsplus.com/zh-hant/tutorials/css-experiments-with-a-search-form-input-and-button--cms-22069 -->
        <!-- <div class="box"> -->
          <div class="search_area">
            <input type="text" id="search" placeholder="搜尋..." />
            <span class="icon"><i class="fa fa-search"></i></span>
          </div>
        <!-- </div> -->
<!--         </form> -->


        <!-- <div class="row">
          <div class="col-lg-4 col-md-4 col-4 mb-4">
            <div class="card_img">
              <a href="#"><img class="card-img-top" src="http://placehold.it/700x700" alt=""></a>
            </div>
          </div>
          <div class="col-lg-4 col-md-4 col-8 mb-4">
            <div class="card_body">
              <h4 class="card-title">
                <a href="#">Item One</a>
              </h4>
              <h5>$24.99<small class="text-muted"> &#9733; &#9733; &#9733; &#9733; &#9734;</small></h5>
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur!</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-3 col-4 mb-4">
            <div class="card_foot"> -->
              <!-- <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small> -->
            <!-- </div>
          </div>
        </div> -->
<!-- =======================================商品卡片======================================= -->
        <div class="row productArea">
<c:forEach items="${productList.all}" var="product">
	<c:choose>
		<c:when test="${product.product_Class=='套裝行程' && product.product_State==1 && param.action == null && param.county == null}">
          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100" data-product_ID="${product.product_ID}" data-product_Class="${product.product_Class}">
              <div class="img_Container">
                <div class="backgroundImg_Area" style="background-image:url('<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG1&tName=PRODUCT');">
                </div>
                <img class="card-img-top main_Img" src="<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG1&tName=PRODUCT">
              </div>
              <div class="card-body">
                <h4 class="card-title">
                  <a href="#">${product.product_Name}</a>
                </h4>
<fmt:parseNumber var="i" integerOnly="true" type="number" value="${product.product_Staytime}" />
                <p class="days"><i class="far fa-calendar-alt"></i>安排天數: ${i}</p>
                <p class="price"><i class="fas fa-dollar-sign"></i>金額: <span></span></p>
                <p class=""><i class="fab fa-gripfire"></i>瀏覽次數: ${product.product_Click_Rec}</p>
                <p>13213213${product.product_State == 1 ? 上架中 : 下架中}</p>
                <p class=""><i class="fas fa-map-marker-alt"></i>安排景點: ${product.product_Address}</p>
              </div>
              <div class="card-footer">
              	<button class="addCollection" type="button" name="button" STYLE="background-color: transparent; border:2px blue none; outline:none;">
              		<i class="far fa-heart fa-1x" style="color: #E93F3F; font-size: 1.5em;"></i>
              		加入收藏
              	</button>
              </div>
            </div>
          </div>
		</c:when>
		<c:when test="${product.product_Class!='套裝行程' && product.product_State==1 && param.action == null && param.county == null}">
          	<div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100"  data-product_ID="${product.product_ID}"  data-product_Class="${product.product_Class}">
              <div class="img_Container">
                <div class="backgroundImg_Area" style="background-image:url('<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG1&tName=PRODUCT');">
                </div>
                <img class="card-img-top main_Img" src="<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG1&tName=PRODUCT">
              </div>
              <div class="card-body">
                <h4 class="card-title">
                  <a href="#">${product.product_Name}</a>
                </h4>
<!--                 <h5>$24.99</h5> -->
                <p class="place"><i class="fas fa-map-marker-alt" style="color: #FF0000;"></i>地點: ${product.product_Address}</p>
                <p class="price"><i class="fas fa-dollar-sign"></i>金額: <span></span></p>
<!--                 <p class="card-text" id="product_rating"><i class="fas fa-star" style="color: #FFDD26;  font-size: 1.2em;"></i><i class="far fa-star" style="color: #FFDD26;  font-size: 1.2em;"></i><i class="far fa-star" style="color: #FFDD26;  font-size: 1.2em;"></i><i class="far fa-star" style="color: #FFDD26;  font-size: 1.2em;"></i><i class="far fa-star" style="color: #FFDD26;  font-size: 1.2em;"></i></p> -->
              	<p class="rating" data-score=""></p>
              </div>
              <div class="card-footer">
              	<button class="addCollection"  type="button" name="button" STYLE="background-color: transparent; border:2px blue none; outline:none;">
              		<i class="far fa-heart fa-1x" style="color: #E93F3F; font-size: 1.5em;"></i>
              		加入收藏
              	</button>
              </div>
            </div>
          </div>
		</c:when>
	</c:choose>
</c:forEach>
          

        </div>
        <!-- /.row -->

<!--         <div class="row justify-content-center"> -->
<!--           <div class="pagination"> -->
<!--             <a href="#">&laquo;</a> -->
<!--             <a href="#">1</a> -->
<!--             <a class="active" href="#">2</a> -->
<!--             <a href="#">3</a> -->
<!--             <a href="#">4</a> -->
<!--             <a href="#">5</a> -->
<!--             <a href="#">6</a> -->
<!--             <a href="#">&raquo;</a> -->
<!--           </div> -->
<!--         </div> -->


      </div>
      <!-- /.col-lg-9 -->

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->

 
<!--   <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>
    </div>
  </footer> -->
  <%@include file="../frontstage_member/pages/footer.file" %>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="js/mall.js"></script>
  <script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>
  <script type="text/javascript">
  

  	$(window).on("load", function(){
	  getRatingPriceRange();
	  getCollections();
	  
// 	  console.log(location.href);
// 	  console.log(location.protocol);
// 	  console.log(location.hostname);
// 	  console.log(location.host);
// 	  console.log(location.port);
// 	  console.log(location.pathname);
// 	  console.log(location.search);
// 	  console.log(location.hash);
// 	  console.log(location.search);
	  let action = "";
	  if(location.search.indexOf('?') != -1){
// 		  let ary1 = location.search.split('action=')[1];
		  let ary1 = location.search;
		  if(ary1.includes('action=1')){
			  $(".action1").click();
// 			  action = "套裝行程";
		  }else if(ary1.includes('action=2')){
			  $(".action2").click();
// 			  action = "景點";
		  }else if(ary1.includes('action=3')){
			  $(".action3").click();
// 			  action = "餐廳";
		  }else if(ary1.includes('action=4')){
			  $(".action4").click();
// 			  action = "住宿";
		  }
// 		  console.log(ary1);
// 		  $('div.list-group').find('button.list-group-item').each(function(index, value){
// 			  if($(value).data('product_class') == action){
// 				  console.log(action);
// 				  $(this).click();
// 			  }
// 		  });
	  }
	  
	  if(location.search.indexOf('?') != -1){
		  let ary1 = location.search;
		  if(ary1.includes('Taipei')){
			  $(".Taipei").click();
		  }else if(ary1.includes('Kaohsiung')){
			  $(".Kaohsiung").click();
		  }else if(ary1.includes('Chiayi')){
			  $(".Chiayi").click();
		  }else if(ary1.includes('Tainan')){
			  $(".Tainan").click();
		  }else if(ary1.includes('Taoyuan')){
			  $(".Taoyuan").click();
		  }else if(ary1.includes('Taichung')){
			  $(".Taichung").click();
		  }else if(ary1.includes('Nantou')){
			  $(".Nantou").click();
		  }
	  }
	});

	function getRatingPriceRange(){
	  let foo = [];
	  $(".card").each(function(index, item){
	    foo[index] = $(this).attr("data-product_ID")
	  });
	  $.ajax({
	  // 資料請求的網址
	    url: "<%=request.getContextPath()%>/ProductServlet.do",
	    // GET | POST | PUT | DELETE | PATCH
	    type: "POST",
	    // 傳送資料到指定的 url
	    data: {
	      "action":"getRating",
	      "product_ID":JSON.stringify(foo)
	    },
	    // 預期會接收到回傳資料的格式： json | xml | html
	    dataType: "json",
	    // request 可等待的毫秒數 | 0 代表不設定 timeout
// 	    timeout: 30000,
	    // 在 request 發送之前執行
	    beforeSend: function() {
	    //	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
	    },
	    // request 成功取得回應後執行
	    success: function(data) {
// 	      console.log(data);
	      $(".rating").each(function(){
	        let product_ID = $(this).closest(".card").attr("data-product_ID");
	        $(this).attr("data-score",(data.rating[product_ID]));
	      });
	      loadStar();
	    }
	  });

	  $.ajax({
	  // 資料請求的網址
	    url: "<%=request.getContextPath()%>/ProductServlet.do",
	    // GET | POST | PUT | DELETE | PATCH
	    type: "POST",
	    // 傳送資料到指定的 url
	    data: {
	      "action":"getPriceRange",
	      "product_ID":JSON.stringify(foo)
	    },
	    // 預期會接收到回傳資料的格式： json | xml | html
	    dataType: "json",
	    // request 可等待的毫秒數 | 0 代表不設定 timeout
// 	    timeout: 30000,
	    // 在 request 發送之前執行
	    beforeSend: function() {
	    //	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
	    },

	    // request 成功取得回應後執行
	    success: function(data) {
// 	      console.log(data);
	    $(".price").each(function(){
	        let product_ID = $(this).closest(".card").attr("data-product_ID");
	        $(this).children("span").html(data.priceRange[product_ID]);
	      });
	    }
	  });
	}
	
	function getCollections(){
		let memberID = "${member.member_ID}";
		$.ajax({
		  // 資料請求的網址
			url: "<%=request.getContextPath()%>/ProductServlet.do",
		    // GET | POST | PUT | DELETE | PATCH
		    type: "POST",
		    // 傳送資料到指定的 url
		    data: {
		      "action":"getCollections",
		    },
		    // 預期會接收到回傳資料的格式： json | xml | html
		    dataType: "json",
		    // request 可等待的毫秒數 | 0 代表不設定 timeout
// 		    timeout: 30000,
		    // 在 request 發送之前執行
		    beforeSend: function() {
		    //	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
		    },
		    // request 成功取得回應後執行
		    success: function(data) {
		    	let arr = [];
				$(data.collectionByMemberID).each(function(index, item){
					arr[index] = item.product_ID;
				});
// 				console.log(arr);
				$(".card").each(function(){
// 					console.log($(this).attr("data-product_ID"));
					if($.inArray($(this).attr("data-product_ID"), arr) > -1){
						$(this).find(".addCollection").children().remove();
						$(this).find(".addCollection").prepend("<i class='fas fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
					}
				});
			}
		});
	}


	function loadStar(){
	$(".rating").each(function(index, item){
		let score = $(this).attr("data-score");
		let star = "";
		let count = 0;
		for(score; score>0; score--){
			if(score-1<0){
				star += `<i class="fas fa-star-half-alt" style="color:#FFDD26;"></i>`
				score--;
				count++;
			}else{
				star += `<i class="fas fa-star" style="color:#FFDD26;"></i>`;
				count++;
			}
		}
		let i = 5-count;
		for(i; i>0; i--){
			star += `<i class="far fa-star" style="color:#FFDD26;"></i>`;
		}
		$(this).html(star);
	});
	}
	
    //按鈕樣式切換
    $(".list-group-item").on("click", function(){
    	$(this).closest(".list-group").children(".list-group-item").attr("class","list-group-item");
    	$(this).toggleClass("-on");
    	filterClassCounty();
    });
    
    $("input[type=checkbox]").on("click", function(e){
    	e.stopPropagation();
		filterClassCounty();
    });
    
    //篩選功能
    function filterClassCounty(){
    	let product_Class = null;
    	let checkedArr = [];
    	
    	if($("input[type=checkbox]:checked").length == 0){
    		$(".filter_area").find("input[type=checkbox]").each(function(index, item){
        		checkedArr[index] = $(this).next("a").attr("data-county");
        	});
    	}else{
    		$(".filter_area").find("input[type=checkbox]:checked").each(function(index, item){
    			checkedArr[index] = $(this).next("a").attr("data-county");
        	});
    	}
    	if($(".-on").length > 0){
    		product_Class = $(".-on").attr("data-product_Class");
    	}
//     	console.log(product_Class);
//     	console.log(checkedArr);
    	
    	$.ajax({
			// 資料請求的網址
    		url: "<%=request.getContextPath()%>/ProductServlet.do",
    		// GET | POST | PUT | DELETE | PATCH
    		type: "POST",
    		// 傳送資料到指定的 url
    		data: {
    			"action":"filterClass",
    			"product_Class":product_Class,
    			"checkedArr": JSON.stringify(checkedArr)
    		},
    		// 預期會接收到回傳資料的格式： json | xml | html
    		dataType: "json",
    		// request 可等待的毫秒數 | 0 代表不設定 timeout
//     		timeout: 30000,
    		// 在 request 發送之前執行
    		beforeSend: function() {
     		//	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
    		},

    		// request 成功取得回應後執行
    		success: function(data) {
//     			console.log(data);
//     			console.log(data.filtedClass[0].product_Class);
//     			console.log(data.filtedClass.length);
    			
    			$(".card").each(function(){
    				$(this).closest(".col-lg-4").remove();
    			});
    			$(".noResultDOM").remove();
    			
    			if(data.filtedClass.length == 0){
    				let noResultDOM = `<div class='noResultDOM' style="width:100%;">
    					<h4 style="text-align:center;">噢噢~沒有搜尋到結果，請再試試其他搜尋條件</h4>
    				</div>`
    				$(".productArea").append(noResultDOM);
    			}else{
    				if(data.filtedClass[0].product_Class=="套裝行程"){
        				$(data.filtedClass).each(function(index, item){
//             				console.log(item);
            				createNewSetCard(item.product_ID, item.product_Name, item.product_Staytime, item.product_Click_Rec, item.product_Address, item.product_Class);
            			});
        			}else{
        				$(data.filtedClass).each(function(index, item){
//             				console.log(item);
    	    				createNewCard(item.product_ID, item.product_Name, item.product_Staytime, item.product_Click_Rec, item.product_Address, item.product_Class);
            			});
        			}
        			getRatingPriceRange();
        			getCollections()
    			}
    		}
    	});
    }
    
    
    var a;
    $("#search").on("keyup", function(e){
//     	console.log(e.which);
//     	if(e.which == 13){
//     		alert();
//     	}
    	clearTimeout(a);
    	
    	a = setTimeout(function(){
	    	let keyword = $("#search").val().trim();
	    	if(keyword != ""){
		    	findKeyword(keyword);
	    	}
    	}, 600);
    });
    
    $(".icon").on("click", function(e){
    	clearTimeout(a);
    	
    	a = setTimeout(function(){
	    	let keyword = $("#search").val().trim();
	    	if(keyword != ""){
		    	findKeyword(keyword);
	    	}
    	}, 600);
    });
    
    function findKeyword(keyword){
    	console.log(keyword);
    	$.ajax({
			// 資料請求的網址
    		url: "<%=request.getContextPath()%>/ProductServlet.do",
    		// GET | POST | PUT | DELETE | PATCH
    		type: "POST",
    		// 傳送資料到指定的 url
    		data: {
    			"action":"findKeyword",
    			"keyword":keyword
    		},
    		// 預期會接收到回傳資料的格式： json | xml | html
    		dataType: "json",
    		// request 可等待的毫秒數 | 0 代表不設定 timeout
//     		timeout: 30000,
    		// 在 request 發送之前執行
    		beforeSend: function() {
     		//	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
    		},

    		// request 成功取得回應後執行
    		success: function(data) {
//     			console.log(data);
    			$(".card").each(function(){
    				$(this).closest(".col-lg-4").remove();
    			});
    			$(".noResultDOM").remove();
    			
    			if(data.reply.length == 0){
    				let noResultDOM = `<div class='noResultDOM' style="width:100%;">
    					<h4 style="text-align:center;">噢噢~沒有搜尋到結果，請再試試其他搜尋條件</h4>
    				</div>`
    				$(".productArea").append(noResultDOM);
    			}else{
    				if(data.reply[0].product_Class=="套裝行程"){
        				$(data.reply).each(function(index, item){
//             				console.log(item);
            				createNewSetCard(item.product_ID, item.product_Name, item.product_Staytime, item.product_Click_Rec, item.product_Address, item.product_Class);
            			});
        			}else{
        				$(data.reply).each(function(index, item){
//             				console.log(item);
    	    				createNewCard(item.product_ID, item.product_Name, item.product_Staytime, item.product_Click_Rec, item.product_Address, item.product_Class);
            			});
        			}
        			getRatingPriceRange();
        			getCollections()
    			}
    		}
    	});
    }
    
    
    function createNewSetCard(productID, product_Name, product_Staytime, product_Click_Rec, product_Address, product_Class){
    	let foo = "<fmt:parseNumber var='i' integerOnly='true' type='number' value='${product.product_Click_Rec}' />"
    	    +"<div class='col-lg-4 col-md-6 mb-4'>"
    	    +"<div class='card h-100' data-product_ID='"+productID+"' data-product_Class='"+product_Class+"'>"
    	    +`<div class="img_Container">`
            +`<div class="backgroundImg_Area" style="background-image:url('<%=request.getContextPath()%>/DBGifReader2?conditions=`+productID+`&whichImg=PRODUCT_IMG1&tName=PRODUCT');">`
            +`</div>`
            +`<img class="card-img-top main_Img" src="<%=request.getContextPath()%>/DBGifReader2?conditions=`+productID+`&whichImg=PRODUCT_IMG1&tName=PRODUCT">`
          +`</div>`
    	      +"<div class='card-body'>"				   
    	      +"<h4 class='card-title'>"
    	        +"<a href='#'>"+product_Name+"</a>"
    	          +"</h4>"
    	        +"<fmt:parseNumber var='i' integerOnly='true' type='number' value='${product.product_Staytime}' />"
    		+"<p class='days'><i class='far fa-calendar-alt'></i>安排天數: "+product_Staytime+"</p>"
    	        +"<p class='price'><i class='fas fa-dollar-sign'></i>金額: <span></span></p>"
    	        +"<p class=''><i class='fab fa-gripfire'></i>瀏覽次數: "+product_Click_Rec+"</p>"
    	        +"<p class=''><i class='fas fa-map-marker-alt'></i>安排景點: "+product_Address+"</p>"
    	        +"</div>"
    	      +"<div class='card-footer'>"
    	      +"<button class='addCollection' type='button' name='button' STYLE='background-color: transparent; border:2px blue none; outline:none;'><i class='far fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>加入收藏</button>"
    	      +"</div>"
    	      +"</div>"
    	  +"</div>"
    	$(".productArea").append(foo);
    }
    
    function createNewCard(productID, product_Name, product_Staytime, product_Click_Rec, product_Address, product_Class){
    	let foo = "<div class='col-lg-4 col-md-6 mb-4'>"
    		+"<div class='card h-100'  data-product_ID='"+productID+"' data-product_Class='"+product_Class+"'>"
    		+`<div class="img_Container">`
            +`<div class="backgroundImg_Area" style="background-image:url('<%=request.getContextPath()%>/DBGifReader2?conditions=`+productID+`&whichImg=PRODUCT_IMG1&tName=PRODUCT');">`
            +`</div>`
            +`<img class="card-img-top main_Img" src="<%=request.getContextPath()%>/DBGifReader2?conditions=`+productID+`&whichImg=PRODUCT_IMG1&tName=PRODUCT">`
          +`</div>`
        +"<div class='card-body'>"
        +"<h4 class='card-title'>"
          +"<a href='#'>"+product_Name+"</a>"
            +"</h4>"
          +"<p class='place'><i class='fas fa-map-marker-alt' style='color: #FF0000;'></i>地點: "+product_Address+"</p>"
          +"<p class='price'><i class='fas fa-dollar-sign'></i>金額: <span></span></p>"
          +"<p class='rating' data-score=''></p>"
        	+"</div>"
        +"<div class='card-footer'>"
        +"<button class='addCollection' type='button' name='button' STYLE='background-color: transparent; border:2px blue none; outline:none;'><i class='far fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>加入收藏</button>"
        	+"</div>"
        +"</div>"
    +"</div>"
    	$(".productArea").append(foo);
    }

    $(document).on("click", ".card", function(){
    	let product_ID = $(this).attr("data-product_ID");
    	let product_Class = $(this).attr("data-product_Class");
    	window.location.href='<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID='+product_ID+"&product_Class="+product_Class;
    });

	//新增收藏
    $(document).on("click", ".addCollection", function(e){
    	e.stopPropagation();
    	let btn_Heart = $(this);
    	let product_ID = $(this).closest(".card").attr("data-product_ID");
    	let location = "<%=request.getRequestURI()%>";
    	$.ajax({
			// 資料請求的網址
    		url: "<%=request.getContextPath()%>/ProductServlet.do",
    		// GET | POST | PUT | DELETE | PATCH
    		type: "POST",
    		// 傳送資料到指定的 url
    		data: {
    			"action":"addCollection",
    			"product_ID":product_ID,
    			"location": location
    		},
    		// 預期會接收到回傳資料的格式： json | xml | html
    		dataType: "json",
    		// request 可等待的毫秒數 | 0 代表不設定 timeout
//     		timeout: 30000,
    		// 在 request 發送之前執行
    		beforeSend: function() {
     		//	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
    		},

    		// request 成功取得回應後執行
    		success: function(data) {
    			if(data.reply=="增加"){
    				$(btn_Heart).children().remove();
    				$(btn_Heart).prepend("<i class='fas fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
    			}else if(data.reply=="移除"){
    				$(btn_Heart).children().remove();
    				$(btn_Heart).prepend("<i class='far fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
    			}else if(data.reply==false){
    				window.location.href="<%=request.getContextPath()%>/frontstage_member/login2.jsp";
    			}
    		}
    	});
    });
    
  </script>

</body>
</html>
