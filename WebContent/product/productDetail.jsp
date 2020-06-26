<%@page import="com.employee.model.EmployeeVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.employee.model.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="memberService" scope="page" class="com.member.model.MemberService"></jsp:useBean>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/product/css/productDetail.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/product/vendors/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="<%=request.getContextPath()%>/product/vendors/jquery/jquery-3.4.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/product/vendors/bootstrap/js/bootstrap.min.js"></script>
<!--     <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script> -->
    <link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/vendors/css/footer.css">

  </head>
  <body>
  <%@include file="../frontstage_member/pages/header.file" %>

    <div class="container">
      <div class="row justify-content-end">
        <div class="col-md-6">
          <div class="search_area">
        		<input type="text" id="search" placeholder="請輸入商品編號" />
        		<span class="searchIcon"><i class="fa fa-search"></i></span>
        	</div>
        </div>
      </div>
      <div class="row features_card">
        <div class="col-md leftside">
          <div class="img_area">
            <div class="main_img">
              <img src="<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG1&tName=PRODUCT"></img>
            </div>
            <div class="smaller_img">
              <img src="<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG1&tName=PRODUCT"></img>
              <img src="<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG2&tName=PRODUCT"></img>
              <img src="<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG3&tName=PRODUCT"></img>
              <img src="<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG4&tName=PRODUCT"></img>
              <img src="<%=request.getContextPath()%>/DBGifReader2?conditions=${product.product_ID}&whichImg=PRODUCT_IMG5&tName=PRODUCT"></img>
            </div>
            <div>
              <button class="addCollection" type="button" name="button">
                <i class="far fa-heart fa-1x" style="color: #E93F3F; font-size: 1.5em;"></i>加入收藏
              </button>
              <button type="button" name="button" data-toggle="modal" data-target="#exampleModal">
                <i class="far fa-envelope" style="color: #000; font-size: 1.5em;"></i>聯繫客服
              </button>
            </div>
          </div>
        </div>
        <div class="col-md">
          <div>
            <h4 class="product_Name" data-product_ID="${product.product_ID}" data-stayTime="${product.product_Staytime}">${product.product_Name}</h4>
          </div>
          <div class="price_area">
            <h5>售價: 請先選擇查看價錢</h5>
          </div>
          <div class="product_spc">
            <table class="anyOptionArea">
              <!-- 套裝行程、景點、餐廳、住宿 -->
              <input class="product_Class" type="input" name="" value="${param.product_Class}" style="display: none;">

              <!-- <tr>
            　  <td rowspan="1">選項</td>
              　<td><i class="far fa-calendar-alt" style="font-size: 1.5em;"></i></td>
                <td>起始日期</td>
                <td><input  class="inputCalendar" name="timeBefore"></td>
            　</tr>
            　<tr>
                <td></td>
              　<td><i class="far fa-calendar-alt" style="font-size: 1.5em;"></i></td>
                <td>結束日期</td>
                <td><input  class="inputCalendar" name="timeBefore"></td>
            　</tr>
              <tr>
                <td></td>
                <td style="text-align: center;"><i class="fas fa-male" style="font-size: 1.8em;"></i></td>
                <td>人數</td>
                <td><input class="input_quantity" type="number" name="quantity" min="1" value="1"></td>
              </tr> -->
              <!-- <tr>
                <td class="spc">
                  選項
                </td>
                <td>
                  <button class="btn_option" type="button" name="button">
                    選項111
                    <a class="price">1980</a>
                    <a class="stock">1231</a>
                    <a class="PD_ID">PD000001</a>
                  </button>
                  <button class="btn_option" type="button" name="button">
                    選項2222222
                    <a class="price">2680</a>
                    <a class="stock">23</a>
                    <a class="PD_ID">PD000002</a>
                  </button>
                  <button class="btn_option" type="button" name="button">
                    選項33
                    <a class="price">360</a>
                    <a class="stock">56</a>
                    <a class="PD_ID">PD000003</a>
                  </button>
                  <button class="btn_option" type="button" name="button">
                    選項44，庫存0
                    <a class="price">750</a>
                    <a class="stock">0</a>
                    <a class="PD_ID">PD000004</a>
                  </button>
                  <button class="btn_option" type="button" name="button">
                    選項55555
                    <a class="price">399</a>
                    <a class="stock">45</a>
                    <a class="PD_ID">PD000005</a>
                  </button>
                  <button class="btn_option" type="button" name="button">
                    選項6666666666
                    <a class="price">280</a>
                    <a class="stock">93</a>
                    <a class="PD_ID">PD000006</a>
                  </button>
                </td>
              </tr>
              <tr>
                <td>
                  數量
                </td>
                <td>
                  <input class="input_quantity" type="number" value="1" name="quantity" min="1" max="99"></input>
                  <a>剩餘數量: > 99</a>
                </td>
              </tr> -->
            </table>
          </div>
          <div class="row justify-content-center">
            <div class="col-{breakpoint}-auto">
              <form class="" action="ErrorFromLine116" method="post">
                <button class="addCar" type="button">加入購物車</button>
