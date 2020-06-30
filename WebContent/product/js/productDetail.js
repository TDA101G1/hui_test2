const contextPath = "/"+location.pathname.split("/")[1];

//網頁載入後要執行的函式
$(window).on("load", function(){
  createSpc();
  checkStock();
  createProductDetail();
  loadStar();
  getCollections();

  //套裝行程圖片參照商品縮圖
  let origin = $(".smaller_img").children("img");
  let ref = $(".introduction_card").find("img");
  $.each(origin, function(index, item){
    $(ref[index]).attr("src", $(origin[index]).attr("src"))
  });
});

//查詢並將庫存小於1的按鈕設定為disabled
function checkStock(){
  $.each($("button.btn_option"), function(index, item){
    if($(item).children("a.stock").html()<1){
      $(this).attr("disabled","disabled");
    }
  });
}

//依照商品類型動態產生頁面
function createSpc(){
  if($(".product_Class").val()=="餐廳"){
    $(".product_spc").children("table").html(typeFood);
  }else if($(".product_Class").val()=="套裝行程" || $(".product_Class").val()=="景點"){
    $(".product_spc").children("table").html(typeTravel);
    //初始化日期
    flatpickr(".inputCalendar",{
      altInput: false,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      minDate: new Date().getTime()+(1000*60*60*24*2),
      maxDate: new Date().getTime()+(1000*60*60*24*59)
    });
    $(".end").attr("disabled","disabled");
  }else if ($(".product_Class").val()=="住宿") {
	$(".product_spc").children("table").html(typeHotel);
	//初始化日期
	flatpickr(".start",{
		altInput: false,
		altFormat: "F j, Y",
		dateFormat: "Y-m-d",
		minDate: "today",
		maxDate: new Date().getTime()+(1000*60*60*24*59)
	});
	flatpickr("input.end",{
		altInput: false,
		altFormat: "F j, Y",
		dateFormat: "Y-m-d",
		minDate: new Date().getTime()+(1000*60*60*24),
		maxDate: new Date().getTime()+(1000*60*60*24*60)
	});
  }
}


$(document).on("change", "input.start", function(){
//起始日與結束日連動
  let foo = $("input.start").val();
  let bar = $("input.end").val();
  if(foo >= bar && $(".product_Class").val()=="住宿"){
    foo = Date.parse(foo).valueOf();
    flatpickr("input.end",{
      altInput: false,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      minDate: new Date(foo+(1000*60*60*24)),
      maxDate: new Date().getTime()+(1000*60*60*24*60)
    });
  }else if ($(".product_Class").val()=="景點") {
    $(".end").val(foo);
  }else if ($(".product_Class").val()=="套裝行程") {
	let bar = $(".product_Name").attr("data-stayTime");
    let days = bar-1;
    foo = Date.parse(foo).valueOf();
    foo = foo+(1000*60*60*24*days);
    flatpickr("input.end",{
      altInput: false,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      defaultDate: foo
    });
  }
  
//查詢某時間段房間庫存
  
});


//動態產生商品詳情
function createProductDetail(){
  if($(".product_Class").val()=="套裝行程"){
    $(".introduction_card").html(travelSet);
  }else{
    $(".introduction_card").html(normalProduct);
  }
}

//確保數量如果是輸入的話最低在1最大值在max
$(document).on("blur", ".input_quantity", function(){
  let foo = parseInt($(this).val());
  if(foo<1){
    $(this).val(1);
  }else if(foo > $(this).attr("max")){
    $(this).val($(this).attr("max"));
  }
});

// 圖片切換
$(".smaller_img img").on("click", function(){
  let src = $(this).attr("src")
  $(".backgroundImg_Area").css("background-image", "url('"+src+"'")
  $(".main_img").attr("src", src);
});

//數量高過max就等同max
//$("input.input_quantity").on("change", function(){
//  if($("input.input_quantity").val()>$(this).attr("max")){
//    $("input.input_quantity").val($(this).attr("max"));
//  }
//  $("input.quantity").val($("input.input_quantity").val());
//});

