<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.member.model.MemberService"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:useBean id="JedisShoppingCar" scope="page" class="com.product.controller.JedisShoppingCar"></jsp:useBean>
<jsp:useBean id="ProductDetailService" scope="page" class="com.product.model.ProductDetailService"></jsp:useBean>

<html lang="en" dir="ltr">
  <head>
    <meta charset="UTF-8">
    <title>購物車</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/product/css/shoppingCar.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/product/vendors/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="<%=request.getContextPath()%>/product/vendors/jquery/jquery-3.4.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/product/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/vendors/css/footer.css">
  </head>
  <body>
	<%@include file="../frontstage_member/pages/header.file" %>
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <div class="search_area">
            <h3><i class="fas fa-shopping-cart" style="font-size:2em"></i>購物車</h3>
        	</div>
        </div>
        <div class="col-md-6">
          <div class="search_area">
        		<input type="text" id="search" placeholder="請輸入商品編號" />
        		<span class="searchIcon"><i class="fa fa-search"></i></span>
        	</div>
        </div>
      </div>

      <!-- 搜尋用戶在redis的購物車再比對oracle商品資料，
      動態產生商品選項及庫存數量，
      若原加入購物車時的數量超過商品庫存量則覆寫回來
      若原加入購物車時的商品選項已經不存在則表示物品失效 -->
      <div class="row itemTable justify-content-center">
        <div class="col-12 shoppingCar">
          <table>
            <!-- =======================標題欄======================= -->
            <tr>
              <th style="width: 30px;"><input class="selectAll" type="checkbox" name="" value=""></th>
              <th style="width: 160px;">預覽圖</th>
              <th style="width: 120px;">商品名稱/選項</th>
              <th style="width: 100px;">日期</th>
              <th style="width: 140px;">單價/數量</th>
              <th style="width: 80px;">小計</th>
              <th style="width: 40px;">操作</th>
            </tr>


            <!-- =======================商品======================= -->
<c:forEach items="${JedisShoppingCar.getMemberCar(member.member_ID)}" var="productVO">
	<c:if test="${productVO.product_State == 1}">
            <tr class="oneProduct">
              <td><input class="selectOne" type="checkbox" name="goods" value="1"></td>
              <td>
                <div class="img_area">
                  <a href="<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID=${productVO.product_ID}&product_Class=${productVO.product_Class}">
                    <img class="img_Preview" src="<%=request.getContextPath()%>/DBGifReader2?conditions=${productVO.product_ID}&whichImg=PRODUCT_IMG1&tName=PRODUCT" alt="">
                  </a>
                </div>
              </td>
              <td>
                <a class="productName" data-addTime="" data-index="" data-product_ID="${productVO.product_ID}" data-product_Class="${productVO.product_Class}" href="<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID=${productVO.product_ID}&product_Class=${productVO.product_Class}">${productVO.product_Name}</a>
                <div class="spc">
                  <select name="">
	<c:forEach items="${ProductDetailService.all}" var="pdVO">
		<c:if test="${pdVO.product_ID==productVO.product_ID}">
			<option id="${pdVO.product_Detail_ID}" value="" data-productDetail_ID="${pdVO.product_Detail_ID}" data-price="${pdVO.product_Detail_Money}" data-instock="${pdVO.product_Detail_Instock}">${pdVO.product_Detail_Spc}</option>
		</c:if>
	</c:forEach>
                  </select>
                </div>
              </td>
              <td>
                <p class="start">2020-06</p>
                <p class="end">2020-06</p>
              </td>
              <td class="price">
                <p>98800</p>
                <div class="quantity">
                  <input class="input_quantity" type="number" name="" value="1" min="1" max="">
                  <i>庫存20</i>
                </div>
              </td>
              <td class="subtotal"></td>
              <td>
                <button class="ask" type="button" name="button" data-toggle="modal" data-target="#exampleModal">
                  <i class="far fa-envelope" style="font-size:1.5em;"></i>
                </button>
                <button class="removeOne" type="button" name="button">
                  <i class="fas fa-trash-alt" style="font-size:1.5em;"></i>
                </button>
              </td>
            </tr>
	</c:if>
