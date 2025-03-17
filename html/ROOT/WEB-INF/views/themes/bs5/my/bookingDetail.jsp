<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="currency" value="đ"/>
<c:set var="currencyrate" value="1"/>
<c:set var="maxF" value="0"/>
<c:if test="${site.agent.currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="currency" value="USD"/>
</c:if>

<header>
    <div class="">
        <div class="border-bottom pt-6">
            <div class="row align-items-center">
                <div class="col-sm col-12">
                    <h1 class="h2 ls-tight">
                        <fmt:message key="booking.order_info"/>
                    </h1>
                </div>

                <div class="col-sm-auto col-12 mb-1">
                    <div class="hstack gap-2 justify-content-sm-end">
                        <a class="btn btn-sm btn-primary" href="javascript:void(0)" onclick="previewPrint()"> <fmt:message key="label.print"/> </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="mybooking mt-2 mb-4">
    <div class="booking-container">
        <div class="my-3 vstack gap-4 ">
            <div class="row">
                <div class="col-md-3 text-right">
                    <form id="myBookingForm" class="form-inline mr-auto" action="/my/booking.html" method="post">
                        <div class="input-group">

                            <input  name="orderNumber" placeholder="<fmt:message key="purchase.number"/>" maxlength="64" class="form-control"/>
                            <button type="submit" class="btn btn-secondary"><i class="bi bi-search"></i></button>
                        </div>
                        <input name="page" type="hidden" value="1"/>
                    </form>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-6">
                    <div class="card">
                        <div class="card-header border-bottom d-flex align-items-center">
                            <h5 class="me-auto"><fmt:message key="booking.order_info"/></h5>
                        </div>
                        <div class="card-body">

                            <p class="card-text"><fmt:message key="booking.number"/>: ${booking.ordernumber}</p>
                            <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
                                <p class="card-text"><fmt:message key="booking.booker"/>: ${booking.booker}</p>
                            </security:authorize>
                            <p class="card-text"><fmt:message key="booking.order-date"/>: <fmt:formatDate type = "both" value = "${booking.orderdate}" /></p>
                            <p class="card-text"><fmt:message key="booking.status"/>: <span class="status ${booking.status}"><fmt:message key="${booking.status}"/></span></p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="card">
                        <div class="card-header border-bottom d-flex align-items-center">
                            <h5 class="me-auto"><fmt:message key="booking.customer.info"/></h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><fmt:message key="booking.customer.full_name"/>: ${customer.fullname}</p>
                            <p class="card-text"><fmt:message key="booking.customer.email"/>: ${customer.email} / <span><fmt:message key="booking.customer.phone"/>: ${customer.phone}</span></p>
                            <p class="card-text"><span><fmt:message key="label.address"/>: ${customer.address} </span></p>
                            <div class="card-text d-flex justify-content-between">
                                <span><fmt:message key="label.ward"/>: ${customer.wardName}</span>
                                <span><fmt:message key="label.city"/>: ${customer.cityName} / ${customer.statecode}</span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <c:if test="${not empty booking.specialrequest}">
                <div class="card">
                    <div class="card-header border-bottom d-flex align-items-center">
                        <h5 class="me-auto"><fmt:message key="booking.customer.special_request"/></h5>
                    </div>
                    <div class="card-body">
                            ${booking.specialrequest}
                    </div>
                </div>
            </c:if>

            <div class="card">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto"><fmt:message key="label.product"/></h5>
                </div>
                <div class="box-table">
                    <div class="table-responsive table-responsive-last">
                        <table class="table table-nowrap">
                            <thead class="table-light">
                            <tr>
                                <th><fmt:message key="label.product.name"/> </th>
                                <th><fmt:message key="label.product.description"/> </th>
                                <th class="text-end"><fmt:message key="price"/></th>
                                <th class="text-end"><fmt:message key="label.product.quantity"/></th>
                                <th class="text-end"><fmt:message key="label.discount"/></th>
                                <th class="text-end"><fmt:message key="booking.amount"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${booking.customerorderitems}" var="item">
                                <tr>
                                    <td>${item.productname}</td>
                                    <td>${item.description}</td>
                                    <td class="text-end"><fmt:formatNumber value="${item.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${currency}</td>
                                    <td class="text-end">${item.quantity}</td>
                                    <td class="text-end"><fmt:formatNumber value="${item.discount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${currency}</td>
                                    <td class="text-end"><fmt:formatNumber value="${item.amount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${currency}</td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="5">
                                    <div class="text-end"><fmt:message key="shipping.fee"/></div>
                                </td>
                                <td class="text-end">
                                    <fmt:formatNumber value="${booking.servicescharge * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${currency}
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <div class="text-end"><fmt:message key="label.discount"/></div>
                                </td>
                                <td class="text-end">
                                    <fmt:formatNumber value="${booking.discount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${currency}
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <div class="text-end"><fmt:message key="booking.total_amount"/></div>
                                </td>
                                <td class="text-end font-bolder">
                                    <fmt:formatNumber value="${booking.finalamount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${currency}
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>

            <div class="row">
                <div class="col-12">
                    <div class="d-flex justify-content-between">
                        <div>
                            <c:if test="${joinmeeting}">
                                <a href="/my/${productcalendar.productcalendarid}/join-meeting.html" class="btn btn-primary"><fmt:message key="join.meeting"/></a>
                            </c:if>
                        </div>
                        <c:if test="${not empty actions}">
                            <div class="actions">
                                <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                    <c:if test="${booking.status eq 'CONFIRMED' or booking.status eq 'SHIPPING'}">
                                        <a href="/my/${booking.customerorderid}/order-form.html?revertToRequest=true" class="btn btn-link px-3"><i class="fa fa-edit"></i></a>
                                    </c:if>
                                </security:authorize>
                                <c:forEach var="ac" items="${actions}">
                                    <a href="#" class="btn btn-outline-primary actionBtn ${ac}" data-action="${ac}" data-name="<fmt:message key="${ac}"/>"><fmt:message key="${ac}"/></a>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="d-none">
    <input type="hidden" id="bookingid" value="${booking.customerorderid}">
</div>
<div class="modal fade" id="actionFormModal" tabindex="-1" role="dialog" aria-labelledby="actionFormModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="actionFormModalLabel"></h3>
            </div>
            <div class="modal-body">
                <form method="post" id="actionForm">
                    <input type="hidden" name="action" value="">
                    <div class="form-group">
                        <label id="paymentinfoLabel">Infomation</label>
                        <input type="text" class="form-control" name="paymentinfo" maxlength="255" value="">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-success btn-action-submit"> <fmt:message key="button.submit"/></button>
                <button class="btn btn-info" data-bs-dismiss="modal" aria-hidden="true">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="previewPrintModal" tabindex="-1" role="dialog" aria-labelledby="previewPrintModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg bg-surface-secondary" >
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="previewPrintModalLabel"></h3>
            </div>
            <div class="modal-body " style="height: 70vh;">
                <iframe class="w-100 h-100" src="/my/booking/${booking.customerorderid}/view-print.html"></iframe>
                <div class="d-none" id="printContent"></div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-success btn-action-print"> <fmt:message key="label.print"/></button>
                <button class="btn btn-info" data-bs-dismiss="modal" aria-hidden="true">Close</button>
            </div>
        </div>
    </div>
</div>
