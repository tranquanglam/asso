<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item" aria-current="page"><a href="/agent/emailTemplates">Templates</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Email settings</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <form:form method="post" id="formBean" commandName="formBean" class="form-horizontal" role="form">
                <spring:bind path="host">
                    <div class="form-group ${status.error ? 'has-error' : '' }">
                        <label>Host:</label>
                        <form:input type="text" class="form-control" path="host"/>
                        <c:if test="${status.error}">
                            <span class="help-block">${status.errorMessage}</span>
                        </c:if>
                    </div>
                </spring:bind>
                <spring:bind path="port">
                    <div class="form-group ${status.error ? 'has-error' : '' }">
                        <label>Port:</label>
                        <form:input type="text" class="form-control" path="port"/>
                        <c:if test="${status.error}">
                            <span class="help-block">${status.errorMessage}</span>
                        </c:if>
                    </div>
                </spring:bind>
                <spring:bind path="username">
                    <div class="form-group ${status.error ? 'has-error' : '' }">
                        <label>Username:</label>
                        <form:input class="form-control" path="username"/>
                        <c:if test="${status.error}">
                            <span class="help-block">${status.errorMessage}</span>
                        </c:if>
                    </div>
                </spring:bind>
                <spring:bind path="password">
                    <div class="form-group ${status.error ? 'has-error' : '' }">
                        <label>Password:</label>
                        <form:input type="password" class="form-control" path="password"/>
                        <c:if test="${status.error}">
                            <span class="help-block">${status.errorMessage}</span>
                        </c:if>
                    </div>
                </spring:bind>
                <spring:bind path="fromname">
                    <div class="form-group ${status.error ? 'has-error' : '' }">
                        <label>Sender name:</label>
                        <form:input class="form-control" path="fromname"/>
                        <c:if test="${status.error}">
                            <span class="help-block">${status.errorMessage}</span>
                        </c:if>
                    </div>
                </spring:bind>
                <div class="form-group">
                    <div class="mt-3">
                        <button type="submit" class="btn btn-success">&nbsp;Save</button>
                        <a href="/agent/settings" class="btn btn-default btn-cancel">&nbsp;Cancel</a>
                    </div>
                </div>

            </form:form>
        </div>
    </div>
</div>