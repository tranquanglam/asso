<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<section class="slice slice-lg min-vh-100 d-flex align-items-center bg-gradient-primary" data-offset-top="#header-main">
    <!-- SVG background -->
    <%--<div class="bg-absolute-cover bg-size--contain d-none d-lg-block pt-lg-6" data-offset-top="#header-main">
        <figure class="w-100">
            <img alt="Login image" src="https://membooking.com/themes/purpose/img/svg/backgrounds/login.svg" class="svg-inject">
        </figure>
    </div>--%>
    <div class="container py-1 px-md-0 d-flex align-items-center">
        <div class="w-100">
            <div class="row row-grid justify-content-center justify-content-lg-between align-items-center">
                <div class="col-sm-8 col-lg-6 col-xl-5 order-lg-2">
                    <div class="card shadow zindex-100 mb-0">
                        <div class="card-body px-md-12 py-12">
                            <div class="mb-12">
                                <h1 class="h3">Login</h1>
                                <p class="text-muted mb-0">Sign in to your account to continue.</p>
                            </div>
                            <span class="clearfix"></span>
                            <form id="loginForm" role="form" action="/j_spring_security_check" method="post">
                                <div class="form-group">
                                    <label class="form-control-label">User name</label>
                                    <div class="input-group ">
                                        <div class="input-group-text"><i class="bi bi-person-fill"></i></div>
                                        <input type="text" name="j_username" class="form-control required"
                                               maxlength="127" placeholder="Email or Phone"/>
                                    </div>
                                </div>
                                <div class="form-group mb-4">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <label class="form-control-label">Password</label>
                                        </div>
                                        <div class="mb-2">
                                            <a href="/forgotPassword.html" class="small text-muted text-underline--dashed border-primary">Lost password?</a>
                                        </div>
                                    </div>
                                    <div class="input-group ">
                                        <div class="input-group-text"><i class="bi bi-key"></i></div>
                                        <input type="password" name="j_password" class="form-control" id="input-password" placeholder="Password">
                                    </div>
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
                                <div class="d-none" id="auto-message"></div>
                                <div class="mt-4"><a href="javascript:void(0);" class="btn btn-sm btn-primary btn-icon rounded-pill btn-login-submit">
                                    <span class="btn-inner--text">Sign in</span>
                                    <span class="btn-inner--icon"><i class="bi bi-long-arrow-alt-right"></i></span>
                                </a></div>
                            </form>
                        </div>
                        <div class="card-footer px-md-12"><small><fmt:message key="registry.signup"/> ${site.domain} ?</small>
                            <a href="/membershipRegister" class="small font-weight-bold"><fmt:message key="registry.dosignup"/></a></div>
                    </div>
                </div>
                <div class="col-lg-5 order-lg-1 d-none d-lg-block zindex-100">
                    <blockquote>
                        <div class="mb-4">${page.content}</div>
                        <footer>— <cite class="text-lg">${page.name}</cite></footer>
                    </blockquote>
                </div>
            </div>
        </div>
    </div>
</section>

