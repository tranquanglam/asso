<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<div class="bg-gradient-primary" data-offset-top="#header-main">
</div>
<section class="slice bg-white">
    <div class="container h-100vh d-flex align-items-center">
        <div class="col">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5 col-xl-4">
                    <c:if test="${email == null}">
                        <div>
                            <div class="mb-5 text-center">
                                <h1 class="h3">Forgot password?</h1>
                                <p class="text-muted mb-0">Enter your email below to proceed.</p>
                            </div>
                            <span class="clearfix"></span>

                            <form:form class="form-signin animated bounce" role="form"
                                       modelAttribute="forgotPasswordForm" method="post">
                                <spring:bind path="email">
                                    <div class="form-group ${status.error ? 'error' : '' }">
                                        <label class="form-control-label">Email address</label>

                                        <div class="input-group input-group-merge ${status.error ? 'is-invalid' : ''}">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                                            </div>
                                            <form:input type="email" path="email" cssClass="form-control required"
                                                        id="input-email"
                                                        placeholder="name@example.com"/>

                                        </div>
                                        <c:if test="${status.error}">
                                            <span class="mt-2 invalid-feedback">${status.errorMessage}</span>
                                        </c:if>


                                    </div>
                                </spring:bind>
                                <div class="form-group">
                                    <label class="form-control-label">Captcha</label>
                                    <div>
                                        <img src="jcaptcha" style="cursor: pointer; width: 10em;" alt="Captcha Forgot Password"
                                             onclick="refreshCaptcha();" id="captchaCodeImg">
                                    </div>
                                </div>
                                <spring:bind path="captchaCode">
                                    <div class="input-group ${status.error ? 'is-invalid' : '' }">
                                        <form:input id="captcha" path="captchaCode"
                                                    cssClass="input-block-level required form-control"
                                                    placeholder="Enter Code From Image Above"/>
                                    </div>
                                    <c:if test="${status.error}">
                                        <span class="mt-2 invalid-feedback">${status.errorMessage}</span>
                                    </c:if>
                                </spring:bind>


                                <div class="mt-4">
                                    <button class="btn btn-block btn-primary w-100" type="submit">Reset password
                                    </button>
                                </div>
                            </form:form>
                            <div class="mt-4 text-center"><small>Not registered?</small>
                                <a href="/membershipRegister" class="small font-weight-bold">Create account</a></div>
                        </div>
                    </c:if>

                    <c:if test="${email != null}">
                        <div>
                            <div class="mb-5 text-center">
                                <p class="text-muted mb-0">
                                    An email has been sent to your email <strong>${email}</strong>.<br>
                                    <br>
                                    Please follow the instructions in the email to reset your password.<br><br>
                                </p>
                            </div>
                            <span class="clearfix"></span>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</section>
