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
                <h1><fmt:message key="shipping"/></h1>
            </div>
            <div class="col-9">
                <div class="w-100">
                    <div class="text-right">
                        <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
                            <a href="#" class="btn btn-success btn-export-booking"><i class="fa fa-download"></i> Export to Exel</a>
                        </security:authorize>
                    </div>
                </div>
            </div>
        </div>
        <div class="mt-2">
            <form:form id="myBookingForm" action="/my/dashboard.html" method="post" modelAttribute="items">
                <div class="row">
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
                        <button type="submit" class="btn btn-info w-100"><i class="fa fa-search"></i></button>
                    </div>
                </div>
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
                    <th class="text-right"><fmt:message key="booking.amount"/></th>
                    <th><fmt:message key="booking.customer.full_name"/></th>
                    <th><fmt:message key="label.phone"/></th>
                    <th><fmt:message key="label.city"/></th>
                    <th><fmt:message key="address"/></th>
                    <th><fmt:message key="booking.status"/></th>
                    <th><fmt:message key="shipping.date"/></th>
                    <th><fmt:message key="shipping.fee"/></th>
                    <th><fmt:message key="priority"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${items.listResult}" var="booking">
                    <tr class="tr-booking-id-${booking.customerorderid} ${booking.rowid} tr-priority-${booking.priority}">
                        <td>
                            <a href="/my/booking/${booking.customerorderid}.html">${booking.ordernumber}</a>
                        </td>
                        <td class="text-right"><span class="finalamount"><fmt:formatNumber value="${booking.finalamount}" maxFractionDigits="0"/></span></td>
                        <td>${booking.customer.fullname}</td>
                        <td>${booking.customer.phone}</td>
                        <td>${booking.customer.city}</td>
                        <td>${booking.customer.address}</td>
                        <td class="td-status"><div class="status ${booking.status}"><span><fmt:message key="${booking.status}"/></span></div></td>
                        <td class="td-shipping-date"><c:if test="${booking.shippingdate != null}"><fmt:formatDate type="both" value="${booking.shippingdate}" /></c:if></td>
                        <td class="td-shipping-fee">
                            <div class="edit-shipping-fee-form-container id-${booking.customerorderid}">
                                <div class="edit-shipping-fee-form"></div>
                                <div class="edit-shipping-fee ${booking.status}" data-bookingid="${booking.customerorderid}">
                                    <fmt:formatNumber value="${booking.servicescharge}" maxFractionDigits="0"/>
                                </div>
                            </div>
                        </td>
                        <td>
                            <input data-bookingid="${booking.customerorderid}" class="checkbox-priority" type="checkbox" name="priority" value="${booking.priority}" ${booking.priority == 1 ? 'checked':''}/>
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
</security:authorize>
