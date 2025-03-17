<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/users">Users</a></li>
                    <li class="breadcrumb-item active" aria-current="page">User's profile</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <form:form method="post" id="formBean" modelAttribute="userProfileForm" class="form-horizontal" role="form">

                <div class="form-group mb-4">
                    <label>Email: ${userProfileForm.email}</label>
                </div>
                <div class="row">
                    <spring:bind path="firstName">
                        <div class="form-group col-md ${status.error ? 'has-error' : '' }">
                            <form:label path="firstName">First Name:</form:label>
                            <form:input path="firstName" class="form-control" placeholder="First Name"/>
                        </div>
                    </spring:bind>
                    <spring:bind path="lastName">
                        <div class="form-group col-md ${status.error ? 'has-error' : '' }">
                            <form:label path="lastName">Last Name:</form:label>
                            <form:input path="lastName" class="form-control" placeholder="Last Name"/>
                            <c:if test="${status.error}">
                                <span class="help-block">${status.errorMessage}</span>
                            </c:if>
                        </div>
                    </spring:bind>
                    <spring:bind path="phone">
                        <div class="form-group col-md ${status.error ? 'has-error' : '' }">
                            <form:label path="phone">Phone:</form:label>
                            <form:input path="phone" class="form-control" placeholder="Phone"/>
                            <c:if test="${status.error}">
                                <span class="help-block">${status.errorMessage}</span>
                            </c:if>
                        </div>
                    </spring:bind>
                </div>
                <div class="form-group mt-3">
                    <button type="submit" class="btn btn-primary">&nbsp;Save</button>
                    <a class="btn btn-default" href="/agent/dashboard">&nbsp;Cancel</a>
                </div>
            </form:form>
        </div>
    </div>
    <div class="row mt-4">
        <div class="col-lg-12">
            <a class="btn btn-danger" href="/agent/users/changePassword">&nbsp;Change Password</a>
        </div>
    </div>
</div>

