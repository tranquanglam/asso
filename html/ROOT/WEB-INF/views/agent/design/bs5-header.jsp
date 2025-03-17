<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<style>
    :root {
        --main-header-bg-color: ${bmenu.bgColor};
        --main-header-bg-gradient-color: ${bmenu.bgGradientColor};
        --main-header-txt-color: ${bmenu.txtColor};
        --main-header-font-family:${bmenu.fontFamily};
    }
    .header-live-content .header {
        display: none;
    }
    .header-live-content.show .header {
        display: block;
    }
</style>
<div class="header-live-content">
    <header class="header header-gradient-primary ${bmenu.cssClass}" id="header-main">
        <!-- Topbar -->
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
                                                <li class="nav-item dropdown ml-lg-2">
                                                    <a class="nav-link px-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            ${item.label}
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-sm">
                                                        <c:forEach var="sub" items="${item.items}">
                                                            <a href="#" class="dropdown-item">${sub.label}</a>
                                                        </c:forEach>
                                                    </div>
                                                </li>
                                            </c:when>
                                            <c:when test="${item.type eq 'link'}">
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#">${item.label}</a>
                                                </li>
                                            </c:when>
                                            <c:when test="${item.label eq 'language'}">
                                                <li class="nav-item dropdown ml-lg-2">
                                                    <c:choose>
                                                        <c:when test="${lang eq 'vi'}">
                                                            <a class="nav-link px-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-offset="0,10">
                                                                <img alt="Vietnamese" src="/themes/mega/images/flags/vn.svg">
                                                                <span class="d-none d-lg-inline-block">Tiếng Việt</span>
                                                                <span class="d-lg-none">VI</span>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a class="nav-link px-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-offset="0,10">
                                                                <img alt="English" src="/themes/mega/images/flags/us.svg">
                                                                <span class="d-none d-lg-inline-block">English</span>
                                                                <span class="d-lg-none">EN</span>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div class="dropdown-menu dropdown-menu-sm">
                                                        <a href="javascript:changeLang('en')" class="dropdown-item"><img alt="Change to English" src="/themes/mega/images/flags/us.svg">English</a>
                                                        <a href="javascript:changeLang('vi')" class="dropdown-item"><img alt="Change to Vietnamese" src="/themes/mega/images/flags/vn.svg">Tiếng Việt</a>
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
                            <div class="ml-auto">
                                <ul class="nav">
                                    <c:forEach var="item" items="${bmenu.bmenuTop.rightItems}">
                                        <c:choose>
                                            <c:when test="${item.type eq 'dropdown'}">
                                                <li class="nav-item dropdown">
                                                    <a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            ${item.label}
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-sm dropdown-menu-right">
                                                        <c:forEach var="sub" items="${item.items}">
                                                            <a href="#" class="dropdown-item">${sub.label}</a>
                                                        </c:forEach>
                                                    </div>
                                                </li>
                                            </c:when>
                                            <c:when test="${item.type eq 'link'}">
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#">${item.label}</a>
                                                </li>
                                            </c:when>
                                            <c:when test="${item.label eq 'account'}">
                                                <li class="nav-item dropdown">
                                                    <a class="nav-link pr-0" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="bi bi-person-circle"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-sm dropdown-menu-right">
                                                        <h6 class="dropdown-header"><fmt:message key="label.my-account"/></h6>
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
                    </div>
                </div>
            </div>
        </c:if>
        <!-- Main navbar -->
        <nav class="navbar navbar-main navbar-expand-lg ${bmenu.bmenuMain.cssClass}" id="navbar-main">
            <div class="container px-lg-0">
                <!-- Logo -->
                <c:if test="${bmenu.bmenuMain.logo != null}">
                    <a class="navbar-brand mr-lg-5 sm-logo-${bmenu.bmenuMain.logo.align}" href="/">
                        <img src="${bmenu.bmenuMain.logo.logo}" alt="logo" height="${bmenu.bmenuMain.logo.height}">
                    </a>
                </c:if>
                <!-- Navbar collapse trigger -->
                <button class="navbar-toggler pr-0" type="button" data-toggle="collapse" data-target="#navbar-main-collapse" aria-controls="navbar-main-collapse" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <!-- Navbar nav -->
                <div class="collapse navbar-collapse" id="navbar-main-collapse">
                    <ul class="navbar-nav align-items-lg-center">
                        <c:if test="${not empty bmenu.bmenuMain.leftItems}">
                            <c:forEach items="${bmenu.bmenuMain.leftItems}" var="menu">
                                <c:choose>
                                    <c:when test="${menu.type eq 'link'}">
                                        <li class="nav-item"><a class="nav-link" href="${menu.href}">${menu.label}</a></li>
                                    </c:when>
                                    <c:when test="${menu.type eq 'dropdown'}">
                                        <li class="nav-item dropdown dropdown-animate" data-toggle="hover">
                                            <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${menu.label}</a>
                                            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-arrow p-0">
                                                <ul class="list-group list-group-flush">
                                                    <c:forEach items="${menu.items}" var="sub">
                                                        <li><a class="list-group-item list-group-item-action" href="${sub.href}" role="button">${sub.label}</a></li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </li>
                                    </c:when>
                                    <c:when test="${menu.type eq 'login'}">
                                        <li class="nav-item">
                                            <security:authorize access="isAnonymous()">
                                                <a href="/login.html" class="nav-link d-lg-none"><fmt:message key="label.login"/></a>
                                                <a href="/login.html" class="btn btn-sm btn-white btn-icon rounded-pill d-none d-lg-inline-flex" data-toggle="tooltip" data-placement="left" title="<fmt:message key='label.login'/>">
                                                    <span class="btn-inner--icon"><i class="fas fa-sign-in-alt"></i></span>
                                                    <span class="btn-inner--text"><fmt:message key="label.login"/></span>
                                                </a>
                                            </security:authorize>
                                            <security:authorize access="isAuthenticated()">
                                                <a href="/my/booking.html" class="nav-link d-lg-none"><fmt:message key="label.my-booking"/></a>
                                                <a href="/my/booking.html" class="btn btn-sm btn-white btn-icon rounded-pill d-none d-lg-inline-flex" data-toggle="tooltip" data-placement="left" title="<fmt:message key='label.my-booking'/>">
                                                    <span class="btn-inner--icon"><i class="fas fa-cart-arrow-down"></i></span>
                                                    <span class="btn-inner--text"><fmt:message key="label.my-booking"/></span>
                                                </a>
                                            </security:authorize>
                                        </li>
                                    </c:when>
                                    <c:otherwise>

                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:if>
                    </ul>
                    <c:if test="${bmenu.bmenuMain.logo != null && bmenu.bmenuMain.logo.align eq 'center'}">
                        <a class="navbar-brand md-logo-${bmenu.bmenuMain.logo.align}" href="/">
                            <img src="${bmenu.bmenuMain.logo.logo}" alt="logo" height="${bmenu.bmenuMain.logo.height}">
                        </a>
                    </c:if>
                    <ul class="navbar-nav align-items-lg-center ml-lg-auto">
                        <c:if test="${not empty bmenu.bmenuMain.rightItems}">
                            <c:forEach items="${bmenu.bmenuMain.rightItems}" var="menu">
                                <c:choose>
                                    <c:when test="${menu.type eq 'link'}">
                                        <li class="nav-item"><a class="nav-link" href="${menu.href}">${menu.label}</a></li>
                                    </c:when>
                                    <c:when test="${menu.type eq 'dropdown'}">
                                        <li class="nav-item dropdown dropdown-animate" data-toggle="hover">
                                            <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${menu.label}</a>
                                            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-arrow p-0">
                                                <ul class="list-group list-group-flush">
                                                    <c:forEach items="${menu.items}" var="sub">
                                                        <li><a class="list-group-item list-group-item-action" href="${sub.href}" role="button">${sub.label}</a></li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </li>
                                    </c:when>
                                    <c:when test="${menu.type eq 'login'}">
                                        <li class="nav-item">
                                            <security:authorize access="isAnonymous()">
                                                <a href="/login.html" class="nav-link d-lg-none"><fmt:message key="label.login"/></a>
                                                <a href="/login.html" class="btn btn-sm btn-white btn-icon rounded-pill d-none d-lg-inline-flex" data-toggle="tooltip" data-placement="left" title="<fmt:message key='label.login'/>">
                                                    <span class="btn-inner--icon"><i class="fas fa-sign-in-alt"></i></span>
                                                    <span class="btn-inner--text"><fmt:message key="label.login"/></span>
                                                </a>
                                            </security:authorize>
                                            <security:authorize access="isAuthenticated()">
                                                <a href="/my/booking.html" class="nav-link d-lg-none"><fmt:message key="label.my-booking"/></a>
                                                <a href="/my/booking.html" class="btn btn-sm btn-white btn-icon rounded-pill d-none d-lg-inline-flex" data-toggle="tooltip" data-placement="left" title="<fmt:message key='label.my-booking'/>">
                                                    <span class="btn-inner--icon"><i class="fas fa-cart-arrow-down"></i></span>
                                                    <span class="btn-inner--text"><fmt:message key="label.my-booking"/></span>
                                                </a>
                                            </security:authorize>
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
    </header>
    <div class="text-end">
        <button class="btn btn-outline-primary btn-toggle-header">Show/Hide Preview Header</button>
    </div>
