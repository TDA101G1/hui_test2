const contextPath = "/"+location.pathname.split("/")[1];

$(window).on("load", function(){
//  changeOption();
//  subtotal();
//  checkStock();
//  noItem();
});

$(document).on("change", function(){
  changeOption();
  subtotal();
  prepareCheckout();
  reverseCheckbox();
  removeFailureArea();
});

window.onpopstate = function(event){
	  location.reload();
}

//選項變動時Ajax更新Redis資料庫
$("select").on("change", function(){
	console.log($(this).find("option:selected").html());
	console.log($(this).find("option:selected").attr("data-productdetail_id"));
	console.log($(this).find("option:selected").attr("data-price"));
//	clearTimeout(a);
	
	let product_Name = $(this).closest("tr").find(".productName").html();
	let product_ID = $(this).closest("tr").find(".productName").attr("data-product_id");
	let productDetail_ID = $(this).closest("tr").find("option:selected").attr("data-productdetail_id");
	let spc = $(this).closest("tr").find("option:selected").html();
	let quantity = $(this).closest("tr").find(".input_quantity").val();
	let start = $(this).closest("tr").find(".start").html();
	let end = $(this).closest("tr").find(".end").html();
	let price = $(this).find("option:selected").attr("data-price")
	let index = $(this).closest("tr").find(".productName").attr("data-index");
	let addTime = $(this).closest("tr").find(".productName").attr("data-addTime");
	
	a = setTimeout(function(){
//		console.log(product_Name);
//		console.log(product_ID);
//		console.log(productDetail_ID);
//		console.log(spc);
//		console.log(quantity);
//		console.log(start);
//		console.log(end);
//		console.log(price);
//		console.log(index);
//		console.log(addTime);
		updateMemberCar(product_Name, product_ID, productDetail_ID, spc, quantity, start, end, price, index, addTime);
	}, 200);
});





//選項變動時價格即時更新
function changeOption(){
  $("option:checked").each(function(){
    let price = $(this).attr("data-price");
    $(this).closest("tr").find(".price p").html(price);
    let stock = "庫存"+$(this).attr("data-instock");
    $(this).closest("tr").find(".quantity i").html(stock);
    $(this).closest("tr").find(".input_quantity").attr("max", $(this).attr("data-instock"));
  });
}

//查詢並將庫存小於1的按鈕設定為disabled
function checkStock(){
  $.each($("option"), function(index, item){
    if($(item).attr("data-instock")<1){
      $(this).attr("disabled","disabled");
    }
  });
}

//確保數量如果是輸入的話最低在1最大值在max
$(document).on("keyup", ".input_quantity", function(){
  let foo = parseInt($(this).val());
  if(foo<1){
    $(this).val(1);
  }else if(foo > $(this).attr("max")){
    $(this).val($(this).attr("max"));
  }
});

//數量變動時Ajax更新Redis資料庫
$(".input_quantity").on("change", function(){
	clearTimeout(a);//頻繁變更時終止Ajax送出資料
	
	let product_Name = $(this).closest("tr").find(".productName").html();
	let product_ID = $(this).closest("tr").find(".productName").attr("data-product_id");
	let productDetail_ID = $(this).closest("tr").find("option:selected").attr("data-productdetail_id");
	let spc = $(this).closest("tr").find("option:selected").html();
	let quantity = $(this).closest("tr").find(".input_quantity").val();
	let start = $(this).closest("tr").find(".start").html();
	let end = $(this).closest("tr").find(".end").html();
	let price = $(this).closest("tr").find("option:selected").attr("data-price")
	let index = $(this).closest("tr").find(".productName").attr("data-index");
	let addTime = $(this).closest("tr").find(".productName").attr("data-addTime");
	
	a = setTimeout(function(){
//		console.log(product_Name);
//		console.log(product_ID);
//		console.log(productDetail_ID);
//		console.log(spc);
//		console.log(quantity);
//		console.log(start);
//		console.log(end);
//		console.log(price);
//		console.log(index);
//		console.log(addTime);
		updateMemberCar(product_Name, product_ID, productDetail_ID, spc, quantity, start, end, price, index, addTime);
	}, 200);
});


