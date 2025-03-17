<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="/themes/mega/css/login.css" />
<section class="mt-3 pb-3">
    <div class="container">
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="mg-sec-title">
                    <h2 class="title"><fmt:message key="registry.title"/></h2>
                </div>
                <div class="d-flex justify-content-center">
                    <div class="login-container container">
                        <form class="justify-content-center" role="form" id="loginForm"
                              action="/j_spring_security_check"
                              method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="form-group">
                                <input type="text" name="j_username" class="form-control input-block-level required email"
                                       placeholder="Username or Email (Required)"/>
                            </div>
                            <div class="form-group">
                                <input type="password" name="j_password" class="form-control input-block-level required password"
                                       placeholder="Password (Required)"/>
                            </div>

                            <div class="form-group">
                                <button class="btn btn-submit" type="submit"><fmt:message key="registry.dologin"/></button>
                                <span class="btn btn-link"><a href="/forgotPassword"><fmt:message key="registry.forgotpassword"/></a></span>
                            </div>

                            <c:if test="${not empty param.error}">
                                <div class="error">
                                    <c:choose>
                                        <c:when test="${param.error == 1}">
                                            <fmt:message key="registry.error1"/>
                                        </c:when>
                                        <c:when test="${param.error == 2}">
                                            <fmt:message key="registry.error2"/>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </c:if>

                            <hr>
                            <div class="form-group">
                                    <span class="pull-right">
                                        <fmt:message key="registry.signup"/> <strong>${site.domain}</strong>? <a href="/membershipRegister"><fmt:message key="registry.dosignup"/></a>
                                    </span>
                            </div>
                        </form>
                    </div>

                    <c:if test="${not empty facebookUrl || not empty googleOauth}">
                        <div class="login-container container">
                            <c:if test="${not empty facebookUrl}">
                                <div class="pb-2">
                                    <input type="hidden" id="facebookUrl" value="${facebookUrl}">
                                    <a class="btn" type="button" href="${facebookUrl}" style="padding: 0px;">
                                        <img src="/themes/mega/images/icon_signin_fb.png" alt="Sign In with Facebook" width="300">
                                    </a>
                                </div>
                            </c:if>
                            <c:if test="${not empty googleOauth}">
                                <form id="signinWithGGForm" action="/oauth/web/signinWithGG" method="post">
                                    <input type="hidden" id="google_user_id" name="google_user_id" >
                                    <input type="hidden" id="id_token" name="id_token" >
                                </form>

                                <div class="" >
                                    <div id="my-signin2"></div>
                                        <%--<div class="g-signin2" data-onsuccess="onGGSignIn"></div>--%>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

</section>
<script>
    loginSubmit = function () {
        $('#loginForm').submit();
    };
    function onGGSignIn(googleUser) {
        var profile = googleUser.getBasicProfile();
        $('#id_token').val(googleUser.getAuthResponse().id_token);
        $('#google_user_id').val(profile.getId());
        $('#signinWithGGForm').submit();
    }

    function onSuccess(googleUser) {
        onGGSignIn(googleUser);
        console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
    }
    function onFailure(error) {
        console.log(error);
    }
    function renderButton() {
        gapi.signin2.render('my-signin2', {
            'scope': 'profile email',
            'width': 300,
            'height': 50,
            'longtitle': true,
            'theme': 'dark',
            'onsuccess': onSuccess,
            'onfailure': onFailure
        });
    }
</script>
<c:if test="${not empty googleOauth}">
    <meta name="google-signin-client_id" content="${googleOauth.appId}">
    <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
</c:if>

