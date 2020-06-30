<%@page import="java.text.DecimalFormat"%>
<%@page import="com.productcmt.model.ProductCmtVO"%>
<%@page import="com.productcmt.model.ProductCmtService"%>
<%@page import="com.product.model.ProductDetailVO"%>
<%@page import="com.product.model.ProductDetailService"%>
<%@page import="com.product.model.ProductService"%>
<%@page import="com.product.model.ProductVO"%>
<%@page import="com.collection.model.CollectionVO"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.collection.model.CollectionService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/css/footer.css">
<style type="text/css">
body {
  font-size: 16px;
  font-family: Microsoft JhengHei;
  color: #343434;
  background-color: #F5F5F5;
}
body nav.bg-dark {
  /* background-color: #707070 !important; */
  background: -webkit-linear-gradient(#E0DFDF,#F5F5F5);
  background: -o-linear-gradient(#E0DFDF,#F5F5F5);
  background: -moz-linear-gradient(#E0DFDF,#F5F5F5);
  background: linear-gradient(#E0DFDF,#F5F5F5);
}
div.card {
  border: solid 1px #31C7D2;
  -webkit-mask-image: -webkit-radial-gradient(circle, white 100%, black 100%);
}
.card-title a{
  color: #343434;
}
.-none {
	display: none;
}
div.sidebar a.nav-link:hover{
	background-color: #007bff;
	color: #fff;
}
div.main_content{
	max-height: 600px;
	overflow: scroll;
}
</style>
<title>Insert title here</title>

</head>
<body>
<%
//取得當天登入會員ID

	MemberVO member = (MemberVO) session.getAttribute("member");
	String member_ID = null;
	if(member != null){
		member_ID = member.getMember_ID();
	}else{
		request.getRequestDispatcher("/frontstage_member/login2.jsp").forward(request, response);
		return;
	}
//取得所有某一個會員的collection
	CollectionService service = new CollectionService();
	Set<CollectionVO> collections = service.getCollectionByMemberID(member_ID);
	pageContext.setAttribute("collections", collections);
//找出collection中的所有product
	ProductService pService = new ProductService();
	List<ProductVO>products = new ArrayList<ProductVO>();
	for(CollectionVO collection : collections){
		ProductVO product = new ProductVO();
		product.setProduct_ID(collection.getProduct_ID());
		products.add(pService.select(product));
	}
//移除所有套裝行程收藏	
  	products.removeIf(ProductVO -> ProductVO.getProduct_State().equals(0));
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
	
//產生MAP key=productID  value = 評價等級
	List<ProductCmtVO>productCmtList = new ProductCmtService().getAll();
	Map<String, String>gradeMap = new HashMap<String, String>();
	for(int i = 0; i < products.size(); i++){
		String product_ID = products.get(i).getProduct_ID();
		OptionalDouble result = productCmtList.stream()
				.filter(p -> p.getProduct_ID().equals(product_ID))
				.mapToDouble(p -> p.getProduct_Cmt_Grade())
				.average();
		if(result.isPresent()){
			DecimalFormat df = new DecimalFormat("0.0");
			String rating = df.format((result.getAsDouble()));
			gradeMap.put(product_ID, rating);
		}else{
			gradeMap.put(product_ID, "(尚未有評價)");
		}
	}
	
	pageContext.setAttribute("gradeMap", gradeMap);
/* 	out.print(gradeMap);*/
 %>

<%-- 	<nav
		class="navbar navbar-expand navbar-light d-flex justify-content-start"
		style="background-color: #e3f2fd;">
		<a class="navbar-brand mr-auto" href="#"> <img
			src="<%=request.getContextPath()%>/img/david_img/logo.png" width="30"
			height="30" class="d-inline-block align-top" alt="tourism">
			Tourism
		</a>
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-pen"></i>建立行程</a></li>
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-store"></i>商城</a></li>
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-shopping-cart"></i>購物車</a></li>
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-sign-in-alt"></i>會員中心</a></li>
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fas fa-user"></i>USER</a></li>
		</ul>
	</nav> --%>
	<%@ include file="../pages/header.file" %>
	<div class="container mt-sm-4">
		<div class="row mb-5">

			<%-- <div class="sidebar col-lg-2 col-md-3 col-sm-4">
				<nav class="nav nav-pills flex-column">
					<div class="d-none d-sm-block nav-link text-center" href="#"> <img
						src="<%=request.getContextPath()%>/member/ShowMemberImage?id=${sessionScope.member.member_ID}"
						class="img-fluid align-top " alt="tourism"> Hi
						${member.member_Name }
					</div> 
					<a class="nav-link" href="#">個人中心</a> 
					<a class="nav-link" href="#">管理訂單</a>
					<a class="nav-link" href="#">我的行程</a> 
					<a class="nav-link" href="#">管理票券</a>
					<a class="nav-link" href="#">我的信箱</a> 
					<a class="nav-link" href="#">我的購物車</a> 
					<a class="nav-link" href="#">我的評價</a> 
					<a class="nav-link active" href="#">我的收藏</a>
				</nav>
			</div> --%>
			<%@include file="../pages/sidebar_member.file" %>
			<div class="content col-lg-10 col-md-9 col-sm-8">
				<div class="title">
		          <h2>我的收藏</h2>
		        </div>
		        <hr>
		        <div class="main_content container-fluid py-3 border rounded">
					
					<div class="row">
					
					<c:forEach var="product" items="${products }">
						<c:choose>
					      <c:when test="${product.product_Class != '套裝行程' }">
						  <div class="col-lg-4 col-md-6 mb-4">
				            <div class="card h-100" data-product_id="${product.product_ID }" data-product_class="${product.product_Class }">
				              <a href="<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID=${product.product_ID}&product_Class=${product.product_Class}"><img class="card-img-top" src="<%=request.getContextPath()%>/util/ShowProductImage?id=${product.product_ID}" height="200px"></a>
				              <div class="card-body">
				                <h4 class="card-title">
				                  <a href="<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID=${product.product_ID}&product_Class=${product.product_Class}">${product.product_Name }</a>
				                </h4>
				                <p class="card-text"><i class="fas fa-map-marker-alt" style="color: #FF0000;"></i>${product.product_Address }</p>
				                <p class="card-text"><i class="fas fa-dollar-sign"></i>金額:
	 							<c:forEach var="pdMap" items="${pdMaps }">
	 						
								 <c:if test="${product.product_ID == pdMap.key }"> 
										${pdMap.value }
	 								</c:if> 
	 							</c:forEach> 
				                </p>
				              <c:forEach var="grade" items="${gradeMap }" >
				              <p class="scoreToStar d-inline"></p>
				              <c:if test="${product.product_ID eq grade.key }">
							  <p class="score d-inline card-text" >${grade.value }</p>
							  </c:if>
				              </c:forEach> 
				              </div>
				              <div class="card-footer">
				              <c:forEach var="collection" items="${collections }">
				              	<c:if test="${collection.product_ID eq product.product_ID }">
					              	<input type="hidden" class="collectionid" value="${collection.collection_ID }" class="">
				              	</c:if>
				              </c:forEach>
				              	<button type="button" name="button" class="removeCollection" STYLE="background-color: transparent; border:2px blue none; outline:none;">
				              	<i class="fas fa-heart fa-1x" style="color: #E93F3F; font-size: 1.5em;"></i>移除收藏
				              	</button>
				                <i class="fas fa-spinner fa-spin fa-2x loading -none"></i>  
				              </div>
				            </div>
				          </div>
				          </c:when>
				          <c:when test="${product.product_Class == '套裝行程' }">
						  <div class="col-lg-4 col-md-6 mb-4">
				            <div class="card h-100" data-product_id="${product.product_ID }" data-product_class="${product.product_Class }">
				              <a href="<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID=${product.product_ID}&product_Class=${product.product_Class}"><img class="card-img-top" src="<%=request.getContextPath()%>/util/ShowProductImage?id=${product.product_ID}" height="200px"></a>
				              <div class="card-body">
				                <h4 class="card-title">
				                  <a href="<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID=${product.product_ID}&product_Class=${product.product_Class}">${product.product_Name }</a>
				                </h4>
				                <fmt:parseNumber var="days" type="number" integerOnly="true" value="${product.product_Staytime }"></fmt:parseNumber>
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
<%-- 				              <c:forEach var="grade" items="${gradeMap }" >
				              <p class="scoreToStar d-inline"></p>
				              <c:if test="${product.product_ID eq grade.key }">
							  <p class="score d-inline card-text" >${grade.value }</p>
							  </c:if>
				              </c:forEach> --%> 
				              </div>
				              <div class="card-footer">
				              <c:forEach var="collection" items="${collections }">
				              	<c:if test="${collection.product_ID eq product.product_ID }">
					              	<input type="hidden" class="collectionid" value="${collection.collection_ID }" class="">
				              	</c:if>
				              </c:forEach>
				              	<button type="button" name="button" class="removeCollection" STYLE="background-color: transparent; border:2px blue none; outline:none;">
				              	<i class="fas fa-heart fa-1x" style="color: #E93F3F; font-size: 1.5em;"></i>移除收藏
				              	</button>
				                <i class="fas fa-spinner fa-spin fa-2x loading -none"></i>  
				              </div>
				            </div>
				          </div>
				          </c:when>
			          </c:choose>
					</c:forEach>




					</div>
				</div>
		    </div>
		    
		</div>
	</div>
	<%@ include file="../pages/footer.file" %>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
	<script src="https://unpkg.com/@popperjs/core@2"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>
	
	<script>
		loadStar();
	
	
		function loadStar(){
		  $(".score").each(function(index, item){
		    let score = $(this).html();
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
		  $(this).prev("p").html(star);
		  });
		}
		
		$('button.removeCollection').on('click', function(){
			/* e.stopPropagation(); */
			let buttonRemove = $(this);
			let collection_id = $(this).closest('div.card-footer').find('input.collectionid').val();
			let form_data = {
					"collection_id" : collection_id 
			}
			
			let form_dataString = JSON.stringify(form_data);
			$.ajax({
				url: "<%=request.getContextPath()%>/collection/RemoveCollection.Api",
				type: 'POST',
				contentType: 'json',
				data: form_dataString,
				beforeSend: function(){
					buttonRemove.hide();
					buttonRemove.closest('div.card-footer').find('svg.loading').show();	
				},
				success: function(res){
					buttonRemove.show();
					buttonRemove.closest('div.card-footer').find('svg.loading').hide();	
					console.log(res);
					if(res.result === true){
						Swal.fire({
							icon: 'success',
							text: '成功刪除'
						});
					buttonRemove.closest('div.col-lg-4').remove();	
					}
					else{
						Swal.fire({
							icon: 'error',
							text: '刪除失敗'
						});
					}
				} 
				
			});
		});
		
<%-- 		$(document).on('click', ".card", function(){
			let product_ID= $(this).data('product_id');
			let product_Class = $(this).data('product_class');
 	    	window.location.href='<%=request.getContextPath()%>/ProductServlet.do?action=goDetailPage&product_ID='+product_ID+"&product_Class="+product_Class;
 
		}) --%>
</script>
</body>
</html>