<!--                 <input class="productDetail_ID" type="hidden" name="productDetail_ID" value=""> -->
<!--                 <input class="quantity" type="hidden" name="quantity" value="1"> -->
                <button class="checkout" type="button">立即購買</button>
              </form>
            </div>
          </div>
        </div>
      </div>
      <div class="row introduction_card">

        <!-- <div class="col">
          <h4>商品詳情</h4>
          商品絕對台灣公司貨，絕無仿冒品
          NIKE球衣褲地址：台中市西屯區文心路三段307號
          PUMA商品地址：南投縣草屯鎮太平路二段325號
          我們皆有實體門市,請放心選購
          -----------------------------------
          【購物需知】
          1.建議您，下標前請使用蝦皮聊聊詢問是否有現貨，小幫手收到您的訊息第一時間一定會盡快回覆您，如小幫手忙碌時無法立即回覆，敬請見諒。
          2.永璨體育用品為實體門市，商品皆為全新公司正貨，購買任何商品一律皆開發票，請安心購買。
          3.商品如有問題需做換貨，請在取貨後七天內與客服聯絡，請保持商品完整性(吊牌、贈品、發票要在)，除為商品瑕疵否則皆須由買家負擔來回運費。

          因多平台銷售與實體共用庫存，下單前請先詢問庫存，若下單前未先聊聊詢問，我們可能會請買家取消訂單喔^^
          如若商品標錯價格，此筆訂單便不會生效
        </div> -->

        <!-- <div class="col-md-6">
          <h3>行程特色</h3>
          <hr>
          高屏小琉球三天之旅，跟著領隊騎車環島不孤單
          彈性小琉球自由活動時間，想逛想休假最實在
          彈性選擇參加浮潛或半潛艇活動，或者跟著領隊前往三大風景區
          入住高雄鬧區的康橋九如飯店
          入住小琉球鬧區的琉夏萊飯店
          到台南小吃一條街－國華街大吃特吃
          高雄的哈瑪星鐵道文化
          在棧貳庫體驗高雄港濱景色
          晚上就是要來高雄五分埔後驛商圈敗家，不必出國也可以掌握流行
          迷幻又迷人的，衛武營迷迷村
          全台最大，南部獨家，好吃又好玩的大魯閣草衙道
        </div>
        <div class="col-md-6">
          <div class="img_scheduleLight">
            <img src="" alt="">
          </div>
        </div>

        <div class="col-12">
          <h3>景點介紹</h3>
          <hr>
          原名沙碼基，有「海上公園」之稱。小琉球嶼是由海底珊瑚礁陸升後所形成，
          造就出豐富觀光資源，除珊瑚礁形成的烏鬼洞、美人洞等景觀外；
          海底的世界也非常值得您細細品味唷！包括軟硬珊瑚、熱帶魚纇等，
          非常適合潛水及浮潛（或透過海底玻璃船觀景）。美麗的珊瑚島嶼－小琉球，
          白天黑夜有著不同的度假風情，黃昏彩霞、落日餘輝、坐望星空、踏浪戲水、聽海拾貝、
          遠眺群峰、湛藍之美，誠心邀請你一起來體驗這個仙人的遺足，品味小琉球珊瑚魅力。
        </div>
        <div class="col-md-4" style="padding: 5px;">
          <div class="ref_img">
            <img class="img_smaller_scheduleLight" src="" alt="">
          </div>
        </div>
        <div class="col-md-4" style="padding: 5px;">
          <div class="ref_img">
            <img class="img_smaller_scheduleLight" src="" alt="">
          </div>
        </div>
        <div class="col-md-4" style="padding: 5px;">
          <div class="ref_img">
            <img class="img_smaller_scheduleLight" src="" alt="">
          </div>
        </div>


        <div class="col-12">
          <h3>行程內容</h3>
          <hr>
          <table class="scheduleContent">
            <tr>
              <td>Day1</td>
              <td><i class="fas fa-grip-lines-vertical" style="color: #556FFF; font-size: 1.5em;"></i></td>
              <td>
                06:40台北車站集合→07:00出發→07:30桃園集合點→08:00新竹集合點→
                09:30台中集合點→11:30台南永樂市場國華街→14:30哈瑪星→16:00棧貳庫→
                後驛商圈→康橋大飯店－後驛九如館check in
              </td>
            </tr>
            <tr>
              <td>Day1</td>
              <td><i class="fas fa-grip-lines-vertical" style="color: #556FFF; font-size: 1.5em;"></i></td>
              <td>
                06:40台北車站集合→07:00出發→07:30桃園集合點→08:00新竹集合點→
                09:30台中集合點→11:30台南永樂市場國華街→14:30哈瑪星→16:00棧貳庫→
                後驛商圈→康橋大飯店－後驛九如館check in
              </td>
            </tr>
            <tr>
              <td>Day1</td>
              <td><i class="fas fa-grip-lines-vertical" style="color: #556FFF; font-size: 1.5em;"></i></td>
              <td>
                06:40台北車站集合→07:00出發→07:30桃園集合點→08:00新竹集合點→
                09:30台中集合點→11:30台南永樂市場國華街→14:30哈瑪星→16:00棧貳庫→
                後驛商圈→康橋大飯店－後驛九如館check in
              </td>
            </tr>
          </table>
        </div> -->
      </div>

      <div class="row rating_card">
        <div class="col-md">
          <table>
            <tr>
              <td class="ratiog">
                <p>商品評價</p>
                <p>4/5</p>
                <p>★★★★★</p>
              </td>
              <td class="filter_area">
                <button class="btn_filter -on" type="button" data-filter="all">全部</button>
                <button class="btn_filter" type="button" data-filter="hasImg">附圖評論</button>
                <button class="btn_filter" type="button" data-filter="5">五星(2)</button>
                <button class="btn_filter" type="button" data-filter="4">四星(2)</button>
                <button class="btn_filter" type="button" data-filter="3">三星(2)</button>
                <button class="btn_filter" type="button" data-filter="2">二星(2)</button>
                <button class="btn_filter" type="button" data-filter="1">一星(2)</button>
              </td>
            </tr>
          </table>
        </div>
      </div>
      

