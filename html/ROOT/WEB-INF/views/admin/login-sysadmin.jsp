<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/login.css" />
</head>
<body>
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
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>



