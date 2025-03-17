<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Authentication method</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h2>${authenticationMethod} settings</h2>
            <form:form method="post" id="formBean" commandName="authenticationMethodForm" class="form-horizontal" role="form">
                <div class="row">
                    <div class="col-12">
                        <div class="form-group">
                            <div class="checkbox-nice">
                                <form:checkbox path="enable" label="Enable/disable this Method"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <c:choose>
                        <c:when test="${authenticationMethod eq 'FB' || authenticationMethod eq 'GG'}">
                            <div class="form-group col-md">
                                <label>AppID</label>
                                <form:input path="appId" cssClass="form-control"/>
                            </div>
                            <div class="form-group col-md">
                                <label>AppSecret</label>
                                <form:input path="appSecret" cssClass="form-control"/>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <%--<form:textarea path="paymentMethodSettings.settings" id="settings" cssClass="form-control" rows="20"/>--%>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary">&nbsp;Submit</button>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>

