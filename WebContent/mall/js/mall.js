// $(window).on("load", function(){
//   getRatingPriceRange();
// });
//
// function getRatingPriceRange(){
//   let foo = [];
//   $(".card").each(function(index, item){
//     foo[index] = $(this).attr("data-product_ID")
//   });
//   $.ajax({
//   // 資料請求的網址
//     url: "http://localhost:8081/TDA101G1/ProductServlet.do",
//     // GET | POST | PUT | DELETE | PATCH
//     type: "POST",
//     // 傳送資料到指定的 url
//     data: {
//       "action":"getRating",
//       "product_ID":JSON.stringify(foo)
//     },
//     // 預期會接收到回傳資料的格式： json | xml | html
//     dataType: "json",
//     // request 可等待的毫秒數 | 0 代表不設定 timeout
//     timeout: 3000,
//     // 在 request 發送之前執行
//     beforeSend: function() {
//     //	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
//     },
//     // request 成功取得回應後執行
//     success: function(data) {
//       console.log(data);
//       $(".rating").each(function(){
//         let product_ID = $(this).closest(".card").attr("data-product_ID");
//         $(this).attr("data-score",(data.rating[product_ID]));
//       });
//       loadStar();
//     }
//   });
//
//   $.ajax({
//   // 資料請求的網址
//     url: "http://localhost:8081/TDA101G1/ProductServlet.do",
//     // GET | POST | PUT | DELETE | PATCH
//     type: "POST",
//     // 傳送資料到指定的 url
//     data: {
//       "action":"getPriceRange",
//       "product_ID":JSON.stringify(foo)
//     },
//     // 預期會接收到回傳資料的格式： json | xml | html
//     dataType: "json",
//     // request 可等待的毫秒數 | 0 代表不設定 timeout
//     timeout: 3000,
//     // 在 request 發送之前執行
//     beforeSend: function() {
//     //	$("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
//     },
//
//     // request 成功取得回應後執行
//     success: function(data) {
//       console.log(data);
//     $(".price").each(function(){
//         let product_ID = $(this).closest(".card").attr("data-product_ID");
//         $(this).children("span").html(data.priceRange[product_ID]);
//       });
//     }
//   });
// }
//
//
// function loadStar(){
// $(".rating").each(function(index, item){
// 	let score = $(this).attr("data-score");
// 	let star = "";
// 	let count = 0;
// 	for(score; score>0; score--){
// 		if(score-1<0){
// 			star += `<i class="fas fa-star-half-alt" style="color:#FFDD26;"></i>`
// 			score--;
// 			count++;
// 		}else{
// 			star += `<i class="fas fa-star" style="color:#FFDD26;"></i>`;
// 			count++;
// 		}
// 	}
// 	let i = 5-count;
// 	for(i; i>0; i--){
// 		star += `<i class="far fa-star" style="color:#FFDD26;"></i>`;
// 	}
// 	$(this).html(star);
// });
// }
