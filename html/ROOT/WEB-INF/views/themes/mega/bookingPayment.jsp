<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="customer" value="${bookingForm.customer}"/>
<c:set var="currency" value="đ"/>
<c:set var="currencyrate" value="1"/>
<c:set var="maxF" value="0"/>
<c:if test="${site.agent.currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="currency" value="USD"/>
</c:if>
<div class="mt-4">
    <div class="text-center">
        <h1 class="title"><fmt:message key="booking.payment_method"/></h1>
    </div>
</div>
<div class="content-booking">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h4><fmt:message key="booking.payment_method"/></h4>
                <div class="card">
                    <div class="card-body">
                        <form id="payNowForm" method="post" action="/${bookingForm.customerorderid}/paynow.html">
                            <c:set var="pmPolicy" value=""/>
                            <div class="row">
                                <c:forEach var="pm" items="${paymentMethods}" varStatus="theCount">
                                    <div class="col">
                                        <label class="radio-inline">
                                            <input type="radio"  name="paymentMethod" value="${pm.code}" class="radio" ${theCount.first ? 'checked' : ''}>
                                                ${pm.policy}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                            <div id="paymentPolicy" class="overflow-auto" style="height: 350px">

                            </div>
                            <div class="mt-3">
                                <input id="agreeid" name="agree" type="checkbox"> <strong class="agree-text"><fmt:message key="booking.agree"/> </strong>
                            </div>
                            <div class="text-right mt-3 mb-3">
                                <div class="">
                                    <a href="javascript:void(0)" id="paymentBookingBtn" class="btn btn-primary continue"><span><fmt:message key="booking.confirm"/> <i
                                            class="fa fa fa-chevron-right"></i></span></a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <h4><fmt:message key="label.product"/></h4>
                <div class="card">
                    <div class="card-body">
                        <div class="product-items">
                            <c:forEach var="item" items="${bookingItems}">
                                <div class="d-flex justify-content-between align-items-center border-bottom pt-4 pb-4">
                                    <div class="d-flex">
                                        <c:if test="${not empty item.image}">
                                            <span class="pr-2"><img src="${item.image}" alt="" width="100px"></span>
                                        </c:if>
                                        <div>
                                            <strong>${item.productname}</strong>
                                            <div>
                                                <fmt:formatNumber value="${item.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>${currency} x ${item.quantity}
                                            </div>
                                        </div>
                                    </div>
                                    <span><fmt:formatNumber value="${item.amount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>${currency}</span>
                                </div>
                            </c:forEach>
                            <div class="d-flex justify-content-between py-4">
                                <span><fmt:message key="shipping.fee.temp"/>:</span><span><fmt:formatNumber value="${bookingForm.servicescharge * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>${currency}</span>
                            </div>
                            <c:if test="${bookingForm.discount gt 0}">
                                <div class="py-4">
                                    <span><strong><fmt:message key="label.discount"/>:</strong></span>
                                    <span class=float-right">
                                -<span class="label-info"><fmt:formatNumber value="${bookingForm.discount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>${currency}</span>
                            </span>
                                </div>
                            </c:if>
                            <div class="d-flex justify-content-between align-items-center border-0">
                                <strong><fmt:message key="booking.total_amount"/></strong>
                                <span class="float-right">
                            <span class="price booking_total"><fmt:formatNumber value="${bookingForm.finalamount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>${currency}</span>
                        </span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