<c:forEach items="${productCmtFilted}" var="comment">
	<div class="row comment_card">
		<div class="col-md-2">
	    	<div class="user_info">
		    	<div class="user_img">
	              <img src="<%=request.getContextPath()%>/DBGifReader2?conditions=${comment.member_ID}&tName=MEMBERS" />
	            </div>
 	            <c:forEach items="${memberService.all}" var="member">
 	            	<c:if test="${member.member_ID==comment.member_ID}">
		            	<a>${member.member_Account}</a>
 	            	</c:if>
	            </c:forEach>
	            <a><fmt:formatDate value="${comment.product_Cmt_Timestamp}" type="date" /></a>
	            <a class="score" style="display: none;">${comment.product_Cmt_Grade}</a>
	            <p class="scoreToStar"></p>
			</div>
		</div>
		<div class="col-md-6">
			<a>${comment.product_Cmt_Info}</a>
		</div>
		<div class="col-md-4">
			<div class="comment_img_area">
				<img id="myImg" class="comment_img" src="<%=request.getContextPath()%>/DBGifReader2?conditions=${comment.product_Cmt_ID}&whichImg=PRODUCT_CMT_IMG1&tName=PRODUCT_CMT" />
			</div>
			<div class="comment_img_area">
	        	<img class="comment_img" src="<%=request.getContextPath()%>/DBGifReader2?conditions=${comment.product_Cmt_ID}&whichImg=PRODUCT_CMT_IMG2&tName=PRODUCT_CMT" />
	    	</div>
		</div>
	</div>
</c:forEach>

      <div class="row justify-content-center">
        <div class="col-fluid">
            <div class="pagination">
              <a href="#">&laquo;</a>
              <a href="#">1</a>
              <a class="active" href="#">2</a>
              <a href="#">3</a>
              <a href="#">4</a>
              <a href="#">5</a>
              <a href="#">6</a>
              <a href="#">&raquo;</a>
            </div>
        </div>
      </div>

    </div>

    <!-- 燈箱 -->
    <div id="myModal" class="modal1">
      <span class="close">&times;</span>
      <img class="modal-content" id="img01">
      <div id="caption"></div>
    </div>

