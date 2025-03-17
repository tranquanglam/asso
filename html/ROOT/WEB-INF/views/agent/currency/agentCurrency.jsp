<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item"><a href="/agent/currency/lastestrates">Lastest Rates</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Site Currency</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1>Site Currency</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <c:if test="${not empty errors}">
                <div class="alert alert-danger" id="error-message">${errors}</div>
            </c:if>
            <form class="form-horizontal" action="${requestScope['javax.servlet.forward.request_uri']}" method="POST">

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="form-group">
                    <label class="col-md-2 control-label">Site Currency</label>
                    <div class="col-md-10">
                        <select name="agentCurrency" class="form-control">
                            <c:forEach var="currency" items="${currencies}">
                                <option value="${currency.currencycode}" ${currency.currencycode eq agentCurrency ? 'selected':''}>${currency.currencycode}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group mt-3">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <a href="${pageContext.request.contextPath}/agent/currency/lastestrates" class="btn btn-warning">Cancel</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
