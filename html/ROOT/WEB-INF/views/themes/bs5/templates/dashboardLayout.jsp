<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/common/taglibs.jsp"%>
<tiles:importAttribute name="stylesheets"/>
<tiles:importAttribute name="javascripts"/>
<c:set var="logo" value="${site.desktopLogo}"/>
<c:set var="avatar" value="/themes/grayscale/assets/img/avatar/avatar-0.png"/>
<c:if test="${not empty userInfo.avatar}">
    <c:set var="avatar" value="${userInfo.avatar}"/>
</c:if>
<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta property="og:url"           content="https://${site.domain}${requestScope['javax.servlet.forward.request_uri']}" />
    <meta property="og:type"          content="website" />
    <meta property="og:title"         content="${page.name}" />
    <meta property="og:description"   content="${page.content}" />
    <title>${page.name}</title>
    <link type="image/x-icon" href="${initParam.hostmedia}${site.favicon}" rel="shortcut icon"/>
    <link rel="stylesheet" href="/themes/agent/bs-icons/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet-ext.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/dashboard.css" />
    <link href="/themes/mega/css/select2-bootstrap-5.min.css" rel="stylesheet">
    <link href="/themes/mega/css/select2-bootstrap-5-theme.min.css" rel="stylesheet">
    <link href="/themes/agent/css/datatables.min.css" rel="stylesheet">

    <c:if test="${not empty stylesheets}">
        <c:forEach var="css" items="${stylesheets}">
            <link rel="stylesheet" type="text/css" href="${css}">
        </c:forEach>
    </c:if>

    <c:if test="${not empty siteStyle && not empty siteStyle.dashboardCss}">
        <style>
            ${siteStyle.dashboardCss}
        </style>
    </c:if>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body class="font-sans">
