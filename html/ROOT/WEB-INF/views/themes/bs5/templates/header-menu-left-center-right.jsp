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
                                                    <a href="javascript:changeLang('vi')" class="dropdown-item"><img alt="Chang to Vietnamese" src="/themes/grayscale/assets/img/flags/vn.svg">Tiếng Việt</a>
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
                                                <a class="nav-link pr-0" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
                                                <a href="#" class="nav-link" data-action="omnisearch-open" data-target="#omnisearch"><i class="bi bi-search"></i></a>
                                            </li>
                                        </c:when>
                                        <c:when test="${item.label eq 'cart'}">
                                            <li class="nav-item">
                                                <a class="nav-link" href="#" data-action="popup-cart-items-open" data-target="#popup-cart-items">
                                                            <span id="cart-items-badge" class="bi-bi-stack has-badge" data-count="0">
                                                                <i class="bi bi-cart-fill"></i>
                                                            </span>
                                                </a>
                                            </li>
                                        </c:when>
                                        <c:when test="${item.label eq 'account'}">
                                            <li class="nav-item dropdown">
                                                <a class="nav-link pr-0 " href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="bi bi-person-circle"></i>
                                                </a>
                                                <div class="dropdown-menu dropdown-menu-sm dropdown-menu-right">
                                                    <p class="dropdown-header h6"><fmt:message key="label.my-account"/></p>
                                                    <security:authorize access="isAuthenticated()">
                                                        <a href="/my/profile.html"
                                                           class="dropdown-group ms-3" role="button">
                                                            <div class="d-flex">
                                                                <div class="lh-none">
                                                                    <i class="bi bi-chat"></i>
                                                                </div>
                                                                <div class="ms-1">
                                                                    <p class="dropdown-heading lh-none mb-2 h6"><fmt:message key="label.my-profile"/></p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                        <a class="dropdown-item" href="/my/booking.html"><fmt:message key="label.my-booking"/></a>
                                                        <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                                            <a class="dropdown-item" href="/my/customers.html"><fmt:message key="label.my-customers"/></a>
                                                            <a class="dropdown-item" href="/my/messages.html"><fmt:message key="label.my-messages"/></a>
                                                            <a class="dropdown-item" href="/agent/news"><fmt:message key="systemadmin"/></a>
                                                            <a class="dropdown-item" href="/agent/design/home.html"><fmt:message key="design.homepage"/></a>
                                                        </security:authorize>
                                                        <div class="dropdown-divider" role="presentation"></div>
                                                        <form id="toplogout" class="d-none" method="post" action="/j_spring_security_logout">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                        </form>
                                                        <a href="#" onclick="document.getElementById('toplogout').submit();" class="dropdown-group ms-3" role="button">
                                                            <div class="d-flex">
                                                                <div class="lh-none">
                                                                    <i class="bi-box-arrow-left"></i>
                                                                </div>
                                                                <div class="ms-1">
                                                                    <p class="dropdown-heading lh-none mb-2 h6"><fmt:message key="label.logout"/></p>
                                                                </div>
                                                            </div>
                                                        </a>

                                                    </security:authorize>
                                                    <security:authorize access="isAnonymous()">
                                                        <a href="/login.html"
                                                           class="dropdown-group ms-3" role="button">
                                                            <div class="d-flex">
                                                                <div class="lh-none">
                                                                    <i class="bi bi-box-arrow-in-right"></i>
                                                                </div>
                                                                <div class="ms-1">
                                                                    <p class="dropdown-heading lh-none mb-2 h6"><fmt:message key="label.login"/></p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                        <a href="/forgotPassword.html"
                                                           class="dropdown-group ms-3" role="button">
                                                            <div class="d-flex">
                                                                <div class="">
                                                                    <p class="dropdown-heading lh-none mb-2 h6"><fmt:message key="label.forgot-password"/></p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                        <div class="dropdown-divider" role="presentation"></div>
                                                        <a href="/membershipRegister" class="dropdown-group ms-3" role="button">
                                                            <div class="d-flex">
                                                                <div class="">
                                                                    <p class="dropdown-heading lh-none mb-2 h6"><fmt:message key="customer.register"/></p>
                                                                </div>
                                                            </div>
                                                        </a>

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
    <nav class="navbar navbar-main navbar-expand-lg ${bmenu.bmenuMain.cssClass}">
        <div class="container-xl">
            <!-- Logo -->
            <a class="navbar-brand" href="/">
                <img src="${bmenu.bmenuMain.logo.logo}" style="height: ${bmenu.bmenuMain.logo.height} !important;" alt="logo">
            </a>
            <!-- Navbar toggle -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <i class="bi bi-list"></i>
            </button>
            <!-- Collapse -->
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <!-- Nav -->
                <ul class="navbar-nav mx-lg-auto">
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
                                    <c:set var="styleBackground" value="" />
                                    <c:if test="${not empty menu.iconCss && fn:startsWith(menu.iconCss, 'http')}">
                                        <c:set var="styleBackground" value="background:url(${menu.iconCss})" />
                                        <c:set var="isMenuDescription" value="true" />
                                    </c:if>

                                    <li class="nav-item dropdown position-static" data-bs-toggle="hover">
                                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">${menu.label}</a>
                                        <div class="dropdown-menu dropdown-menu-lg-fluid p-0 rounded-0 border-0 shadow-6" aria-labelledby="">
                                            <div class="border-top-4 border-primary">
                                                <div class="row g-0">
                                                    <c:if test="${isMenuDescription eq true}">
                                                        <div class="col-12 col-lg-4">
                                                            <div class="dropdown-img-left rounded-0 ${menu.cssClass}" style="${styleBackground}">
                                                                <div class="position-relative overlap-10 text-center">
                                                                    <c:if test="${empty styleBackground}">
                                                                        <h3 class="ls-tight">${menu.label}</h3>
                                                                        <div class="text-sm mb-6">${menu.description}</div>
                                                                    </c:if>
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
                                                                                <a href="${sub.href}" class="dropdown-group ${not empty sub.description ? 'mb-8' : ''}" role="button">
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
                <!-- Right navigation -->

                <ul class="navbar-nav align-items-lg-center ms-lg-auto">
                    <c:if test="${not empty bmenu.bmenuMain.rightItems}">
                        <c:forEach items="${bmenu.bmenuMain.rightItems}" var="menu">
                            <c:choose>
                                <c:when test="${menu.type eq 'link'}">
                                    <li class="nav-item"><a class="nav-link ${menu.cssClass}" href="${menu.href}">${menu.label}</a></li>
                                </c:when>
                                <c:when test="${menu.type eq 'dropdown'}">
                                    <li class="nav-item dropdown dropdown-animate" data-bs-toggle="hover">
                                        <a class="nav-link dropdown-toggle ${menu.cssClass}" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${menu.label}</a>
                                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg dropdown-menu-arrow p-0">
                                            <div class="px-6">
                                                <c:forEach items="${menu.items}" var="sub">
                                                    <a href="${sub.href}"
                                                       class="dropdown-group py-5 border-top border-bottom" role="button">
                                                        <div class="d-flex">
                                                                <%--<div class="lh-none">
                                                                    <i class="bi bi-chat"></i>
                                                                </div>--%>
                                                            <div class="ms-1">
                                                                <h6 class="dropdown-heading lh-none mb-2">${sub.label}</h6>
                                                                    <%--<p class="dropdown-helper">Quick setup and build tools</p>--%>
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
                                    <c:set var="styleBackground" value="" />
                                    <c:if test="${not empty menu.iconCss && fn:startsWith(menu.iconCss, 'http')}">
                                        <c:set var="styleBackground" value="background:url(${menu.iconCss})" />
                                        <c:set var="isMenuDescription" value="true" />
                                    </c:if>

                                    <li class="nav-item dropdown position-static" data-bs-toggle="hover">
                                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">${menu.label}</a>
                                        <div class="dropdown-menu dropdown-menu-lg-fluid p-0 rounded-0 border-0 shadow-6" aria-labelledby="">
                                            <div class="border-top-4 border-primary">
                                                <div class="row g-0">
                                                    <c:if test="${isMenuDescription eq true}">
                                                        <div class="col-12 col-lg-4">
                                                            <div class="dropdown-img-left rounded-0 ${menu.cssClass}" style="${styleBackground}">
                                                                <div class="position-relative overlap-10 text-center">
                                                                    <c:if test="${empty styleBackground}">
                                                                        <h3 class="ls-tight">${menu.label}</h3>
                                                                        <div class="text-sm mb-6">${menu.description}</div>
                                                                    </c:if>
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
                                                                        <a href="${sub.href}" class="dropdown-group ${not empty sub.description ? 'mb-8' : ''}" role="button">
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
                                <c:when test="${menu.type eq 'login'}">
                                    <li class="nav-item">
                                        <security:authorize access="isAnonymous()">
                                            <a href="/login.html" class="nav-link ${menu.cssClass} d-lg-none"><fmt:message key="label.login"/></a>
                                            <a href="/login.html" class="nav-item nav-link d-none d-lg-inline-flex"><fmt:message key="label.login"/></a>
                                        </security:authorize>
                                        <security:authorize access="isAuthenticated()">
                                            <a href="/my/booking.html" class="nav-link ${menu.cssClass} d-lg-none"><fmt:message key="label.my-booking"/></a>
                                            <a href="/my/booking.html" class="nav-item nav-link d-none d-lg-inline-flex"><fmt:message key="label.my-booking"/></a>
                                        </security:authorize>
                                    </li>
                                </c:when>
                                <c:otherwise>

                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                </ul>
                <security:authorize access="isAuthenticated()">
                    <form id="mainlogout" class="d-none" method="post" action="/j_spring_security_logout">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                    <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                    <div class="navbar-nav">
                        <a class="nav-item nav-link" href="/agent/news"><fmt:message key="systemadmin"/></a>
                    </div>
                    </security:authorize>
                    <div class="d-flex align-items-lg-center">
                        <a href="#" onclick="document.getElementById('mainlogout').submit();" class="btn btn-sm btn-primary w-full w-lg-auto">
                            <fmt:message key="label.logout"/>
                        </a>
                    </div>
                </security:authorize>
            </div>
        </div>
    </nav>
</header>
<jsp:include page="popups.jsp"/>
