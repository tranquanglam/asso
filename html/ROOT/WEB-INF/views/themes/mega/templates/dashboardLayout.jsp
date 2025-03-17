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
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/dashboard.css" />
    <c:if test="${not empty stylesheets}">
        <c:forEach var="css" items="${stylesheets}">
            <link rel="stylesheet" type="text/css" href="${css}">
        </c:forEach>
    </c:if>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="row flex-xl-nowrap">
        <div class="col-12 col-md-1 bd-sidebar pl-0 pr-0">
            <div class="text-center border-bottom p-2 font-weight-bold text-primary">
                <a href="/"><i class="fa fa-home" aria-hidden="true"></i></a>
            </div>
            <security:authorize access="hasAnyAuthority('CUSTOMER')">
                <div class="text-center border-bottom pt-4 pb-4 pl-4 pr-4 font-weight-bold text-primary bd-sidebar-dashboard">
                    <a href="/my/booking.html"><i class="fa fa-2x fa-cart-arrow-down text-primary" aria-hidden="true"></i></a>
                </div>
                <div class="text-center border-bottom pt-4 pb-4 pl-4 pr-4 font-weight-bold text-primary bd-sidebar-profile">
                    <a href="/my/profile.html"><i class="fa fa-2x fa-user text-success" aria-hidden="true"></i></a>
                </div>
            </security:authorize>
            <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-summary">
                    <a href="/bo/report/summary.html" title="<fmt:message key='menu.title.summary_report'/>">
                        <i class="fa fa-line-chart text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='menu.title.summary_report'/></div>
                    </a>
                </div>
            </security:authorize>
            <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_USER','PM')">
                <div class="text-center border-bottom p-2 font-weight-bold text-primary bd-sidebar-dashboard">
                    <a href="/my/dashboard.html"><i class="fa fa-tachometer text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='menu.title.dashboard'/></div>
                    </a>
                </div>
                <c:if test="${fn:contains(site.agent.supplierproducts,'APPOINTMENT')}">
                    <div class="text-center border-bottom p-2 font-weight-bold text-info bd-sidebar-cal">
                        <a href="/bo/data/cal">
                            <i class="fa fa-calendar text-info" aria-hidden="true"></i>
                            <div class="sm-text">Calendar</div>
                        </a>
                    </div>
                </c:if>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-booking">
                    <a href="/my/booking.html" title="<fmt:message key='label.my-booking'/>">
                        <i class="fa fa-cart-arrow-down text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.my-booking'/></div>
                    </a>
                </div>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-report-group">
                    <a href="/bo/report/zip.html" title="<fmt:message key='label.report-zip'/>">
                        <i class="fa fa-list-ul text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.report-zip'/></div>
                    </a>
                </div>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-report-group">
                    <a href="/bo/report/booker.html" title="<fmt:message key='label.report-booker'/>">
                        <i class="fa fa-list-ul text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.report-booker'/></div>
                    </a>
                </div>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-group-booking">
                    <a href="/my/group-booking.html" title="<fmt:message key='label.group-booking'/>">
                        <i class="fa fa-object-group text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.group-booking'/></div>
                    </a>
                </div>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-report-group">
                    <a href="/bo/report/group.html" title="<fmt:message key='label.report-group'/>">
                        <i class="fa fa-list-ul text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.report-group'/></div>
                    </a>
                </div>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-customer">
                    <a href="/my/customers.html" title="<fmt:message key='label.my-customers'/>">
                        <i class="fa fa-users text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.my-customers'/></div>
                    </a>
                </div>
            </security:authorize>
            <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-manufacturer">
                    <a href="/bo/data/manufacturers.html" title="<fmt:message key='label.manufacturer'/>">
                        <i class="fa fa-trademark text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.manufacturer'/></div>
                    </a>
                </div>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-category">
                    <a href="/bo/data/categories.html" title="<fmt:message key='label.categories'/>">
                        <i class="fa fa-folder text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.categories'/></div>
                    </a>
                </div>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-product">
                    <a href="/bo/data/products.html" title="<fmt:message key='label.product'/>">
                        <i class="fa fa-database text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.product'/></div>
                    </a>
                </div>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-product">
                    <a href="/bo/data/promotions" title="<fmt:message key='label.promotions'/>">
                        <i class="fa fa-gift text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='label.promotions'/></div>
                    </a>
                </div>
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-shippingfees">
                    <a href="/bo/data/shippingfees.html" title="<fmt:message key='shipping.fee'/>">
                        <i class="fa fa-truck text-success" aria-hidden="true"></i>
                        <div class="sm-text"><fmt:message key='shipping.fee'/></div>
                    </a>
                </div>
            </security:authorize>
            <c:if test="${fn:contains(site.agent.supplierproducts,'APPOINTMENT')}">
                <div class="text-center border-bottom p-2 font-weight-bold bd-sidebar-account-balance">
                    <a href="/loyalty/account-balance.html" title="Account balance">
                        <i class="fa fa-money text-info" aria-hidden="true"></i>
                        <div class="sm-text">Account balance</div>
                    </a>
                </div>
                <div class="text-center p-2 font-weight-bold text-primary bd-sidebar-gstudy">
                    <a href="/my/gstudy/products.html">
                        <i class="fa fa-book text-success" aria-hidden="true"></i>
                        <div class="sm-text">Books</div>
                    </a>
                </div>
            </c:if>
        </div>
        <main class="col-12 col-md-11 py-md-3 pl-md-3" role="main">
            <div class="main-content">
                <tiles:insertAttribute name="content"/>
            </div>
        </main>
    </div>
</div>
<div class="sending-loader">
    <div class="sending-loader-content"></div>
</div>
</body>
<script type="text/javascript" src="/themes/mega/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/dashboard.js"></script>
<c:if test="${not empty javascripts}">
    <c:forEach var="script" items="${javascripts}">
        <script type="text/javascript" src="<c:url value="${script}"/>"></script>
    </c:forEach>
</c:if>
</html>