//更新Redis資料庫updateMemberCar
var a;
function updateMemberCar(product_Name, product_ID, productDetail_ID, spc, quantity, start, end, price, index, addTime){
	$.ajax({
	  // 資料請求的網址
		url: contextPath+"/ProductServlet.do",
	    // GET | POST | PUT | DELETE | PATCH
	    type: "POST",
	    // 傳送資料到指定的 url
	    data: {
	      "action":"updateMemberCar",
	      "product_Name":product_Name,
	      "product_ID":product_ID,
	      "productDetail_ID":productDetail_ID,
	      "spc":spc,
	      "quantity":quantity,
	      "start":start,
	      "end":end,
	      "price":price,
	      "index":index,
	      "addTime":addTime
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
		    	console.log("goBack");
		}
	});
}




//單一商品小計
function subtotal(){
  for(let i=0; i<$(".subtotal").length; i++){
    let price = $(".price p")[i].innerHTML;
    let quantity = $(".input_quantity")[i].value;
    $(".subtotal")[i].innerHTML = price * quantity;
    
  }
}

// 選中的商品結算
function prepareCheckout(){
  let price = 0;
  let count = 0;
  $(".sumPrice").html(0);
  $(".sumQuantity").html(0);
  $(".selectOne:checked").each(function(){
    price += parseInt($(this).closest("tr").find(".subtotal").html());
    count += parseInt($(this).closest("tr").find(".input_quantity").val());
    $(".sumPrice").html(price);
    $(".sumQuantity").html(count);
    // console.log(count);
    // console.log(price);
  });
}

//結帳
$(".checkout").on("click", function(e){
  if($(".selectOne:checked").length==0){
	e.preventDefault();
    swal({
      position: 'top-end',
      icon: 'warning',
      title: '請先選擇要結帳的商品',
      showConfirmButton: false,
      timer: 1000
    });
  }else {
    let goods = [];
    $(".selectOne:checked").each(function(index, item){
      // console.log($(this).closest("tr").find("option:checked").attr("data-productDetail_ID"));
      // console.log($(this).closest("tr").find(".input_quantity").val());
      let product_Name = $(this).closest("tr").find(".productName").html();
      let product_ID = $(this).closest("tr").find(".productName").attr("data-product_ID");
      let productDetail_ID = $(this).closest("tr").find("option:checked").attr("data-productDetail_ID");
      let spc = $(this).closest("tr").find("option:checked").html();
      let price = $(this).closest("tr").find(".price p").html();
      let quantity = $(this).closest("tr").find(".input_quantity").val();
      let start = $(this).closest("tr").find(".start").html();
      let end = $(this).closest("tr").find(".end").html();
      let addTime = $(this).closest("tr").find(".productName").attr("data-addtime");
      goods[index] = {
        "product_Name":product_Name,
        "product_ID":product_ID,
        "productDetail_ID":productDetail_ID,
        "spc":spc,
        "price":price,
        "quantity":quantity,
        "start":start,
        "end":end,
        "addTime":addTime
      }
      sessionStorage.setItem("checkoutInfo", JSON.stringify(goods));
      $(".goods").val(JSON.stringify(goods));
    });
    
    console.log(location.href);
    console.log(location.protocol);
    console.log(location.hostname);
    console.log(location.host);
    console.log(location.port);
    console.log(location.pathname);
    console.log(location.search);
    console.log(location.hash);
    
//    let pathname = location.pathname;
//    let foo = pathname.split("/");
//    console.log(foo);
//    foo.splice(0, 1, location.host);
//    foo.splice(foo.length-1, 1, "checkout.jsp");
//    pathname = foo.join("/");
//    console.log(foo);
//    console.log(pathname);
    
//    window.location.href=pathname;
  }
});

