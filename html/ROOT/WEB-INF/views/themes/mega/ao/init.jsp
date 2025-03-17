<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="pageName"><fmt:message key="ao.init"/></c:set>
<c:set var="pageContent"><fmt:message key="ao.init.content"/></c:set>
<c:if test="${page != null}">
    <c:set var="pageName">${page.name}</c:set>
    <c:set var="pageContent">${page.content}</c:set>
</c:if>
<div class="text-center">
    <h1 class="font-weight-normal">${pageName}</h1>
    <div>${pageContent}</div>
</div>
<div class="bg-light">
    <div class="p-3 bg-white">

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <strong>${errorMessage}!</strong>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        <div class="form-register">
            <form:form cssClass="form-horizontal" id="createSiteForm" action="/ao/init.html"  modelAttribute="formBean" method="post">
                <div class="row">
                    <div class="col-md-9">
                        <div class="row">
                            <c:forEach items="${products}" var="product">
                                <c:set var="pname" value="${product.namevi}"/>
                                <c:if test="${lang eq 'en'}">
                                    <c:set var="pname" value="${product.name}"/>
                                </c:if>
                                <div class="col-md-3 col-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="mpcodes" value="${product.mpcode}">
                                        <label class="form-check-label">
                                                ${pname}
                                        </label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <input type="hidden" id="sitetype" name="sitetype" value="100">
                        <div class="form-group">
                            <input class="form-control w-100" name="inputEmail" type="email" placeholder="Enter email address..." />
                        </div>
                        <div class="form-group">
                            <input class="form-control w-100" name="subdomain" type="text" placeholder="Enter subdomain" />
                        </div>
                        <select class="custom-select form-control" name="cdomain">
                            <option value="${site.domain}">Default</option>
                            <c:forEach var="temp" items="${templates}">
                                <option value="${temp.link}">${temp.name}</option>
                            </c:forEach>
                        </select>
                        <div class="form-group mt-3 bg-dark">
                            <img src="/jcaptcha" style="cursor: pointer; width: 30%;" onclick="refreshCaptcha();" id="captchaCodeImg">
                        </div>
                        <div class="form-group">
                            <form:input id="captcha" path="captchaCode" cssClass="required form-control" placeholder="Enter code from the image" />
                        </div>
                        <div class="form-group">
                            <button class="btn btn-primary create-site w-100" type="button" onclick="createSiteFormSubmit()">Create site</button>
                        </div>
                        <div class="accept-agreement pt-3 pb-3">
                                ${acceptAgreementPage.content}
                        </div>
                    </div>
                </div>
            </form:form>
        </div>
    </div>

</div>

