<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/users">Users</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Change password</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <form:form method="post" id="formBean" modelAttribute="changePasswordForm" class="form-horizontal" role="form">

                <spring:bind path="currentPassword">
                    <div class="form-group ${status.error ? 'has-error' : '' }">
                        <form:label path="currentPassword">Current Password:</form:label>
                        <form:password path="currentPassword" class="form-control" placeholder="Current Password"/>
                        <c:if test="${status.error}">
                            <span class="help-block">${status.errorMessage}</span>
                        </c:if>
                    </div>
                </spring:bind>

                <spring:bind path="password">
                    <div class="form-group mt-3${status.error ? 'has-error' : '' }">
                        <form:label path="password">New Password:</form:label>
                        <form:password path="password" class="form-control" placeholder="New Password"/>
                        <c:if test="${status.error}">
                            <span class="help-block">${status.errorMessage}</span>
                        </c:if>
                    </div>
                </spring:bind>

                <spring:bind path="confirmPassword">
                    <div class="form-group mt-3 ${status.error ? 'has-error' : '' }">
                        <form:label path="confirmPassword">Confirm New Password:</form:label>
                        <form:password path="confirmPassword" class="form-control" placeholder="Confirm Password"/>
                        <c:if test="${status.error}">
                            <span class="help-block">${status.errorMessage}</span>
                        </c:if>
                    </div>
                </spring:bind>

                <div class="form-group mt-3">
                    <button type="submit" class="btn btn-primary">&nbsp;Save</button>
                    <a class="btn btn-default" href="/agent/dashboard">&nbsp;Cancel</a>
                </div>
            </form:form>
        </div>
    </div>
</div>