// 商品選項切換與填寫表單
$(document).on("click", "button.btn_option", function(){
  if($(this).is(".-on")){
    $(this).toggleClass("-on");
    $("div.price_area").children("h5").html("售價: " + "請先選擇查看價錢");
    $("input.input_quantity").siblings("a").html("剩餘數量: " + "> 99");
  }else{
    $(this).closest("td").children("button").attr("class","btn_option");
    $(this).toggleClass("-on");
    $("div.price_area").children("h5").html("售價: " + $(this).attr("data-price"));
    $("input.input_quantity").val(1);
    $("input.input_quantity").siblings("a").html("剩餘數量: " + $(this).attr("data-stock"));
    $("input.input_quantity").attr("max", $(this).attr("data-stock"));
//    $("input.productDetail_ID").val($(this).children("a.PD_ID").html()); 0618form表單改用Ajax
  }
});

// 評論篩選的按鈕樣式相關
$("td.filter_area").children("button").on("click", function(){
  if($(this).is(".-on")){
    $(this).toggleClass("-on");
    $(this).closest("td").children("button").first("button").toggleClass("-on")
  }else{
    $(this).closest("td").children("button").attr("class","btn_filter");
    $(this).toggleClass("-on");
  }
});

//依照評分動態產生星號
function loadStar(){
  $(".score").each(function(index, item){
    let j = $(this).html();
    let star = ""
    for(let i=0; i<j; i++){
      star += `<i class="fas fa-star" style="color:#FFDD26;"></i>`;
    }
    for(let i=0; i<5-j; i++){
      star += `<i class="far fa-star" style="color:#FFDD26;"></i>`;
    }
    $(this).next("p").html(star);
  });
}

//依照評分篩選評論
$(".btn_filter").on("click", function(){
  $(".comment_card").css("display", "flex");
  let foo = $(this).data("filter")
  $(".comment_card").each(function(){
    let bar = $(this).find(".score").html();
    if(foo == "all"){
      $(this).css("display", "flex");
    }else if (foo == "hasImg") {
      if($(this).find(".comment_img").attr("src") == ""){
        $(this).css("display", "none");
      }

    }else if (foo != bar) {
      $(this).css("display", "none");
    }
  });
});

//確認是否是收藏
function getCollections(){
	let memberID = "${member.member_ID}";
	$.ajax({
	  // 資料請求的網址
		url: contextPath+"/ProductServlet.do",
	    // GET | POST | PUT | DELETE | PATCH
	    type: "POST",
	    // 傳送資料到指定的 url
	    data: {
	      "action":"getCollections",
	    },
	    // 預期會接收到回傳資料的格式： json | xml | html
	    dataType: "json",
	    // request 可等待的毫秒數 | 0 代表不設定 timeout
	    timeout: 3000,
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
			if($.inArray($(".product_Name").attr("data-product_ID"), arr) > -1){
				$(".addCollection").children().remove();
				$(".addCollection").prepend("<i class='fas fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
			}
		}
	});
}

////加入收藏或取消收藏
//$(document).on("click", ".addCollection", function(e){
//	e.stopPropagation();
//	let btn_Heart = $(this);
//	let product_ID = $(".product_Name").attr("data-product_ID");
//	let location = "<%=request.getRequestURI()%>";
//	$.ajax({
//		// 資料請求的網址
//		url: "http://localhost:8081/TDA101G1/ProductServlet.do",
//		// GET | POST | PUT | DELETE | PATCH
//		type: "POST",
//		// 傳送資料到指定的 url
//		data: {
//			"action":"addCollection",
//			"product_ID":product_ID,
//			"location": location
//		},
//		// 預期會接收到回傳資料的格式： json | xml | html
//		dataType: "json",
//		// request 可等待的毫秒數 | 0 代表不設定 timeout
//		timeout: 3000,
//		// 在 request 發送之前執行
//		beforeSend: function() {
// 		//	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
//		},
//
//		// request 成功取得回應後執行
//		success: function(data) {
//			if(data.reply=="增加"){
//				$(btn_Heart).children().remove();
//				$(btn_Heart).prepend("<i class='fas fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
//			}else if(data.reply=="移除"){
//				$(btn_Heart).children().remove();
//				$(btn_Heart).prepend("<i class='far fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
//			}
//		}
//	});
//});
//搜尋欄
$("span.searchIcon").children("i").on("click", function(){
  let keyword = $("input#search").val();
  if(keyword.trim()==""){
    swal({
      position: 'top-end',
      icon: 'warning',
      title: '請商品名稱輸入關鍵字',
      showConfirmButton: false,
      timer: 1500
    });
  }else{
    window.location.href="#";
  }
});
$("#search").on("keyup", function(e) {
  // console.log("鍵盤對應的ASCII: " + e.which);
  if (e.which == 13) {
    $("span.searchIcon").children("i").click();
  }
});