</div>
<div class="text-center py-10">
    <h1>Using following tools to design your site header</h1>
</div>
<div class="header-config text-end me-4 pt-4">
    <a href="javascript:void(0);" class="header-config-change"><i class="bi bi-gear"></i></a>
    <a href="/" class="px-4"><i class="bi bi-house"></i></a>
    <a href="javascript:void(0);" class="change-logo">Change logo</a>
    <span><i class="bi bi-globe"></i> ${lang} </span>
</div>
<div class="d-none" id="lang">${lang}</div>
<section class="header-content-top mt-4 mb-4 bg-secondary ${bmenu.bmenuTop.show ? '' : 'd-none'}">
    <div class="container">
        <nav class="navbar navbar-expand-md py-0">
            <div class="collapse navbar-collapse">
                <c:set var="ordernum" value="-1"/>
                <ul class="navbar-nav flex-row menu-top mr-auto">
                    <c:if test="${not empty bmenu.bmenuTop.leftItems}">
                        <c:forEach items="${bmenu.bmenuTop.leftItems}" var="menu" varStatus="theCount">
                            <c:set var="menuname" value="${menu.label}"/>
                            <c:set var="ordernum" value="${theCount.index}"/>
                            <c:choose>
                                <c:when test="${menu.type eq 'link'}">
                                    <li class="nav-item">
                                        <a class="nav-link cat-item" data-isnew="false" data-path="bmenuTop/leftItems/${ordernum}" data-dropdownlink="dropdownlink" href="#">${menuname}</a>
                                    </li>
                                </c:when>
                                <c:when test="${fn:startsWith(menu.type,'dropdown')}">
                                    <c:set var="subordernum" value="-1"/>
                                    <li class="nav-item dropdown">
                                        <a class="cat-item" data-isnew="false" data-path="bmenuTop/leftItems/${ordernum}" data-dropdownlink="dropdown">${menuname}</a>
                                        <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                        <ul class="dropdown-menu">
                                            <c:forEach items="${menu.items}" var="sub" varStatus="subCount">
                                                <c:set var="subordernum" value="${subCount.index}"/>
                                                <c:set var="menuname" value="${sub.label}"/>
                                                <li class="cat-item" data-isnew="false" data-path="bmenuTop/leftItems/${ordernum}/${subordernum}" data-dropdownlink="link"><a class="nav-link" href="#">${menuname}</a></li>
                                            </c:forEach>
                                            <li class="nav-item cat-item" data-isnew="true" data-path="bmenuTop/leftItems/${ordernum}/${subordernum + 1}" data-dropdownlink="link"><a class="nav-link" href="#"><i class="bi bi-plus-circle"></i></a></li>
                                        </ul>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item">
                                        <a class="nav-link cat-item" data-isnew="false" data-path="bmenuTop/leftItems/${ordernum}" data-dropdownlink="${menu.type}" href="#">${menuname}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                    <li class="nav-item cat-item" data-isnew="true" data-path="bmenuTop/leftItems/${ordernum + 1}" data-dropdownlink="dropdownlink">
                        <a class="nav-link" href="#">
                            <i class="bi bi-plus-circle"></i>
                        </a>
                    </li>
                </ul>
                <c:set var="ordernum" value="-1"/>
                <ul class="navbar-nav flex-row menu-top ml-auto">
                    <c:if test="${not empty bmenu.bmenuTop.rightItems}">
                        <c:forEach items="${bmenu.bmenuTop.rightItems}" var="menu" varStatus="theCount">
                            <c:set var="menuname" value="${menu.label}"/>
                            <c:set var="ordernum" value="${theCount.index}"/>
                            <c:choose>
                                <c:when test="${menu.type eq 'link'}">
                                    <li class="nav-item">
                                        <a class="nav-link cat-item" data-isnew="false" data-path="bmenuTop/rightItems/${ordernum}" data-dropdownlink="dropdownlink" href="#">${menuname}</a>
                                    </li>
                                </c:when>
                                <c:when test="${fn:startsWith(menu.type,'dropdown')}">
                                    <c:set var="subordernum" value="-1"/>
                                    <li class="nav-item dropdown">
                                        <a class="cat-item" data-isnew="false" data-path="bmenuTop/rightItems/${ordernum}" data-dropdownlink="dropdown">${menuname}</a>
                                        <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                        <ul class="dropdown-menu">
                                            <c:forEach items="${menu.items}" var="sub" varStatus="subCount">
                                                <c:set var="subordernum" value="${subCount.index}"/>
                                                <c:set var="menuname" value="${sub.label}"/>
                                                <li class="cat-item" data-isnew="false" data-path="bmenuTop/rightItems/${ordernum}/${subordernum}" data-dropdownlink="link"><a class="nav-link dropdown-item" href="#">${menuname}</a></li>
                                            </c:forEach>
                                            <li class="nav-item cat-item" data-isnew="true" data-path="bmenuTop/rightItems/${ordernum}/${subordernum + 1}" data-dropdownlink="link"><a class="nav-link dropdown-item" href="#"><i class="bi bi-plus-circle"></i></a></li>
                                        </ul>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item">
                                        <a class="nav-link cat-item" data-isnew="false" data-path="bmenuTop/rightItems/${ordernum}" data-dropdownlink="${menu.type}" href="#">${menuname}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                    <li class="nav-item cat-item" data-isnew="true" data-path="bmenuTop/rightItems/${ordernum + 1}" data-dropdownlink="dropdownlink">
                        <a class="nav-link" href="#">
                            <i class="bi bi-plus-circle"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</section>
