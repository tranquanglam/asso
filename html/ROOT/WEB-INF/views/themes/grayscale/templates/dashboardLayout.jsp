<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/common/taglibs.jsp"%>
<tiles:importAttribute name="stylesheets"/>
<tiles:importAttribute name="javascripts"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><tiles:insertAttribute name="title" ignore="true"/></title>
    <link type="image/x-icon" href="${applicationScope['hostmedia']}${site.favicon}" rel="shortcut icon"/>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:300,400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap-datepicker3.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/doctorcalendar.css" />
    <c:if test="${not empty stylesheets}">
        <c:forEach var="css" items="${stylesheets}">
            <link rel="stylesheet" type="text/css" href="${css}">
        </c:forEach>
    </c:if>
    <script src="/themes/mega/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="row flex-xl-nowrap">
        <div class="col-12 col-md-1 bd-sidebar pl-0 pr-0">
            <div class="text-center border-bottom pt-4 pb-4 pl-4 pr-4 font-weight-bold text-primary">
                <a href="/"><i class="fa fa-2x fa-home" aria-hidden="true"></i></a>
            </div>
            <security:authorize access="hasAnyAuthority('CUSTOMER')">
                <div class="text-center border-bottom pt-4 pb-4 pl-4 pr-4 font-weight-bold text-primary bd-sidebar-dashboard">
                    <a href="/my/booking.html"><i class="fa fa-2x fa-tachometer text-primary" aria-hidden="true"></i></a>
                </div>
            </security:authorize>
            <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_USER','PM','ASSISTANT','CASHIER')">
                <div class="text-center border-bottom pt-4 pb-4 pl-4 pr-4 font-weight-bold text-primary bd-sidebar-dashboard">
                    <a href="/my/dashboard.html"><i class="fa fa-2x fa-tachometer text-primary" aria-hidden="true"></i></a>
                </div>
                <div class="text-center border-bottom pt-4 pb-4 pl-4 pr-4 font-weight-bold bd-sidebar-customer">
                    <a href="/my/customers.html" title="<fmt:message key='label.my-customers'/>"><i class="fa fa-2x fa-users text-success" aria-hidden="true"></i></a>
                </div>
                <div class="text-center border-bottom pt-4 pb-4 pl-4 pr-4 font-weight-bold bd-sidebar-booking">
                    <a href="/my/booking.html" title="<fmt:message key='label.my-booking'/>">
                        <i class="fa fa-2x fa-cart-arrow-down text-success" aria-hidden="true"></i>
                    </a>
                </div>
            </security:authorize>
            <security:authorize access="hasAnyAuthority('AGT_ADMIN','PRODUCT_W','PRODUCT_R','AGT_USER','AGT_SUSER')">
                <div class="text-center pt-4 pb-4 pl-4 pr-4 font-weight-bold bd-sidebar-product">
                    <a href="/bo/data/products.html" title="<fmt:message key='label.product'/>">
                        <i class="fa fa-2x fa-database text-success" aria-hidden="true"></i>
                    </a>
                </div>
            </security:authorize>
        </div>
        <main class="col-12 col-md-11 py-md-3 pl-md-3" role="main">
            <div class="main-content">
                <tiles:insertAttribute name="content"/>
            </div>
        </main>
    </div>
</div>
</body>
<script type="text/javascript" src="/themes/mega/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootstrap-datepicker.min.js"></script>
<c:if test="${not empty javascripts}">
    <c:forEach var="script" items="${javascripts}">
        <script type="text/javascript" src="<c:url value="${script}"/>"></script>
    </c:forEach>
</c:if>
</html>
