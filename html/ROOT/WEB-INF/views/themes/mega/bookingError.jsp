<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="customer" value="${bookingForm.customer}"/>
<c:set var="currency" value="${sessionScope.SESSION_CURRENCY.tocode}"/>
<c:set var="currencyrate" value="1"/>
<c:forEach var="currencyItem" items="${sessionScope.SESSION_CURRENCY_LIST}">
    <c:if test="${currencyItem.code eq bookingForm.currency and currencyItem.tocode eq currency}">
        <c:set var="currencyrate" value="${currencyItem.rate}"/>
    </c:if>
</c:forEach>
<c:set var="maxF" value="0"/>
<c:if test="${currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
</c:if>

<div class="mg-page">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h3><fmt:message key="checkout.error.text"/></h3>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            <strong><fmt:message key="booking.number"/></strong>: ${bookingForm.ordernumber}
                        </p>
                        <c:forEach var="bItem" items="${bookingItems}">
                            <p class="card-text">
                                <strong>${bItem.productname}</strong>: ${bItem.price} x ${bItem.quantity} = ${currency}<fmt:formatNumber value="${bItem.amount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>
                            </p>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${not empty resultMap}">
                                <p class="card-text">
                                    <span><fmt:message key="checkout.done.transaction.status"/>: ${resultMap["transStatus"]}</span>
                                </p>

                                <p class="card-text">
                                    <span><fmt:message key="checkout.done.transaction.information.merchant.name"/>: ${resultMap["merchantID"]}</span>
                                </p>

                                <p class="card-text">
                                    <span><fmt:message key="checkout.done.transaction.information.ordernumber"/>: ${resultMap["orderInfo"]}</span>
                                </p>
                                <p class="card-text">
                                    <c:set var="quocte" value="quocte"/>
                                    <c:if test="${sessionScope.isLocal}"><c:set var="quocte" value="noidia"/></c:if>
                                    <span><fmt:message key="checkout.done.transaction.information.code"/>: <a href="/querydr-${quocte}?code=${resultMap["merchTxnRef"]}">${resultMap["merchTxnRef"]}</a></span>
                                </p>

                                <p class="card-text">
                                    <span><fmt:message key="checkout.done.transaction.information.total.price"/>: <fmt:formatNumber pattern="#,###.## đ; -#,###.## đ" value="${resultMap['amount']}"/></span>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="card-text">
                                    <strong><fmt:message key="booking.total_amount"/></strong>: ${currency}<fmt:formatNumber value="${bookingForm.finalamount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>