<!--     <div class="footer"></div> -->

    <!-- 這邊是下彈視窗 -->
    <% EmployeeService eService = new EmployeeService();
       List<EmployeeVO> list = eService.getAll();
       pageContext.setAttribute("emps", list);
    
    %>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <form method="POST" action="<c:url value="/inbox/WriteMail.Controller" />">
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
                <c:forEach var="emp1" items="${emps }">
                  <option value="${emp1.emp_ID }">${emp1.emp_Name }</option>
                </c:forEach>

              </select>
            </div>
            <div class="form-group">
              <label for="recipient-name" class="col-form-label">標題:</label>
              <input type="text" class="form-control" name="title" id="write_title" value="">
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







    <script src="<%=request.getContextPath()%>/product/js/productDetail.js"></script>
    <script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script type="text/javascript">
 //寫信   
    $(function(){
		$('table').on('click', 'input.checkbox_delete',function(e){
			e.stopImmediatePropagation();
		});
		$('button.writeMail').on('click', function(){
			let name = $('select#write_name').val();
			let title = $('input#write_title').val();
			let message = $('textarea#write_message').val();
			let id = $('input#write_id').val();
			let state = $('input#write_state').val();

			let form_data = {
				"id": id,				//會員ＩＤ
		    	"name": name,			//員工ＩＤ
		    	"title": title,
		    	"message": message,
		    	"state": state
		    };
		    let form_dataString = JSON.stringify(form_data);		//後端接收參數為String type的JSON

			alert('begin ajax');
			$.ajax({
				url: "<%=request.getContextPath()%>/inbox/Inbox.Api",
				type : 'POST',
				contentType:'application/json',
				dataType : 'json',
/* 				data : {											傳送text方式 !基本!
					account: $('input#account').val()
				}, */
				data : form_dataString,
				beforeSend: function(){
					let timerInterval;
					Swal.fire({
					  title: 'Auto close alert!',
					  html: 'I will close in <b></b> milliseconds.',
					  timer: 2000,
					  timerProgressBar: true,
					  onBeforeOpen: () => {
					    Swal.showLoading()
					    timerInterval = setInterval(() => {
					      const content = Swal.getContent()
					      if (content) {
					        const b = content.querySelector('b')
					        if (b) {
					          b.textContent = Swal.getTimerLeft()
					        }
					      }
					    }, 100)
					  },
					  onClose: () => {
					    clearInterval(timerInterval)
					  }
					}).then((result) => {
					  /* Read more about handling dismissals below */
					  if (result.dismiss === Swal.DismissReason.timer) {
					    console.log('I was closed by the timer')
					  }
					})
				},
				success: function(res){
					console.log(res);
					if(res.result === 'OK'){
						Swal.fire({
							  icon: 'success',
							  title: '成功',
							  text: res.resultDetail,
							})
						/* $('select#write_name').val(""); */
						$('input#write_title').val("");
						$('textarea#write_message').val("");

					}else{
						let error = "";
/* 						for(var prop in res.resultDetail){
							error.push(res.resultDetail[prop])
						} */
						$.each(res.resultDetail, function(index, value){
							error += value +"\n";
						});
						console.log(error);
						Swal.fire({
							  icon: 'error',
							  title: '失敗',
							  html: '<pre class="text-danger text-uppercase font-weight-bold">' + error + '</pre>',
							});
					}
					
				}
				
			});
		});
	});
 //加入收藏或取消收藏
