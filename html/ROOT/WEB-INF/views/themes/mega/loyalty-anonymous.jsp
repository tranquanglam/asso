<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta property="og:url"           content="https://${site.domain}${requestScope['javax.servlet.forward.request_uri']}" />
    <meta property="og:type"          content="website" />
    <meta property="og:title"         content="Live deals" />
    <meta property="og:description"   content="Live deals with best price" />
    <meta name="description" content="Live deals">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="theme-color" content="#ffffff">
    <title>Live deals</title>
    <link type="image/x-icon" href="${initParam.hostmedia}${site.favicon}" rel="shortcut icon"/>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap-datepicker3.min.css" />
    <link rel="stylesheet" type="text/css" href="https://membooking.com/themes/loyalty/css/loyalty.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css" integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="container-fluid" id="loyalty-container" data-accesstoken="${access_token}" data-serverpath="https://membooking.com" data-userscope="read" data-robot="YES">
    ${page.content}
</div>
<input type="hidden" id="ftoken" value="${ftoken}">
</body>
<script type="text/javascript" src="/themes/mega/js/popper.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootbox.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/firebasejs/8.2.0/firebase-auth.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/firebasejs/8.2.0/firebase-database.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js"></script>
<script type="text/javascript" src="https://membooking.com/themes/loyalty/js/firebase-app.js"></script>
<script type="text/javascript" src="https://membooking.com/themes/loyalty/js/loyalty-anonyous.js"></script>
</html>