//加入購物車
$("button.addCar").on("click", function(){
  if($(".product_Class").val()=="餐廳" && $("div.product_spc").find("button.-on").length!=1){
    swal({
      position: 'top-end',
      icon: 'error',
      title: '請先選擇商品規格',
      showConfirmButton: false,
      timer: 1500
    });
  }else if ($(".product_Class").val()=="套裝行程" && $(".start").val()=="" || $("div.product_spc").find("button.-on").length!=1) {
    swal({
      position: 'top-end',
      icon: 'error',
      title: '請先選擇商品規格',
      showConfirmButton: false,
      timer: 1500
    });
  }else if ($(".product_Class").val()=="景點" && $(".start").val()=="" || $("div.product_spc").find("button.-on").length!=1) {
    swal({
      position: 'top-end',
      icon: 'error',
      title: '請先選擇商品規格',
      showConfirmButton: false,
      timer: 1500
    });
  }else if ($(".product_Class").val()=="住宿" && $(".start").val()=="" || $(".end").val()=="" || $("div.product_spc").find("button.-on").length!=1) {
    swal({
      position: 'top-end',
      icon: 'error',
      title: '請先選擇商品規格',
      showConfirmButton: false,
      timer: 1500
    });
  }else{ //正確加入
    console.log($(".product_Class").val());
    let product_ID = $(".product_Name").attr("data-product_id");
    let product_Name = $(".product_Name").html();
    let productDetail_ID = $("div.product_spc").find("button.-on").attr("data-pd_id");
    let price = $("div.product_spc").find("button.-on").attr("data-price");
    let spc = $("div.product_spc").find("button.-on").html();
    let quantity = $("input.input_quantity").val();
    let start = $(".start").val();
    let end = $(".end").val();
//    console.log(product_ID);
//    console.log(product_Name);
//    console.log(productDetail_ID);
//    console.log(quantity);
//    console.log(spc);
//    console.log(start);
//    console.log(end);
//    console.log(price);
    
    $.ajax({
		// 資料請求的網址
		url: contextPath+"/ProductServlet.do",
		// GET | POST | PUT | DELETE | PATCH
		type: "POST",
		// 傳送資料到指定的 url
		data: {
			"action":"addShoppingCar",
			"product_ID":product_ID,
			"product_Name":product_Name,
			"productDetail_ID":productDetail_ID,
			"quantity":quantity,
			"spc":spc,
			"start":start,
			"end":end,
			"price":price
		},
		// 預期會接收到回傳資料的格式： json | xml | html
		dataType: "json",
		// request 可等待的毫秒數 | 0 代表不設定 timeout
		timeout: 3000,
		// 在 request 發送之前執行
		beforeSend: function() {
 		//	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
		},

		// request 成功取得回應後執行
		success: function(data) {
			console.log(data);
			if(data.reply == "added"){
				swal({
					position: 'top-end',
					icon: 'success',
					title: '成功加入購物車',
					showConfirmButton: false,
					timer: 1000
				});
			}
//			if(data.reply=="增加"){
//				$(btn_Heart).children().remove();
//				$(btn_Heart).prepend("<i class='fas fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
//			}else if(data.reply=="移除"){
//				$(btn_Heart).children().remove();
//				$(btn_Heart).prepend("<i class='far fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
//			}
		}
	});
  }
});

