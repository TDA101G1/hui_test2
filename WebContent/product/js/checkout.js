const contextPath = "/"+location.pathname.split("/")[1];
const contextPath_fileName= contextPath+"/"+location.pathname.split("/")[2];
const checkoutInfo = sessionStorage.getItem("checkoutInfo");

$(window).on("load", function(){
  checkSessionStorage();
  getCheckoutInfo();
  subtotal();
  tottleAmount();
  creditCardReplace();
});

//檢查sessionStorage是否有需要的資訊，如果沒有就導向失效頁面
function checkSessionStorage(){
	if(checkoutInfo == null){
		window.location.href = contextPath_fileName+"/shoppingCar.jsp"
	}
}



//信用卡隱碼以及分隔符
function creditCardReplace(){
	$(".cardNumber").each(function(){
		let origin = $(this).attr("data-cardnumber");
		let foo = origin.substring(0,4)+"-xxxx-xxxx-"+origin.slice(-4);
		$(this).html(foo);
	});
}

//建立訂單
$(".btn_order").on("click", function(){
	if($(".radioCreditCard:checked").length < 1){
		swal({
			position: 'top-end',
			icon: 'warning',
			title: '請先確認付款資訊',
			showConfirmButton: false,
			timer: 1000
		});
		return;
	}
	sessionStorage.removeItem("checkoutInfo");
	$(".btn_order").html(`處理中請稍後<i class="fas fa-spinner fa-spin fa-1x"></i>`);
	$(".btn_order").attr("disabled","disabled");
	
//	let checkoutInfo = sessionStorage.getItem("checkoutInfo");
	let payment = $(".-on").html();
	let couponID = $(".radioCoupon:checked").closest("tr").attr("data-coupon_id");
	$.ajax({
		// 資料請求的網址
		url: contextPath+"/ProductServlet.do",
	    // GET | POST | PUT | DELETE | PATCH
	    type: "POST",
	    // 傳送資料到指定的 url
	    data: {
	      "action":"checkout",
	      "payment":payment,
	      "couponID":couponID,
	      "checkoutInfo":checkoutInfo
	    },
	    // 預期會接收到回傳資料的格式： json | xml | html
	    dataType: "json",
	    // request 可等待的毫秒數 | 0 代表不設定 timeout
	    timeout: 3000,
	    // 在 request 發送之前執行
	    beforeSend: function() {
//	    	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
	    },
	    // request 成功取得回應後執行
	    success: function(data) {
	    	console.log(data);
	    	if(data.reply == "success"){
	    		
	    		window.location.href = contextPath_fileName+"/successPay.jsp";
	    		
	    		
	    	}else{
	    		swal({
	    		    position: 'top-end',
	    		    icon: 'error',
	    		    title: '購物車資料比對失敗，請聯絡客服人員，或請稍後再試一次',
	    		    text: "我們即將為您返回到購物車頁面",
	    		    showConfirmButton: false,
	    		    timer: 8000
	    		})
	    		.then((willDelete) => {
	    		    window.location.href = contextPath_fileName+"/shoppingCar.jsp";
	    		});
	    	}
		}
	});
});


//計算每個商品的小計
function subtotal(){
  $(".orderOne").each(function(){
    let price = $(this).find(".price").html();
    let quantity = $(this).find(".quantity").html();
    $(this).next("tr").find(".span_subtotal").html(price * quantity);
    $(this).next("tr").find(".span_quantity").html(quantity);
  });
}

//計算應付金額
function tottleAmount(){
  let tottleAmount = 0;
  $(".orderOne").each(function(){
    let price = $(this).find(".price").html();
    let quantity = $(this).find(".quantity").html();
    $(this).find(".subtotal").html(price * quantity);
    tottleAmount += price * quantity;
  });

  $(".tottleAmount").html(tottleAmount);
  $(".shouldPay").html(tottleAmount);
}


//讀取購物車放在sessionStorage的資料
function getCheckoutInfo(){
  let goods = JSON.parse(checkoutInfo)
  $(goods).each(function(){
    let good = $(this)[0];
//    console.log(good);
    orderOneDOM(good.product_Name, good.product_ID, good.productDetail_ID, good.spc, good.price, good.quantity, good.start, good.end);
  });
}



//付款方式按鈕樣式切換
$(".btn_payments").on("click", function(){
  $(".-on").toggleClass("-on");
  $(this).toggleClass("-on");
});

//選擇使用信用卡付款時動態產生相關頁面
$(".credicard").on("click", function(){
  // $(".choiceAccount").html(credicard);
  $(".creditCard").css("display", "block")
});
//選擇使用銀行轉帳時動態產生相關頁面
$(".transfer").on("click", function(){
  // $(".choiceAccount").html("");
});
//選擇使用手機支付時動態產生相關頁面
$(".mobilePay").on("click", function(){
  // $(".choiceAccount").html("");
  $(".creditCard").css("display", "none")
});



// 燈箱==============================================
let modal = document.getElementById('myModal');
let modalImg = document.getElementById("img01");
let captionText = document.getElementById("caption");
$(".choiceCoupon").on("click", function(){
  modal.style.display = "block";
});