// 刪除勾選的商品
$(".removeSelect").on("click", function(){
	if($(".selectOne:checked").length>0){
	    swal({
	    	title: "確認刪除勾選的商品嗎?",
	    	text: "",
	    	icon: "warning",
	    	buttons: true,
	    	dangerMode: true,
	    	buttons: ["取消","確認刪除"],
	    })
	    .then((willDelete) => {
	    	if (willDelete) {
	    		let foo = [];
				let product_Name;
				let product_ID;
				let productDetail_ID;
				let spc;
				let quantity;
				let start;
				let end;
				let index;
				let addTime;
				let jsonArr = [];
//				console.log(product_Name);
//				console.log(product_ID);
//				console.log(productDetail_ID);
//				console.log(spc);
//				console.log(quantity);
//				console.log(start);
//				console.log(end);
//				console.log(index);
//				console.log(addTime);
		        $(".selectOne:checked").each(function(index, item){
		        	foo[index] = $(this);
					product_Name = $(this).closest("tr").find(".productName").html();
					product_ID = $(this).closest("tr").find(".productName").attr("data-product_id");
					productDetail_ID = $(this).closest("tr").find("option:selected").attr("data-productdetail_id");
					spc = $(this).closest("tr").find("option:selected").html();
					quantity = $(this).closest("tr").find(".input_quantity").val();
					start = $(this).closest("tr").find(".start").html();
					end = $(this).closest("tr").find(".end").html();
					price = $(this).closest("tr").find(".price p").html();
//					index = $(this).closest("tr").find(".productName").attr("data-index");
					addTime = $(this).closest("tr").find(".productName").attr("data-addTime");
					
					jsonArr[index] = {
						"product_Name":product_Name,
						"product_ID":product_ID,
						"productDetail_ID":productDetail_ID,
						"spc":spc,
						"quantity":quantity,
						"start":start,
						"end":end,
						"price":price,
//						"index":index,
						"addTime":addTime
					}
			    });
				$.ajax({
					// 資料請求的網址
					url: contextPath+"/ProductServlet.do",
					// GET | POST | PUT | DELETE | PATCH
					type: "POST",
					// 傳送資料到指定的 url
					data: {
						"action":"removeGoods",
						"jsonArr":JSON.stringify(jsonArr)
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
//						console.log(data);
						if(data.reply != "fail to removeGoods"){
							$(foo).each(function(){
								 $(this).closest("tr").remove();
							});
							reverseCheckbox();
							prepareCheckout();
//							if($(".failureItem").length<1){
//								$(".failureArea").remove();
//							}
							removeFailureArea();
					        noItem();
							swal("您勾選的商品已經被刪除", {
								icon: "success",
								timer: 1000
							});
						}else{
							swal({
								position: 'top-end',
								icon: 'warning',
								title: '噢噢~刪除失敗了，請稍後再試一次',
								showConfirmButton: false,
								timer: 1000
							});
						}
					}
				});
			} else {
				// swal("Your imaginary file is safe!");
			}
	    });
	}
});

