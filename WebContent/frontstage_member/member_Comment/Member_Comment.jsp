<%@page import="java.util.Comparator"%>
<%@page import="com.product.model.ProductVO"%>
<%@page import="com.product.model.ProductService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.productcmt.model.*"%>

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
/* div.card {
  border: solid 1px #31C7D2;
  -webkit-mask-image: -webkit-radial-gradient(circle, white 100%, black 100%);
}
.card-title a{
  color: #343434;
} */

.comment_card{
  margin-top: 10px;
  margin-bottom: 10px;
  background-color: white;
  box-shadow: 1px 3px 3px 3px #cccccc;
}

img.user_img{
  height: 40px;
  border: 1px solid gray;
  border-radius: 50%
}
div.user_info{
  padding: 15px;
}

div.comment_img_area{
  width: 100px;
  height: 80px;
  display: inline-block;
  position: relative;
  background-color: #f0f0f0;
  overflow: hidden;
  margin: 5px 8px;
}
img.comment_img{
  max-height: 100%;
  max-width: 100%;
  width: auto;
  height: auto;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  transition: 0.3s;
}

img.comment_img:hover{
  opacity: 0.7;
}
hr{
/*   height: 2px !important;
 */  border: 1px solid rgb(13, 218, 218);
}
h3{
  margin-top: 30px !important;
}
div.img_scheduleLight{
  height: 300px;
  margin-top: 20px;
}
div.img_scheduleLight img{
  max-height: 100%;
  max-width: 100%;
  width: auto;
  height: auto;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
}
img.img_smaller_scheduleLight{
  width: 100%;
}
table.scheduleContent tr td{
  padding: 10px 5px;
  /* border: 1px blue solid; */
}

div.ref_img img{
  max-height: 100%;
  max-width: 100%;
  width: auto;
  height: auto;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  transition: 0.2s;
}

div.ref_img{
  height: 200px;
  width: 100%;
  position: relative;
  background-color: black;
}

div.ref_img img:hover{
  opacity: 0.7;
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
		MemberVO member = (MemberVO)session.getAttribute("member"); 
		String member_ID = member.getMember_ID();
		
		ProductCmtService comService = new ProductCmtService();
		List<ProductCmtVO> comments = comService.select_by_member(member_ID);
		comments.sort(Comparator.comparing(ProductCmtVO::getProduct_Cmt_ID).reversed());
		
		pageContext.setAttribute("comments", comments);
		
		ProductService pService = new ProductService();
		List<ProductVO> products = pService.getAll();
		pageContext.setAttribute("products", products);
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
		          <h2>我的評論</h2>
		        </div>
		        <hr>
		        <div class="main_content container-fluid  border rounded">
					
					<c:forEach var="comment" items="${comments }">
						<div class="row comment_card">
																		
									<div class="col-md-12 my-3">
										<div class="row">
										<c:forEach var="product" items="${products }">
											<c:if test="${comment.product_ID eq product.product_ID }">
											<h5 class="card-title col-3 font-weight-bold">${product.product_Name }</h5>
											</c:if>
										</c:forEach>
												<p class="scoreToStar"></p>
												<p class="score" >${comment.product_Cmt_Grade }</p>
										</div>
										<div class="row">
											<div class="col-md-12">
												<a>${comment.product_Cmt_Info}</a>
											
											</div>
										</div>
										<div class="row">
											<div class="col-md-12">
												<div class="comment_img_area">
												<img id="myImg" class="comment_img" src="<%=request.getContextPath()%>/util/ShowCommentImage?id=${comment.product_Cmt_ID}&number=1">
												</div>
												<div class="comment_img_area">
												<img class="comment_img" src="<%=request.getContextPath()%>/util/ShowCommentImage?id=${comment.product_Cmt_ID}&number=2">
												</div>
											
											</div>
										</div>
										
									</div>

							</div>
					</c:forEach>
					
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
	
	</script>
</body>
</html>