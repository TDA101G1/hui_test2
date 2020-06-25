<%@page import="com.productcmt.model.ProductCmtService"%>
<%@page import="com.productcmt.model.ProductCmtVO"%>
<%@page import="com.customerizedetail.model.CustDetailVO"%>
<%@page import="java.util.List"%>
<%@page import="com.product.model.ProductVO"%>
<%@page import="com.product.model.ProductService"%>
<%@page import="com.customerize.model.CustomerizeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
//ProductCmtService dao = new ProductCmtService();
//List<ProductCmtVO> cmtVOs = dao.getProductCmt();
//pageContext.setAttribute("cmtVOs", cmtVOs); 
  CustomerizeVO custVO = (CustomerizeVO) request.getAttribute("custVO");
//   pageContext.setAttribute("custVO", custVO);
//   List<ProductVO> list = (List<ProductVO>) request.getAttribute("products");
//   pageContext.setAttribute("list", list);
//   List<CustDetailVO> lists = (List<CustDetailVO>) request.getAttribute("custDetailVOs");
//   pageContext.setAttribute("CustDetailVO", lists);
%>
<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <!-- Google Map -->
  <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAbXslbdHryJFaivbDzQzHhvwo4bxM9hpc&callback=initMap&libraries=&v=weekly" defer></script>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
    integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
  <link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/css/footer.css">
  <style>
    * {
      font-family: 微軟正黑體;
      font-weight: bold;
    }
    .navbar-light .navbar-nav .nav-link {
	    color: rgba(0,0,0,.5) !important;
	    font-weight: normal;
	}
    body {
      overflow-x: hidden;
    }
    div.container-fluid {
      margin-top: 30px;
    }
    div button.add_bg {
      width: 100%;
      margin-bottom: 20px;
      background-color: #E5B280;
      border: #E5B280;
    }
    div button.selected {
      background-color: #0069d9 !important;
      border-color: #007bff !important;
      box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25) !important;
    }
    /* -----------------行程內容----------------- */
    div.schedule_content {
      width: 100%;
      height: 750px;
      position: relative;
      border: 1px solid black;
      display: block;
      border-radius: 4px;
      box-shadow: 0 0 6px;
    }
    div.schedule_header {
      width: 100%;
      height: 65px;
      position: relative;
      background-color: #E6903B;
      display: block;
    }
    div.schedule_header p {
      font-size: 32px;
      font-weight: bold;
      color: #343434;
      margin-bottom: 0;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
    /* div.schedule_header span.plus {
      position: absolute;
      top: 50%;
      right: 1%;
      transform: translate(-50%, -50%);
    } */
    div.schedule_body {
      display: block;
      height: calc(100% - 65px);
      position: relative;
      overflow-y: scroll;
    }
    div.schedule_body p.no_schedule {
      font-size: 32px;
      font-weight: bold;
      color: #E0DFDF;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
    ul {
      list-style: none;
      padding: 0;
    }
    li {
      list-style: none;
    }
    div.detail_block {
      /* width: 450px; */
      width: 100%;
      height: 150px;
      border: 1px solid black;
      margin-top: 20px;
      font-size: 0;
      box-shadow: 0 0 6px;
      border-radius: 4px;
    }
    div.detail_info {
      border-top: 1px solid black;
      display: block;
      width: 100%;
      height: 69px;
      font-size: 16px;
      word-break: break-all;
    }
    div.detail_info p {
      max-height: 100%;
      word-break: break-all;
      overflow: hidden;
    }
    div.detail_time {
      display: inline-block;
      width: calc(100% - 120px);
      height: 100%;
      font-size: 16px;
      text-align: center;
    }
    div.detail_img {
      display: inline-block;
      vertical-align: bottom;
      width: 120px;
      height: 100%;
    }
    div.detail_img img {
      width: 100%;
      height: 100%;
    }
    div.detail_top {
      width: 100%;
      height: 80px;
    }
    /* -----------------產品內容----------------- */
    div.product_content {
      width: 100%;
      height: 750px;
      position: relative;
      border: 1px solid black;
      border-radius: 4px;
      box-shadow: 0 0 6px;
    }
    div.product_header {
      width: 100%;
      height: 65px;
      position: relative;
      font-size: 32px;
      font-weight: bold;
      color: #343434;
      display: block;
      background-color: #E6903B;
    }
    div.product_header span.product_filter {
      position: absolute;
      top: 50%;
      left: 8%;
      transform: translate(-50%, -50%);
      font-size: 24px;
      font-weight: bold;
      color: #343434;
    }
    div.product_checkbox {
      width: 100%;
      height: 60px;
      position: relative;
      display: block;
      background-color: #E0DFDF;
      line-height: 60px;
    }
    div.product_body {
      max-width: 100%;
      height: calc(100% - 60px - 65px);
      position: relative;
    }
    div.product_body_content {
      overflow-y: scroll;
      width: 100%;
      height: 100%;
      max-width: 100%;
      max-height: 100%;
    }
    div.product_body_content div.card {
      margin-top: 20px;
      box-shadow: 0 0 6px;
    }
    div.btn_model button {
      width: 120px;
      float: right;
      margin-right: 20px;
    }
    div.input_title {
      width: 100%;
      height: 75px;
      border-radius: 0 30px 30px 0;
      background-color: #556fff;
      font-size: 32px;
      font-weight: bold;
      color: white;
      text-align: center;
      line-height: 75px;
    }
    div.input_title input {
      margin: auto;
      border: 0px solid;
      height: 30px;
      font-size: 24px;
    }
    div.text_title,
    div.edit_title {
      display: inline-block;
    }
    div#first_row {
      height: 80px;
      margin-bottom: 10px;
    }
    span.love {
      float: right;
    }
    div.card {
      width: 100%;
      height: 370px;
      max-height: 100%;
      margin: auto;
    }
    div.card img {
      max-width: 100%;
      height: 150px;
    }
    div.schedule_map {
      max-width: 100%;
      width: 100%;
      height: calc(100% - 60px - 65px);
      background-color: #E5B280;
      z-index: 10;
    }
    /* ---------------------搜尋欄---------------------------*/
    div.product_header div.search_area {
      width: 300px;
      white-space: nowrap;
      position: absolute;
      top: 50%;
      right: 0;
      transform: translate(-10%, -50%);
    }
    div.search_area input#search {
      width: 100%;
      height: 40px;
      font-size: 10px;
      color: #63717f;
      padding-left: 10px;
      /* border: solid 1px; */
      /* -webkit-border-radius: 5px;
  -moz-border-radius: 5px; */
      border-radius: 20px;
      display: block;
      border: solid 1px;
      /* -webkit-transition: background .55s ease;
  -moz-transition: background .55s ease;
  -ms-transition: background .55s ease;
  -o-transition: background .55s ease; */
      transition: background .55s ease;
    }
    div.search_area .icon {
      max-width: auto;
      position: absolute;
      top: 50%;
      right: 0;
      transform: translate(-50%, -50%);
      z-index: 1;
      color: #4f5b66;
    }
    .search_area input#search::-webkit-input-placeholder {
      color: #65737e;
    }
    .search_area input#search:-moz-placeholder {
      /* Firefox 18- */
      color: #65737e;
    }
    .search_area input#search::-moz-placeholder {
      /* Firefox 19+ */
      color: #65737e;
    }
    .search_area input#search:-ms-input-placeholder {
      color: #65737e;
    }
    .search_area input#search:hover,
    .search_area input#search:focus,
    .search_area input#search:active {
      outline: none;
      background: #f0f0f0;
    }
    label.label_area {
      font-size: 20px;
      margin-right: 50px;
    }
    label.label_area input {
      display: inline-block;
      top: 3px;
      width: 21px;
      height: 21px;
    }
    label.label_area a {
      display: inline-block;
    }
    div.checkbox_area {
      width: 100%;
      text-align: center;
      /* position: absolute;
      top: 50%;
      right: 50%;
      transform: translate(-50%, -50%); */
    }
    /*---------------------操控none-------------------------*/
    .-none {
      display: none;
    }
    .-on {
      display: none;
    }
    .-onScroll {
      overflow-y: scroll;
      max-height: 680px;
    }
    /*-----------------------填寫資訊-----------------------*/
    div.overlay_add_schedule {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100vh;
      background-color: hsla(0, 0%, 0%, .5);
      /* 預設：完全透明；設定 z-index: -1 會在整個頁面的後方，看不到，才不會擋到頁面元素。 */
      opacity: 0;
      z-index: -1;
      /* transition: opacity 1s; */
    }
    div.overlay_add_schedule.-on1 {
      /* 加上 -on1 之後，Modal 漸漸出現，因為有設定 transition */
      opacity: 1;
      z-index: 20;
    }
    div.overlay_add_schedule-opacity-zero {
      /*關閉 Modal 時，先讓 opacity設定0，就會慢慢變成完全透明，但這時會擋到後面的元素，所以要再移除 -on 及 -opacity-zero 這兩個 class */
      opacity: 0;
    }
    /* 元素 article 置中及基本樣式 */
    div.overlay_add_schedule>article {
      background-color: white;
      width: 685px;
      height: 550px;
      /* max-width: 800px; */
      border-radius: 4px;
      box-shadow: 0 6px 6px;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
    div.overlay_content {
      height: 100%;
    }
    div.overlay_header {
      border-radius: 4px 4px 0px 0px;
      background-color: #E0DFDF;
      height: 70px;
      font-size: 24px;
      font-weight: bold;
      position: relative;
    }
    div.overlay_header p {
      position: absolute;
      top: 50%;
      left: 10%;
      transform: translate(-50%, -50%);
    }
    div.overlay_body {
      position: relative;
      max-width: 100%;
      height: calc(100% - 70px - 70px);
    }
    div.body_content {
      /* border: 1px solid #343434; */
      width: 530px;
      height: 340px;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      /* text-align: center; */
    }
    div.content_top {
      margin: 20px 34px 0 34px;
    }
    div.content_img {
      width: 150px;
      height: 120px;
      display: inline-block;
    }
    div.content_img img {
      width: 100%;
      height: 100%;
    }
    div.context_title {
      display: inline-block;
      width: calc(100% - 120px - 34px - 34px);
      text-align: center;
      vertical-align: bottom;
    }
    div.context_title p.text {
      font-size: 32px;
      font-weight: bold;
    }
    hr.content_hr {
      width: 460px;
      background-color: #343434;
    }
    p.schedule_info {
      margin: 0 0 5px 34px;
      font-size: 16px;
      font-weight: bold;
      color: #343434;
    }
    div.text_info {
      text-align: center;
    }
    textarea#content_area {
      max-height: 110px;
      min-height: 110px;
      border: 1px solid #556fff;
      width: 460px;
    }
    div.btn_block {
      width: 100%;
      height: 70px;
      position: absolute;
      bottom: 0;
      text-align: center;
    }
    button#btn_confirm {
      background-color: #E6903B;
      width: 150px;
      height: 48px;
      border-radius: 4px;
      color: white;
    }
    button#btn_cancel {
      background-color: #E5B280;
      width: 150px;
      height: 48px;
      margin-right: 10px;
      border-radius: 4px;
      color: white;
    }
    div.last_change span {
      font-size: 20px;
      font-weight: bold;
      color: #343434;
      /* text-decoration: underline; */
    }
    div.update_date {
      width: 300px;
      /* text-decoration: underline; */
      display: inline-block;
    }
    div.change_date {
      display: inline-block;
    }
    div.current_date {
      display: inline-block;
    }
    div.current_date span {
      font-size: 24px;
      font-weight: bold;
      color: #343434;
      cursor: pointer;
      text-decoration: underline;
    }
    /*=================================刪除天數的視窗====================================*/
    div.overlay_delete_day {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100vh;
      background-color: hsla(0, 0%, 0%, .5);
      /* 預設：完全透明；設定 z-index: -1 會在整個頁面的後方，看不到，才不會擋到頁面元素。 */
      opacity: 0;
      z-index: -1;
      transition: opacity 1s;
    }
    div.overlay_delete_day.-on1 {
      /* 加上 -on1 之後，Modal 漸漸出現，因為有設定 transition */
      opacity: 1;
      z-index: 20;
    }
    div.overlay_delete_day-opacity-zero {
      /*關閉 Modal 時，先讓 opacity設定0，就會慢慢變成完全透明，但這時會擋到後面的元素，所以要再移除 -on 及 -opacity-zero 這兩個 class */
      opacity: 0;
    }
     /* 元素 article 置中及基本樣式 */
     div.overlay_delete_day>article {
      background-color: white;
      width: 700px;
      height: 300px;
      /* max-width: 800px; */
      border-radius: 4px;
      box-shadow: 0 6px 6px;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
    div.overlay_delete_content {
      height: 100%;
    }
    div.overlay_delete_body {
      position: relative;
      max-width: 100%;
      text-align: center;
      height: calc(100% - 70px);
      line-height: 230px;
      font-size: 20px;
    }
    div.btn_delete_block {
      background-color: #E0DFDF;
      border-radius: 0px 0px 4px 4px;
      width: 100%;
      height: 70px;
      font-size: 16px;
      font-weight: bold;
      text-align: center;
    }
    button#btn_delete_confirm {
    margin: 10px;
      background-color: #E6903B;
      width: 150px;
      height: 48px;
      border-radius: 4px;
      color: white;
    }
    button#btn_delete_cancel {
      background-color: #E5B280;
      width: 150px;
      height: 48px;
      margin-right: 10px;
      border-radius: 4px;
      color: white;
    }
    /*----------------------------天數垃圾桶-------------------------------*/
    span.delete_day {
      font-size: 18px;
      z-index: 20;
      cursor: pointer;
      /* margin-left: 10px; */
      float: right;
    }
    /*---------------------查詢不到產品資料時-------------------*/
    p#no_data {
      color: #343434;
      font-size: 24px;
      font-weight: bold;
      text-align: center;
    }
    span#no_data {
      text-decoration: underline;
      color: blue;
      font-size: 24px;
      font-weight: bold;
      cursor: pointer;
    }
    div#no {
      text-align: center;
      line-height: 390px;
    }
    /*-----------------------評價跟卡片調整---------------------------*/
    .list-group-item {
      padding: 10px;
      margin: 0;
      max-height: 70px;
      height: 70px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      width: 100%;
    }
    span.cmt_count {
      cursor: pointer;
      text-decoration: underline;
      color: blue;
      font-size: 20px;
      z-index: 20;
    }
    div.member_img img{
      width: 30px;
      height: 30px;
    }
    /*---------------------------產品詳細資訊-------------------------------*/
    hr {
      border-top: 1px solid #343434 !important;
      margin-top: 0 !important;
    }
    div.product_info_content {
      width: 100%;
      height: 750px;
      border: 1px solid black;
      border-radius: 4px;
      box-shadow: 0 0 6px;
      position: relative;
      left: 1500px;
      opacity: 0;
    }
    div.product_info_header {
      width: 100%;
      height: 65px;
      font-size: 32px;
      color: #343434;
      background-color: #E6903B;
      line-height: 65px;
      text-align: center;
    }
    /*------------------top----------------------*/
    div.product_info_top {
      height: 200px;
      max-height: 200px;
    }
    div.product_info_detail {
      height: 100%;
      line-height: 50px;
      text-align: center;
    }
    div.product_info_img img {
      /* width: 500px; */
      width: 100%;
      height: 200px;
    }
    /*------------------middle----------------------*/
    div.product_info_middle {
      height: 130px;
      max-height: 130px;
    }
    div.product_intro {
      height: 130px;
      max-height: 130px;
      padding: 0 15px;
      margin-bottom: 10px;
      overflow: hidden;
    }
    /*------------------bottom----------------------*/
    ul#product_cmt_scope {
      padding: 0;
      width: 650px;
      max-height: 275px;
      overflow-y: scroll;
      overflow-x: hidden;
      box-shadow: 0 0 1px;
      display: inline-block;
      vertical-align: top;
      margin: 0 auto;
    }
    li.product_cmt_content {
      list-style: none;
      width: 600px;
      margin: 15px auto;
      padding: 0;
    }
    div.product_cmt_body {
      /* width: 600px; */
      width: 100%;
      height: 90px;
      box-shadow: 0 0 6px;
      border-radius: 4px;
      margin: 0 auto;
      padding: 10px 20px;
    }
    div.member_img {
      display: inline-block;
      width: 70px;
    }
    div.member_name {
      display: inline-block;
      width: 100px;
    }
    div.member_cmt_star {
      display: inline-block;
      width: 120px;
    }
    div.product_cmt_time {
      display: inline-block;
      width: 200px;
    }
    div.product_cmt_img {
      margin: 10px auto;
      width: 600px;
    }
    div.product_cmt_img img {
      margin: 0 5px 0 0;
      width: 100px;
      height: 100px;
    }
    /*------------------scrollbar----------------------*/
    ::-webkit-scrollbar {
      width: 12px;
    }
    ::-webkit-scrollbar-track {
      -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
      border-radius: 10px;
    }
    ::-webkit-scrollbar-thumb {
      border-radius: 10px;
      -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.5);
    }
    /*---------------------google map-------------------------*/
    /*----------------------------地圖模式-------------------------------*/
    div.Transportation {
      text-align: center;
      /* line-height: 60px; */
      width: 100%;
      height: 100%;
    }
    div.Transportation button {
      width: 100px;
      height: 50px;
      border-radius: 4px;
      margin: auto;
    }
    #map {
      height: 100%;
    }
    div.map_img{
      font-size: 20px;
      text-align: center;
    }
    div.map_img img{
      width: 200px;
      height: 100px;
    }
    .-select_travel_mode{
      color: white;
      background-color: #007bff !important;
      border: 5px solid #007bff;
      outline: 5px auto -webkit-focus-ring-color !important;
      /* outline: 1px dotted ; */
    }
