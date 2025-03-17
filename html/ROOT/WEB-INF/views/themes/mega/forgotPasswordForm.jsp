<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<link rel="stylesheet" type="text/css" href="/themes/mega/css/login.css" />
<div class="mt-5 session-forgot-password">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="mg-sec-title">
                    <h2 class="title">Forgot password?</h2>
                </div>
    <c:if test="${email == null}">
                <div class="d-flex justify-content-center align-items-center container">
                    <div class="login-container">
        <form:form class="form-signin animated bounce" role="form" modelAttribute="forgotPasswordForm" method="post">
            <p>
                Please enter the email address for your account. A verification email will be sent to you. Once you have received the verification email, you will be able to choose a new password for your account.
            </p>
            <spring:bind path="email">
                <div class="form-group ${status.error ? 'error' : '' }">
                    <form:input path="email" type="email" cssClass="input-block-level required email form-control" placeholder="Email (Required)"/>
                    <c:if test="${status.error}">
                        <span class="help-block">${status.errorMessage}</span>
                    </c:if>
                </div>
            </spring:bind>
            <!--captcha-->
            <div class="form-group">
                <label class="control-label"></label>
                <div>
                    <img src="jcaptcha" style="cursor: pointer; width: 10em;" onclick="refreshCaptcha();" id="captchaCodeImg">
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
            <button class="btn btn-large btn-block btn-blue" type="submit">Submit</button>
        </form:form>
                    </div>
                </div>
    </c:if>
    <c:if test="${email != null}">

        <form class="form-signin">
            <h4 class="form-signin-heading">
                An email has been sent to your email <strong>${email}</strong>.<br>
                <br>
                Please follow the instructions in the email to reset your password.<br><br>
            </h4>
        </form>
    </c:if>
            </div>
        </div>
    </div>
</div>
<div class="mt-3"></div>