</c:forEach>

            <!-- ========================失效商品==================== -->
            <tr class="failureArea">
              <th></th>
              <!-- <th style="width: 6%;"><input class="selectFailureAll" type="checkbox" name="" value=""></th> -->
              <th>預覽圖</th>
              <th colspan="4">失效商品 (請重新加入購物車)</th>
              <th>操作</th>
            </tr>

<!--             <tr class="failureItem"> -->
<!--               <td></td> -->
<!--               <td> -->
<!--                 <div class="img_area"> -->
<!--                   <a href="#"><img class="img_Preview" src="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRlHYMzh5mYwX_ag7DrgR2NrWYb8PGvDd2gkM2OW4AoO2VDVmbY&usqp=CAU" alt=""></a> -->
<!--                 </div> -->
<!--               </td> -->
<!--               <td colspan="4"><a class="productName" data-product_ID="PID000001" href="#">231231321231132</a></td> -->
<!--               <td> -->
<!--                 <button class="ask" type="button" name="button" data-toggle="modal" data-target="#exampleModal"> -->
<!--                   <i class="far fa-envelope" style="font-size:1.5em"></i> -->
<!--                 </button> -->
<!--                 <button class="removeOne" type="button" name="button"> -->
<!--                   <i class="fas fa-trash-alt" style="font-size:1.5em"></i> -->
<!--                 </button> -->
<!--               </td> -->
<!--             </tr> -->
          </table>
        </div>
      </div>

      <div class="row clearItem justify-content-center">
        <div class="col">
          <div class="removeArea">
            <button class="removeSelect" type="button" name="button">刪除勾選的商品</button>
            <button class="removeFailure" type="button" name="button">清除全部失效商品</button>
            <hr>
          </div>
        </div>
      </div>
      <div class="row checkoutArea justify-content-end">
        <div class="col-md-4">
          <div class="">
            <a>購買(</a>
            <a class="sumQuantity"></a>
            <a>)個商品</a>
            <a>，總計$ </a>
            <a class="sumPrice"></a>
          </div>
        </div>
        <div class="col-md-2">
          <div class="">
          	<form action="<%=request.getContextPath()%>/ProductServlet.do" method="post">
          		<input type="hidden" name="action" value="goCheckout">
          		<input class="goods" type="hidden" name="goods" value="">
          		<input class="checkout" type="submit" name="" value="確認結帳">
          	</form>
