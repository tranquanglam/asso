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
<header class="header header-gradient-primary header-primary " id="header-main">
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
                                                        <a class="dropdown-item nav-item-booking" href="/my/booking.html"><fmt:message key="label.my-booking"/></a>
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
                                                        <a href="#" onclick="document.getElementById('plogout').submit();" class="dropdown-group ms-3" role="button">
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
    <!-- Main navbar -->
    <nav class="navbar navbar-main navbar-expand-lg ${bmenu.bmenuMain.cssClass}" id="navbar-main">
        <div class="container px-lg-0">
            <!-- Logo -->
            <c:if test="${bmenu.bmenuMain.logo != null}">
                <!-- Logo -->
                <a class="navbar-brand" href="/">
                    <img src="${bmenu.bmenuMain.logo.logo}" style="height: ${bmenu.bmenuMain.logo.height} !important;" alt="logo">
                </a>
            </c:if>
            <!-- Navbar collapse trigger -->
            <button class="navbar-toggler pr-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-main-collapse" aria-controls="navbar-main-collapse" aria-expanded="false" aria-label="Toggle navigation">
                <i class="bi bi-list"></i>
            </button>
            <!-- Navbar nav -->
            <div class="collapse navbar-collapse" id="navbar-main-collapse">
                <ul class="navbar-nav align-items-lg-center">
                    <li class="nav-item"><a class="nav-link" href="#">Đặt Hàng</a></li>
                </ul>

            </div>
        </div>
    </nav>
</header>
<jsp:include page="popups.jsp"/>
