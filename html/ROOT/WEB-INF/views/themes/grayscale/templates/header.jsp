<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="headerid" value="header_jcontent_${site.siteid}"/>
<c:choose>
    <c:when test="${applicationScope[headerid] != null}">
        <c:set var="bmenu" value="${applicationScope[headerid].localmenu}"/>
        <c:if test="${lang eq 'en'}">
            <c:set var="bmenu" value="${applicationScope[headerid].menu}"/>
        </c:if>
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
                                                    <li class="nav-item dropdown ml-lg-2">
                                                        <c:choose>
                                                            <c:when test="${lang eq 'vi'}">
                                                                <a class="nav-link px-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-offset="0,10">
                                                                    <img alt="Image placeholder" src="https://membooking.com/themes/purpose/img/icons/flags/vn.svg">
                                                                    <span class="d-none d-lg-inline-block">Tiếng Việt</span>
                                                                    <span class="d-lg-none">VI</span>
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a class="nav-link px-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-offset="0,10">
                                                                    <img alt="Image placeholder" src="https://membooking.com/themes/purpose/img/icons/flags/us.svg">
                                                                    <span class="d-none d-lg-inline-block">English</span>
                                                                    <span class="d-lg-none">EN</span>
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div class="dropdown-menu dropdown-menu-sm">
                                                            <a href="javascript:changeLang('en')" class="dropdown-item"><img alt="Image placeholder" src="https://membooking.com/themes/purpose/img/icons/flags/us.svg">English</a>
                                                            <a href="javascript:changeLang('vi')" class="dropdown-item"><img alt="Image placeholder" src="https://membooking.com/themes/purpose/img/icons/flags/vn.svg">Tiếng Việt</a>
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
                                                <c:when test="${item.label eq 'search'}">
                                                    <li class="nav-item">
                                                        <a href="#" class="nav-link" data-action="omnisearch-open" data-target="#omnisearch"><i class="fas fa-search"></i></a>
                                                    </li>
                                                </c:when>
                                                <c:when test="${item.label eq 'cart'}">
                                                    <li class="nav-item">
                                                        <a class="nav-link" href="#" data-action="popup-cart-items-open" data-target="#popup-cart-items"><span id="cart-items-badge" class="fa-stack fa-1x has-badge" data-count="0"><i class="fas fa-shopping-cart fa-stack-1x"></i></span></a>
                                                    </li>
                                                </c:when>
                                                <c:when test="${item.label eq 'account'}">
                                                    <li class="nav-item dropdown">
                                                        <a class="nav-link pr-0" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <i class="fas fa-user-circle"></i>
                                                        </a>
                                                        <div class="dropdown-menu dropdown-menu-sm dropdown-menu-right">
                                                            <h6 class="dropdown-header"><fmt:message key="label.my-account"/></h6>
                                                            <security:authorize access="isAuthenticated()">
                                                                <a class="dropdown-item" href="/my/profile.html">
                                                                    <i class="fas fa-user"></i><fmt:message key="label.my-profile"/>
                                                                </a>
                                                                <a class="dropdown-item" href="/my/booking.html"><fmt:message key="label.my-booking"/></a>
                                                                <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                                                    <a class="dropdown-item" href="/my/customers.html"><fmt:message key="label.my-customers"/></a>
                                                                    <a class="dropdown-item" href="/my/messages.html"><fmt:message key="label.my-messages"/></a>
                                                                    <a class="dropdown-item" href="/agent/news"><fmt:message key="systemadmin"/></a>
                                                                    <a class="dropdown-item" href="/agent/design/home.html"><fmt:message key="design.homepage"/></a>
                                                                </security:authorize>
                                                                <div class="dropdown-divider" role="presentation"></div>
                                                                <form id="plogout" class="d-none" method="post" action="/j_spring_security_logout">
                                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                                </form>
                                                                <a class="dropdown-item" href="#" onclick="document.getElementById('plogout').submit();">
                                                                    <i class="fas fa-sign-out-alt"></i><fmt:message key="label.logout"/>
                                                                </a>
                                                            </security:authorize>
                                                            <security:authorize access="isAnonymous()">
                                                                <a class="dropdown-item" href="/login.html"><i class="fas fa-sign-in-alt"></i><fmt:message key="label.login"/></a>
                                                                <a class="dropdown-item" href="/forgotPassword.html"><i class="fas fa-key"></i><fmt:message key="label.forgot-password"/></a>
                                                                <div class="dropdown-divider" role="presentation"></div>
                                                                <a class="dropdown-item" href="/membershipRegister"><i class="fas fa-user"></i><fmt:message key="customer.register"/></a>
                                                            </security:authorize>
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
                        <i class="fas fa-bars"></i>
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
        <jsp:include page="popups.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="old-header.jsp"/>
    </c:otherwise>
</c:choose>
