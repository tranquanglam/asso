<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="headerid" value="header_jcontent_${site.siteid}"/>
<c:set var="bmenu" value="${applicationScope[headerid].localmenu}"/>
<c:if test="${lang eq 'en'}">
    <c:set var="bmenu" value="${applicationScope[headerid].menu}"/>
</c:if>
<style>
    .navbar-brand {
        width: 20%;
        display: inline;
    }
    .navbar-menu-search-container {
        max-height: 117px;
        width: 80%;
        display: inline;
    }
    .navbar-menu-search {
        height: 50px;
        padding-top: 1rem;
    }
    .navbar-menu-search .omnisearch-form {
        min-width: 440px;
        height: 37px;
    }
    .navbar-menu-search .omnisearch-form .input-group-text,.navbar-menu-search .omnisearch-form .form-control {
        height: 35px;
    }
    .navbar-menu-search .omnisearch-suggestions {
        display: none;
    }
    .navbar-menu-search .omnisearch-suggestions.show {
        display: block;
        pointer-events: auto;
        opacity: 1;
    }
    .omnisearch-container {
        position: relative;
    }
    .omnisearch-container .omnisearch-form .form-control:-ms-input-placeholder {
        color: #C0CCDA; }
    .omnisearch-container .omnisearch-form .form-control::placeholder {
        color: #C0CCDA; }
    .omnisearch-container .omnisearch-suggestions {
        width: 680px;
        min-height: 150px;
        padding: 1.5rem;
        background: white;
        margin: auto;
        border-radius: 0.375rem;
        position: relative;
        opacity: 0;
        transition: opacity 0.3s;
        transition-delay: 0.21s; }
    @media (prefers-reduced-motion: reduce) {
        .omnisearch .omnisearch-suggestions {
            transition: none; } }
    .omnisearch-container .omnisearch-suggestions:before {
        background: #FFF;
        box-shadow: none;
        content: '';
        display: block;
        height: 16px;
        width: 16px;
        left: 20px;
        position: absolute;
        bottom: 100%;
        transform: rotate(-45deg) translateY(1rem);
        z-index: -5;
        border-radius: .2rem; }
    .omnisearch-container .omnisearch-suggestions .heading {
        color: #8492A6; }
    .omnisearch-container .omnisearch-suggestions .list-link span {
        font-weight: 600;
        color: #3C4858; }
    .omnisearch-container .omnisearch-suggestions .list-link:hover {
        color: #306EFF; }
    .omnisearch-container .omnisearch-suggestions .list-link:hover span {
        color: #306EFF; }
    @media (max-width: 991.98px) {
        .navbar-brand {
            width: 50% !important;
        }
        .omnisearch-container .omnisearch-form {
            width: 100%; }
        .omnisearch-container .omnisearch-suggestions {
            width: 100%; } }

    .navbar-main-menu-container {
        margin-top: 1rem;
        margin-bottom: 0;
    }
</style>
<header class="header ${bmenu.cssClass}" id="header-main">
    <c:if test="${bmenu.bmenuTop.show}">
        <div id="navbar-top-main" class="navbar-top ${bmenu.bmenuTop.cssClass}">
            <div class="container px-0">
                <div class="navbar-nav align-items-center">
                    <c:if test="${bmenu.bmenuTop.titleItem != null}">
                        <div class="${bmenu.bmenuTop.titleItem.cssClass}">
                                ${bmenu.bmenuTop.titleItem.label}
                        </div>
                    </c:if>
                    <c:if test="${not empty bmenu.bmenuTop.leftItems}">
                        <div>
                            <ul class="nav">
                                <c:forEach var="item" items="${bmenu.bmenuTop.leftItems}">
                                    <c:choose>
                                        <c:when test="${item.type eq 'dropdown'}">
                                            <li class="nav-item dropdown ms-lg-2">
                                                <a class="nav-link px-0" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        ${item.label}
                                                </a>
                                                <div class="dropdown-menu dropdown-menu-sm">
                                                    <c:forEach var="sub" items="${item.items}">
                                                        <a href="${sub.href}" class="dropdown-item">${sub.label}</a>
                                                    </c:forEach>
                                                </div>
                                            </li>
                                        </c:when>
                                        <c:when test="${item.type eq 'link'}">
                                            <li class="nav-item">
                                                <a class="nav-link" href="${item.href}">${item.label}</a>
                                            </li>
                                        </c:when>
                                        <c:when test="${item.label eq 'language'}">
                                            <li class="nav-item dropdown ms-lg-2">
                                                <c:choose>
                                                    <c:when test="${lang eq 'vi'}">
                                                        <a class="nav-link px-0" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-offset="0,10">
                                                            <img alt="Vietnamese" src="/themes/grayscale/assets/img/flags/vn.svg">
                                                            <span class="d-none d-lg-inline-block">Tiếng Việt</span>
                                                            <span class="d-lg-none">VI</span>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="nav-link px-0" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-offset="0,10">
                                                            <img alt="English" src="/themes/grayscale/assets/img/flags/us.svg">
                                                            <span class="d-none d-lg-inline-block">English</span>
                                                            <span class="d-lg-none">EN</span>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="dropdown-menu dropdown-menu-sm">
                                                    <a href="javascript:changeLang('en')" class="dropdown-item"><img alt="Change to English" src="/themes/grayscale/assets/img/flags/us.svg">English</a>
                                                    <a href="javascript:changeLang('vi')" class="dropdown-item"><img alt="Change to Vietnamese" src="/themes/grayscale/assets/img/flags/vn.svg">Tiếng Việt</a>
                                                </div>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="nav-item">
                                                <span class="${item.cssClass}">${item.label}</span>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${not empty bmenu.bmenuTop.rightItems}">
                        <div class="ms-auto">
                            <ul class="nav">
                                <c:forEach var="item" items="${bmenu.bmenuTop.rightItems}">
                                    <c:choose>
                                        <c:when test="${item.type eq 'dropdown'}">
                                            <li class="nav-item dropdown">
                                                <a class="nav-link pe-0" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        ${item.label}
                                                </a>
                                                <div class="dropdown-menu dropdown-menu-sm dropdown-menu-right">
                                                    <c:forEach var="sub" items="${item.items}">
                                                        <a href="${sub.href}" class="dropdown-item">${sub.label}</a>
                                                    </c:forEach>
                                                </div>
                                            </li>
                                        </c:when>
                                        <c:when test="${item.type eq 'link'}">
                                            <li class="nav-item">
                                                <a class="nav-link ${item.cssClass}" href="${item.href}">${item.label}</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="nav-item">
                                                <span class="${item.cssClass}">${item.label}</span>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>
    <nav class="navbar navbar-main navbar-expand-lg ${bmenu.bmenuMain.cssClass}">
        <div class="container-xl">
            <!-- Logo -->
            <a class="navbar-brand" href="/">
                <img src="${bmenu.bmenuMain.logo.logo}" style="height: ${bmenu.bmenuMain.logo.height} !important;" alt="logo">
            </a>
            <button class="navbar-toggler me-n4 ms-auto text-start" type="button" data-bs-toggle="modal" data-bs-target="#mobile_main_nav" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="navbar-menu-search-container">
                <div class="navbar-menu-search d-none d-md-block">
                    <div class="d-flex justify-content-between">
                        <div class="omnisearch-container">
                            <div class="omnisearch-form">
                                <div class="form-group">
                                    <div class="input-group input-group-merge input-group-flush">
                                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                                        <input type="text" class="form-control omnisearch-search-input" id="omnisearch-search-input" placeholder="Type ...">
                                    </div>
                                </div>
                            </div>
                            <div class="omnisearch-suggestions">
                                <p class="heading h6"><fmt:message key="label.search.suggestion"/></p>
                                <div class="row">
                                    <div class="col-12">
                                        <ul class="list-unstyled mb-0 omnisearch-result" id="omnisearch-result">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <ul class="nav">
                            <li class="nav-item dropdown">
                                <a class="nav-link pr-0 " href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="bi bi-person-circle"></i> <fmt:message key="label.my-account"/>
                                </a>

                                <div class="dropdown-menu dropdown-menu-end px-6 pt-2 pb-2 shadow-3">
                                    <security:authorize access="isAuthenticated()">
                                        <a class="dropdown-item px-0" href="/my/profile.html"><fmt:message key="label.my-profile"/></a>
                                        <a class="dropdown-item px-0" href="/my/booking.html"><fmt:message key="label.my-booking"/></a>

                                        <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                            <a class="dropdown-item px-0" href="/my/customers.html"><fmt:message key="label.my-customers"/></a>
                                            <a class="dropdown-item px-0" href="/my/messages.html"><fmt:message key="label.my-messages"/></a>
                                            <a class="dropdown-item px-0" href="/agent/news"><fmt:message key="systemadmin"/></a>
                                            <a class="dropdown-item px-0" href="/agent/design/home.html"><fmt:message key="design.homepage"/></a>
                                        </security:authorize>

                                        <div class="dropdown-divider"></div>
                                        <form id="plogout" class="d-none" method="post" action="/j_spring_security_logout">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        </form>
                                        <a href="#" onclick="document.getElementById('plogout').submit();" class="dropdown-item px-0" role="button">
                                            <fmt:message key="label.logout"/>
                                        </a>

                                    </security:authorize>
                                    <security:authorize access="isAnonymous()">
                                        <a class="dropdown-item px-0" href="/login.html"><fmt:message key="label.login"/></a>
                                        <a class="dropdown-item px-0" href="/forgotPassword.html"><fmt:message key="label.forgot-password"/></a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item px-0" href="/membershipRegister.html"><fmt:message key="customer.register"/></a>
                                    </security:authorize>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" data-action="popup-cart-items-open" data-target="#popup-cart-items">
                                                            <span id="cart-items-badge" class="bi-bi-stack has-badge" data-count="0">
                                                                <i class="bi bi-cart-fill"></i>
                                                            </span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="navbar-main-menu-container">
                    <!-- Collapse -->
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <!-- Nav -->
                        <ul class="navbar-nav w-100 justify-content-between">
                            <c:if test="${not empty bmenu.bmenuMain.leftItems}">
                                <c:forEach items="${bmenu.bmenuMain.leftItems}" var="menu">
                                    <c:choose>
                                        <c:when test="${menu.type eq 'link'}">
                                            <li class="nav-item"><a class="nav-link" href="${menu.href}">${menu.label}</a></li>
                                        </c:when>
                                        <c:when test="${menu.type eq 'text' and menu.label eq 'separator'}">
                                            <li class="separator my-auto d-none d-sm-inline"></li>
                                        </c:when>
                                        <c:when test="${menu.type eq 'dropdown'}">
                                            <li class="nav-item dropdown dropdown-animate" data-bs-toggle="hover">
                                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">${menu.label}</a>
                                                <div class="dropdown-menu dropdown-menu-md shadow-6 p-0" aria-labelledby="">
                                                    <div class="px-6 py-6">

                                                        <c:forEach items="${menu.items}" var="sub">
                                                            <a href="${sub.href}" class="dropdown-group mb-8" role="button">
                                                                <div class="d-flex align-items-center">
                                                                    <c:if test="${not empty sub.iconCss }">
                                                                        <div>
                                                                            <div class="icon icon-shape bg-info text-white text-lg rounded-4">
                                                                                <i class="${sub.iconCss}"></i>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                    <div class="ps-4">
                                                                        <span class="d-block dropdown-heading mb-0">${sub.label}</span>
                                                                        <p class="dropdown-helper">${sub.description}</p>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </c:forEach>
                                                    </div>

                                                </div>
                                            </li>
                                        </c:when>
                                        <c:when test="${menu.type eq 'dropdown-mega'}">

                                            <c:set var="isMenuDescription" value="${not empty menu.description ? true : false}" />

                                            <li class="nav-item dropdown position-static" data-bs-toggle="hover">
                                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">${menu.label}</a>
                                                <div class="dropdown-menu dropdown-menu-lg-fluid p-0 rounded-0 border-0 shadow-6" aria-labelledby="">
                                                    <div class="border-top-4 border-primary">
                                                        <div class="row g-0">
                                                            <c:if test="${isMenuDescription eq true}">
                                                                <div class="col-12 col-lg-4">
                                                                    <div class="dropdown-img-left rounded-0 ${menu.cssClass}">
                                                                        <div class="position-relative overlap-10 text-center">
                                                                            <!-- Heading -->
                                                                            <h3 class="ls-tight">
                                                                                    ${menu.label}
                                                                            </h3>
                                                                            <!-- Text -->
                                                                            <div class="text-sm mb-6">
                                                                                    ${menu.description}
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:if>

                                                            <div class="col-12 ${isMenuDescription eq true ? 'col-lg-7' : '' }">
                                                                <div class="p-6 px-10">
                                                                    <div class="row no-gutters">
                                                                        <div class="${isMenuDescription eq true ? 'col-sm-12 col-md-6 col-lg-6' : 'col-sm-12 col-md-4 col-lg-4' }">
                                                                            <c:set var="newCol" value="false"/>
                                                                            <c:forEach items="${menu.items}" var="sub">
                                                                            <c:choose>
                                                                            <c:when test="${sub.cssClass eq 'static-text'}">
                                                                            <c:if test="${newCol eq 'true'}">
                                                                        </div>
                                                                        <div class="${isMenuDescription eq true ? 'col-sm-12 col-md-6 col-lg-6' : 'col-sm-12 col-md-4 col-lg-4' }">
                                                                            <c:set var="newCol" value="false"/>
                                                                            </c:if>
                                                                            <div class="dropdown-header px-0 text-uppercase text-xs font-semibold">${sub.label}</div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <a href="${sub.href}" class="dropdown-group mb-8" role="button">
                                                                                    <div class="d-flex align-items-center">
                                                                                        <c:if test="${not empty sub.iconCss }">
                                                                                            <div>
                                                                                                <div class="icon icon-shape bg-info text-white text-lg rounded-4">
                                                                                                    <i class="${sub.iconCss}"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </c:if>

                                                                                        <div class="${not empty sub.iconCss ? 'ps-4' : ''}">
                                                                                            <span class="d-block dropdown-heading mb-0">${sub.label}</span>
                                                                                            <p class="dropdown-helper">${sub.description}</p>
                                                                                        </div>
                                                                                    </div>
                                                                                </a>
                                                                                <c:set var="newCol" value="true"/>
                                                                            </c:otherwise>
                                                                            </c:choose>
                                                                            </c:forEach>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </li>
                                        </c:when>
                                        <c:otherwise>

                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:if>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>
<div id="popup-cart-items" class="popup-cart-items">
    <div class="container">
        <div class="cart-items-container">
            <p class="heading h6"><fmt:message key="title.shopping-cart"/></p>
            <div class="row">
                <div class="col-12">
                    <div class="cart-item-list mb-0" id="cart-item-list">
                    </div>
                    <div class="mt-3 btn-checkout">
                        <div class="text-end">
                            <a href="/booking.html" class="btn btn-sm btn-primary btn-icon rounded-pill">
                                <span class="btn-inner--text"><fmt:message key="book-now"/></span>
                                <span class="btn-inner--icon"><i class="bi bi-arrow-right"></i></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Mobile -->
<div class="modal fade" id="mobile_main_nav" tabindex="-1" aria-labelledby="mobile_main_nav" aria-hidden="true">
    <div class="modal-dialog modal-dialog-slideout">
        <div class="modal-content rounded-xl">
            <div class="p-1">
                <div class="px-6 pt-4 position-relative">
                    <a class="navbar-brand" href="/">
                        <div class="w-md-auto  text-dark">
                            <img src="${bmenu.bmenuMain.logo.logo}" width="40" alt="logo">
                        </div>
                    </a>

                    <div class="position-absolute top-4 end-4 text-xs">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                </div>
                <div class="px-6 pb-4">
                    <ul class="navbar-nav flex-row flex-wrap pt-4 py-lg-0">
                        <c:if test="${not empty bmenu.bmenuMain.leftItems}">
                            <c:forEach items="${bmenu.bmenuMain.leftItems}" var="menu">
                                <c:choose>
                                    <c:when test="${menu.type eq 'link'}">
                                        <li class="nav-item col-12"><a class="nav-link  py-2" href="${menu.href}">${menu.label}</a></li>
                                    </c:when>
                                    <c:when test="${menu.type eq 'dropdown'}">
                                        <li class="nav-item dropdown dropdown-animate col-12" data-bs-toggle="hover">
                                            <a class="nav-link py-2 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">${menu.label}</a>
                                            <div class="dropdown-menu dropdown-menu-md shadow-6 p-0" aria-labelledby="">
                                                <div class="px-6 py-6">

                                                    <c:forEach items="${menu.items}" var="sub">
                                                        <a href="${sub.href}" class="dropdown-group mb-8" role="button">
                                                            <div class="d-flex align-items-center">
                                                                <c:if test="${not empty sub.iconCss }">
                                                                    <div>
                                                                        <div class="icon icon-shape bg-info text-white text-lg rounded-4">
                                                                            <i class="${sub.iconCss}"></i>
                                                                        </div>
                                                                    </div>
                                                                </c:if>
                                                                <div class="ps-4">
                                                                    <span class="d-block dropdown-heading mb-0">${sub.label}</span>
                                                                    <p class="dropdown-helper">${sub.description}</p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </c:forEach>
                                                </div>

                                            </div>
                                        </li>
                                    </c:when>
                                    <c:when test="${menu.type eq 'dropdown-mega'}">

                                        <c:set var="isMenuDescription" value="${not empty menu.description ? true : false}" />

                                        <li class="nav-item col-6 dropdown position-static" data-bs-toggle="hover">
                                            <a class="nav-link py-2 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">${menu.label}</a>
                                            <div class="dropdown-menu dropdown-menu-lg-fluid p-0 rounded-0 border-0 shadow-6" aria-labelledby="">
                                                <div class="border-top-4 border-primary">
                                                    <div class="row g-0">
                                                        <c:if test="${isMenuDescription eq true}">
                                                            <div class="col-12 col-lg-4">
                                                                <div class="dropdown-img-left rounded-0 ${menu.cssClass}">
                                                                    <div class="position-relative overlap-10 text-center">
                                                                        <!-- Heading -->
                                                                        <h3 class="ls-tight">
                                                                                ${menu.label}
                                                                        </h3>
                                                                        <!-- Text -->
                                                                        <div class="text-sm mb-6">
                                                                                ${menu.description}
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>

                                                        <div class="col-12 ${isMenuDescription eq true ? 'col-lg-7' : '' }">
                                                            <div class="p-6 px-10">
                                                                <div class="row no-gutters">
                                                                    <div class="${isMenuDescription eq true ? 'col-sm-12 col-md-6 col-lg-6' : 'col-sm-12 col-md-4 col-lg-4' }">
                                                                        <c:set var="newCol" value="false"/>
                                                                        <c:forEach items="${menu.items}" var="sub">
                                                                        <c:choose>
                                                                        <c:when test="${sub.cssClass eq 'static-text'}">
                                                                        <c:if test="${newCol eq 'true'}">
                                                                    </div>
                                                                    <div class="${isMenuDescription eq true ? 'col-sm-12 col-md-6 col-lg-6' : 'col-sm-12 col-md-4 col-lg-4' }">
                                                                        <c:set var="newCol" value="false"/>
                                                                        </c:if>
                                                                        <div class="dropdown-header px-0 text-uppercase text-xs font-semibold">${sub.label}</div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="${sub.href}" class="dropdown-group mb-8" role="button">
                                                                                <div class="d-flex align-items-center">
                                                                                    <c:if test="${not empty sub.iconCss }">
                                                                                        <div>
                                                                                            <div class="icon icon-shape bg-info text-white text-lg rounded-4">
                                                                                                <i class="${sub.iconCss}"></i>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:if>

                                                                                    <div class="ps-4">
                                                                                        <span class="d-block dropdown-heading mb-0">${sub.label}</span>
                                                                                        <p class="dropdown-helper">${sub.description}</p>
                                                                                    </div>
                                                                                </div>
                                                                            </a>
                                                                            <c:set var="newCol" value="true"/>
                                                                        </c:otherwise>
                                                                        </c:choose>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </li>
                                    </c:when>
                                    <c:otherwise>

                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:if>
                    </ul>
                    <hr class="my-4" />
                    <div class="d-flex justify-content-between">
                        <security:authorize access="isAnonymous()">
                            <div class="navbar-nav">
                                <a href="/login.html" class="nav-item nav-link"><fmt:message key="label.login"/></a>
                            </div>
                            <div class="navbar-nav">
                                <a href="/membershipRegister" class="btn btn-sm btn-primary w-full w-lg-auto">
                                    <fmt:message key="customer.register"/>
                                </a>
                            </div>
                        </security:authorize>
                        <security:authorize access="isAuthenticated()">
                            <div class="navbar-nav">
                                <a href="/my/booking.html" class="nav-item nav-link"><fmt:message key="label.my-booking"/></a>
                            </div>
                            <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                <div class="navbar-nav">
                                    <a class="nav-item nav-link" href="/agent/news"><fmt:message key="systemadmin"/></a>
                                </div>
                            </security:authorize>
                            <div class="navbar-nav">
                                <a href="#" onclick="document.getElementById('plogout').submit();" class="btn btn-sm btn-primary w-full w-lg-auto">
                                    <fmt:message key="label.logout"/>
                                </a>
                            </div>
                        </security:authorize>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


