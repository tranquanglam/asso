<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<link rel="stylesheet" type="text/css" href="/themes/mega/css/login.css" />
<div class="mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="mg-sec-title">
                    <h2 class="title">Renew form</h2>
                </div>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>${errorMessage}!</strong>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <div class="text-center">
                    Please enter the email address and your site domain to renew
                </div>
                <div class="d-flex justify-content-center align-items-center">
                    <div class="login-container container">
                        <form:form class="justify-content-center" role="form" modelAttribute="paymentForm" method="post" id="paymentForm">
                            <div class="form-group">
                                <form:input path="email" type="email" cssClass="input-block-level required email form-control" placeholder="Email (Required)"/>
                            </div>
                            <div class="form-group">
                                <form:input path="domain" cssClass="input-block-level required form-control" placeholder="Domain (Required)"/>
                            </div>
                            <!--captcha-->
                            <div class="form-group">
                                <label class="control-label"></label>
                                <div>
                                    <img src="/jcaptcha" style="cursor: pointer; width: 10em;" onclick="refreshCaptcha();" id="captchaCodeImg">
                                </div>
                            </div>
                            <spring:bind path="captchaCode">
                                <div class="form-group ${status.error ? 'error' : '' }">
                                    <form:input id="captcha" path="captchaCode" cssClass="input-block-level required form-control" placeholder="Enter Code From Image Above" />
                                    <c:if test="${status.error}">
                                        <span class="help-block">${status.errorMessage}</span>
                                    </c:if>
                                </div>
                            </spring:bind>
                            <div class="form-group mt-4">
                                <button class="btn btn-large btn-block btn-blue" type="button" onclick="paymentFormSubmit()">Submit</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="mt-3"></div>