<div class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
    <!-- Vertical Navbar -->
    <nav class="navbar show navbar-vertical h-lg-screen navbar-expand-lg px-0 py-3 py-lg-0 navbar-dark bg-primary border-end-lg" id="navbarVertical">
        <div class="container-fluid">
            <!-- Toggler -->
            <button class="navbar-toggler ms-n2" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarCollapse" aria-controls="sidebarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- Brand -->
            <a class="navbar-brand py-lg-5 px-lg-6 me-0" href="/">
                <img src="${logo}" alt="...">
            </a>
            <!-- User menu (mobile) -->
            <div class="navbar-user d-lg-none">
                <!-- Dropdown -->
                <div class="dropdown">
                    <!-- Toggle -->
                    <a href="#" id="sidebarAvatar" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <div class="avatar bg-warning rounded-circle text-white">
                            <img alt="..." src="${avatar}">
                        </div>
                    </a>
                    <!-- Menu -->
                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                        <div class="dropdown-item">
                            <span class="d-block text-sm text-muted mb-1">Signed in as</span>
                            <span class="d-block text-heading font-semibold">${userInfo.firstName} ${userInfo.lastName}</span>
                        </div>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="/my/profile.html"><fmt:message key='label.my-profile'/></a>
                        <a class="dropdown-item" href="/loyalty/account-balance.html">Account balance</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" onclick="document.getElementById('logout').submit();">Logout</a>
                    </div>
                </div>
            </div>
            <!-- Collapse -->
            <div class="collapse navbar-collapse" id="sidebarCollapse">
                <!-- Navigation -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="/dashboard.html">
                            <i class="bi bi-speedometer"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/my/booking.html">
                            <i class="bi bi-journal-medical"></i> <fmt:message key='label.my-booking'/>
                        </a>
                    </li>
                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_USER')">
                    <li class="nav-item">
                        <a class="nav-link" href="/my/group-booking.html" title="<fmt:message key='label.group-booking'/>">
                            <i class="bi bi-collection"></i> <fmt:message key='label.group-booking'/>
                        </a>
                    </li>
                    </security:authorize>
                </ul>
                <!-- Divider -->
                <hr class="navbar-divider my-5 opacity-20">
                <!-- Navigation -->
                <ul class="navbar-nav mb-md-4">
                    <c:if test="${fn:contains(site.agent.supplierproducts,'AFFILIATE')}">
                    <security:authorize access="hasAnyAuthority('CUSTOMER','AGT_USER')">
                        <li class="nav-item">
                            <a class="nav-link" href="/share/affiliate-program.html" title="<fmt:message key='affiliate.program'/>">
                                <i class="bi bi-share"></i> <fmt:message key='affiliate.program'/>
                            </a>
                        </li>
                    </security:authorize>
                    </c:if>
                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_USER')">
                        <li class="nav-item">
                            <a class="nav-link" href="#reportdata-nav" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="reportdata-nav">
                                <i class="bi bi-graph-up-arrow"></i> <fmt:message key='menu.title.report'/>
                            </a>
                            <div class="collapse" id="reportdata-nav">
                                <ul class="nav nav-sm flex-column">
                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/report/summary.html" title="<fmt:message key='menu.title.summary_report'/>">
                                                <i class="bi bi-bar-chart-line" aria-hidden="true"></i>
                                                <div class="sm-text"><fmt:message key='menu.title.summary_report'/></div>
                                            </a>
                                        </li>
                                    </security:authorize>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/bo/report/zip.html">
                                            <i class="bi bi-geo-alt"></i> <fmt:message key='label.report-zip'/>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/bo/report/booker.html">
                                            <i class="bi bi-person-plus"></i> <fmt:message key='label.report-booker'/>
                                        </a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" href="/bo/report/group.html" title="<fmt:message key='label.report-group'/>">
                                            <i class="bi bi-bar-chart"></i> <fmt:message key='label.report-group'/>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </security:authorize>
                        <li class="nav-item">
                            <a class="nav-link" href="#metadata-nav" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="metadata-nav">
                                <i class="bi bi-files"></i> Meta data
                            </a>
                            <div class="collapse" id="metadata-nav">
                                <ul class="nav nav-sm flex-column">
                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','PRODUCT_W', 'PRODUCT_R')">
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/products.html">
                                                <i class="bi bi-question-circle"></i> <fmt:message key='label.product'/>
                                            </a>
                                        </li>
                                    </security:authorize>
                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_USER', 'AGT_SUSER')">
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/manufacturers.html">
                                                <i class="bi bi-markdown"></i> <fmt:message key='label.manufacturer'/>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/categories.html">
                                                <i class="bi bi-file-bar-graph"></i> <fmt:message key='label.categories'/>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/providers.html">
                                                <i class="bi bi-house"></i> <fmt:message key='label.providers'/>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/promotions">
                                                <i class="bi bi-gift"></i> <fmt:message key='label.promotions'/>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/shippingfees.html">
                                                <i class="bi bi-truck"></i> <fmt:message key='shipping.fee'/>
                                            </a>
                                        </li>
                                    </security:authorize>

                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','CUSTOMER_R', 'CUSTOMER_W')">
                                        <li class="nav-item">
                                            <a class="nav-link" href="/my/customers.html">
                                                <i class="bi bi-people"></i> <fmt:message key='label.my-customers'/>
                                            </a>
                                        </li>
                                    </security:authorize>

                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                        <li class="nav-item">
                                            <a class="nav-link" href="/my/messages.html">
                                                <i class="bi bi-envelope"></i> <fmt:message key='label.my-messages'/>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/sizes.html">
                                                <i class="bi bi-textarea-resize"></i> <fmt:message key='label.size'/>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/colors.html">
                                                <i class="bi bi-palette"></i> <fmt:message key='label.color'/>
                                            </a>
                                        </li>
                                    </security:authorize>

                                </ul>
                            </div>
                        </li>
                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','INPUT_R', 'INPUT_W','OUTPUT_R', 'OUTPUT_W')">
                        <li class="nav-item">
                            <a class="nav-link" href="#material-store-data-nav" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="material-store-data-nav">
                                <i class="bi bi-shop-window"></i> <fmt:message key='material.store'/>
                            </a>
                            <div class="collapse" id="material-store-data-nav">
                                <ul class="nav nav-sm flex-column">
                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','INPUT_R', 'INPUT_W')">
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/materialinput.html">
                                                <i class="bi bi-save2"></i> <fmt:message key='material.input'/>
                                            </a>
                                        </li>
                                    </security:authorize>
                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','OUTPUT_R', 'OUTPUT_W')">
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/material-ouput.html">
                                                <i class="bi bi-list-check"></i> <fmt:message key='material.output'/>
                                            </a>
                                        </li>
                                    </security:authorize>

                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                        <li class="nav-item">
                                            <a class="nav-link" href="/bo/data/materials.html">
                                                <i class="bi bi-palette"></i> <fmt:message key='label.materials'/>
                                            </a>
                                        </li>
                                    </security:authorize>
                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','BRANCH_W','BRANCH_R')">
                                                    <li class="nav-item">
                                                        <a class="nav-link" href="/bo/data/branches.html">
                                                            <i class="bi bi-shop"></i> <fmt:message key='label.branch'/>
                                                        </a>
                                                    </li>
                                    </security:authorize>
                                </ul>
                            </div>
                        </li>
                    </security:authorize>

                        <c:if test="${fn:contains(site.agent.supplierproducts,'APPOINTMENT')}">
                            <li class="nav-item">
                                <a class="nav-link" href="/bo/data/cal">
                                    <i class="bi bi-calendar"></i> Calendar
                                </a>
                            </li>
                        </c:if>
                        <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                            <li class="nav-item">
                                <a class="nav-link" href="/agent/settings">
                                    <i class="bi bi-gear-wide"></i> App Config
                                </a>
                            </li>
                        </security:authorize>
                </ul>
                <!-- Push content down -->
                <div class="mt-auto"></div>
                <form id="logout" class="d-none" method="post" action="/j_spring_security_logout">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <ul class="navbar-nav mb-5">
                    <li class="nav-item">
                        <a class="nav-link" href="/my/profile.html">
                            <i class="bi bi-person-square"></i> <fmt:message key='label.my-profile'/>
                        </a>
                    </li>
                    <c:if test="${fn:contains(site.agent.supplierproducts,'APPOINTMENT')}">
                        <li class="nav-item">
                            <a class="nav-link" href="/loyalty/account-balance.html" title="Account balance">
                                <i class="bi bi-coin"></i> Account balance
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/my/gstudy/products.html">
                                <i class="bi bi-book"></i> Books
                            </a>
                        </li>
                    </c:if>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="document.getElementById('logout').submit();">
                            <i class="bi bi-box-arrow-left"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Main content -->
    <div class="h-screen flex-grow-1 overflow-y-lg-auto">
        <!-- Main content -->
        <main class="p-0">
            <!-- Container -->
            <div class="container-xl">
                <tiles:insertAttribute name="content"/>
            </div>
        </main>
    </div>
</div>

<script type="text/javascript" src="/themes/agent/js/datatables.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/select2-bootstrap-5.full.min.js"></script>
<script type="text/javascript" src="/themes/agent/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="/themes/grayscale/js/dashboard.js"></script>
<c:if test="${not empty javascripts}">
    <c:forEach var="script" items="${javascripts}">
        <script type="text/javascript" src="${script}"></script>
    </c:forEach>
</c:if>
</body>
</html>
