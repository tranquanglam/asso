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
<%--<div class=" " data-offset-top="#header-main"></div>--%>
<div class="content-booking py-5">
    <div class="">
        <div class="row">
            <div class="col-12 col-md-12 col-lg-8">

                <div class="card">
                    <div class="card-header border-bottom">
                        <h4><fmt:message key="booking.payment_method"/></h4>
                    </div>
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
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-12 col-lg-4">
                <div class="card">
                    <div class="card-header border-bottom">
                        <h4><fmt:message key="label.product"/></h4>
                    </div>
                    <div class="card-body">
                        <div class="product-items">
                            <c:forEach var="item" items="${bookingItems}">
                                <div class=" border-bottom pt-2">
                                    <div class="row">
                                        <c:if test="${not empty item.image}">
                                            <div class="col-2">
                                                <span class="p-2"><img src="${item.image}" class="w-100 pt-2" alt=""></span>
                                            </div>

                                        </c:if>
                                        <div class="col-10">
                                            <p>${item.productname}</p>
                                            <div class="w-100 d-flex justify-content-between">
                                                <div>
                                                    <fmt:formatNumber value="${item.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>${currency} x ${item.quantity}
                                                </div>
                                                <span><fmt:formatNumber value="${item.amount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>${currency}</span>
                                            </div>

                                        </div>
                                    </div>

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
                            <hr>
                            <div class="d-flex justify-content-between align-items-center border-0">
                                <strong><fmt:message key="booking.total_amount"/></strong>
                                <span class="float-right">
                            <span class="price booking_total"><fmt:formatNumber value="${bookingForm.finalamount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>${currency}</span>
                        </span>
                            </div>
                        </div>

                        <div class="w-100 mt-3 mb-3">
                            <div class="">
                                <button id="paymentBookingBtn" class="btn btn-primary continue w-100"><span><fmt:message key="booking.confirm"/></span></button></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

