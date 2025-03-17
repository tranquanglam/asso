<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
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
        <footer>
            <div class="footer-widget">
                <div class="container">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="widget">
                                <h4 class="widget-title"><fmt:message key="label.about"/></h4>
                                <ul>
                                    <li><a href="/page/about-us.html"><fmt:message key="page.about-us"/></a></li>
                                    <li><a href="/page/contact-us.html"><fmt:message key="page.contact-us"/> </a></li>
                                    <li><a href="/blog"><fmt:message key="label.news"/></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="widget">
                                <h4 class="widget-title"><fmt:message key="label.how-it-work"/> </h4>
                                <ul>
                                    <li><a href="/page/terms-conditions.html"><fmt:message key="page.terms-conditions"/></a></li>
                                    <li><a href="/page/cancellation-policy.html"><fmt:message key="page.cancellation-policy"/></a></li>
                                    <li><a href="/page/privacy-policy.html"><fmt:message key="page.privacy-policy"/></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="widget">
                                <h4 class="widget-title"><fmt:message key="label.my-account"/> </h4>
                                <ul>
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
                                            <a href="#" onclick="document.getElementById('logout').submit();" class="logout"><fmt:message key="label.logout"/></a>
                                        </li>
                                    </security:authorize>
                                    <security:authorize access="isAnonymous()">
                                        <li><a href="/login.html"><fmt:message key="label.login"/></a></li>
                                        <li><a href="/forgotPassword.html"><fmt:message key="label.forgot-password"/></a></li>
                                    </security:authorize>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="widget">
                                <h2 class="widget-title"><fmt:message key="label.follow-us"/></h2>
                                <ul class="footer-social">
                                    <li><a href="${site.facebook}"><i class="fa fa-facebook"></i></a></li>
                                    <li><a href="${site.twitter}"><i class="fa fa-twitter"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/.footer-->
            <div class="copyright">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <fmt:message key="copyright.text1"/> ${site.domain} <fmt:message key="copyright.text2"/> Powered by <a href="https://www.travelenet.com/">Travel Enet Technology</a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </c:otherwise>
</c:choose>

