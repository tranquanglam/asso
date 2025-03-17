<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="logo" value="${site.desktopLogo}"/>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="menuListMapid" value="menuListMap_${site.siteid}"/>
<c:set var="menuList" value="${applicationScope[menuListMapid][lang]}"/>
<nav class="navbar navbar-inverse navbar-expand-md" id="mainNav">
    <div class="container-fluid">
        <button class="navbar-toggler mt-3" type="button" data-toggle="collapse" data-target="#navbarCollapse">
            <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
        </button>
        <c:choose>
            <c:when test="${not empty logo}">
                <div class="d-inline logo-bd"><a class="navbar-brand" href="/dashboard.html"><img src="${logo}" alt="logo"/></a></div>
            </c:when>
            <c:otherwise>
                <div class="d-inline logo-bd"><a class="navbar-brand" href="/dashboard.html"><i class="fa fa-2x fa-database text-white" aria-hidden="true"></i></a></div>
            </c:otherwise>
        </c:choose>
        <div class="collapse navbar-collapse" id="navbarCollapse">

            <ul class="navbar-nav flex-row menu-second ml-auto">
                <c:if test="${not empty menuList}">
                    <c:forEach items="${menuList}" var="menu">
                        <c:set var="menuname" value="${menu.name}"/>
                        <c:choose>
                            <c:when test="${empty menu.subList}">
                                <li class="nav-item"><a class="nav-link" href="${menu.link}">${menuname}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item dropdown">
                                    <a class="dropdown-toggle no-caret" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${menuname}</a>
                                    <ul class="dropdown-menu">
                                        <c:forEach items="${menu.subList}" var="sub">
                                            <c:set var="menuname" value="${sub.name}"/>
                                            <li><a href="${sub.link}">${menuname}</a></li>
                                        </c:forEach>
                                    </ul>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:if>
                <li class="nav-item dropdown">
                    <a class="dropdown-toggle no-caret" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user" aria-hidden="true"></i></a>
                    <ul class="dropdown-menu">
                        <security:authorize access="isAuthenticated()">
                            <li><a href="/my/profile.html"><fmt:message key="label.my-profile"/></a></li>
                            <li><a href="/my/booking.html"><fmt:message key="label.my-booking"/></a></li>
                            <security:authorize access="hasAnyAuthority('ASSISTANT','CASHIER')">
                                <li><a href="/my/customers.html"><fmt:message key="label.my-customers"/></a></li>
                            </security:authorize>
                            <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_USER','PM')">
                                <li><a href="/my/customers.html"><fmt:message key="label.my-customers"/></a></li>
                                <li><a href="/bo/data/branches.html"><fmt:message key="label.branch"/></a></li>
                                <li><a href="/bo/data/products.html"><fmt:message key="label.product"/></a></li>
                                <li><a href="/bo/data/manufacturers.html"><fmt:message key="label.manufacturer"/></a></li>
                            </security:authorize>
                            <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_USER')">
                                <li><a href="/agent/news"><fmt:message key="systemadmin"/></a></li>
                                <li><a href="/my/messages.html"><fmt:message key="label.my-messages"/></a></li>
                            </security:authorize>
                            <li>
                                <form id="logout" class="d-none" method="post" action="/j_spring_security_logout">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </form>
                                <a href="#" onclick="logout();" class="logout"><fmt:message key="label.logout"/></a>
                            </li>
                        </security:authorize>
                        <security:authorize access="isAnonymous()">
                            <li><a href="/login.html"><fmt:message key="label.login"/></a></li>
                            <li><a href="/forgotPassword.html"><fmt:message key="label.forgot-password"/></a></li>
                        </security:authorize>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="dropdown-toggle no-caret text-uppercase font-weight-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-language" aria-hidden="true"></i> ${lang}</a>
                    <ul class="dropdown-menu menu-lang">
                        <li class="nav-item"><a href="javascript:changeLang('en')" class="font-weight-light">EN</a></li>
                        <c:if test="${not empty site.langext}">
                            <li class="nav-item"><a href="javascript:changeLang('${site.langext}')" class="font-weight-light">${site.langext}</a></li>
                        </c:if>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
