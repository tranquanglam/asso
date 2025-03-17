<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="headerid" value="header_${site.siteid}"/>
<c:choose>
    <c:when test="${applicationScope[headerid] != null}">
        <c:choose>
            <c:when test="${lang eq 'en'}">
                ${applicationScope[headerid].content}
            </c:when>
            <c:otherwise>
                ${applicationScope[headerid].contentvn}
            </c:otherwise>
        </c:choose>
        <div class="d-none">
            <ul>
                <li class="my-account-real-content">
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
                                <li><a href="/agent/design/home.html"><fmt:message key="design.homepage"/></a></li>
                            </security:authorize>
                            <li>
                                <form id="logout" class="d-none" method="post" action="/j_spring_security_logout">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </form>
                                <a href="#" onclick="document.getElementById('logout').submit();" class="logout"><fmt:message key="label.logout"/></a>
                            </li>
                        </security:authorize>
                        <security:authorize access="isAnonymous()">
                            <li><a href="/login.html"><fmt:message key="label.login"/></a></li>
                            <li><a href="/forgotPassword.html"><fmt:message key="label.forgot-password"/></a></li>
                        </security:authorize>
                    </ul>
                </li>
                <li class="lang-real-content">
                    <a class="dropdown-toggle no-caret text-uppercase font-weight-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-language" aria-hidden="true"></i> ${lang}</a>
                    <ul class="dropdown-menu menu-lang">
                        <li class="nav-item"><a href="javascript:changeLang('en')" class="text-uppercase font-weight-light">EN</a></li>
                        <c:if test="${not empty site.langext}">
                        <li class="nav-item"><a href="javascript:changeLang('${site.langext}')" class="text-uppercase font-weight-light">${site.langext}</a></li>
                        </c:if>
                    </ul>
                </li>
            </ul>
        </div>
    </c:when>
    <c:otherwise>
        <header class="header transp sticky">
            <jsp:include page="menu.jsp"/>
        </header>
    </c:otherwise>
</c:choose>