//刪除單一商品
$(document).on("click", ".removeOne", function(){
	let foo = $(this);
	swal({
		title: "確認刪除這項商品嗎?",
		text: "",
		icon: "warning",
		buttons: true,
		dangerMode: true,
		buttons: ["取消","確認刪除"],
	})
	.then((willDelete) => {
		if (willDelete) {
			let product_Name = $(this).closest("tr").find(".productName").html();
			let product_ID = $(this).closest("tr").find(".productName").attr("data-product_id");
			let productDetail_ID = $(this).closest("tr").find("option:selected").attr("data-productdetail_id");
			let spc = $(this).closest("tr").find("option:selected").html();
			let quantity = $(this).closest("tr").find(".input_quantity").val();
			let start = $(this).closest("tr").find(".start").html();
			let end = $(this).closest("tr").find(".end").html();
			let index = $(this).closest("tr").find(".productName").attr("data-index");
			let addTime = $(this).closest("tr").find(".productName").attr("data-addTime");
//			console.log(product_Name);
//			console.log(product_ID);
//			console.log(productDetail_ID);
//			console.log(spc);
//			console.log(quantity);
//			console.log(start);
//			console.log(end);
//			console.log(index);
//			console.log(addTime);
			$.ajax({
				// 資料請求的網址
				url: contextPath+"/ProductServlet.do",
				// GET | POST | PUT | DELETE | PATCH
				type: "POST",
				// 傳送資料到指定的 url
				data: {
					"action":"delectOneItem",
					"product_Name":product_Name,
					"product_ID":product_ID,
					"productDetail_ID":productDetail_ID,
					"spc":spc,
					"quantity":quantity,
					"start":start,
					"end":end,
					"index":index,
					"addTime":addTime
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
//					console.log(data);
					
					if(data.reply != "fail to deleted"){
						$(foo).closest("tr").remove();
						prepareCheckout();
						removeFailureArea();
//						if($(".failureItem").length<1){
//							$(".failureArea").remove();
//						}
						noItem();
						swal("您勾選的商品已經被刪除", {
							icon: "success",
							timer: 1000
						});
					}else{
						swal({
							position: 'top-end',
							icon: 'warning',
							title: '噢噢~刪除失敗了，請稍後再試一次',
							showConfirmButton: false,
							timer: 1000
						});
					}
				}
			});
		} else {
			// swal("Your imaginary file is safe!");
		}
	});
});



// 刪除失效商品
$(".removeFailure").on("click", function(){
	if($(".failureItem").length<1){
		return;
	}
	let foo = [];
	let product_Name;
	let product_ID;
	let productDetail_ID;
	let spc;
	let quantity;
	let start;
	let end;
	let index;
	let addTime;
	let jsonArr = [];
	
	$(".failureItem").each(function(index, item){
		foo[index] = $(this);
		product_Name = $(this).closest("tr").find(".productName").html();
		product_ID = $(this).closest("tr").find(".productName").attr("data-product_id");
//		productDetail_ID = $(this).closest("tr").find("option:selected").attr("data-productdetail_id");
//		spc = $(this).closest("tr").find("option:selected").html();
//		quantity = $(this).closest("tr").find(".input_quantity").val();
//		start = $(this).closest("tr").find(".start").html();
//		end = $(this).closest("tr").find(".end").html();
//		index = $(this).closest("tr").find(".productName").attr("data-index");
		addTime = $(this).closest("tr").find(".productName").attr("data-addTime");
		jsonArr[index] = {
			"product_Name":product_Name,
			"product_ID":product_ID,
//			"productDetail_ID":productDetail_ID,
//			"spc":spc,
//			"quantity":quantity,
//			"start":start,
//			"end":end,
//			"index":index,
			"addTime":addTime
		}
	});

//	console.log(product_Name);
//	console.log(product_ID);
//	console.log(productDetail_ID);
//	console.log(spc);
//	console.log(quantity);
//	console.log(start);
//	console.log(end);
//	console.log(index);
//	console.log(addTime);

	$.ajax({
		// 資料請求的網址
		url: contextPath+"/ProductServlet.do",
		// GET | POST | PUT | DELETE | PATCH
		type: "POST",
		// 傳送資料到指定的 url
		data: {
			"action":"removeFailureGoods",
			"jsonArr":JSON.stringify(jsonArr)
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
			
			if(data.reply != "fail to removeFailureGoods"){
				$(".failureItem").remove();
				removeFailureArea();
				noItem();
				swal("失效商品已經全部移除", {
					icon: "success",
					timer: 1000
				});
			}else{
				swal({
					position: 'top-end',
					icon: 'warning',
					title: '噢噢~刪除失敗了，請稍後再試一次',
					showConfirmButton: false,
					timer: 1000
				});
			}
		}
	});
});