<section class="header-content py-3 mt-9">
    <nav class="navbar navbar-inverse navbar-expand-md" id="mainNav">
        <div class="container">
            <button class="navbar-toggler mt-3" type="button" data-toggle="collapse" data-target="#navbarCollapse">
                <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <c:set var="ordernum" value="-1"/>
                <ul class="navbar-nav flex-row menu-second me-auto">
                    <c:if test="${not empty bmenu.bmenuMain.leftItems}">
                        <c:forEach items="${bmenu.bmenuMain.leftItems}" var="menu" varStatus="theCount">
                            <c:set var="menuname" value="${menu.label}"/>
                            <c:set var="ordernum" value="${theCount.index}"/>
                            <c:choose>
                                <c:when test="${menu.type eq 'link'}">
                                    <li class="nav-item">
                                        <a class="nav-link cat-item" data-isnew="false" data-path="bmenuMain/leftItems/${ordernum}" data-dropdownlink="dropdownlink" href="#">${menuname}</a>
                                    </li>
                                </c:when>
                                <c:when test="${fn:startsWith(menu.type,'dropdown')}">
                                    <c:set var="subordernum" value="-1"/>
                                    <li class="nav-item dropdown dropdown-animate">
                                        <a class="cat-item" data-isnew="false" data-path="bmenuMain/leftItems/${ordernum}" data-dropdownlink="dropdown">${menuname}</a>
                                        <a class="nav-link dropdown-toggle ms-2" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-arrow p-0">
                                            <ul class="list-group list-group-flush">
                                                <c:forEach items="${menu.items}" var="sub" varStatus="subCount">
                                                    <c:set var="subordernum" value="${subCount.index}"/>
                                                    <c:set var="menuname" value="${sub.label}"/>
                                                    <li class="cat-item" data-isnew="false" data-path="bmenuMain/leftItems/${ordernum}/${subordernum}" data-dropdownlink="link"><a class="nav-link dropdown-item" href="#">${menuname}</a></li>
                                                </c:forEach>
                                                <li class="nav-item cat-item" data-isnew="true" data-path="bmenuMain/leftItems/${ordernum}/${subordernum + 1}" data-dropdownlink="link"><a class="nav-link dropdown-item" href="#"><i class="bi bi-plus-circle"></i></a></li>
                                            </ul>
                                        </div>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item">
                                        <a class="nav-link cat-item" data-isnew="false" data-path="bmenuMain/leftItems/${ordernum}" data-dropdownlink="${menu.type}" href="#">${menuname}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                    <li class="nav-item cat-item" data-isnew="true" data-path="bmenuMain/leftItems/${ordernum + 1}" data-dropdownlink="dropdownlink">
                        <a class="nav-link" href="#">
                            <i class="bi bi-plus-circle"></i>
                        </a>
                    </li>
                </ul>
                <c:set var="ordernum" value="-1"/>
                <ul class="navbar-nav flex-row menu-second ml-auto">
                    <c:if test="${not empty bmenu.bmenuMain.rightItems}">
                        <c:forEach items="${bmenu.bmenuMain.rightItems}" var="menu" varStatus="theCount">
                            <c:set var="menuname" value="${menu.label}"/>
                            <c:set var="ordernum" value="${theCount.index}"/>
                            <c:choose>
                                <c:when test="${menu.type eq 'link'}">
                                    <li class="nav-item">
                                        <a class="nav-link cat-item" data-isnew="false" data-path="bmenuMain/rightItems/${ordernum}" data-dropdownlink="dropdownlink" href="#">${menuname}</a>
                                    </li>
                                </c:when>
                                <c:when test="${fn:startsWith(menu.type,'dropdown')}">
                                    <c:set var="subordernum" value="-1"/>
                                    <li class="nav-item dropdown">
                                        <a class="cat-item" data-isnew="false" data-path="bmenuMain/rightItems/${ordernum}" data-dropdownlink="dropdown">${menuname}</a>
                                        <a class="nav-link dropdown-toggle ms-2" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-arrow p-0">
                                            <ul class="list-group list-group-flush">
                                                <c:forEach items="${menu.items}" var="sub" varStatus="subCount">
                                                    <c:set var="subordernum" value="${subCount.index}"/>
                                                    <c:set var="menuname" value="${sub.label}"/>
                                                    <li class="cat-item" data-isnew="false" data-path="bmenuMain/rightItems/${ordernum}/${subordernum}" data-dropdownlink="link"><a class="nav-link dropdown-item" href="#">${menuname}</a></li>
                                                </c:forEach>
                                                <li class="nav-item cat-item" data-isnew="true" data-path="bmenuMain/rightItems/${ordernum}/${subordernum + 1}" data-dropdownlink="link"><a class="nav-link dropdown-item" href="#"><i class="bi bi-plus-circle"></i></a></li>
                                            </ul>
                                        </div>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item">
                                        <a class="nav-link cat-item" data-isnew="false" data-path="bmenuMain/rightItems/${ordernum}" data-dropdownlink="${menu.type}" href="#">${menuname}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                    <li class="nav-item cat-item" data-isnew="true" data-path="bmenuMain/rightItems/${ordernum + 1}" data-dropdownlink="dropdownlink">
                        <a class="nav-link" href="#">
                            <i class="bi bi-plus-circle" aria-hidden="true"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</section>