$(".box").click(function(e){
	e.stopPropagation();
})

$(".modal").click(function(){
  modal.style.display = "none";
  $(".couponDetail").css("display","none");
});

$(".cancel").click(function(){
  modal.style.display = "none";
  $(".couponDetail").css("display","none");
});

$(".btn_GoBack").on("click", function(e){
  e.stopPropagation();
  $(".couponDetail").css("display","none");
});

//顯示優惠券使用詳情
$(".callDetail").on("click", function(e){
  $(".couponDetail").css("display","block");
  $(".couponInfo").html($(this).closest("tr").attr("data-coupon_Info"));
  $(".couponName a").html($(this).closest("tr").find(".couponTittle").html());
});

$(".couponDetail").click(function(e){
  e.stopPropagation();
});

//計算應付金額(含打折後)
$(".confirm").on("click", function(){
  console.log($("input.radioCoupon:checked").next("a").html());
  if($("input.radioCoupon:checked").length>0){
    $(".selectedCoupon").html("已選取: "+$("input.radioCoupon:checked").next("a").html());
    let discount = $("input.radioCoupon:checked").attr("data-discount")
    $(".discount").html(Math.ceil($(".tottleAmount").html()-$(".tottleAmount").html()*discount));
    $(".shouldPay").html($(".tottleAmount").html()-$(".discount").html());
  }
  modal.style.display = "none";
});

$(window).on("keyup", function(e){
  // console.log("鍵盤對應的ASCII: " + e.which);
  if (e.which == 27 && $(".couponDetail").css("display")=="block") {
    $(".couponDetail").css("display","none");
  }else if (e.which == 27 && $(".couponDetail").css("display")=="none") {
    modal.style.display = "none";
  }
});

// 燈箱2==============================================
let modal1 = document.getElementById('myModal1');
$(document).on("click", ".addCreditcard", function(){
  modal1.style.display = "block";
});

$(".box").click(function(e){
	e.stopPropagation();
})

$(".modal1").click(function(){
  modal1.style.display = "none";
});

$(".cancel").click(function(){
  modal1.style.display = "none";
  $(".couponDetail").css("display","none");
});

$(window).on("keyup", function(e){
  // console.log("鍵盤對應的ASCII: " + e.which);
  if (e.which == 27) {
    modal1.style.display = "none";
  }
});

//註冊新增信用卡
$(".registerCreditcard").on("click", function(){


});



//自動切換信用卡icon
$(".btn_payments").on("click", function(){
  $(".cardNumber").each(function(){
    let str = $(this).html();
    if(str.indexOf(5) == 0){
      $(this).prev("i").attr("class","fab fa-cc-mastercard");
    }else if (str.indexOf(3) == 0) {
      $(this).prev("i").attr("class","fab fa-cc-jcb");
    }else {
      $(this).prev("i").attr("class","fab fa-cc-visa");
    }
  });
});


let credicard =`<div class="col-12 col-md-3">
  選擇付款帳戶
  <br><i>(要先拿到用戶資料再select出來)</i>
</div>
<div class="col-12 col-md-9">
  <div class="">
    <label>
      <input type="radio" name="1" value=""><i class="fab fa-cc-visa" style="font-size: 2em;"></i>
      <a class="cardNumber">4xxx-xxxx-xxxx-xxxx</a>
    </label>
  </div>
  <div class="">
    <label>
      <input type="radio" name="1" value=""><i class="fab fa-cc-mastercard" style="font-size: 2em;"></i>
      <a class="cardNumber">5xxx-xxxx-xxxx-xxxx</a>
    </label>
  </div>
  <div class="">
    <label>
      <input type="radio" name="1" value=""><i class="fab fa-cc-jcb" style="font-size: 2em;"></i>
      <a class="cardNumber">3xxx-xxxx-xxxx-xxxx</a>
    </label>
  </div>
  <div class="">
    <button class="addCreditcard" type="button" name="button">++使用新信用卡付款</button>
  </div>
</div>`



function orderOneDOM(product_Name, product_ID, productDetail_ID, spc, price, quantity, start, end){
  let contextPath = location.pathname.split("/")[1];
  let foo = `<tr class="orderOne" data-product_ID="`+product_ID+`" data-productDetail_ID="`+productDetail_ID+`">
    <td rowspan="2" class="" style="box-shadow: 0px 3px 0px 0px #cccccc;">
      <div class="previewImg">
        <img src="/`+contextPath+`/DBGifReader2?conditions=`+product_ID+`&whichImg=PRODUCT_IMG1&tName=PRODUCT" alt="">
      </div>
    </td>
    <td class="">
      <p class="">`+product_Name+`</p>
      <p class="">`+spc+`</p>
    </td>
    <td>
      <p class="">`+start+`</p>
      <p class="">`+end+`</p>
    </td>
    <td class="price">`+price+`</td>
    <td class="quantity">`+quantity+`</td>
  </tr>
  <tr>
    <td colspan="4" class="subtotalAgain">
      <hr>
      訂單金額(<span class="span_quantity"></span>個商品)
      NT:<span class="span_subtotal"></span>
    </td>
  </tr>`
  $("table").first().append(foo)
}