//立即購買
$("button.checkout").on("click", function(e){
  if($(".product_Class").val()=="餐廳" && $("div.product_spc").find("button.-on").length!=1){
    swal({
      position: 'top-end',
      icon: 'error',
      title: '請先選擇商品規格',
      showConfirmButton: false,
      timer: 1500
    });
//    e.preventDefault();//阻止submit送出表單
  }else if ($(".product_Class").val()=="套裝行程" && $(".start").val()=="" || $("div.product_spc").find("button.-on").length!=1) {
    swal({
      position: 'top-end',
      icon: 'error',
      title: '請先選擇商品規格',
      showConfirmButton: false,
      timer: 1500
    });
//    e.preventDefault();//阻止submit送出表單
  }else if ($(".product_Class").val()=="景點" && $(".start").val()=="" || $("div.product_spc").find("button.-on").length!=1) {
    swal({
      position: 'top-end',
      icon: 'error',
      title: '請先選擇商品規格',
      showConfirmButton: false,
      timer: 1500
    });
//    e.preventDefault();//阻止submit送出表單
  }else if ($(".product_Class").val()=="住宿" && $(".start").val()=="" || $(".end").val()=="" || $("div.product_spc").find("button.-on").length!=1) {
    swal({
      position: 'top-end',
      icon: 'error',
      title: '請先選擇商品規格',
      showConfirmButton: false,
      timer: 1500
    });
    e.preventDefault();//阻止submit送出表單
  }else{
	    console.log($(".product_Class").val());
	    let product_ID = $(".product_Name").attr("data-product_id");
	    let product_Name = $(".product_Name").html();
	    let productDetail_ID = $("div.product_spc").find("button.-on").attr("data-pd_id");;
	    let price = $("div.product_spc").find("button.-on").attr("data-price");
	    let spc = $("div.product_spc").find("button.-on").html();
	    let quantity = $("input.input_quantity").val();
	    let start = $(".start").val();
	    let end = $(".end").val();
//	    console.log(product_ID);
//	    console.log(product_Name);
	    console.log(productDetail_ID);
//	    console.log(quantity);
//	    console.log(spc);
//	    console.log(start);
//	    console.log(end);
//	    console.log(price);
	    
	    $.ajax({
			// 資料請求的網址
			url: contextPath+"/ProductServlet.do",
			// GET | POST | PUT | DELETE | PATCH
			type: "POST",
			// 傳送資料到指定的 url
			data: {
				"action":"addShoppingCar",
				"product_ID":product_ID,
				"product_Name":product_Name,
				"productDetail_ID":productDetail_ID,
				"quantity":quantity,
				"spc":spc,
				"start":start,
				"end":end,
				"price":price
			},
			// 預期會接收到回傳資料的格式： json | xml | html
			dataType: "json",
			// request 可等待的毫秒數 | 0 代表不設定 timeout
			timeout: 3000,
			// 在 request 發送之前執行
			beforeSend: function() {
	 		//	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
			},

			// request 成功取得回應後執行
			success: function(data) {
				console.log(data);
				if(data.reply == "added"){
					window.location.href="product/shoppingCar.jsp";
				}
//				if(data.reply=="增加"){
//					$(btn_Heart).children().remove();
//					$(btn_Heart).prepend("<i class='fas fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
//				}else if(data.reply=="移除"){
//					$(btn_Heart).children().remove();
//					$(btn_Heart).prepend("<i class='far fa-heart fa-1x' style='color: #E93F3F; font-size: 1.5em;'></i>");
//				}
			}
		});
  	}
});

// 燈箱https://zacklive.com/w3schools-lightbox
let modal = document.getElementById('myModal');
let modalImg = document.getElementById("img01");
let captionText = document.getElementById("caption");
$("img.comment_img").on("click", function(){
  modal.style.display = "block";
  modalImg.src = this.src;
  captionText.innerHTML = this.alt;
});
$(".main_img").on("click", function(){
  modal.style.display = "block";
  modalImg.src = this.src;
  captionText.innerHTML = this.alt;
});
$(document).on("click", ".img_smaller_scheduleLight", function(){
  modal.style.display = "block";
  modalImg.src = this.src;
  captionText.innerHTML = this.alt;
});
modal.onclick = function() {
  modal.style.display = "none";
}
