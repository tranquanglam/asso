<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><tiles:insertAttribute name="title" ignore="true"/></title>
    <link type="image/x-icon" href="${site.favicon}" rel="shortcut icon"/>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:300,400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap-datepicker3.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/booking.css" />
    <script src="/themes/mega/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="row flex-xl-nowrap">
        <main class="col-12 py-md-3 pl-md-3" role="main">
            <div class="main-content">
                <tiles:insertAttribute name="content"/>
            </div>
        </main>
    </div>
</div>
</body>
<script type="text/javascript" src="/themes/mega/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/booking.js"></script>
</html>