/*----------------------------聊天室-------------------------------*/
    .chat {
        border: 2px solid #dedede;
        background-color: white;
        padding: 10px;
        height: 450px;
        width: 500px;
        position: absolute;
        right: 0;
        bottom: 0;
    }
    .panel {
        border: 2px solid #0078ae;
        border-radius: 5px;
        width: 100%;
    }
    .message-area {
        height: 70%;
        resize: none;
        box-sizing: border-box;
        overflow: auto;
    }
    .text-field {
        border: 1px solid grey;
        /* padding: 0.1em ;
        box-shadow: 0 0 5px #000000; */
    }
    #message {
        min-width: 100%;
        max-width: 100%;
        min-height: 20%;
        max-height: 20%;
    }
    div.chat input{
        margin-top: 5px;
    }
/*----------------------------共同編輯下拉選單-------------------------------*/
    .dropdown-menu{
        width: 400px;
        padding: 10px 20px;
        margin: 0 auto;
        min-height: 125px;
    }
    .show{
      /* transform: translate3d(381px, 48px, 0px); */
      left: -10px !important;
      height: auto;
      max-height: 300px;
    }
    .dropdown-menu span{
        font-size: 20px;
    }
    ul#firend{
      overflow-y: scroll;
    }
/*----------------------------聊天室-------------------------------*/
    .chat_icon img {
        height: 50px;
        width: 50px;
        border-radius: 100px;
        cursor: pointer;
        /* position: absolute;
        left: 0;
        top: 0;
        right: 0;
        bottom: 0;
        margin: auto; */
    }
    .test{
      border: 5px solid tomato;
    }
    /*--------------------RWD---------------------*/
    @media screen and (max-width:1440px){
      div.current_date span{
        font-size: 20px;
      }
    }
  </style>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
  <!-- <link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_orange.css"> -->
</head>

