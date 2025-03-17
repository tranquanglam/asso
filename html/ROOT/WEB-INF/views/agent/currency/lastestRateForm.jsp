<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item"><a href="/agent/currency/lastestrates">Lastest Rates</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Add/Edit Rate</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1>Add/Edit Lastest Rate</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <c:if test="${not empty errors}">
                <div class="alert alert-danger" id="error-message">${errors}</div>
            </c:if>
            <form:form id="lastestRateForm" commandName="lastestRateForm" class="form-horizontal" action="${requestScope['javax.servlet.forward.request_uri']}" method="POST">

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="form-group">
                    <label class="col-md-2 control-label">Base Currency</label>
                    <div class="col-md-10">
                        <form:select path="code" cssClass="form-control">
                            <form:options items="${currencies}" itemValue="currencycode" itemLabel="name"/>
                        </form:select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-2 control-label">To Currency</label>
                    <div class="col-md-10">
                        <form:select path="tocode" cssClass="form-control">
                            <form:options items="${currencies}" itemValue="currencycode" itemLabel="name"/>
                        </form:select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-2 control-label">Rate</label>
                    <div class="col-md-10">
                        <form:input path="rate" type="number" step="any" cssClass="form-control"/>
                    </div>
                </div>

                <div class="form-group mt-3">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <a href="${pageContext.request.contextPath}/agent/currency/lastestrates" class="btn btn-warning">Cancel</a>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>
