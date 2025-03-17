<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="logo" value="${site.desktopLogo}"/>
<c:set var="footerid" value="footer_${site.siteid}"/>
<c:choose>
    <c:when test="${applicationScope[footerid] != null}">
        <c:choose>
            <c:when test="${lang eq 'en'}">
                ${applicationScope[footerid].content}
            </c:when>
            <c:otherwise>
                ${applicationScope[footerid].contentvn}
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <footer id="footer-main">
            <div class="footer footer-dark bg-gradient-primary">
                <div class="container">
                    <div class="row pt-md">
                        <div class="col-lg-5 mb-5 mb-lg-0">
                            <a href="/">
                                <img src="${logo}" alt="Footer logo" height="70px">
                            </a>
                            <div>${site.description}</div>
                        </div>
                        <div class="col-lg-2 col-6 col-sm-4 ml-lg-auto mb-5 mb-lg-0">
                            <h6 class="heading mb-3"><fmt:message key="label.my-account"/></h6>
                            <ul class="list-unstyled">
                                <security:authorize access="isAuthenticated()">
                                    <li><a href="/my/booking.html"><fmt:message key="label.my-booking"/></a></li>
                                    <li><a href="/my/profile.html"><fmt:message key="label.my-profile"/></a></li>
                                    <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                        <li><a href="/my/customers.html"><fmt:message key="label.my-customers"/></a></li>
                                        <li><a href="/my/messages.html"><fmt:message key="label.my-messages"/></a></li>
                                    </security:authorize>
                                    <li>
                                        <form id="flogout" class="d-none" method="post" action="/j_spring_security_logout">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        </form>
                                        <a href="#" onclick="document.getElementById('flogout').submit();" class="logout"><fmt:message key="label.logout"/></a>
                                    </li>
                                </security:authorize>
                                <security:authorize access="isAnonymous()">
                                    <li><a href="/login.html"><fmt:message key="label.login"/></a></li>
                                    <li><a href="/forgotPassword.html"><fmt:message key="label.forgot-password"/></a></li>
                                    <li><a href="/membershipRegister"><fmt:message key="label.create-account"/></a></li>
                                </security:authorize>
                            </ul>
                        </div>
                        <div class="col-lg-2 col-6 col-sm-4 mb-5 mb-lg-0">
                            <h6 class="heading mb-3"><fmt:message key="label.about"/></h6>
                            <ul class="list-unstyled text-small">
                                <li><a href="/page/about-us.html"><fmt:message key="page.about-us"/></a></li>
                                <li><a href="/page/contact-us.html"><fmt:message key="page.contact-us"/> </a></li>
                                <li><a href="/blog"><fmt:message key="label.news"/></a></li>
                            </ul>
                        </div>
                        <div class="col-lg-2 col-sm-4 mb-5 mb-lg-0">
                            <h6 class="heading mb-3"><fmt:message key="label.how-it-work"/></h6>
                            <ul class="list-unstyled">
                                <li><a href="/page/terms-conditions.html"><fmt:message key="page.terms-conditions"/></a></li>
                                <li><a href="/page/cancellation-policy.html"><fmt:message key="page.cancellation-policy"/></a></li>
                                <li><a href="/page/privacy-policy.html"><fmt:message key="page.privacy-policy"/></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="row align-items-center justify-content-md-between py-4 mt-4 delimiter-top">
                        <div class="col-md-6">
                            <div class="copyright text-sm font-weight-bold text-center text-md-left">
                                &copy; 2020-2021 ${site.domain}. All rights reserved. Powered by <a href="https://dolaenet.io" class="font-weight-bold" target="_blank">Enet</a>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <ul class="nav justify-content-center justify-content-md-end mt-3 mt-md-0">
                                <li class="nav-item">
                                    <a class="nav-link" href="${site.twitter}" target="_blank">
                                        <i class="fab fa-twitter"></i>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${site.youtube}" target="_blank">
                                        <i class="fab fa-youtube"></i>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${site.facebook}" target="_blank">
                                        <i class="fab fa-facebook"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </c:otherwise>
</c:choose>