<div class="modal fade" id="menuItemFormModal" tabindex="-1" role="dialog" aria-labelledby="menuItemFormModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="menuItemFormModalLabel">Item</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="menuItemForm" class="form-horizontal" role="form">
                    <input type="hidden" name="isnew" value="">
                    <input type="hidden" name="path" value="">
                    <input type="hidden" name="visible" value="true">
                    <div class="form-group">
                        <input type="text" class="form-control" name="label" placeholder="label"/>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="iconCss" placeholder="Icon Css"/>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="cssClass" placeholder="cssClass"/>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="description" placeholder="description"/>
                    </div>
                    <div class="form-group" id="dropdownmenulink-col">
                        <select class="form-control" name="type">
                            <option value="link">link</option>
                            <option value="dropdown">dropdown</option>
                            <option value="dropdown-mega">dropdown-mega</option>
                            <option value="text">text</option>
                            <option value="login">login</option>
                        </select>
                    </div>
                    <div class="form-group" id="link-col">
                        <input type="text" class="form-control" name="href" placeholder="hyperlink"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="menuItemFormSave()"><fmt:message key="label.save"/></button>
                <button class="btn btn-delete btn-more" type="button" onclick="menuItemFormDelete()"><fmt:message key="label.remove"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="uploadLogoModal" tabindex="-1" role="dialog" aria-labelledby="uploadLogoModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="uploadLogoModalLabel">Upload Logo</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="uploadLogoForm" method="post" action="/agent/design/upload-logo.html" enctype="multipart/form-data">
                    <input type="hidden" name="fromPage" value="design_header">
                    <div class="form-group">
                        <c:if test="${not empty site.desktopLogo}">
                            <img src="${site.desktopLogo}" height="100px">
                        </c:if>
                        <input type="file" name="file"/>
                    </div>
                    <div class="row">
                        <div class="form-group col-12">
                            <label>Logo position</label>
                            <select name="align" class="form-control custom-select">
                                <option value="left" ${bmenu.bmenuMain.logo.align eq 'left' ? 'selected' :''}>left</option>
                                <option value="center" ${bmenu.bmenuMain.logo.align eq 'center' ? 'selected' :''}>center</option>
                                <option value="right" ${bmenu.bmenuMain.logo.align eq 'right' ? 'selected' :''}>right</option>
                            </select>
                        </div>
                        <div class="form-group col-6">
                            <label>Width</label>
                            <input type="text" class="form-control" name="width" value="${bmenu.bmenuMain.logo.width}">
                        </div>
                        <div class="form-group col-6">
                            <label>Height</label>
                            <input type="text" class="form-control" name="height" value="${bmenu.bmenuMain.logo.height}">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="uploadLogoSubmit()"><fmt:message key="label.upload"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="headerConfigFormModal" tabindex="-1" role="dialog" aria-labelledby="headerConfigFormLabel">
    <div class="modal-dialog" role="document" style="width:98%;max-width: 1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="headerConfigFormLabel">Header configuration</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post" id="headerConfigForm" class="form-horizontal" role="form">
                    <div class="row">
                        <div class="form-group col-12">
                            <label>Type of Header</label>
                            <select name="headerType" class="form-control custom-select">
                                <option value="left-right" ${bmenu.headerType eq 'left-right' ? 'selected' :''}>Two columns left and right</option>
                                <option value="left-center-right" ${bmenu.headerType eq 'left-center-right' ? 'selected' :''}>Three columns left center right</option>
                                <option value="search-center-top-main-header" ${bmenu.headerType eq 'search-center-top-main-header' ? 'selected' :''}>Two rows main header with Search form on top center</option>
                                <option value="submenu-horizontal" ${bmenu.headerType eq 'submenu-horizontal' ? 'selected' :''}>Submenu horizontal</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-12">
                            <label>Header Css Class</label>
                            <input type="text" class="form-control" name="cssClass" value="${bmenu.cssClass}"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-8">
                            <label>Menu top Css clas</label>
                            <input type="text" class="form-control" name="bmenuTop.cssClass" value="${bmenu.bmenuTop.cssClass}"/>
                        </div>
                        <div class="form-group col-4">
                            <label>Show top menu</label>
                            <input type="checkbox" class="form-check-input"  name="bmenuTop.show" ${bmenu.bmenuTop.show ? 'checked' :''}/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-8">
                            <label>Menu main Css clas</label>
                            <input type="text" class="form-control" name="bmenuMain.cssClass" value="${bmenu.bmenuMain.cssClass}"/>
                        </div>
                        <div class="form-group col-4">
                            <label>Logo position</label>
                            <select name="bmenuMain.logo.align" class="form-control custom-select">
                                <option value="left" ${bmenu.bmenuMain.logo.align eq 'left' ? 'selected' :''}>left</option>
                                <option value="center" ${bmenu.bmenuMain.logo.align eq 'center' ? 'selected' :''}>center</option>
                                <option value="right" ${bmenu.bmenuMain.logo.align eq 'right' ? 'selected' :''}>right</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Google Font Family</label>
                            <input type="text" class="form-control" name="fontFamily" value="${bmenu.fontFamily}"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Background color</label>
                            <input type="color" class="form-control form-control-color" name="bgColor" value="${bmenu.bgColor}"/>
                        </div>
                        <div class="form-group col">
                            <label>Background gradient color</label>
                            <input type="color" class="form-control form-control-color" name="bgGradientColor" value="${bmenu.bgGradientColor}"/>
                        </div>
                        <div class="form-group col">
                            <label>Text color</label>
                            <input type="color" class="form-control form-control-color" name="txtColor" value="${bmenu.txtColor}"/>
                        </div>
                        <div class="form-group col">
                            <label>Top text color</label>
                            <input type="color" class="form-control form-control-color" name="txtColorTop" value="${bmenu.txtColorTop}"/>
                        </div>
                        <div class="form-group col">
                            <label>Top bg color</label>
                            <input type="color" class="form-control form-control-color" name="bgColorTop" value="${bmenu.bgColorTop}"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="saveHeaderConfigForm()"><fmt:message key="label.save"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="d-none" id="base64_encoded_path">${base64_encoded_path}</div>