<body>
 <%--  <nav class="navbar navbar-expand navbar-light d-flex justify-content-start" style="background-color: #e3f2fd;">
    <a class="navbar-brand mr-auto" href="#">
      <img src="<%=request.getContextPath()%>/img/hui/logo.png" width="30" height="30"
        class="d-inline-block align-top" alt="tourism">
      Tourism</a>
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="#"><i class="fas fa-pen"></i>建立行程</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#"><i class="fas fa-store"></i>商城</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#"><i class="fas fa-shopping-cart"></i>購物車</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#"><i class="fas fa-sign-in-alt"></i>會員中心</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#"><i class="fas fa-user"></i>USER</a>
      </li>
    </ul>
  </nav> --%>
  <%@include file="../frontstage_member/pages/header.file" %>

  <div class="container-fluid">
    <div class="row" id="first_row">
      <div class="col-12 col-sm-6 col-md-6 col-lg-6 col-xl-3" style="padding: 0;">
        <div class="input_title" data-schedule-id="${custVO.cust_Schedule_ID}" data-member-id="${custVO.member_ID}"
          data-quantity="${custVO.cust_Quantity}" data-position="${custVO.cust_Position}"
          data-selected-county="${custVO.cust_Selected_County}">
          <div class="text_title">
            <p class="text_title"><%=custVO.getCust_Schedule_Name() == null?"請輸入標題 ":custVO.getCust_Schedule_Name()%> </p>
          </div>
          <div class="edit_title">
            <span class="edit_title"><i class="fas fa-pen" style="font-size: 20px; cursor: pointer;"></i></span>
          </div>
          <input type="text" class="update_title -none">
        </div>
      </div>
      <div class="col-12 col-sm-6 col-md-6 col-lg-6 col-xl-4" style="padding: 0; text-align: center;">
        <div class="last_change" data-last-time="${custVO.cust_Schedule_Last_Timestamp}">
          <span>最後修改時間：<fmt:formatDate type="both" value="${custVO.cust_Schedule_Last_Timestamp}"/></span>
          <div class="current_date">
            <span>選擇的日期為：${custVO.cust_Schedule_Start_Time} ～ ${custVO.cust_Schedule_End_Time}</span>
          </div>
          <div class="update_date">
            <input class="-none" type="text" name="date" style="width: 100%;">
          </div>
          <div class="change_date">
            <button class="-none" type="button">更改日期</button>
          </div>

        </div>
      </div>

      <div class="col-12 col-sm-12 col-md-12 col-lg-12 col-xl-5">
        <form id="produce" action="<%=request.getContextPath()%>/CustomerizeController" method="POST">
          <div class="btn_model">
            <button id="btnGroupDrop1" type="button" class="btn btn-primary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">共同編輯</button>
            <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
              <span>請輸入email：</span><input id="email" type="text" style="width: 75%;">
              <button id="invite" type="button" style="width: 50px;">邀請</button>
              <div style="margin-top: 10px;">
                <hr id="loading" style="border-color: #E0DFDF !important;">
                <ul id="firend" style="text-align: center;">
                  <!--------------- 動態新增 --------------->
                </ul>
              </div>
            </div>
            <button id="btn_Store" type="button" class="btn btn-primary btn-lg">儲存行程</button>
            <button id="btn_produce" type="button" class="btn btn-primary btn-lg">產生行程</button>
            <button id="btn_map" type="button" class="btn btn-primary btn-lg">地圖模式</button>
            <button id="btn_standard" type="button" class="btn btn-primary btn-lg -none">標準模式</button>
            <input type="hidden" name="action" value="produce_schedule">
            <input id="cust_schedule_id" type="hidden" name="cust_schedule_id" value="${custVO.cust_Schedule_ID}">
          </div>
        </form>
      </div>
    </div>

    <div class="row">
      <div class="col-12 col-sm-12 col-md-3 col-lg-3  col-xl-1">
        <ul id="sum_day" data-start="${custVO.cust_Schedule_Start_Time}" data-end="${custVO.cust_Schedule_End_Time}"
          data-days="${custVO.cust_Schedule_Total_Day}">
          <!--------------- 動態新增 --------------->
        </ul>
        <div class="add_day">
          <button type="button" class="btn btn-primary btn-lg add_day" style="width: 100%;">新增</button>
        </div>
        <div class="chat_icon">
          <img src="https://picsum.photos/200/200/?random=1">
        </div>
      </div>
      <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-4">
        <div class="schedule_content">
          <div class="schedule_header" data-date="${custVO.cust_Schedule_Start_Time}" data-sort="1">
            <p>Day1</p>
            <!-- <span class="plus"><i class="fas fa-plus fa-2x"></i></span> -->
          </div>
          <div class="schedule_body">
            <p class="no_schedule">請加入行程</p>
            <div class="schedule_body_content">
              <ul class="schedule_list" id="schedule_list">
                <!--------------- 動態新增 --------------->
              </ul>
            </div>
          </div>
        </div>
      </div>

      <div class="col-12 col-sm-12 col-md-12 col-lg-12 col-xl-7">
        <div class="product_content">
          <div class="product_header">
            <!-- <span class="product_filter"><i class="fas fa-filter"></i>新增條件</span> -->
            <div class="search_area">
              <input type="search" id="search" placeholder="搜尋..." />
              <span class="icon"><i class="fa fa-search"></i></span>
            </div>
          </div>
          <div class="product_checkbox">
            <div class="checkbox_area">
              <div class="row" style="padding-left: 15px; padding-right: 15px;">
                <div class="col-3 col-sm-3 col-md-3">
                  <label class="label_area">
                    <input id="all" type="checkbox" name="product_group" value="全部" class="checkbox_area" checked>
                    <a>全部</a>
                  </label>
                </div>
                <div class="col-3 col-sm-3 col-md-3">
                  <label class="label_area">
                    <input id="activities" type="checkbox" name="product_group" value="景點" class="checkbox_area"
                      checked>
                    <a>景點</a>
                  </label>
                </div>
                <div class="col-3 col-sm-3 col-md-3">
                  <label class="label_area">
                    <input id="restaurant" type="checkbox" name="product_group" value="餐廳" class="checkbox_area"
                      checked>
                    <a>美食</a>
                  </label>
                </div>
                <div class="col-3 col-sm-3 col-md-3">
                  <label class="label_area">
                    <input id="accommodation" type="checkbox" name="product_group" value="住宿" class="checkbox_area"
                      checked>
                    <a>住宿</a>
                  </label>
                </div>
              </div>
            </div>
            <!-- 地圖模式使用的按鈕，一開始不顯示，設定為none -->
            <div class="Transportation -none">
              <div class="row" style="padding-left: 15px; padding-right: 15px;">
                <div class="col-3 col-md-3">
                  <button class="btn_optimize" name="btn_optimize" style="margin-top: 5px; line-height: 50px;">優化路線</button>
                </div>
                <div class="col-3 col-md-3">
                  <button id="btn_car" name="DRIVING" style="margin-top: 5px; line-height: 50px;""><i class="fas fa-car fa-2x"></i></button>
                </div>
                <div class="col-3 col-md-3">
                  <button id="btn_motorcycle" name="BICYCLING" style="margin-top: 5px; line-height: 50px;""><i class="fas fa-motorcycle fa-2x"></i></button>
                </div>
                <div class="col-3 col-md-3">
                  <button id="btn_walk" name="WALKING" style="margin-top: 5px; line-height: 50px;""><i class="fas fa-walking fa-2x"></i></i></button>
                </div>
              </div>
            </div> 
 
          </div>
          <div class="product_body">
            <div class="product_body_content" style="padding-left: 15px; padding-right: 15px;">
              <!------------------------------- 由AJAX動態新增 -------------------------------->
            </div>
            <div class="chat -none">
              <textarea id="messagesArea" class="panel message-area" readonly></textarea>
              <input id="message" class="text-field" type="text" />
              <input type="submit" id="sendMessage" class="button" value="Send" />
              <input type="button" id="connect" class="button" value="Connect" onclick="connect();" />
              <input type="button" id="disconnect" class="button" value="Disconnect" onclick="disconnect();" />
            </div>
          </div>
          <!-- 地圖模式使用的畫面，一開始不顯示，設定為none -->
          <div class="schedule_map -none">
            <div id="map"></div>
          </div>
        </div>
        <!-- 產品詳細資訊，一開始不顯示，設定為none -->
        <div class="product_info_content -none">
          <div class="product_info_header">
            <div class="row" style="padding: 0 15px; height: 65px;">
              <div class="col col-md-1" style="border-right: 2px solid #343434; height: 65px;">
                <span class="product_info_close" style="cursor: pointer;"><i class="fas fa-times"></i></span>
              </div>
              <div class="col col-md-11">
                <span class="product_info_name">自由廣場</span>
              </div>
            </div>
          </div>
          <div class="product_info_top">
            <div class="row" style="padding: 0 15px; height: 200px;">
              <div class="col col-md-6" style="padding: 0;">
                <div class="product_info_img">
                  <img src=" ">
                </div>
              </div>
              <div class="col col-md-6">
                <div class="product_info_detail">
                  <p class=""><i class="fas fa-map-marker-alt"></i>地址：<span class="address"></span></p>
                  <p><i class="far fa-clock"></i> 建議遊玩時間：<span class="time"></span>小時</p>
                  <div id="cmt_star">
                    <!--------------- 動態新增 --------------->
                  </div>
                </div>
              </div>
            </div>
          </div>
          <hr id="top_hr">
          <div class="product_info_middle">
            <div class="product_intro">
              <p style="font-size: 24px; margin: 0;">簡介</p>
              <p class="product_intro_text"> Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi
                quaerat modi repellat quasi excepturi at vitae placeat quo quam rerum, officiis a maiores
                nesciunt laboriosam saepe impedit maxime ad illum? </p>
            </div>
          </div>
          <hr id="bottom_hr">
          <div class="product_info_bottom" style="padding: 0 15px;">
            <div class="row" style="padding: 0 15px; height: 200px;">
              <p style="font-size: 24px; margin: 0; width: 185px; display: inline-block;">評價<span
                  class="bottom_count"></span></p>
              <ul id="product_cmt_scope">
                <!--------------- 動態新增 --------------->
              </ul>
            </div>
          </div>
        </div>
        
      </div>
    </div>
  </div>
  <!-- 新增行程的Modal -->
  <div class="overlay_add_schedule">
    <article>
      <div class="overlay_content">
        <div class="overlay_header">
          <p>填寫資訊</p>
        </div>
        <div class="overlay_body">
          <div class="body_content">
            <div class="content_top">
              <div class="content_img">
                <img src="">
              </div>
              <div class="context_title">
                <p class="text"></p>
                <p style="font-size: 16px;"><i class="far fa-clock fa-1x"></i> 建議遊玩時間：<span></span>小時</p>
              </div>
            </div>
            <hr class="content_hr">
            <div class="content_bottom">
              <p class="schedule_info">行程備註</p>
              <div class="text_info">
                <textarea id="content_area" name="content_area" placeholder="最多50個字"></textarea>
              </div>
            </div>
          </div>
        </div>
        <div class="btn_block">
          <button id="btn_cancel" type="button">取消</button>
          <button id="btn_confirm" type="button">確認</button>
        </div>
      </div>
    </article>
  </div>
  <div class="overlay_delete_day -none">
    <article>
        <div class="overlay_delete_content">
            <div class="overlay_delete_body">
              <p>確定要移除<span id="delete_day"></span>的行程?</p>
            </div>
            <div class="btn_delete_block">
                <button id="btn_delete_cancel" type="button">取消</button>
                <button id="btn_delete_confirm" type="button">確認</button>
            </div>
        </div>
    </article>
  </div>
	<!-- <%@ include file="../frontstage_member/pages/footer.file" %> -->
  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
    integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
  </script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
    integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous">
  </script>
  <!-- Font-Awesome -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
  <!-- jQuery -->
  <script src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
  <!-- 日曆 -->
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <!-- sweetalert -->
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
  <!-- dragular -->
  <!-- <script src='https://cdnjs.cloudflare.com/ajax/libs/dragula/3.7.2/dragula.min.js'></script> -->
  <script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>
  <script>
    /*==================================================先讀取一份篩選地點及類別的產品資料==================================================*/
    function initMap(){}
    var filter_product = []; //將篩選後的結果，儲存一份給其他天數用，就不需每次切換天數時都要request一次，只要再次篩選，就會即時更新內容
    var empty_star = `<i class="far fa-star" style="color:#FFDD26;"></i>`;
    var full_star = `<i class="fas fa-star" style="color:#FFDD26;"></i>`;
    var half_star = `<i class="fas fa-star-half-alt" style="color:#FFDD26;"></i>`;
    let position = $("div.input_title").attr("data-position").split(",");
    let list_selected_county = $("div.input_title").attr("data-selected-county");
    let selected_county = "";
    selected_county = list_selected_county.substring(1, list_selected_county.length - 1).split(",");
    for(let i = 0; i < selected_county.length; i++){    //因為後端為了將地點轉成字串存入資料庫，而使用Arrays.toString，資料間會有多餘的空格
      selected_county[i] = selected_county[i].trim();   //所以在這裡解決以防擴散問題
    }
    let selected_class = [];
    $("input:checkbox:checked[name=product_group]").each(function (i, items) { //可以確認Checkbox被勾選的為哪些
      selected_class.push($(items).val());
    });
    listProductResult(selected_county, selected_class);
    init(selected_county);
    
    $(function () {
      var directionsRenderer = new google.maps.DirectionsRenderer;
      var directionsService = new google.maps.DirectionsService;
      var user_departure = {lat: parseFloat(position[0]), lng: parseFloat(position[1].trim())};
      var map;
      initMap = function(){
          map = new google.maps.Map(document.getElementById('map'), {
          zoom: 14,
          center: user_departure,
          gestureHandling: 'greedy'
        });
      }
      
    // var dragulaKanban = dragula([
    //     document.querySelector('#schedule_list')], 
    //     {
    //       moves: function(el, container, handle) {
    //         console.log(handle)
    //       return handle.classList.contains('test');
    //   }
    // });
    
    /*==================================================發送mail邀請編輯==================================================*/
    $("button#invite").on("click", function(e){
      e.stopImmediatePropagation();
      let email = $("input#email").val();
      let cust_schedule_id = $(".input_title").attr("data-schedule-id");
      if(email.trim().length == 0 || email == ""){
        $("input#email").attr("placeholder", "請輸入email帳號");
        return;
      }
      console.log(email)
      $.ajax({
        url: "<%=request.getContextPath()%>/InviteEditScheduleController",
        type: "POST",
        data: {
                "email": email,
                "cust_schedule_id": cust_schedule_id
              },
        dataType: "json",
        beforeSend: function(){
          $("hr#loading").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-1x"></i></li>'); //讀取動畫
        },
        statusCode: {                 // 狀態碼
          404: function (res) {
          },
          500: function (res) {
            $("input#email").val("");
            $("hr#loading").html("");
            $("input#email").attr("placeholder", "輸入的email錯誤");
          }
        },
        success: function (data) {
          if(data.result === "success"){
            swal({
              position: 'top-end',
              icon: 'success',
              title: '已發送邀請',
              showConfirmButton: false,
              timer: 1500
            });
            $("input#email").val("");
            $("hr#loading").html("");
            $("ul#firend").append(`<li style="margin-top:5px;">`+email+`</li>`);
          }
        },
        error: function () {
          console.log("fail")
        }
      });
    });
    
    /*==================================================聊天室==================================================*/
    $("div.chat_icon").on("click", function(){
        $(".chat").toggleClass("-none");
        $("div.chat_icon img").removeClass("test");
    });
    
    $("input#message").keyup(function(e){
      if(e.keyCode == 13) {
        $("input#sendMessage").click();
      } 
    });
    $("input#sendMessage").on("click", function(){
      let insertMessage = $("input#message");
      let message = insertMessage.val().trim();
      if(message === ""){
        alert("Input a message");
        insertMessage.focus();
      }else{
        var jsonObj = [{"action": "chatMessage"},{"userName" : userName,"message" : message,}] //為了配合推播的判斷式
        webSocket.send(JSON.stringify(jsonObj));
        insertMessage.val("");
        insertMessage.focus();
      }
    });
    
    /*==================================================WebSocket共同編輯行程==================================================*/
      var userName = $("div.input_title").attr("data-member-id");
      var Mypoint = "/TogetherWS/MID000000";
      var host = window.location.host;
      var path = window.location.pathname;
      var webCtx = path.substring(0, path.indexOf('/', 1));
      var endPointURL = "ws://" + host + webCtx + Mypoint;
      console.log("Mypoint = "+Mypoint)
      console.log("host = "+host)
      console.log("path =" + path)
      console.log("webCtx = " + webCtx)
      console.log("endPointURL = " + endPointURL)
      // function connect(){
        //create a webSocket
        var webSocket = new WebSocket(endPointURL);
        
        webSocket.onopen = function(e){
          console.log("連線成功");
        };
        webSocket.onmessage = function(e){
          let current_day = $("div.schedule_header p").html();
          let jsonObj = JSON.parse(e.data);
          console.log(jsonObj)
          if(jsonObj[0].action === "update_title"){
            $("p.text_title").text(jsonObj[1].title); //將輸入的文字，加入到p標籤，更改文字
          }
          if(jsonObj[0].action === "chatMessage"){
            let messageArea = $("#messagesArea");
            let message = jsonObj[1].userName + ": " + jsonObj[1].message +"\r\n";
            messageArea.val(messageArea.val() + message);
            if($(".chat").hasClass("-none")){
              $("div.chat_icon img").addClass("test");
            }
          }
          if(jsonObj[0].action === "deleteSchedule"){
            let storage = [];
            if(jsonObj[1].delete_day_number != undefined){                               //會進到這裡代表是最後一個行程被刪除
              // sessionStorage.removeItem(jsonObj[1].delete_day_number);
              sessionStorage.setItem(jsonObj[1].delete_day_number, JSON.stringify([]));  //直接把當前天數的sessionStorage設成空陣列
              if(current_day === jsonObj[1].delete_day_number){                               //如果在相同天數的頁面才需要更新畫面
                $("ul.schedule_list").html("");
                printSessionStorage_and_refreshProduct(jsonObj[1].delete_day_number);
              }
            }else{
              for(let i = 1; i < jsonObj.length; i++){              
                storage.push(jsonObj[i]);
              }
              sessionStorage.setItem(storage[0].day_number, JSON.stringify(storage));
              if(current_day === storage[0].day_number){                               //如果在相同天數的頁面才需要更新畫面
                $("ul.schedule_list").html("");
                printSessionStorage_and_refreshProduct(storage[0].day_number);
              }
            }
          }
          if(jsonObj[0].action === "addSchedule"){
            let storage = [];
            for(let i = 1; i < jsonObj.length; i++){                                 //為了要分類action，所以再做一次
              storage.push(jsonObj[i]);
            }
            sessionStorage.setItem(storage[0].day_number, JSON.stringify(storage));  //先將更改的資料存入sessionStorage
            if(current_day === storage[0].day_number){                               //如果在相同天數的頁面才需要更新畫面
              $("ul.schedule_list").html("");
              printSessionStorage_and_refreshProduct(storage[0].day_number);         //再取出重新排列及產品列表更新
            }
          }
          
        };
        webSocket.onclose = function(e){
          console.log("結束了")
        };
      // }
    
    /*==================================================地圖模式==================================================*/
    $("button#btn_map").on("click", function (e) {
      $("div.Transportation").find("button").each(function(i, value){   //把有-select_travel_mode的class移除
          if($(this).hasClass("-select_travel_mode")){
            $(this).removeClass("-select_travel_mode");
          }
        });
      $("button#btn_car").addClass("-select_travel_mode");
      $("button#btn_standard").removeClass("-none");
      $(this).addClass("-none");
      $("div.product_body").toggle("-none");
      $("div.checkbox_area").toggle("-none");
      $("div.schedule_map").toggle("-none");
      $("div.Transportation").toggle("-none");
      if ($("ul.schedule_list").find("li").hasClass("schedule_block")) {
          initMap();
          directionsRenderer.setMap(map);
          calculateAndDisplayRoute(directionsService, directionsRenderer, false, tempCallback);
      }else{
        initMap();
      }
      
      var iconBase = 'http://maps.google.com/mapfiles/kml/paddle/';
      var icons = {
      user_departure: {icon: iconBase + '1.png'}, location_1: {icon: iconBase + '2.png'}, location_2: {icon: iconBase + '3.png'}, location_3: {icon: iconBase + '4.png'},
          location_4: {icon: iconBase + '5.png'}, location_5: {icon: iconBase + '6.png'}, location_6: {icon: iconBase + '7.png'}, location_7: {icon: iconBase + '8.png'},     
          location_8: {icon: iconBase + '9.png'}, location_9: {icon: iconBase + '10.png'}, location_10: {icon: iconBase + '11.png'}, location_11: {icon: iconBase + '12.png'}     
        };
         // The location of user_departure
     
      // The map, centered at user_departure
      // var map = new google.maps.Map(                  //地圖初始置中的地方
      //     document.getElementById('map'), {zoom: 8, center: user_departure});
      // // The marker, positioned at user_departure
      // let marker = new google.maps.Marker({           //使用者的出發地
      //     position: user_departure, 
      //     icon: icons["user_departure"].icon, 
      //     map: map
      //   });
      // for(let i = 0; i < features.length; i++){       //將行程列表中的地點，創建marker
      //   let marker = new google.maps.Marker({
      //     position: features[i].position, 
      //     icon: icons[features[i].type].icon, 
      //     map: map,
      //     title: 'Uluru (Ayers Rock)'
      //   });
      // }
      // var contentString = ` <div class="product_cmt_img">
      //                                 <img src="<%=request.getContextPath()%>/ImageController?action=printImage_cmt_id&img=img1&product_cmt_id=CMT000000">
      //                                 <img src="<%=request.getContextPath()%>/ImageController?action=printImage_cmt_id&img=img2&product_cmt_id=CMT000000">
      //                             </div>`;
 
      
      // var infowindow = new google.maps.InfoWindow({   //創建marker上的視窗
      //   content: contentString
      // });
      // marker.addListener('click', function() {
      //   infowindow.setContent(title);
      //  infowindow.open(map, marker);
      // });
    
    });
    
    /*==================================================標準模式按鈕==================================================*/
    $("button#btn_standard").on("click", function () {
      $("button#btn_map").removeClass("-none");
      $(this).addClass("-none");
      $("div.product_body").toggle("-none");
      $("div.checkbox_area").toggle("-none");
      $("div.schedule_map").toggle("-none");
      $("div.Transportation").toggle("-none");
    });
    
    /*==================================================路線模式按鈕(汽車等..)==================================================*/
    $("div.Transportation").find("button[name!='btn_optimize']").on("click", function(){  //當name不等於btn_optimize的按鈕click時
      $("div.Transportation").find("button").each(function(i, value){   //把有-select_travel_mode的class移除
          if($(this).hasClass("-select_travel_mode")){
            $(this).removeClass("-select_travel_mode");
          }
        });
      $(this).addClass("-select_travel_mode");
      let travel_mode = $(this).attr("name");
      // initMap();
      directionsRenderer.setMap(map);
      calculateAndDisplayRoute(directionsService, directionsRenderer, false, tempCallback, travel_mode);
    })
     
     /*==================================================優化按鈕==================================================*/
    $("button.btn_optimize").on("click", function(){
      let travel_mode;
      $("div.Transportation").find("button").each(function(i, value){   //把有-select_travel_mode的class移除
          if($(this).hasClass("-select_travel_mode")){
            travel_mode = $(this).attr("name");
          }
        });
      if ($("ul.schedule_list").find("li").hasClass("schedule_block")) {
          initMap();
          directionsRenderer.setMap(map);
          calculateAndDisplayRoute(directionsService, directionsRenderer, true, optimizeSchedule, travel_mode);
        }else{
          alert("您還沒加入行程唷~~")
        }
    });
    
      /*==================================================未優化路線的function==================================================*/
      function tempCallback(waypoint_order, distance){
        console.log("地圖模式 = " + distance)
        let listSchedule = [];
        take_schedule_list(listSchedule);
        $("ul.schedule_list").html("");
        for (let i = 0; i < listSchedule.length; i++) {
          let items = listSchedule[i]; //只是要讓名稱短一點
          scheduleView(items.product_ID, i, items.product_img, items.product_name, items.stay_time, items
            .schedule_info, items.product_Latitutde, items.product_Longitude, distance[i]);
        } 
      }
      
      /*==================================================優化路線的function==================================================*/
      function optimizeSchedule(waypoint_order, distance){
        console.log("distance = " + distance)
        let day_number = $("div.schedule_header p").html();
        let listSchedule = [];
        let newSchedule = [];
        console.log("waypoint_order = " + waypoint_order)
        take_schedule_list(listSchedule);
        for(let i = 0; i < listSchedule.length; i++){
          if(i == (listSchedule.length - 1)){
            newSchedule[i] = listSchedule[i];
          } else {
            newSchedule[i] = listSchedule[waypoint_order[i]];
          }
        }
        sessionStorage.setItem(day_number, JSON.stringify(newSchedule));
        $("ul.schedule_list").html("");
        for (let i = 0; i < newSchedule.length; i++) {
          let items = newSchedule[i]; //只是要讓名稱短一點
          scheduleView(items.product_ID, i, items.product_img, items.product_name, items.stay_time, items
            .schedule_info, items.product_Latitutde, items.product_Longitude, distance[i]);
        } 
      }
  
      /*==================================================計算距離及畫路線圖的function==================================================*/
      let master_distance = [];
      function calculateAndDisplayRoute(directionsService, directionsRenderer, optimizeWaypoint, callback, travelMode) {
        let travel_mode = travelMode == null?'DRIVING':travelMode;
        console.log(travelMode)
        master_distance = [];
        var waypts = [];
        let insertHtml = [];
        let li_length =  $("ul.schedule_list").children("li").length;
        $("ul.schedule_list").find("li").each(function(i, value){
          let product_name = $(value).find("div.detail_time p").html();
          let product_id = $(value).attr("id");
          let tempHtml= `<div class="map_img">`+product_name+`<br><img src="<%=request.getContextPath()%>/ImageController?action=printImage_product_id&product_id=`+product_id+`"></div>`;
          let lat = parseFloat($(this).attr("data-latitutde"));
          let lng =  parseFloat($(this).attr("data-longitude"));
          insertHtml.push(tempHtml);
          if(i == (li_length - 1)){
            user_destination = {lat:lat, lng:lng};
          }else{
            let temp = {
                          location: {lat:lat, lng:lng},     //使用者選的地點經緯度
                          stopover: true,
                          // type: ('location_'+ (i+1))        //用哪一個icon
                        }
            waypts.push(temp);     
          }
        });
        // Clear past routes
    // if (directionsDisplay != null) {
    //     directionsDisplay.setMap(null);
    //     directionsDisplay = null;
    // }
        if(li_length > 0){
          directionsService.route({
            origin: user_departure,         // Note that Javascript allows us to access the constant
            destination: user_destination,  // using square brackets and a string value as its"property."
            waypoints: waypts,
            optimizeWaypoints: optimizeWaypoint,
            travelMode: google.maps.TravelMode[travel_mode]
          }, function(response, status) {
            if (status == 'OK') {
              console.log(response.routes[0]);
              let legs = response.routes[0].legs;
              let waypoint_order = response.routes[0].waypoint_order;
              for(let i = 0; i < legs.length; i++){
                master_distance.push(legs[i].distance.text);
                if(i == 0){
                  legs[i].start_address = "<div class='map_img' style='font-size: 20px; text-align: center;'>出發點</div>";
                  legs[i].end_address = insertHtml[i];
                }else if(i == legs.length - 1){
                  legs[i].start_address = insertHtml[i - 1];
                  legs[i].end_address = insertHtml[i];
                }else{
                  legs[i].start_address = insertHtml[i - 1];
                  legs[i].end_address = insertHtml[i];
                }
              }
              callback(waypoint_order, master_distance);
              directionsRenderer.setDirections(response);
            } else {
              console.log('Directions request failed due to ' + status);
            }
          });
        }
      } 
      // function createMarker(latlng, title) {
      //   var infowindow = new google.maps.InfoWindow();
      //   var marker = new google.maps.Marker({
      //       position: latlng,
      //       title: title,
      //       map: map
      //   });
      //   google.maps.event.addListener(marker, 'click', function () {
      //       infowindow.setContent(title);
      //       infowindow.open(map, marker);
      //   });
      // }
      
      /*==================================================搜尋==================================================*/
      $("input#search").keyup(function (e) {
        if (e.which == 13) {
          $("span.icon").click();
        }
      });
      $("span.icon").on("click", function () {
        var searchWord = $('#search').val();
        if (searchWord !== "") {
          searchData(searchWord);
        }
      });
      
      /*==================================================搜尋沒有資料時的請按此==================================================*/
      $("div.product_body_content").on("click", "p#no_data", function () {
        sortProduct(filter_product);
      });
      
      /*==================================================到後端搜尋資料的function==================================================*/
      function searchData(query) {
        $.ajax({
          url: "<%=request.getContextPath()%>/project/JsonController",
          type: "POST",
          data: {
            "action": "searchData",
            "query": query
          },
          dataType: "json",
          beforeSend: function () {
            $("div.product_body_content").html(
              '<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
          },
          success: function (data) {
            console.log(data)
            if (data.hasOwnProperty("products")) { //判斷回傳的物件是否有查詢到資料 = 這個key
              filter_product = data.products; //products = server傳回的key
              sortProduct(data.products);
            } else {
              sortProduct(data.checkBox_no_result);
            }
          },
          error: function () {
          }
        });
      }
      
      /*==================================================可按enter==================================================*/
      $("div.overlay_content").find("textarea#content_area").keyup(function (e) {
        if (e.which == 13) {
          $("div.btn_block button#btn_confirm").click();
        }
      });
      
      /*==================================================Checkbox篩選==================================================*/
      $("input.checkbox_area").on("click", function () {
        if (this.checked != true) {
          $("#all").prop("checked", false);
        }
        let Checked_class = [];
        setTimeout(function () {
          $("input:checkbox:checked[name=product_group]").each(function (i, items) { //可以確認Checkbox被勾選的為哪些
            Checked_class.push($(items).val());
          });
          if (Checked_class.length != 0 && Checked_class != null) {
            listProductResult(selected_county, Checked_class); //ajax與後端拿資料
          } else {
            listProductResult(selected_county, selected_class);
          }
          console.log("selected_class = " + selected_class);
          console.log("Checked_class = " + Checked_class);
        }, 50)
      });
      /*==================================================Checkbox全選/全不選==================================================*/
      $("input#all").on("click", function () {
        if (this.checked == true) {
          $("#activities, #restaurant, #accommodation").prop("checked", true);
        } else {
          $("#activities, #restaurant, #accommodation").prop("checked", false);
        }
      });
      
      /*==================================================標題編輯，筆icon按下去的動作==================================================*/
      $("span.edit_title").on("click", function () {
        let title = $("p.text_title").text(); //取得原有的標題
        $("p.text_title").addClass("-none"); //display:none p標籤
        $("span.edit_title").addClass("-none"); //display:none 筆icon
        $("input.update_title").removeClass("-none"); //將隱藏的input顯示出來
        $("input.update_title").focus(); //input一顯示出來時，focus
        $("input.update_title").attr("placeholder", title); //將原有的標題，加入到input的placeholder
      });
      
      /*==================================================標題input離開的動作==================================================*/
      $("input.update_title").on("blur", function () {
        update_title($(this));
      });
      $("input.update_title").keyup(function(e){
        if (e.which == 13) {
          update_title($(this));
        }
      });
      function update_title($this){
        let title = $this.val(); //取得輸入的文字 
        if(title == "" && title.length == 0){
          $this.attr("placeholder", "請輸入文字");
        }else{
          $("p.text_title").text(title); //將輸入的文字，加入到p標籤，更改文字
          $("p.text_title").removeClass("-none"); //移除display:none p標籤
          $("span.edit_title").removeClass("-none"); //移除display:none 筆icon
          $this.addClass("-none"); //display:none input
          webSocket.send(JSON.stringify([{"action":"update_title"},{"title":title}]));
        }
      }
      
      /*==================================================選取卡片的動作==================================================*/
      $("div.product_body_content").on("click", "div.card", function (e) {
        $(this).closest("div.col-lg-4").toggle("-none"); //被選到的卡片display:none
        $("div.overlay_add_schedule").addClass("-on1"); //開啟被隱藏的頁面(填寫資訊頁面)
        $("div.overlay_add_schedule").fadeIn(); //動畫
        $("div.overlay_content").find("textarea#content_area").focus(); //填寫資訊頁面彈出時，focus在輸入框
        let product_ID = $(this).attr("id");
        let product_name = $(this).find("h5").html();
        let product_img = $(this).find("img").attr("src");
        let stay_time = $(this).find("p.stay_time").html();
        let product_Latitutde = $(this).attr("data-latitutde");
        let product_Longitude = $(this).attr("data-longitude");
        $("div.context_title p.text").html(product_name);
        $("div.overlay_add_schedule img").attr("src", product_img);
        $("div.overlay_add_schedule").attr("id", product_ID);
        $("div.overlay_add_schedule").attr("data-latitutde", product_Latitutde);
        $("div.overlay_add_schedule").attr("data-longitude", product_Longitude);
        $("div.context_title span").html(stay_time);
        $("textarea#content_area").val("");
      });
      
      /*==================================================點選評價次數會出現景點介紹==================================================*/
      $("div.product_body_content").on("click", "a.cmt_count", function (e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let $card = $(this).closest("div.card");
        let product_id = $card.attr("id");
        let product_name = $card.find("h5").html();
        let product_img = $card.find("img").attr("src");
        let stay_time = $card.find("p.stay_time").html();
        let address = $card.find("p.card-text span").html();
        let product_cmt_avg = $card.find("span.cmt_avg").html();
        let product_cmt_count = $card.find("a.cmt_count").html();
        let product_info = $card.find("p.product_info").html();
        let $product_info_content = $("div.product_info_content");
        $product_info_content.find("span.product_info_name").html(product_name);
        $product_info_content.find("div.product_info_img img").attr("src", product_img);
        $product_info_content.find("span.time").html(stay_time);
        $product_info_content.find("span.address").html(address);
        $product_info_content.find("p.product_intro_text").html(product_info);
        $product_info_content.find("span.bottom_count").html(product_cmt_count);
        $product_info_content.find("div#cmt_star").html(`<span class="cmt_avg">` + product_cmt_avg + `</span>`+ checkStar(product_cmt_avg));
        $.ajax({
          url: "<%=request.getContextPath()%>/project/JsonController",
          type: "POST",
          data: {
            "action": "load_productCmt",
            "product_id": product_id,
          },
          dataType: "json",
          success: function (data) {
            let insertHtml = "";
            $.each(data.product_cmt, function (i, value) {
              console.log(value)
              let get_date = flatpickr.formatDate(new Date(value.product_Cmt_Timestamp), 'Y-m-d');
              insertHtml += ` <div class="col-12">
                                <li class="product_cmt_content">
                                  <div class="col-12">
                                    <div class="product_cmt_body">
                                        <div class="member_img" style="text-align: center;">
                                          <img src="<%=request.getContextPath()%>/ImageController?action=printImage_member_id&member_id=` + value.memberVO.member_ID +`">
                                        </div>
                                        <div class="member_name">
                                            <p style="margin-bottom: 5px;">` + value.memberVO.member_Account + `</p>
                                        </div>
                                        <div class="member_cmt_star">
                                          `+ checkStar(value.product_Cmt_Grade) +`
                                        </div>
                                        <div class="product_cmt_time">` + get_date + `</div>
                                        <div class="product_cmt_info" style="text-align: center;">
                                            <p style="overflow:hidden; height:50px;">` + value.product_Cmt_Info +`</p>
                                        </div>
                                    </div>
                                    <div class="product_cmt_img">
                                        <img src="<%=request.getContextPath()%>/ImageController?action=printImage_cmt_id&img=img1&product_cmt_id=` + value.product_Cmt_ID +`">
                                        <img src="<%=request.getContextPath()%>/ImageController?action=printImage_cmt_id&img=img2&product_cmt_id=` + value.product_Cmt_ID +`">
                                    </div>
                                  <div class="col-12">
                                </li>
                              </div>`;
            });
            $("ul#product_cmt_scope").html(insertHtml);
            // <img src="<%=request.getContextPath()%>/ImageController?member_id=`+value.member_ID+`">
            // <i class="fas fa-user"></i>
          },
          error: function () {
            console.log("fail")
          }
        });
        $("div.product_content").fadeOut(700);
        $("div.product_info_content").toggle("-none"); //將景點詳細資訊顯示出來
        // $("div.product_content").animate({                  //產品列表先關閉
        //         width: "toggle"
        //     }, 1000);
        $("div.product_info_content").animate({ //景點詳細資訊從右邊往左過來，透明度調回1
          left: 0,
          opacity: 1,
        }, 700, );
      });
      $("span.product_info_close").on("click", function () {
        $("div.product_info_content").animate({ //景點詳細資訊再回去原位
          left: "1500px",
          opacity: 0,
        }, 700);
        setTimeout(function () {
          $("div.product_content").fadeIn()
          // $("div.product_content").animate({
          //     width: "toggle"
          // }, 700);
        }, 500);
        $("div.product_info_content").toggle("-none");
      });
      
      /*==================================================點選填寫資訊的確認動作==================================================*/
      $("div.btn_block button#btn_confirm").on("click", function (e) {
        $("p.no_schedule").addClass("-none");
        $("div.overlay_add_schedule").fadeOut();
        let $overlay_add_schedule = $(this).closest("div.overlay_add_schedule");
        let product_ID = $overlay_add_schedule.attr("id");
        let product_name = $overlay_add_schedule.find("div.context_title p.text").html();
        let product_img = $overlay_add_schedule.find("div.content_img img").attr("src");
        let stay_time = $overlay_add_schedule.find("div.context_title span").html();
        let schedule_info = $overlay_add_schedule.find("div.overlay_content textarea").val();
        let product_Latitutde = $overlay_add_schedule.attr("data-latitutde");
        let product_Longitude = $overlay_add_schedule.attr("data-longitude");
        let schedule_id = [];
        $("ul.schedule_list").find("li").each(function (index, items) { //取得當前行程列表內的各個id
          schedule_id.push($(this).attr("id"));
        });
        
        if (check_Id(schedule_id, product_ID) == false) { //若為false就是就新增行程到左邊列表中
          let sort = (schedule_id.length - 1) + 1; //將schedule_id陣列長度 - 1，利用陣列特性獲得最後一筆資料的數值，再 + 1，即可當成順序sort的值
          scheduleView_afterDistance(product_ID, sort, product_img, product_name, stay_time, schedule_info, product_Latitutde, product_Longitude);
        } else {
          //若為ture就是等於更新左側的行程備註
          $("div.detail_block").closest("li#" + product_ID).find("div.detail_info p").html(schedule_info);
        }
        let json = [{"action":"addSchedule"}];
        take_schedule_list(json);
        webSocket.send(JSON.stringify(json));
      
      });
      
      /*==================================================點選填寫資訊的取消動作==================================================*/
      // 關閉 Modal
      $("div.btn_block button#btn_cancel").on("click", function () {
        let product_ID = $(this).closest("div.overlay_add_schedule").attr("id");
        $("div.overlay_add_schedule").fadeOut();
        let schedule_id = [];
        $("ul.schedule_list").find("li").each(function (index, items) {
          schedule_id.push($(this).attr("id"));
        });
        if (check_Id(schedule_id, product_ID) == false) { //若為false就是產品列表所點選的動作
          $("div.product_body_content").find("div#" + product_ID).closest("div.col-lg-4").toggle("-none");
        } //點選取消時，原選取的卡片，會返回產品列表
      });
      
      /*==================================================載入日期樣式==================================================*/
      var selectedDate = $("div.update_date input").flatpickr({
        altInput: true,
        altFormat: "Y-m-d",
        dateFormat: "Y/m/d",
        minDate: "today",
        mode: "range",
      });
      
      /*==================================================新增天數的按鈕==================================================*/
      $("div.add_day").on("click", function () {
        let $ul = $("ul#sum_day");
        let first_day = $ul.attr("data-start");
        let last_day = $ul.find("li").last().attr("data-date"); //取最後一個li的日期
        let last_day_num = parseInt($ul.find("li").last().attr("data-sort")) + 1; //取最後一個li的天數，然後+1給下一天用
        let millisecond = new Date(last_day).getTime() + (60 * 60 * 24 * 1000); //+1天
        let add_date = flatpickr.formatDate(new Date(millisecond), 'Y-m-d'); //格式化為Y-m-d
        let add_day =
          `<li class="Day` + last_day_num + `"data-sort="` + last_day_num + `"data-date="` + add_date + `">
            <button type="button" class="btn btn-primary btn-lg add_bg">Day` + last_day_num + `<span class="delete_day -none"><i class="fas fa-trash-alt"></i></span></button>
          </li>`;
        if (last_day_num > 10) {
          $ul.addClass("-onScroll");
        } else {
          $ul.removeClass("-onScroll");
        }
        $ul.append(add_day);
        $ul.attr("data-days", last_day_num);
        sessionStorage.setItem('Day'+last_day_num, JSON.stringify([]));       //為了讓產生行程時判斷有沒有空行程而做
        $ul.attr("data-end", add_date);
        $("div.current_date span").html("選擇的日期為：" + first_day + " ～ " + add_date);
      });
      
      /*==================================================切換天數的按鈕==================================================*/
      $("ul#sum_day").on("click", "button", function () {
        $("ul#sum_day").find("li button").each(function(i, value){   //把有selected的class移除
          if($(this).hasClass("selected")){
            $(this).removeClass("selected");
          }
        });
        $(this).toggleClass("selected");
        let day_number = $("div.schedule_header p").html(); //取得當前的天數
        let current_data = [];
        take_schedule_list(current_data); //取得行程列表當前資料
        sessionStorage.setItem(day_number, JSON.stringify(current_data)); //存到sessionStorage
        let date = $(this).closest("li").attr("data-date");
        let sort = $(this).closest("li").attr("data-sort");
        $("div.schedule_header p").text($(this).text()); //將行程表的天數切換為選取的天數
        $("div.schedule_header").attr("data-date", date); //將切換為選取的日期帶入
        $("div.schedule_header").attr("data-sort", sort); //將切換為選取的順序帶入
        $("ul.schedule_list").html(""); //先將行程列表清空
        printSessionStorage_and_refreshProduct($(this).text()); //取得要切換天數的sessionStorage，把資料印出，並更新產品(已被選的不會出現)
        if(!$("button#btn_standard").hasClass("-none")){      //代表現在是地圖模式，
          if ($("ul.schedule_list").find("li").hasClass("schedule_block")) {
            initMap();
            directionsRenderer.setMap(map);
            calculateAndDisplayRoute(directionsService, directionsRenderer, false, tempCallback);
          }else{
            initMap();
          }
        }
      });
      
      /*==================================================滑鼠移進天數的動作==================================================*/
      $("ul#sum_day").on("mouseenter", "button", function () {
        $(this).find("span.delete_day").removeClass("-none");
        $(this).find("span.delete_day").on("click", function (e) {
          if ($("ul#sum_day").children("li").length == 1) { //如果刪除前的只剩一天，則無法刪除
            alert("只剩一天無法刪除");
          } else {
            let removeKey = $(this).closest("li").attr("class"); //取得要刪除天數名稱
            $("div.overlay_delete_day").find("span#delete_day").html(removeKey);
            $("div.overlay_delete_day").addClass("-on1");        //行程尚未儲存確認捨棄現有行程?
            $("div.overlay_delete_day").removeClass("-none");
          }
          e.stopImmediatePropagation(); //取消事件的进一步捕获或冒泡，同时阻止任何事件处理程序被调用
          });
        });
      
      /*==================================================滑鼠移出天數的動作==================================================*/
      $("ul#sum_day").on("mouseleave", "button", function () {
        $(this).find("span.delete_day").addClass("-none");
      });
      
      /*==================================================刪除天數點選確認的動作==================================================*/
      $("#btn_delete_confirm").on("click", function(){
        let delete_day = $(this).closest(".overlay_delete_day").find("span#delete_day").html();
        let $ul = $("ul#sum_day");
        $ul.find("li."+delete_day).remove(); //刪除選取的天數
        sessionStorage.removeItem(delete_day); //sessionStorage一併刪除
        $("div.overlay_delete_day").find("span#delete_day").html("");
            
            let current_sessionStorage = Object.keys(sessionStorage).sort(); //將當前剩下的sessionStorage做排序(小到大)
            $.each(current_sessionStorage, function (i, value) {
              let temp = sessionStorage.getItem(value); //將value一個一個取出
              sessionStorage.setItem("Day" + (i + 1), temp); //重新排列塞入value
            });
            sessionStorage.removeItem("Day" + (current_sessionStorage.length + 1)); //刪除最後一筆多餘的storage
            
            let add_day = "";
            let first_day = $ul.attr("data-start");
            let total_day = $ul.attr("data-days");
            let li_length = $ul.children("li").length;
            let millisecond = 60 * 60 * 24 * 1000;
            let time = new Date(first_day).getTime();
            $("div.schedule_header p").html("Day1");
            $("div.schedule_header").attr("data-date", first_day);
            $("div.schedule_header").attr("data-sort", 1);
            $("ul.schedule_list").html(""); //先將行程列表清空
            printSessionStorage_and_refreshProduct("Day1"); //重新取資料，載入行程及產品列表
            if ($("ul.schedule_list").find("li").hasClass("schedule_block")) {
              initMap();
              directionsRenderer.setMap(map);
              calculateAndDisplayRoute(directionsService, directionsRenderer, false, tempCallback);
            }else{
              initMap();
            }
            for (let i = 1; i <= li_length; i++) {
              let date = flatpickr.formatDate(new Date(time), 'Y-m-d');
              if(i == 1){
                add_day +=
                `<li class="Day` + i + `"data-sort="` + i + `"data-date="` + date + `">
                <button type="button" class="btn btn-primary btn-lg add_bg selected">Day` + i + `<span class="delete_day -none"><i class="fas fa-trash-alt"></i></span></button>
                </li>`;
              }else{
                add_day +=
                  `<li class="Day` + i + `"data-sort="` + i + `"data-date="` + date + `">
                  <button type="button" class="btn btn-primary btn-lg add_bg">Day` + i + `<span class="delete_day -none"><i class="fas fa-trash-alt"></i></span></button>
                  </li>`;
              }
              time += millisecond;
            }
            $ul.html(add_day);
        let last_day = $ul.find("li").last().attr("data-date"); //更新日期排序後取最後一個li的日期
        $ul.attr("data-end", last_day); //更新日期、天數
        $ul.attr("data-days", li_length);
        $("div.current_date span").html("選擇的日期為：" + first_day + " ～ " + last_day);
        let $overlay_delete_day = $("div.overlay_delete_day");
        $overlay_delete_day.addClass("-opacity-zero");
        $overlay_delete_day.addClass("-none");
        $overlay_delete_day.removeClass("-on1");
        $overlay_delete_day.removeClass("-opacity-zero");
      });
          
      /*==================================================刪除天數點選取消的動作==================================================*/
      $("#btn_delete_cancel").on("click", function(){
        let $overlay_delete_day = $("div.overlay_delete_day");
        $overlay_delete_day.addClass("-opacity-zero");
        $overlay_delete_day.addClass("-none");
        $overlay_delete_day.removeClass("-on1");
        $overlay_delete_day.removeClass("-opacity-zero");
        $overlay_delete_day.find("span#delete_day").html("");
      });
      
      /*==================================================點選儲存的按鈕==================================================*/
      $("button#btn_Store").on("click", function () {
        // let last_time = $("div.last_change").attr("data-last-time");
        // let time = new Date($("div.last_change").attr("data-last-time")).getTime();
        // let current_time = new Date();
        // console.log(time)
        // console.log(current_time)
        if(sessionStorage.length == 0){
          swal({
            position: 'top-end',
            icon: 'error',
            title: '列表中沒有行程，請加入行程',
            showConfirmButton: false,
            timer: 1500
          });
        }else{
          // let array = [];
          let cust_schedule_detail_data = take_all_sessionStorage([]);
          console.log("cust_schedule_detail_data = " + cust_schedule_detail_data)
          ajax_insertDataBase(cust_schedule_detail_data, sweet_alert);
        }
      });
      /*----------一些儲存需要用到的方法----------*/
      function sweet_alert(){
          swal({
              position: 'top-end',
              icon: 'success',
              title: '儲存成功',
              showConfirmButton: false,
              timer: 1500
          });
        } 
      function take_all_sessionStorage(array){
        let last_data = [];
        let day_number = $("div.schedule_header p").html(); //取得當前的天數
        take_schedule_list(last_data); //取得當前天數行程資料
        sessionStorage.setItem(day_number, JSON.stringify(last_data)); //存入sessionStorage
        $("ul#sum_day").find("li").each(function (index, items) { //將所有天數的sessionStorage取出
          let sessionDate = JSON.parse(sessionStorage.getItem("Day" + (index + 1)));
          array.push(sessionDate);
        });
          return array;
      }
      function ajax_insertDataBase(cust_schedule_detail_data, callback){
        console.log("cust_schedule_detail_data = " + JSON.stringify(cust_schedule_detail_data))
        let $ul = $("ul#sum_day");
        let cust_schedule_id = $("div.input_title").attr("data-schedule-id");
        let title = $("p.text_title").text();
        let first_day = $ul.attr("data-start");
        let last_day = $ul.attr("data-end");
        let total_day = $ul.attr("data-days").toString();
        let cust_schedule_data = {
          "cust_schedule_data": {
            "cust_schedule_id": cust_schedule_id,
            "title": title,
            "first_day": first_day,
            "last_day": last_day,
            "total_day": total_day
          }
        }
        $.ajax({
          url: "<%=request.getContextPath()%>/project/JsonController",
          type: "POST",
          data: {
            "action": "insert_schedule",
            "cust_schedule_data": JSON.stringify(cust_schedule_data),
            "cust_schedule_detail_data": JSON.stringify(cust_schedule_detail_data)
          },
          dataType: "json",
          success: function (data) {
            callback();
            console.log("success")
          },
          error: function () {
            console.log("fail")
          }
        });
      }
      
      /*==================================================產生行程的按鈕==================================================*/
      $("button#btn_produce").on("click", function () {
        let cust_schedule_detail_data = take_all_sessionStorage([]);
        let cust_schedule_id = $("div.input_title").attr("data-schedule-id");
        // ajax_insertDB(function(){});
        let count = [];
        let title = "";
        if(sessionStorage.length == 0){                                     //沒有行程無法產生行程
          swal({
            position: 'top-end',
            icon: 'error',
            title: '列表中沒有行程，請加入行程',
            showConfirmButton: false,
            timer: 1500
          });
        }else{                                                  
          let session = Object.keys(sessionStorage).sort();
          $.each(session, function(i, value){
            let get_session = JSON.parse(sessionStorage.getItem(value));
            if(get_session.length == 0){
              count.push(value);
            }
          });
          
          if(count.length != 0){
            if(count.length < 4){
              title = count.toString()+'沒有行程，請加入行程';
            }else{
              title = '多個天數沒有行程，請加入行程';
            }
            swal({
              position: 'top-end',
              icon: 'error',
              title: title,
              showConfirmButton: false,
              timer: 1500
            });
          }else{
            ajax_insertDataBase(cust_schedule_detail_data, product_schedule);
          }
        }
      });
      function product_schedule(){
        $("form#produce").submit();
      }
      
      /*==================================================點選行程，修改行程備註==================================================*/
      $("ul.schedule_list").on("click", "li div.detail_block", function () {
        $("div.overlay_add_schedule").addClass("-on1");
        $("div.overlay_add_schedule").fadeIn();
        $("div.overlay_content").find("textarea#content_area").focus();
        let $this = $(this);
        let day_number = $("div.schedule_header p").html();
        let product_ID = $this.closest("li").attr("id");
        let product_name = $this.find("div.detail_time p").html();
        let product_img = $this.find("div.detail_img img").attr("src");
        let stay_time = $this.find("div.detail_time span").html();
        let schedule_info = $this.find("div.detail_info p").html();
        let sort = $this.attr("data-sort");
        let product_Latitutde = $this.closest("li").attr("data-latitutde");
        let product_Longitude = $this.closest("li").attr("data-longitude");
        $("div.overlay_add_schedule").attr("id", product_ID);
        $("div.context_title p.text").html(product_name);
        $("div.overlay_add_schedule img").attr("src", product_img);
        $("div.context_title span").html(stay_time);
        $("textarea#content_area").val(schedule_info);
        $("div.overlay_add_schedule").attr("data-latitutde", product_Latitutde);
        $("div.overlay_add_schedule").attr("data-longitude", product_Longitude);
      });
      
      /*==================================================刪除行程，點選垃圾桶的icon==================================================*/
      $("ul.schedule_list").on("click", "li span.trash", function () {
        let json = [{"action":"deleteSchedule"}];
        let schedule_product_id = $(this).closest("li").attr("id");
        let day_number = $("div.schedule_header p").html();
        $(this).closest("li.schedule_block").remove();
        $("div#" + schedule_product_id).closest("div.col-lg-4").toggle("-none");
        let current_data = [];
        take_schedule_list(current_data); 
        sessionStorage.setItem(day_number, JSON.stringify(current_data)); //讀取當前天數的內容，儲存於current_data
        if (current_data.length == 0) {
          $("p.no_schedule").removeClass("-none");
        }
        if ($("ul.schedule_list").find("li").hasClass("schedule_block")) {
          initMap();
          directionsRenderer.setMap(map);
          calculateAndDisplayRoute(directionsService, directionsRenderer, false, tempCallback);
        }else{
          initMap();
        }
        if(current_data.length == 0 || current_data === []){
          json.push({"delete_day_number":day_number});
          webSocket.send(JSON.stringify(json));
        }else{
          take_schedule_list(json);
          webSocket.send(JSON.stringify(json));
        }
      });
      /*==================================================點選當前日期，可更改日期==================================================*/
      $("div.current_date span").on("click", function () {
        $("div.current_date span").addClass("-none");
        // $("div.update_date input").removeClass("-none");
        // $("div.change_date button").removeClass("-none");
        $("div.update_date input").fadeIn();
        $("div.change_date button").fadeIn();
      });
      
      /*==================================================更改日期的按鈕==================================================*/
      $("div.change_date").on("click", function () {
        initMap();  //初始化地圖
        let $ul = $("ul#sum_day");
        let data = listDateResult(selectedDate.selectedDates);
        if (data.length == 0 || data == []) { //若取得的資料為空陣列，則跳出提醒視窗
          // $("input.update_date").focus();
          alert("請輸入日期\u000d若只選一天，請在日期上點兩下")
        } else if (confirm("所有資料即將被刪除\u000d確定要重新選擇日期嗎?")) {
          sessionStorage.clear(); //清除sessionStorge資料
          $("ul.schedule_list").html(""); //清除行程列表
          $("p.no_schedule").removeClass("-none");
          let add_day = "";
          let first_day = "";
          let last_day = "";
          let total_day = "";
          $.each(data, function (index, items) {
            switch (index) {
              case 0:
                first_day = items;
                break;
              case 1:
                last_day = items;
                break;
              case 2:
                total_day = items;
                break;
            }
          });
          $ul.attr("data-start", first_day, "data-end", last_day, "data-days", );
          $ul.attr("data-end", last_day);
          $ul.attr("data-days", total_day);
          $("div.schedule_header").attr("data-date", first_day);
          $("div.current_date span").html("選擇的日期為：" + first_day + " ～ " + last_day);
          $("div.current_date span").removeClass("-none");
          $("div.current_date span").fadeIn();
          $("div.update_date input").fadeOut();
          $("div.change_date button").fadeOut();
          if (total_day > 10) {
            $ul.addClass("-onScroll");
          } else {
            $ul.removeClass("-onScroll");
          }
          for (let i = 1; i <= total_day; i++) {
            sessionStorage.setItem('Day'+i, JSON.stringify([]));          //為了讓產生行程時判斷有沒有空行程而做
            let start_date = flatpickr.formatDate(new Date(first_day), 'Y-m-d');
            if(i == 1){
              add_day +=
              `<li class="Day` + i + `"data-sort="` + i + `"data-date="` + start_date + `">
              <button type="button" class="btn btn-primary btn-lg add_bg selected">Day` + i + `<span class="delete_day -none"><i class="fas fa-trash-alt"></i></span></button>
              </li>`;
            }else{
              add_day +=
                `<li class="Day` + i + `"data-sort="` + i + `"data-date="` + start_date + `">
                <button type="button" class="btn btn-primary btn-lg add_bg">Day` + i + `<span class="delete_day -none"><i class="fas fa-trash-alt"></i></span></button>
                </li>`;
            }
            first_day = new Date(first_day).getTime();
            first_day += (60 * 60 * 24 * 1000);
          }
          $ul.html(add_day);
          $("div.product_body_content").html(
            '<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>'); //讀取動畫
          setTimeout(function () {
            sortProduct(filter_product); //將最新產品的篩選結果，重新顯示一次
          }, 300);
        } else {
          $("div.current_date span").removeClass("-none");
          $("div.current_date span").fadeIn();
          $("div.update_date input").fadeOut();
          $("div.change_date button").fadeOut();
          $("div.update_date input").val("");
        }
      });
    });
    
    /*==================================================使用者重新選擇天數時用的function==================================================*/
    function listDateResult(startDateObj) {
      let allDate = [];
      let first_day = "";
      let last_day = "";
      $.each(startDateObj, function (index, items) { //宣告變數承接所有日期
        let time = new Date(items);
        console.log(time)
        if (index == 0) {
          first_day = time;
          let flatDate = flatpickr.formatDate(items, 'Y-m-d');
          allDate.push(flatDate);
        } else {
          last_day = time;
          let flatDate = flatpickr.formatDate(items, 'Y-m-d');
          allDate.push(flatDate);
        }
      });
      if (first_day.length != 0 && last_day != "") {
        let total_day = ((last_day - first_day) / (60 * 60 * 24 * 1000)) + 1; //取得選取的總天數
        allDate.push(total_day.toString());
      }
      return allDate;
    };
    
    /*==================================================與後端連線，讀取篩選後的產品function==================================================*/
    function listProductResult(selected_county, selected_class) {
      $.ajax({
        url: "<%=request.getContextPath()%>/project/JsonController",
        type: "POST",
        data: {
          "action": "load_product",
          "selected_county": JSON.stringify(selected_county),
          "selected_class": JSON.stringify(selected_class)
        },
        dataType: "json",
        beforeSend: function () {
          $("div.product_body_content").html(
            '<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
        },
        success: function (data) {
          if (data.hasOwnProperty("products")) { //判斷回傳的物件是否有查詢到資料 = 這個key
            filter_product = data.products; //products = server傳回的key
            console.log("產品篩選後的數量 = "+filter_product.length)
            sortProduct(data.products);
          } else {
            sortProduct(data.checkBox_no_result);
          }
        },
        error: function () {
          console.log("fail")
        }
      });
    }
    
    /*==================================================將後端傳回的產品資料顯示出來的function==================================================*/
    function sortProduct(data) {
      if (data.length === 0) { //若為true代表沒有查詢到資料
        let html = `<div id="no"><img src="<%=request.getContextPath()%>/ImageController?action=printImage_product_id&product_id=no_data" width="300" height="300"></div>
                    <p id="no_data">頁面即將在<span id="sec"></span>秒鐘自動轉跳...若無反應<span id="no_data">請按此</span></p>`
        $("div.product_body_content").html(html);
        let x = 3; //倒數計時器
        for (let i = 0; i <= 3; i++) {
          setTimeout(function () {
            $("div.product_body_content").find("span#sec").text(x);
            x -= 1;
          }, 1000 * i);
        }
        setTimeout(function () { //設定倒數三秒，自動轉跳頁面
          sortProduct(filter_product);
        }, 3500)
        $("input#search").val("");
        return;
      } else {
        let insertHtml = "";
        let product_id = [];
        let schedule_product_id = [];
        $.each(data, function (index, value) {
          product_id.push(value.product_ID); //儲存全部的ID要準備比對
          let cmt_avg = parseFloat(value.productCmtVO.product_Cmt_Grade.toFixed(1)) === 0 ? "" : value.productCmtVO.product_Cmt_Grade.toFixed(1);
          insertHtml += `<div class="col-6 col-sm-6 col-md-4 col-lg-4">
                              <div id="` + value.product_ID + `" class="card" data-latitutde="` + value.product_Latitutde + `" 
                                                                              data-longitude="` + value.product_Longitude +`">
                                <img src="<%=request.getContextPath()%>/ImageController?action=printImage_product_id&product_id=` + value.product_ID + `"class="card-img-top">
                                <div class="card-body">
                                  <h5 class="card-title">` + value.product_Name +`</h5>
                                  <p class="card-text" style="margin:0; height: 45px;"><i class="fas fa-map-marker-alt"></i><span>` + value.product_Address + `</span></p>
                                  <div id="cmt_star" style="margin-top:10px;">
                                    <span class="cmt_avg">` + cmt_avg + `</span>
                                    `+ checkStar(cmt_avg) +`
                                    <a href=# class="cmt_count">(` + value.productCmtVO.count + `)</a>
                                    </div> 
                                </div>
                                <div class="list-group list-group-flush">
                                  <p class="list-group-item">` + value.product_Intro + `</p>
                                </div>
                                <p class="stay_time -none">` + value.product_Staytime + `</p>
                                <p class="product_info -none">` + value.product_Info + `</p>
                              </div>
                            </div>`;
        });
        // <span class="love"><i class="far fa-heart fa-2x"></i></span>
        $("div.product_body_content").html("<div class='row'>" + insertHtml + "</div>");
        $("ul.schedule_list").find("li").each(function (index, items) {
          schedule_product_id.push($(items).attr("id"));
        })
        for (let i = 0; i < product_id.length; i++) {
          if ($.inArray(product_id[i], schedule_product_id) != -1) { //若等於-1，就是表示兩邊列表沒有共同的id
            $("div#" + product_id[i]).closest("div.col-lg-4").addClass("-none"); //反之不等於-1，就是表示兩邊有共同的id，所以要隱藏起來
          }
        }
      }
    }
    
    /*==================================================印出sessionStorage的資料，更新產品列表==================================================*/
    function printSessionStorage_and_refreshProduct(day_number) {
      let get_Data = JSON.parse(sessionStorage.getItem(day_number)); //取得要切換天數的sessionStorage，把資料印出
      if (get_Data != null) { //判斷取得的sessionStorage有沒有資料，若有就將"請加入行程"-none，反之則無
        if (get_Data.length != 0) {
          $("p.no_schedule").addClass("-none");
        }else {
          $("p.no_schedule").removeClass("-none");
        }
      } else {
        $("p.no_schedule").removeClass("-none");
      }
      $.each(get_Data, function (index, items) {
      console.log(items)
        scheduleView_afterDistance(items.product_ID, items.sort, items.product_img, items.product_name, items.stay_time, items
          .schedule_info, items.product_Latitutde, items.product_Longitude);
      });
      // $("div.product_body_content").html(
      //   '<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>'); //讀取動畫
      setTimeout(function () {
        sortProduct(filter_product); //將最新產品的篩選結果，重新顯示一次
      }, 300);
    }
    
    function printSessionStorage_and_refreshProduct_for_init(day_number) {
      let get_Data = JSON.parse(sessionStorage.getItem(day_number)); //取得要切換天數的sessionStorage，把資料印出
      if (get_Data != null) { //判斷取得的sessionStorage有沒有資料，若有就將"請加入行程"-none，反之則無
        if (get_Data.length != 0) {
          $("p.no_schedule").addClass("-none");
        }else {
          $("p.no_schedule").removeClass("-none");
        }
      } else {
        $("p.no_schedule").removeClass("-none");
      }
      $.each(get_Data, function (index, items) {
      console.log(items)
        scheduleView_afterDistance(items.product_ID, items.sort, items.product_img, items.product_name, items.stay_time, items
          .schedule_info, items.product_Latitutde, items.product_Longitude);
      });
      // $("div.product_body_content").html(
      //   '<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>'); //讀取動畫
      setTimeout(function () {
        sortProduct(filter_product); //將最新產品的篩選結果，重新顯示一次
      }, 2000);
    }
    
    /*==================================================載入此頁面做的事：選擇的天數、從編輯行程或我的行程按鈕過來==================================================*/
    function init(selected_county) {
      let $ul = $("ul#sum_day");
      let add_day = "";
      let millisecond = 60 * 60 * 24 * 1000;
      let first_day = $ul.attr("data-start");
      let last_day = $ul.attr("data-end");
      let total_day = $ul.attr("data-days");
      let time = new Date(first_day).getTime();
      if (total_day > 10) {
        $ul.addClass("-onScroll");
      } else {
        $ul.removeClass("-onScroll");
      }
      for (let i = 1; i <= total_day; i++) {
        let start_date = flatpickr.formatDate(new Date(time), 'Y-m-d');
        if(i == 1){
          add_day +=
          `<li class="Day` + i + `"data-sort="` + i + `"data-date="` + start_date + `">
          <button type="button" class="btn btn-primary btn-lg add_bg selected">Day` + i + `<span class="delete_day -none"><i class="fas fa-trash-alt"></i></span></button>
          </li>`;
        }else{
          add_day +=
            `<li class="Day` + i + `"data-sort="` + i + `"data-date="` + start_date + `">
            <button type="button" class="btn btn-primary btn-lg add_bg">Day` + i + `<span class="delete_day -none"><i class="fas fa-trash-alt"></i></span></button>
            </li>`;
        }
        time += millisecond;
        sessionStorage.setItem('Day'+i, JSON.stringify([]));          //為了讓產生行程時判斷有沒有空行程而做
      }
      $ul.html(add_day);
      let day_number = $("div.schedule_header p").html(); //取得當前的天數

      $.ajax({ //這個ajax是要取得使用者的行程資料
        url: "<%=request.getContextPath()%>/project/JsonController",
        type: "POST",
        data: {
          "action": "load_schedule",
          "cust_schedule_id": $("div.input_title").attr("data-schedule-id"),
          "selected_county": JSON.stringify(selected_county),      //或許可以不用傳這個參數，沒時間研究
        },
        dataType: "json",
        success: function (data) {
          if (data.hasOwnProperty("userSchedule")) { //判斷回傳的物件是否有查詢到資料 = 這個key
            let dataResult = data.userSchedule; //初始化
            let userSchedule = [];
            let count = 1; //計算天數
            $.each(dataResult, function (i, value) {
              let data = {
                "date": value.cust_Schedule_Detail_Date,
                "product_ID": value.productVO.product_ID,
                "product_name": value.productVO.product_Name,
                "product_img": "<%=request.getContextPath()%>/ImageController?action=printImage_product_id&product_id=" + value.productVO.product_ID,
                "stay_time": value.productVO.product_Staytime,
                "sort": value.cust_Schedule_Detail_Seq.toString(), //從後端傳來的是數字
                "schedule_info": value.cust_Schedule_Detail_Info == null ? "" : value.cust_Schedule_Detail_Info, //如果一開始沒輸入備註，從後端傳來的值就是null，所以要判斷
                "product_Latitutde": value.productVO.product_Latitutde,
                "product_Longitude": value.productVO.product_Longitude
              };
              userSchedule.push(data);
              try { //這邊是為了要偵測下一個陣列是否有符合條件，跑到最後一個陣列時一定會跳錯誤，所以用try catch包起來
                if (dataResult[i + 1].cust_Schedule_Detail_Seq == 0) {
                  sessionStorage.setItem("Day" + count, JSON.stringify(userSchedule)); //存到sessionStorage
                  userSchedule = []
                  count++;
                }
              } catch (e) {
                sessionStorage.setItem("Day" + count, JSON.stringify(userSchedule));
              } //若被捕捉到例外，代表到了最後一筆資料，直接存到sessionStorage
            });
            printSessionStorage_and_refreshProduct_for_init(day_number);
          }
        },
        error: function () {
          console.log("fail")
        }
      });
    }
    
    /*==================================================新增行程區塊的function==================================================*/
    function scheduleView(product_ID, sort, product_img, product_name, stay_time, schedule_info, product_Latitutde,
      product_Longitude, distance) {
      let distance_result = distance == undefined?"": distance;
      let insertHtml = `<li class="schedule_block" id="` + product_ID + `"data-sort="` + sort + `" data-latitutde="` + product_Latitutde + `" 
                          data-longitude="` + product_Longitude + `" style="padding-left: 15px; padding-right: 15px;">
                          <div class="row" style="padding-left: 15px; padding-right: 15px;">
                            <div class="col-10 col-md-10">
                                <div class="row del" style="padding-left: 15px; padding-right: 15px; margin-top: 20px;">
                                <div class="col col-md-6">
                                  <span><i class="fas fa-car-side fa-2x"></i></span>
                                  <span class="distance"> `+distance_result+`</span>
                                </div>
                                <div class="col col-md-6" >
                                  <span><i class="fas fa-arrow-down fa-2x"></i></span>
                                </div>
                              </div>
                              <div class="detail_block">
                                <div class="detail_top">
                                  <div class="detail_img">
                                    <img src="` + product_img + `">
                                  </div>
                                  <div class="detail_time">
                                    <p style="font-size: 24px">` + product_name + `</p>
                                    <p><i class="far fa-clock"></i> 建議遊玩時間：<span>` + stay_time + `</span>小時</p>
                                  </div>
                                </div>
                                <div class="detail_info">
                                  <p>` + schedule_info + `</p>
                                </div>
                              </div>
                            </div>
                            <div class="col-2 col-md-2 align-self-center" style="margin-top:50px; text-align: center;">
                              <span class="trash" style="cursor: pointer;"><i class="fas fa-trash-alt fa-2x"></i></span>
                            </div>
                            
                          </div>
                        </li>`;
      let no_km = `<li class="schedule_block" id="` + product_ID + `"data-sort="` + sort + `" data-latitutde="` + product_Latitutde + `" 
                          data-longitude="` + product_Longitude + `" style="padding-left: 15px; padding-right: 15px;">
                          <div class="row" style="padding-left: 15px; padding-right: 15px;">
                            <div class="col-10 col-md-10">
                              <div class="detail_block">
                                <div class="detail_top">
                                  <div class="detail_img">
                                    <img src="` + product_img + `">
                                  </div>
                                  <div class="detail_time">
                                    <p style="font-size: 24px">` + product_name + `</p>
                                    <p><i class="far fa-clock"></i> 建議遊玩時間：<span>` + stay_time + `</span>小時</p>
                                  </div>
                                </div>
                                <div class="detail_info">
                                  <p>` + schedule_info + `</p>
                                </div>
                              </div>
                            </div>
                            <div class="col-2 col-md-2 align-self-center" style="text-align: center;">
                              <span class="trash" style="cursor: pointer;"><i class="fas fa-trash-alt fa-2x"></i></span>
                            </div>
                           
                        </li>`;
      if ($("ul.schedule_list").find("li").hasClass("schedule_block")) {
        $("ul.schedule_list").append(insertHtml);
      } else {
        $("ul.schedule_list").append(no_km);
      }
      // <div class="col-1 col-md-1 align-self-center" style="margin-top:50px;">
      //                         <span><i class="fas fa-bars fa-2x"></i></span>
      //                       </div>
      // <div class="col-1 col-md-1 align-self-center">
      //                         <span><i class="fas fa-bars fa-2x"></i></span>
      //                     </div>
    }
    
      /*==================================================新增行程區塊的function(有距離計算)==================================================*/
      let start;
      function scheduleView_afterDistance(product_ID, sort, product_img, product_name, stay_time, schedule_info, product_Latitutde,
      product_Longitude) {
      let insertHtml = `<li class="schedule_block" id="` + product_ID + `"data-sort="` + sort + `" data-latitutde="` + product_Latitutde + `" 
                          data-longitude="` + product_Longitude + `" style="padding-left: 15px; padding-right: 15px;">
                          <div class="row" style="padding-left: 15px; padding-right: 15px;">
                            <div class="col-10 col-md-10">
                                <div class="row del" style="padding-left: 15px; padding-right: 15px; margin-top: 20px;">
                                <div class="col col-md-6">
                                  <span><i class="fas fa-car-side fa-2x"></i></span>
                                  <span class="distance"></span>
                                </div>
                                <div class="col col-md-6" >
                                  <span><i class="fas fa-arrow-down fa-2x"></i></span>
                                </div>
                              </div>
                              <div class="detail_block">
                                <div class="detail_top">
                                  <div class="detail_img">
                                    <img src="` + product_img + `">
                                  </div>
                                  <div class="detail_time">
                                    <p style="font-size: 24px">` + product_name + `</p>
                                    <p><i class="far fa-clock"></i> 建議遊玩時間：<span>` + stay_time + `</span>小時</p>
                                  </div>
                                </div>
                                <div class="detail_info">
                                  <p>` + schedule_info + `</p>
                                </div>
                              </div>
                            </div>
                            <div class="col-2 col-md-2 align-self-center" style="margin-top:50px; text-align: center;">
                              <span class="trash" style="cursor: pointer;"><i class="fas fa-trash-alt fa-2x"></i></span>
                            </div>
                            
                        </li>`;
      let no_km = `<li class="schedule_block" id="` + product_ID + `"data-sort="` + sort + `" data-latitutde="` + product_Latitutde + `" 
                          data-longitude="` + product_Longitude + `" style="padding-left: 15px; padding-right: 15px;">
                          <div class="row" style="padding-left: 15px; padding-right: 15px;">
                            <div class="col-10 col-md-10">
                              <div class="detail_block">
                                <div class="detail_top">
                                  <div class="detail_img">
                                    <img src="` + product_img + `">
                                  </div>
                                  <div class="detail_time">
                                    <p style="font-size: 24px">` + product_name + `</p>
                                    <p><i class="far fa-clock"></i> 建議遊玩時間：<span>` + stay_time + `</span>小時</p>
                                  </div>
                                </div>
                                <div class="detail_info">
                                  <p>` + schedule_info + `</p>
                                </div>
                              </div>
                            </div>
                            <div class="col-2 col-md-2 align-self-center" style="text-align: center;">
                              <span class="trash" style="cursor: pointer;"><i class="fas fa-trash-alt fa-2x"></i></span>
                            </div>
                            
                        </li>`;
      if ($("ul.schedule_list").find("li").hasClass("schedule_block")) {
        $("ul.schedule_list").append(insertHtml);
      } else {
        $("ul.schedule_list").append(no_km);
      }
      // <div class="col-1 col-md-1 align-self-center" style="margin-top:50px;">
      //                         <span><i class="fas fa-bars fa-2x"></i></span>
      //                      </div>
      // <div class="col-1 col-md-1 align-self-center">
      //                         <span><i class="fas fa-bars fa-2x"></i></span>
      //                     </div>
      
      let li_length =  $("ul.schedule_list").children("li").length;
      let directionsService = new google.maps.DirectionsService;
      let distance;
      let lat = parseFloat(product_Latitutde);
      let lng = parseFloat(product_Longitude);
      if(li_length == 1){
        start = {lat: lat, lng: lng};
      }
      if(li_length > 1){
        let end = {lat: lat, lng: lng};
        directionsService.route({
          origin: start,         // Note that Javascript allows us to access the constant
          destination: end,  // using square brackets and a string value as its"property."
          travelMode: google.maps.TravelMode['DRIVING']
        }, function(response, status) {
            if (status == 'OK') {
              distance = response.routes[0].legs[0].distance.text; 
              $("li#"+product_ID).find("span.distance").html(distance);
            } else {
              console.log('Directions request failed due to ' + status);
            }
          });
        start = {lat: lat, lng: lng};
      }
  }
      
    /*==================================================取得行程列表的當前資訊==================================================*/
    function take_schedule_list(array) {
      $("ul.schedule_list").find("li").each(function (index, items) { //讀取當前天數的內容，儲存於current_data
        let date = $("div.schedule_header").attr("data-date");
        let product_ID = $(this).attr("id");
        let product_name = $(this).find("div.detail_time p").html();
        let product_img = $(this).find("div.detail_img img").attr("src");
        let stay_time = $(this).find("div.detail_time span").html();
        let schedule_info = $(this).find("div.detail_info p").html();
        let product_Latitutde = $(this).attr("data-latitutde");
        let product_Longitude = $(this).attr("data-longitude");
        let sort = $(this).attr("data-sort");
        let day_number = $("div.schedule_header").find("p").html();
        let currentData = {
          "date": date,
          "product_ID": product_ID,
          "product_name": product_name,
          "product_img": product_img,
          "stay_time": stay_time,
          "sort": sort,
          "schedule_info": schedule_info,
          "product_Latitutde": product_Latitutde,
          "product_Longitude": product_Longitude,
          "day_number": day_number
        };
        array.push(currentData);
      });
    }
    
    /*==================================================星星數量的function==================================================*/
    function checkStar(starAvg){
      let print_star = "";
      for(let i = 1; i <= 5; i++){
        if(starAvg >= i){
          if(starAvg != i && starAvg < (i + 1)){
            print_star += `<span>` + full_star + `</span>
                           <span>` + half_star + `</span>`;
            i++;
          }else{
            print_star += `<span>` + full_star + `</span>`;
          }
        }else {
          print_star += `<span>` + empty_star + `</span>`;
        }
      }
      return print_star;
    }
    
    /*==================================================檢查當前行程列表全部的ID是否跟彈跳視窗的產品ID相同==================================================*/
    function check_Id(schedule_id, product_id) {
      if (schedule_id.length != 0) {
        for (j of schedule_id) {
          if (j === product_id) {
            return true;
          }
        }
      }
      return false
    }
    
    /*==================================================檢查兩個陣列裡物件的內容==================================================*/
    function checkArray(arrayA, arrayB) {
      if (!Array.isArray(arrayA) || !Array.isArray(arrayB)) {
        return false;
      } else if (arrayA.length != arrayB.length) {
        return false;
      } else {
        for (var i = 0; i < arrayA.length; i++) {
          console.log("進迴圈")
          if (arrayA[i].product_ID !== arrayB[i].product_ID || arrayA[i].schedule_info !== arrayB[i].schedule_info) {
            console.log("不一樣") //依照物件內的name自行更改
            return false;
            break;
          }
        }
      }
    }
  </script>
</body>

</html>