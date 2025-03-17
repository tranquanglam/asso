<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="scurrency" value="đ"/>
<c:set var="maxF" value="0"/>
<c:if test="${site.agent.currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="scurrency" value="USD"/>
</c:if>
<header>
    <div class="">
        <div class="border-bottom pt-6">
            <div class="row align-items-center">
                <div class="col-sm col-12">
                    <h1 class="h2 ls-tight">
                        <fmt:message key="label.customerorder"/>
                    </h1>
                </div>

                <div class="col-sm-auto col-12 mb-1">
                    <div class="hstack gap-2 justify-content-sm-end">
                        <security:authorize access="hasAnyAuthority('AGT_ADMIN','BILLING_W')">
                            <a href="/my/0/order-form.html" class="btn btn-sm  btn-primary px-3 mr-4"><i class="bi bi-plus"></i> Add</a>
                        </security:authorize>
                        <a href="#" class="btn btn-sm btn-success btn-export-booking px-3"><i class="bi bi-download"></i> Export to Exel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="mybooking">
    <div class="booking-container">
        <div class="my-3  vstack gap-4 ">
            <div class="d-flex flex-column flex-md-row gap-3 justify-content-between">

                <div class="d-flex gap-3">
                    <form:form id="myBookingForm" action="/my/booking.html" method="post" modelAttribute="items">
                        <div class="row">
                            <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
                                <c:if test="${not empty states}">
                                    <div class="form-group col-md-3 col-6">
                                        <form:select path="statecode" cssClass="form-select cus-state">
                                            <option value="">--<fmt:message key="label.state"/>--</option>
                                            <c:forEach items="${states}" var="state">
                                                <form:option value="${state.code}">${state.name}</form:option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </c:if>
                                <div class="form-group col-md-3 col-6">
                                    <form:select path="city" class="form-select cus-city">
                                        <option value="">--<fmt:message key="label.city"/>--</option>
                                        <c:forEach items="${cities}" var="ct">
                                            <form:option value="${ct.code}">${ct.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </div>
                                <div class="form-group col-md-3 col-6">
                                    <form:select path="zip" cssClass="form-select custom-select cus-zip">
                                        <option value=""><fmt:message key="label.ward"/></option>
                                        <c:forEach items="${wards}" var="w">
                                            <form:option value="${w.zip}">${w.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </div>
                            </security:authorize>
                            <div class="form-group col-md-3 col-6">
                                <form:select cssClass="form-control mr-2" path="status">
                                    <form:option value=""><fmt:message key="status.all"/> </form:option>
                                    <c:forEach var="st" items="${statuses}">
                                        <form:option value="${st}"><fmt:message key="${st}"/></form:option>
                                    </c:forEach>
                                </form:select>


                            </div>
                            <div class="form-group col-md-3 col-6">
                                <form:input cssClass="form-control datepicker bg-light" path="fromDate" placeholder="from date" autocomplete="off"/>
                            </div>
                            <div class="form-group col-md-3 col-6">
                                <form:input cssClass="form-control datepicker bg-light" path="toDate" placeholder="to date"/>

                            </div>
                            <div class="form-group col-md col-6">
                                <c:set var="mdc"><fmt:message key='label.search'/> <fmt:message key='booking.number'/></c:set>
                                <form:input  path="orderNumber" placeholder="${mdc}" maxlength="64" cssClass="form-control"/>
                            </div>
                            <div class="form-group col-md col-6">
                                <button type="submit" class="btn btn-secondary w-100"><i class="bi bi-search"></i></button>
                            </div>
                        </div>
                        <form:hidden path="customerId"/>
                        <form:hidden path="page" id="formPage"/>
                    </form:form>
                </div>

                <div class="btn-group">

                </div>
            </div>

            <div class="card">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto"><fmt:message key="label.customerorder"/></h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                        <tr>
                            <th><fmt:message key="booking.number"/> </th>
                            <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
                                <th class="text-right"><fmt:message key="booking.inputprice"/></th>
                            </security:authorize>
                            <th class="text-right"><fmt:message key="booking.amount"/></th>
                            <th class="text-right"><fmt:message key="booking.debtamount"/></th>
                            <th class="my-booking-customer-id"><fmt:message key="booking.customer.id"/></th>
                            <th><fmt:message key="booking.customer.full_name"/></th>
                            <th><fmt:message key="label.phone"/></th>
                            <th><fmt:message key="address"/></th>
                            <th><fmt:message key="label.city"/></th>
                            <th><fmt:message key="label.state"/></th>
                            <th><fmt:message key="booking.order-date"/></th>
                            <th><fmt:message key="booking.status"/></th>
                            <th><fmt:message key="shipping.date"/></th>
                            <th><fmt:message key="shipping.fee"/></th>
                            <th><fmt:message key="label.branch"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${items.listResult}" var="booking">
                            <c:if test="${not empty mapMCustomer[booking.customer.customerid]}">
                                <c:set var="mCustomer" value="${mapMCustomer[booking.customer.customerid]}"/>
                            </c:if>
                            <tr class="tr-booking-id-${booking.customerorderid}">
                                <td>
                                    <a href="/my/booking/${booking.customerorderid}.html">${booking.ordernumber}</a>
                                </td>
                                <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
                                    <td class="text-right"><span class="inputamount"><fmt:formatNumber value="${booking.inputprice}" maxFractionDigits="0"/></span></td>
                                </security:authorize>
                                <td class="text-right"><span class="finalamount"><fmt:formatNumber value="${booking.finalamount}" maxFractionDigits="0"/></span></td>
                                <td class="text-right"><span class="debtamount"><fmt:formatNumber value="${booking.debtamount}" maxFractionDigits="0"/></span></td>
                                <td class="my-booking-customer-id">${booking.customer.customerid}</td>
                                <td>${booking.customer.fullname}</td>
                                <td>${booking.customer.phone}</td>
                                <td>${booking.customer.address}</td>
                                <td>${not empty mCustomer ? mCustomer.cityName : booking.customer.city}</td>
                                <td>${not empty mCustomer ? mCustomer.stateName : ''}</td>
                                <td><fmt:formatDate type="both" value="${booking.orderdate}" /></td>
                                <td class="td-status"><div class="status ${booking.status} change-status" data-bookingid="${booking.customerorderid}"><span><fmt:message key="${booking.status}"/></span></div></td>
                                <td class="td-shipping-date"><c:if test="${booking.shippingdate != null}"><fmt:formatDate type="both" value="${booking.shippingdate}" /></c:if></td>
                                <td class="td-shipping-fee">
                                    <c:choose>
                                        <c:when test="${booking.status eq 'REQUEST'}">
                                            <div class="edit-shipping-fee-form-container id-${booking.customerorderid}">
                                                <div class="edit-shipping-fee-form"></div>
                                                <div class="edit-shipping-fee ${booking.status}" data-bookingid="${booking.customerorderid}">
                                                    <fmt:formatNumber value="${booking.servicescharge}" maxFractionDigits="0"/>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${booking.servicescharge}" maxFractionDigits="0"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${not empty mapBranch && not empty booking.branchid}">
                                        ${mapBranch[booking.branchid].name}
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="card-footer">
                    <div class="d-flex justify-content-between">
                        <ul class="nav">
                            <c:if test="${items.hasPrevious}">
                                <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-arrow-left"></i></a></li>
                            </c:if>
                            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                                <li class="nav-item"><a class="nav-link ${items.page eq loop.count?'current':''}" href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
                            </c:forEach>
                            <c:if test="${items.hasNext}">
                                <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-arrow-right"></i></a></li>
                            </c:if>
                        </ul>

                        <div class="total-amount pt-2">
                            <fmt:message key="booking.total_amount"/>: <fmt:formatNumber value="${items.totalAmount}" maxFractionDigits="${maxF}"/> ${scurrency}
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
    <div class="d-none access_token">${userInfo.access_token}</div>
    <div class="d-none" id="edit-shipping-fee-template">
        <div class="card">
            <div class="card-header">
                <fmt:message key="shipping.fee"/> {city} <a href="javascript:void(0)" onclick="cancelEditShippingfee(this)"><i class="fa fa-times"></i></a>
            </div>
            <div class="input-group p-3">
                <div class="input-group-prepend">
                    <input type="text" name="shippingdate" class="form-control shipping-datetime" placeholder="shipping datetime">
                </div>
                <input type="number" name="shippingfee" value="{shippingfee}" class="form-control">
                <div class="input-group-append">
                    <a href="javascript:void(0)" data-bookingid="{bookingid}" onclick="confirmShipping(this)" class="btn btn-outline-secondary"><fmt:message key="shipping"/></a>
                </div>
            </div>
            <ul class="list-group list-group-flush">
                {lis}
            </ul>
        </div>
    </div>
    <div class="d-none countryid">${country.countryid}</div>
    <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="statusModalLabel">
        <div class="modal-dialog" role="document" style="width: 98%;max-width: 500px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="statusModalLabel"><fmt:message key="status"/> <span class="current-status"></span></h4>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <form>
                        <input type="hidden" class="bookingid" name="bookingid" value="">
                        <ul class="list-group list-group-flush">

                        </ul>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-returned d-none" onclick="saveStatus('RETURNED');"><fmt:message key="return"/></button>
                    <button type="button" class="btn btn-secondary btn-cancelled d-none" onclick="saveStatus('CANCELLED');"><fmt:message key="cancel"/></button>
                    <button type="button" class="btn btn-primary btn-done d-none" onclick="saveStatus('DONE');"><fmt:message key="done"/></button>
                    <button type="button" class="btn btn-outline-info" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</security:authorize>
