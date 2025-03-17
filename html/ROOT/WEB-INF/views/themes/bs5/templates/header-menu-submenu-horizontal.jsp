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
    .submenu-horizontal-item {
        display: none;
    }
    .submenu-horizontal-item.show {
        display: flex;
        flex-direction: row;
    }
    .navbar-submenu-horizontal .separator {
        width: 1px;  height: 1.2rem;  background-color: var(--main-top-header-txt-color);  padding: 0;  opacity: 0.7;  font-weight: 400;
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
                                                <a class="nav-link ${item.cssClass}" href="${item.href}">${item.label}</a>
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
    <nav class="navbar navbar-main navbar-expand-lg navbar-main-submenu-horizontal ${bmenu.bmenuMain.cssClass}">
        <div class="container-xl">
            <!-- Logo -->
            <a class="navbar-brand" href="/">
                <img src="${bmenu.bmenuMain.logo.logo}" style="height: ${bmenu.bmenuMain.logo.height} !important;" alt="logo">
            </a>
            <button class="navbar-toggler me-n4 ms-auto text-start" type="button" data-bs-toggle="modal" data-bs-target="#mobile_main_nav" aria-label="Toggle navigation">
                <i class="bi bi-list"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav mx-lg-auto">
                    <c:if test="${not empty bmenu.bmenuMain.leftItems}">
                        <c:forEach items="${bmenu.bmenuMain.leftItems}" var="menu">
                            <c:choose>
                                <c:when test="${menu.type eq 'link'}">
                                    <li class="nav-item"><a class="nav-link ${menu.cssClass}" href="${menu.href}">${menu.label}</a></li>
                                </c:when>
                                <c:when test="${menu.type eq 'login'}">
                                    <security:authorize access="isAnonymous()">
                                        <li class="nav-item"><a class="nav-link ${menu.cssClass}" href="/login.html"><fmt:message key="label.login"/></a></li>
                                    </security:authorize>
                                    <security:authorize access="isAuthenticated()">
                                        <li class="nav-item"><a class="nav-link ${menu.cssClass}" href="/my/booking.html"><fmt:message key="label.my-booking"/></a></li>
                                    </security:authorize>
                                </c:when>
                                <c:when test="${menu.type eq 'text' and menu.label eq 'separator'}">
                                    <li class="separator my-auto d-none d-sm-inline"></li>
                                </c:when>
                                <c:when test="${menu.type eq 'dropdown'}">
                                    <li class="nav-item"><a class="nav-link has-sub" path="${menu.path}" href="#">${menu.label}</a></li>
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
            </div>
        </div>
    </nav>
    <div class="navbar navbar-submenu-horizontal d-none d-md-block ${bmenu.bmenuTop.cssClass}">
        <div class="container">
        <c:if test="${not empty bmenu.bmenuMain.leftItems}">
            <c:set var="showfirst" value="show"/>
            <c:forEach items="${bmenu.bmenuMain.leftItems}" var="menu">
                <c:if test="${menu.type eq 'dropdown'}">
                    <div class="mx-lg-auto submenu-horizontal-item ${showfirst}" path="${menu.path}">
                        <c:forEach items="${menu.items}" var="sub" varStatus="theCountSub">
                            <div class="nav-item">
                                <a href="${sub.href}" class="nav-link">
                                    <span class="">${sub.label}</span>
                                </a>
                            </div>
                            <c:if test="${fn:length(menu.items) gt 1 and not theCountSub.last}">
                                <div class="separator my-auto d-none d-sm-inline"></div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <c:set var="showfirst" value=""/>
                </c:if>
            </c:forEach>
        </c:if>
        </div>
    </div>
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
        <div class="modal-content">
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


