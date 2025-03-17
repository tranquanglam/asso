<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="currency" value="${sessionScope.SESSION_CURRENCY.tocode}"/>
<c:set var="currencyrate" value="1"/>
<c:forEach var="currencyItem" items="${sessionScope.SESSION_CURRENCY_LIST}">
    <c:if test="${currencyItem.code eq site.agent.currency and currencyItem.tocode eq currency}">
        <c:set var="currencyrate" value="${currencyItem.rate}"/>
    </c:if>
</c:forEach>
<c:set var="maxF" value="0"/>
<c:if test="${currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
</c:if>
<div class="payment-container bg-dark pt-5 pb-5">
<div class="container">
    <div class="text-center pb-5">
        <h1 class="text-white"><fmt:message key="payment.select.plan"/></h1>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title"><fmt:message key="booking.customer.info"/></h5>
                    <p class="card-text"><fmt:message key="booking.customer.full_name"/>: ${customer.fullname}</p>
                    <p class="card-text"><fmt:message key="booking.customer.email"/>: ${customer.email}</p>
                    <p class="card-text"><fmt:message key="booking.customer.phone"/>: ${customer.phone}</p>
                    <p class="card-text"><fmt:message key="label.country"/>: ${customer.country}</p>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title"><fmt:message key="payment.select.plan"/></h5>
                    <form class="form-horizontal" method="post" action="/ao/payment/${customer.customerid}/payment-submit.html">
                        <div class="row">
                            <div class="col-md-8 col-6">
                            <select class="custom-select w-100" name="productpriceid">
                                <c:forEach var="productprice" items="${productprices}">
                                    <c:set var="pname" value="${productprice.description}"/>
                                    <c:if test="${lang eq 'vi'}">
                                        <c:set var="pname" value="${productprice.descriptionvi}"/>
                                    </c:if>
                                    <option value="${productprice.productpriceid}">${pname} - ${currency}  <fmt:formatNumber value="${productprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/></option>
                                </c:forEach>
                            </select>
                            </div>
                            <div class="col-md-4 col-6">
                                <button class="btn btn-primary w-100 payment-submit" type="submit"><fmt:message key="pay-now"/></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</div>