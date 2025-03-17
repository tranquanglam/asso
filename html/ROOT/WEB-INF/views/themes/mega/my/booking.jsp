<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="scurrency" value="đ"/>
<c:set var="maxF" value="0"/>
<c:if test="${site.agent.currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="scurrency" value="USD"/>
</c:if>
<section class="mybooking">
    <div class="booking-container">
        <div class="row">
            <div class="col-3">
                <h1><fmt:message key="label.customerorder"/></h1>
            </div>
            <div class="col-9">
                <div class="w-100">
                <div class="text-right">
                <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
                    <a href="/my/0/order-form.html" class="btn btn-primary mr-4"><i class="fa fa-plus"></i> Add</a>
                    <a href="#" class="btn btn-success btn-export-booking"><i class="fa fa-download"></i> Export to Exel</a>
                </security:authorize>
                </div>
                </div>
            </div>
        </div>
        <div class="mt-2">
        <form:form id="myBookingForm" action="/my/booking.html" method="post" modelAttribute="items">
            <div class="row">
                <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
                <c:if test="${not empty states}">
                    <div class="form-group col-md col-6">
                        <form:select path="statecode" cssClass="form-control cus-state">
                            <option value="">--<fmt:message key="label.state"/>--</option>
                            <c:forEach items="${states}" var="state">
                                <form:option value="${state.code}">${state.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                </c:if>
                <div class="form-group col-md col-6">
                    <form:select path="city" class="form-control cus-city">
                        <option value="">--<fmt:message key="label.city"/>--</option>
                        <c:forEach items="${cities}" var="ct">
                            <form:option value="${ct.code}">${ct.name}</form:option>
                        </c:forEach>
                    </form:select>
                </div>
                    <div class="form-group col-md col-6">
                        <form:select path="zip" cssClass="form-control custom-select cus-zip">
                            <option value=""><fmt:message key="label.ward"/></option>
                            <c:forEach items="${wards}" var="w">
                                <form:option value="${w.zip}">${w.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                </security:authorize>
                <div class="form-group col-md col-6">
                    <form:input cssClass="form-control datepicker mr-2" path="fromDate" placeholder="from date"/>
                </div>
                <div class="form-group col-md col-6">
                    <form:input cssClass="form-control datepicker mr-2" path="toDate" placeholder="to date"/>
                </div>
                <div class="form-group col-md col-6">
                    <form:select cssClass="form-control mr-2" path="status">
                        <form:option value=""><fmt:message key="status.all"/> </form:option>
                        <c:forEach var="st" items="${statuses}">
                            <form:option value="${st}"><fmt:message key="${st}"/></form:option>
                        </c:forEach>
                    </form:select>
                </div>
                <div class="form-group col-md col-6">
                    <form:input  path="orderNumber" placeholder="number" maxlength="64" cssClass="form-control"/>
                </div>
                <div class="form-group col-md col-6">
                    <button type="submit" class="btn btn-info w-100"><i class="fa fa-search"></i></button>
                </div>
            </div>
            <form:hidden path="customerId"/>
            <form:hidden path="page" id="formPage"/>
        </form:form>
        </div>
        <div class="total-amount pt-2">
            <fmt:message key="booking.total_amount"/>: <fmt:formatNumber value="${items.totalAmount}" maxFractionDigits="${maxF}"/> ${scurrency}
        </div>
        <div class="box-table pt-4">
            <table class="table table-striped">
                <thead class="blue">
                <tr>
                    <th><fmt:message key="booking.number"/> </th>
                    <th class="text-right"><fmt:message key="booking.inputprice"/></th>
                    <th class="text-right"><fmt:message key="booking.amount"/></th>
                    <th class="text-right"><fmt:message key="booking.debtamount"/></th>
                    <th class="my-booking-customer-id"><fmt:message key="booking.customer.id"/></th>
                    <th><fmt:message key="booking.customer.full_name"/></th>
                    <th><fmt:message key="label.phone"/></th>
                    <th><fmt:message key="label.city"/></th>
                    <th><fmt:message key="address"/></th>
                    <th><fmt:message key="booking.order-date"/></th>
                    <th><fmt:message key="booking.status"/></th>
                    <th><fmt:message key="shipping.date"/></th>
                    <th><fmt:message key="shipping.fee"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${items.listResult}" var="booking">
                <tr class="tr-booking-id-${booking.customerorderid}">
                    <td>
                        <a href="/my/booking/${booking.customerorderid}.html">${booking.ordernumber}</a>
                    </td>
                    <td class="text-right"><span class="inputamount"><fmt:formatNumber value="${booking.inputprice}" maxFractionDigits="0"/></span></td>
                    <td class="text-right"><span class="finalamount"><fmt:formatNumber value="${booking.finalamount}" maxFractionDigits="0"/></span></td>
                    <td class="text-right"><span class="debtamount"><fmt:formatNumber value="${booking.debtamount}" maxFractionDigits="0"/></span></td>
                    <td class="my-booking-customer-id">${booking.customer.customerid}</td>
                    <td>${booking.customer.fullname}</td>
                    <td>${booking.customer.phone}</td>
                    <td>${booking.customer.city}</td>
                    <td>${booking.customer.address}</td>
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
                </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <ul class="pagination">
            <c:if test="${items.hasPrevious}">
                <li><a href="#"><i class="fa fa-play arrow-left"></i></a></li>
            </c:if>
            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                <li><a ${items.page eq loop.count?'class="current"':''} href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
            </c:forEach>
            <c:if test="${items.hasNext}">
                <li><a href="#"><i class="fa fa-play arrow-right"></i></a></li>
            </c:if>
        </ul>
    </div>
</section>
<div class="total-amount py-3">
    <fmt:message key="booking.total_amount"/>: <fmt:formatNumber value="${items.totalAmount}" maxFractionDigits="${maxF}"/> ${scurrency}
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
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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
                    <button type="button" class="btn btn-outline-info" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</security:authorize>