$(document).on("click", ".addCollection", function(e){
	e.stopPropagation();
	let btn_Heart = $(this);
	let product_ID = $(".product_Name").attr("data-product_ID");
	let product_Class = $('.product_Class').val();
	let location ='<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID='+product_ID+"&product_Class="+product_Class;
	console.log(product_ID + location);
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
		timeout: 3000,
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
    
    let typeFood = `<tr>
        <td class="spc">
     	     選項
        </td>
        <td>
<c:forEach items="${oneProductDetailInfo}" var="pdInfo">
	<button class="btn_option" type="button" name="button"  data-price="${pdInfo.product_Detail_Money}" data-stock="${pdInfo.product_Detail_Instock}" data-PD_ID="${pdInfo.product_Detail_ID}" >${pdInfo.product_Detail_Spc}</button>
</c:forEach>
        </td>
      </tr>
      <tr>
        <td>
        數量
        </td>
        <td>
          <input class="input_quantity" type="number" value="1" name="quantity" min="1" max="99"></input>
          <a>剩餘數量: > 99</a>
        </td>
      </tr>`;

      let typeTravel=`<tr>
      　<td class="spc" rowspan="1">選項</td>
      　<td><i class="far fa-calendar-alt" style="font-size: 1.5em;"></i></td>
        <td class="col3">起始日期</td>
        <td><input class="inputCalendar start" name=""></td>
      </tr>
      <tr>
        <td></td>
      　<td><i class="far fa-calendar-alt" style="font-size: 1.5em;"></i></td>
        <td class="col3">結束日期</td>
        <td><input class="inputCalendar end" name=""></td>
      </tr>
      <tr>
        <td></td>
        <td style="text-align: center;"><i class="fas fa-location-arrow" style="font-size: 1.2em;"></i></td>
        <td class="col3">細項</td>
        <td>
<c:forEach items="${oneProductDetailInfo}" var="pdInfo">
	<button class="btn_option" type="button" name="button" data-price="${pdInfo.product_Detail_Money}" data-stock="${pdInfo.product_Detail_Instock}" data-PD_ID="${pdInfo.product_Detail_ID}" >${pdInfo.product_Detail_Spc}</button>
</c:forEach>
        </td>
      </tr>
      <tr>
        <td></td>
        <td style="text-align: center;"></td>
        <td class="col3">數量</td>
        <td><input class="input_quantity" type="number" name="quantity" min="1" value="1">
          <a>剩餘數量: > 99</a>
        </td>
      </tr>`;



      let typeHotel=`<tr>
      　<td class="spc" rowspan="1">選項</td>
      　<td><i class="far fa-calendar-alt" style="font-size: 1.5em;"></i></td>
        <td class="col3">入住日期</td>
        <td><input class="inputCalendar start" name=""></td>
      </tr>
      <tr>
        <td></td>
      　<td><i class="far fa-calendar-alt" style="font-size: 1.5em;"></i></td>
        <td class="col3">退房日期</td>
        <td><input class="inputCalendar end" name=""></td>
      </tr>
      <tr>
        <td></td>
        <td style="text-align: center;"><i class="fas fa-bed" style="font-size: 1.2em;"></i></td>
        <td class="col3">房型</td>
        <td>
<c:forEach items="${oneProductDetailInfo}" var="pdInfo">
	<button class="btn_option" type="button" name="button" data-price="${pdInfo.product_Detail_Money}" data-stock="${pdInfo.product_Detail_Instock}" data-PD_ID="${pdInfo.product_Detail_ID}" >${pdInfo.product_Detail_Spc}</button>
</c:forEach>          
        </td>
      </tr>
      <tr>
        <td></td>
        <td style="text-align: center;"><i class="fas fa-home" style="font-size: 1.4em;"></i></td>
        <td class="col3">房間數</td>
        <td><input class="input_quantity" type="number" name="quantity" min="1" value="1">
          <a>剩餘數量: > 99</a>
        </td>
      </tr>`;

      let normalProduct = `<div class="col descript">
        <h4>商品詳情</h4>
        <a>${product.product_Info}</a>

      </div>`;

      let travelSet = `<div class="col-md-6">
                <h3>行程特色: product_Intro</h3>
                <hr>
                ${product.product_Intro}

              </div>
              <div class="col-md-6">
                <div class="img_scheduleLight">
                  <img src="" alt="">
                </div>
              </div>

              <div class="col-12">
                <h3>景點介紹: product_Info</h3>
                <hr>
                ${product.product_Info}
              </div>
              <div class="col-md-4" style="padding: 5px;">
                <div class="ref_img">
                  <img class="img_smaller_scheduleLight" src="" alt="">
                </div>
              </div>
              <div class="col-md-4" style="padding: 5px;">
                <div class="ref_img">
                  <img class="img_smaller_scheduleLight" src="" alt="">
                </div>
              </div>
              <div class="col-md-4" style="padding: 5px;">
                <div class="ref_img">
                  <img class="img_smaller_scheduleLight" src="" alt="">
                </div>
              </div>


              <div class="col-12">
                <h3>行程內容: product_Total_Schedule</h3>
                <hr>

                <table class="scheduleContent">
<c:forEach items="${scheduleArr}" var="schedule" varStatus="foo">
	<tr>
		<td>Day${foo.count}</td>
		<td><i class="fas fa-grip-lines-vertical" style="color: #556FFF; font-size: 1.5em;"></i></td>
		<td>${schedule}</td>
	</tr>
</c:forEach>
                </table>
              </div>`;
    </script>


  </body>
</html>