//沒有失效商品時移除失效商品區域
function removeFailureArea(){
	if($(".failureItem").length<1){
		$(".failureArea").remove();
		$(".removeFailure").remove();
	}
}

// checkbox全選
$(".selectAll").on("click", function(){
  $(".selectOne").each(function(){
    $(".selectOne").prop("checked", $(".selectAll").prop("checked"))
  });
});

// reverseCheckbox
function reverseCheckbox(){
  if($(".selectOne").length>0){
    if($(".selectOne").length == $(".selectOne:checked").length){
      $(".selectAll").prop("checked", true);
    }else {
      $(".selectAll").prop("checked", false);
    }
  }else {
    $(".selectAll").prop("checked", false);
  }
}

//寄信功能自動填入標題
$(".ask").on("click", function(){
  let productName = $(this).closest("tr").find(".productName").html();
  let product_ID = $(this).closest("tr").find(".productName").attr("data-product_ID");
  $("#write_title").val(product_ID + " 品名:" + productName + "詢問");
  console.log($(this).closest("tr").find(".productName").html());
});



//失效商品的checkbox勾選 > 0608取消失效商品的checkbox
// $(".selectFailureAll").on("click", function(){
//   for(let i=0; i<$(".selectFailureOne").length; i++){
//     $(".selectFailureOne")[i].checked = $(this)[0].checked;
//   }
// });

function addFailureItemDOM(product_ID, product_Name, product_Class, index, addTime){
	let failureItemDOM = `<tr class="failureItem">
		<td></td>
		<td>
		  <div class="img_area">
		    <a href="`+contextPath+`/ProductServlet.do?action=goDetailPage&product_ID=`+product_ID+`&product_Class=`+product_Class+`">
		      <img class="img_Preview" src="`+contextPath+`/DBGifReader2?conditions=`+product_ID+`&whichImg=PRODUCT_IMG1&tName=PRODUCT" alt="">
		    </a>
		  </div>
		</td>
		<td colspan="4"><a class="productName" data-addTime="`+addTime+`" data_index="`+index+`" data-product_ID="`+product_ID+`" href="`+contextPath+`/ProductServlet.do?action=goDetailPage&product_ID=`+product_ID+`&product_Class=`+product_Class+`" style="text-decoration:line-through;">`+product_Name+`</a></td>
		<td>
		  <button class="ask" type="button" name="button" data-toggle="modal" data-target="#exampleModal">
		    <i class="far fa-envelope" style="font-size:1.5em"></i>
		  </button>	
		  <button class="removeOne" type="button" name="button">
		    <i class="fas fa-trash-alt" style="font-size:1.5em"></i>
		  </button>
		</td>
		</tr>`
		
		$(".failureArea").after(failureItemDOM);
}

//空購物車動態產生提示訊息
function noItem(){
  if($(".selectOne").length<1 && $(".failureArea").length<1){
	let pathname = location.pathname;
	let foo = pathname.split("/");
	console.log(foo);
	foo.splice(foo.length-2, 1, "mall");
	foo.splice(foo.length-1, 1, "mall.jsp");
	pathname = foo.join("/");
	console.log(foo);
	console.log(pathname);
	let noItemDOM = `<div class="row noItemCar justify-content-center">
		  <div class="col-12 noItem">
		    <div class="">
		      <i class="fas fa-shopping-cart" style="font-size:200px; color:#5A5A5A;"></i>
		    </div>
		    <div class="">
		      <p>您的購物車目前是空的</p>
		      <p><a href="`+pathname+`">點擊這裡</a>到商城首頁開始選購吧</p>
		    </div>
		  </div>
		</div>`;
    $(".itemTable").after(noItemDOM);
    $(".clearItem").css("display","none");
    $(".checkoutArea").css("display","none");
  }
}
