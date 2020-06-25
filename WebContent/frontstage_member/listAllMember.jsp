<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<!DOCTYPE html>

<%-- <% 
	MemberService service = new MemberService();
	List<MemberVO> members = service.getAll();
	pageContext.setAttribute("members", members);
%> --%>
<jsp:useBean id="members" scope="page"
	class="com.member.model.MemberService" />
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
<style type="text/css">
	div.pagination{
	  /* display: block; */
	  margin-top: 80px;
	  margin-bottom: 200px;
	  /* margin-left: 24%; */
	}
/* Pagination links */
	.pagination a {
	  color: black;
	  font-family: roboto;
	  font-size: 16px;
	  float: left;
	  padding-top: 4px;
	  text-decoration: none;
	  transition: background-color .3s;
	  margin-left: 2px;
	  margin-right: 2px;
	  border: 1px solid #E2E2E2;
	  border-radius: 4px;
	  height: 32px;
	  width: 32px;
	  box-sizing: border-box;
	  text-align: center;
	}
	
	/* Style the active/current link */
	.pagination a.active {
	  background-color: #E6903B;
	  color: white;
	}
	
	/* Add a grey background color on mouse-over */
	.pagination a:hover:not(.active) {
	  background-color: #ddd;
	}
	
	/* table Height  */
	tr {
	   line-height: 25px;
	   min-height: 25px;
	   height: 25px;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<nav
		class="navbar navbar-expand navbar-light d-flex justify-content-start"
		style="background-color: #e3f2fd;">
		<a class="navbar-brand mr-auto" href="#"> <img
			src="<%=request.getContextPath()%>/img/david_img/logo.png" width="30" height="30"
			class="d-inline-block align-top" alt="tourism"> Tourism
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
	</nav>
	<form method="post" action="<c:url value="/member/login.controller" />">
		<input type="text" name="account" placeholder="帳號" value="${account }"><span>${errorMsg.account }</span>
		<input type="password" name="password" placeholder="密碼"> <span>${errorMsg.password }</span>
		<div>${errorMsg.login }</div>
		<div>${errorMsg.other }</div>
		<input type="hidden" name="action" value="login"> 
		<input type="submit" value="login">

	</form>
	<h1>所有會員</h1>
<%-- 	<c:forEach var="members" items="${members.all}">
		<h3>ID:${members.member_ID}</h3>
		<h3>ACCOUNT:${members.member_Account}</h3>
		<h3>PWD:${members.member_Pwd }</h3>

	</c:forEach> --%>

	<c:if test="${not empty member}">
		<h4>
			<span>${member.member_Account}</span><br> <span>${member.member_Name}</span><br>
		</h4>
	</c:if>

	<table class="table table-hover">
		<thead>
			<tr>
				<th style="width: 5%" scope="col">#</th>
				<th style="width: 10%" scope="col">ID</th>
				<th style="width: 10%" scope="col">ACCOUNT</th>
				<th style="width: 10%" scope="col">PASSWORD</th>
				<th style="width: 20%" scope="col">地址</th>
				<th style="width: 10%" scope="col">生日</th>
				<th style="width: 10%" scope="col">電話</th>
				<th style="width: 10%" scope="col">信箱</th>
				<th style="width: 10%" scope="col">建立時間</th>
				<th style="width: 10%" scope="col">圖片</th>
			</tr>
		</thead>
		<tbody>
		<%@ include file="pages/page1.file" %> 
		<c:forEach var="members" items="${members.all}" varStatus="loop" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<c:url value="/MemberUpdate.jsp" var="path">
				<c:param name="id" value="${members.member_ID}" />
				<c:param name="account" value="${members.member_Account}" />
				<c:param name="password" value="${members.member_Pwd}" />
				<c:param name="address" value="${members.member_Address}" />
				<c:param name="birthday" value="${members.member_Birth}" />
			</c:url>
			<tr>
				<th scope="row"><a href="${path}">${loop.count }</a></th>
				<td>${members.member_ID}</td>
				<td>${members.member_Account}</td>
				<td>${members.member_Pwd}</td>
				<td>${members.member_Address}</td>
				<td>${members.member_Birth }</td>
				<td>${members.member_Phone }</td>
				<td>${members.member_Mail }</td>
				<td>${members.member_Est_Time }</td>
				<td><img class="img-fluid rounded mx-auto " src="<%=request.getContextPath()%>/member/ShowMemberImage?id=${members.member_ID}"></td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<%@ include file="pages/page2.file"%>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
</body>
</html>