<!--             <button class="checkout" type="button" name="button">確認結帳1</button> -->
            <hr>
          </div>
        </div>
      </div>

      </div>
    </div>




    <!-- 這邊是下彈視窗 -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <form method="POST" action="<c:url value=" /inbox/WriteMail.Controller" />">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">新增信件</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <!--            <div class="form-group">
                  <label for="recipient-name" class="col-form-label">收件者:</label>
                  <input type="text" class="form-control" name="receiver" id="write_name">
                  <input type="text" class="form-control" name="emp_ID" id="write_name">
                </div> -->
            <div class="form-group">
              <label for="write_name" class="col-form-label">收件者:</label>
              <select class="form-control" name="receiver" id="write_name">
                <c:forEach var="emp1" items="${empService.all }">
                  <option value="${emp1.emp_ID }">${emp1.emp_Name }</option>
                </c:forEach>

              </select>
            </div>
            <div class="form-group">
              <label for="recipient-name" class="col-form-label">標題:</label>
              <input type="text" class="form-control" name="title" id="write_title" value="" readonly>
            </div>
            <div class="form-group">
              <label for="message-text" class="col-form-label">內容:</label>
              <textarea class="form-control" rows="10" name="message" id="write_message"></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            <input type="hidden" name="state" id="write_state" value="1">
            <input type="hidden" id="write_id" value="${member.member_ID }">
            <button type="submit" name="action" value="writeMail" class="btn btn-primary">送出</button>
            <button class="writeMail btn btn-primary" type="button">送出Ajax</button>
          </div>
          </form>
        </div>
      </div>
    </div>
	<%@include file="../frontstage_member/pages/footer.file" %>
    <script src="<%=request.getContextPath()%>/product/js/shoppingCar.js"></script>
    <script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>
    <script type="text/javascript">
    	$(window).on("load", function(){
    		getMemberSelected();
    	});   
    
    	function getMemberSelected(){
    		let memberID = "${member.member_ID}";
    		$.ajax({
    		  // 資料請求的網址
    			url: "<%=request.getContextPath()%>/ProductServlet.do",
    		    // GET | POST | PUT | DELETE | PATCH
    		    type: "POST",
    		    // 傳送資料到指定的 url
    		    data: {
    		      "action":"getMemberSelected",
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
//     		    	console.log(data);
					let failure = [];
    		    	$(data).each(function(index, item){
    		    		let product_Name = $(this)[0].product_Name;
    		    		let product_ID = $(this)[0].product_ID;
    		    		let productDetail_ID = $(this)[0].productDetail_ID;
    		    		let spc = $(this)[0].spc;
    		    		let quantity = $(this)[0].quantity;
    		    		let start = $(this)[0].start;
    		    		let end = $(this)[0].end;
    		    		let price = $(this)[0].price;
    		    		let addTime = $(this)[0].addTime;
	    		    	
	    		    	let oneProduct = $(".oneProduct")[index];
// 	    		    	console.log(oneProduct);
	    		    	$(oneProduct).find("option").each(function(){
	    		    		if($(this).attr("id") == productDetail_ID){
	    		    			if($(this).html() == spc && $(this).attr("data-price") == price){
	    		    				$(this).attr("selected", "true");
	    		    			}else{
	    		    				console.log("產品失效0");
	    		    				console.log("失效的產品規格: "+productDetail_ID+spc+" 售價:"+price);
		    		    			console.log($(this).attr("data-price"));
		    		    			addFailureItemDOM(product_ID, product_Name, $(oneProduct).find(".productName").attr("data-product_Class"), index, addTime);
		    		    			failure.push(oneProduct);
	    		    			}
	    		    		}
	    		    	});
	    		    	if(product_Name != $(oneProduct).find(".productName").html()){
	    		    		console.log("產品失效1");
	    		    		console.log($(oneProduct).find(".productName").html());
	    		    		console.log(product_Name);
	    		    		addFailureItemDOM(product_ID, product_Name, $(oneProduct).find(".productName").attr("data-product_Class"), index, addTime);
	    		    		failure.push(oneProduct);
	    		    	}
	    		    	
	    		    	if(new Date(start).getTime() < new Date().getTime()-1*60*60*24*1000 || new Date(end).getTime() < new Date().getTime()){
	    		    		console.log("產品失效2");
	    		    		console.log("start: " + new Date(start).getTime());
	    		    		console.log("昨天: " + new Date().getTime()-1*60*60*24*1000);
	    		    		console.log("end: " + new Date(end).getTime());
	    		    		console.log("今天: " + new Date().getTime());
	    		    		addFailureItemDOM(product_ID, product_Name, $(oneProduct).find(".productName").attr("data-product_Class"), index, addTime);
	    		    		failure.push(oneProduct);
	    		    	}
	    		    	
	    		    	$(oneProduct).find(".start").html(start);
	    		    	$(oneProduct).find(".end").html(end);
	    		    	$(oneProduct).find(".productName").attr("data-addTime", addTime);
	    		    	$(oneProduct).find(".productName").attr("data-index", index);
	    		    	$(oneProduct).find(".input_quantity").val(quantity);
	    		    	changeOption();
	    		    	subtotal();
    		    	});
    		    	
    		    	//處理失效產品
//     		    	console.log(failure);
    		    	$(failure).each(function(){
    		    		$(this).remove();
    		    	});
	    		    removeFailureArea();
	    		    changeOption();
	    		    subtotal();
	    		    checkStock();
	    		    $(".selectAll").click();
	    		    noItem();
    			}
    		});
    	}
    	
    </script>
  </body>
</html>
