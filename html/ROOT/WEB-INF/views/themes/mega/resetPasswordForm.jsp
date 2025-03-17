<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<link rel="stylesheet" type="text/css" href="/themes/mega/css/login.css" />
<section class="mt-3 pb-3">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="mg-sec-title">
                    <h2 class="title"><fmt:message key="label.forgot-password"/></h2>
                </div>
                <div class="d-flex justify-content-center align-items-center">
                    <div class="login-container container">
                        <c:if test="${done == null}">
                            <form:form class="form-signin animated bounce" role="form" modelAttribute="resetPasswordForm" method="post">
                                <h2 class="form-signin-heading"><strong>Reset your password.</strong></h2>

                                <spring:bind path="password">
                                    <div class="control-group ${status.error ? 'error' : '' }">
                                        <form:password path="password" cssClass="form-control input-block-level required email" placeholder="New Password"/>
                                        <c:if test="${status.error}">
                                            <span class="help-block">${status.errorMessage}</span>
                                        </c:if>
                                    </div>
                                </spring:bind>
                                <spring:bind path="confirmPassword">
                                    <div class="control-group ${status.error ? 'error' : '' }">
                                        <form:password path="confirmPassword" cssClass="form-control input-block-level required email" placeholder="Retype Password"/>
                                        <c:if test="${status.error}">
                                            <span class="help-block">${status.errorMessage}</span>
                                        </c:if>
                                    </div>
                                </spring:bind>
                                <div class="form-group mt-5">
                                    <button class="btn btn-large btn-block btn-blue" type="submit">Submit</button>
                                </div>
                            </form:form>
                        </c:if>
                        <c:if test="${done != null}">

                            <form class="form-signin">
                                <h4 class="form-signin-heading">
                                    Your password has been reset successfully.<br>
                                    <br>
                                    Please <a href="/login.html">click here</a> to login.<br><br>
                                </h4>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>