<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item"><a href="/agent/paymentMethods">Payment methods</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${agentPaymentMethod.paymentMethod}</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <h2>Payment method: ${agentPaymentMethod.paymentMethod}</h2>
            <form:form method="post" id="formBean" commandName="agentPaymentMethod" class="form-horizontal" role="form">
                <div class="row">
                    <div class="col-lg-1"></div>
                    <div class="col-lg-11">
                        <div class="form-group">
                            <div class="checkbox-nice">
                                <form:checkbox path="activated" label="Enable/disable this Payment Method"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-1"><label>Content:</label></div>
                    <div class="col-lg-11">
                        <div class="form-group">
                            <form:textarea path="content" cssClass="form-control" rows="3"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-1">
                        <label>Settings:</label>
                    </div>
                    <div class="col-lg-11">
                        <c:choose>
                            <c:when test="${agentPaymentMethod.paymentMethod eq 'PP' or agentPaymentMethod.paymentMethod eq 'ST'}">
                                <div class="form-group">
                                    <label>Mode</label>
                                    <form:select path="paymentMethodSettings.mode" cssClass="form-control">
                                        <form:option value="sandbox">Sandbox</form:option>
                                        <form:option value="live">Live</form:option>
                                    </form:select>
                                </div>
                                <div class="form-group">
                                    <label>ClientId</label>
                                    <form:input path="paymentMethodSettings.clientId" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>ClientSecret</label>
                                    <form:input path="paymentMethodSettings.clientSecret" cssClass="form-control"/>
                                </div>
                            </c:when>
                            <c:when test="${agentPaymentMethod.paymentMethod eq 'OG' or agentPaymentMethod.paymentMethod eq 'OL'}">
                                <div class="form-group">
                                    <label>secret</label>
                                    <form:input path="paymentMethodSettings.secret" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>title</label>
                                    <form:input path="paymentMethodSettings.title" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>version</label>
                                    <form:input path="paymentMethodSettings.version" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>command</label>
                                    <form:input path="paymentMethodSettings.command" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>accessCode</label>
                                    <form:input path="paymentMethodSettings.accessCode" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>merchant</label>
                                    <form:input path="paymentMethodSettings.merchant" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>locale</label>
                                    <form:input path="paymentMethodSettings.locale" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>orderInfo</label>
                                    <form:input path="paymentMethodSettings.orderInfo" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>virtualPaymentClientURL</label>
                                    <form:input path="paymentMethodSettings.virtualPaymentClientURL" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>street</label>
                                    <form:input path="paymentMethodSettings.street" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>city</label>
                                    <form:input path="paymentMethodSettings.city" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>stateProv</label>
                                    <form:input path="paymentMethodSettings.stateProv" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>country</label>
                                    <form:input path="paymentMethodSettings.country" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>postCode</label>
                                    <form:input path="paymentMethodSettings.postCode" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>queryUrl</label>
                                    <form:input path="paymentMethodSettings.queryUrl" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>user</label>
                                    <form:input path="paymentMethodSettings.user" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>password</label>
                                    <form:input path="paymentMethodSettings.password" cssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label>againLinkBase</label>
                                    <form:input path="paymentMethodSettings.againLinkBase" cssClass="form-control"/>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <form:textarea path="paymentMethodSettings.settings" id="settings" cssClass="form-control" rows="20"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-offset-1 col-lg-11">
                        <button type="submit" class="btn btn-primary">&nbsp;Submit</button>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>

