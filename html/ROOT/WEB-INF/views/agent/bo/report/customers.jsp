<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-2 mb-5">
    <div class="customers-container">
        <div class="row mt-4">
            <div class="col-md-3">
                <h1><fmt:message key="label.my-customers"/> </h1>
            </div>
            <div class="col-md-9">
                <form:form id="myForm" cssClass="form-inline pull-right" action="/my/customers.html" method="post" modelAttribute="items">
                    <div class="d-flex justify-content-end">
                    <c:if test="${not empty states}">
                        <div class="form-group me-3">
                            <form:select path="statecode" cssClass="form-control cus-state">
                                <option value="">--<fmt:message key="label.state"/>--</option>
                                <c:forEach items="${states}" var="state">
                                    <form:option value="${state.code}">${state.name}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </c:if>
                    <div class="form-group me-3">
                        <form:select path="city" class="form-control cus-city">
                            <option value="">--<fmt:message key="label.city"/>--</option>
                            <c:forEach items="${cities}" var="ct">
                                <form:option value="${ct.code}">${ct.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="form-group me-3">
                        <form:input  path="searchTerm" placeholder="search..." maxlength="64" cssClass="form-control"/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-secondary pl-4 pr-4"><span><i class="bi bi-search"></i></span></button>
                    </div>
                    </div>
                    <form:hidden path="page" id="formPage"/>
                    <input type="hidden" name="customerId" id="customerId">
                </form:form>
            </div>
        </div>
        <div class="box-table">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped" id="customer_table">
                    <thead class="blue">
                    <tr>
                        <th><fmt:message key="booking.customer.id"/> </th>
                        <th><fmt:message key="booking.customer.full_name"/> </th>
                        <th><fmt:message key="label.city"/></th>
                        <th><fmt:message key="address"/></th>
                        <th><fmt:message key="relativename"/></th>
                        <th><fmt:message key="booking.customer.phone"/></th>
                        <th><fmt:message key="booking.customer.email"/></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${items.listResult}" var="cus">
                        <tr id="customer_${cus.customerid}">
                            <td>${cus.customerid}</td>
                            <td>
                                <a href="#" class="fullname btn-link-customer" data-customerid="${cus.customerid}">${cus.fullname}</a>
                            </td>
                            <td class="city">${cus.city}</td>
                            <td class="address">${cus.address}</td>
                            <td class="relativename">${cus.relativename}</td>
                            <td class="phone">${cus.phone}</td>
                            <td class="email">${cus.email}</td>
                            <td><a href="#" class="btn-booking-history" data-customerid="${cus.customerid}"><fmt:message key="booking.history"/></a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!--  -->
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
    </div>
</div>
<div class="modal fade" id="customerContentModal" tabindex="-1" role="dialog"
     aria-labelledby="customerContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 100%;max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="customerContentModalLabel"><fmt:message key="label.customer"/> </h4>
                <a type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></a>
            </div>
            <div class="modal-body">
                <form id="customerForm" action="/bo/data/customer.html" method="post" autocomplete="off">
                    <input type="hidden" name="customerid" value="0"/>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key='fullname'/></label>
                            <input id="cfullname" name="fullname" class="form-control"/>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key='dateofbirth'/></label>
                            <input name="cdateofbirth" class="form-control dateofbirth" />
                            <input type="hidden" name="dateofbirth" value="">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-12">
                            <label><fmt:message key='note'/></label>
                            <input type="text" name="cusNote.note" class="form-control" value="">
                        </div>
                    </div>
                    <div class="row">
                        <c:if test="${not empty states}">
                            <div class="form-group col-md">
                                <select name="statecode" class="form-control cus-state-one">
                                    <option value="">--<fmt:message key="label.state"/>--</option>
                                    <c:forEach items="${states}" var="state">
                                        <option value="${state.code}">${state.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:if>
                        <div class="form-group col-md">
                            <select name="city" class="form-control cus-city-one">
                                <option value="">--<fmt:message key="label.city"/>--</option>
                                <c:forEach items="${cities}" var="ct">
                                    <option value="${ct.code}">${ct.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col-md">
                            <select name="zip" class="form-control custom-select cus-zip-one">
                                <option value=""><fmt:message key="label.ward"/></option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-12">
                            <label><fmt:message key='address'/></label>
                            <input name="address" class="form-control" maxlength="255" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label class="font-weight-bold"><fmt:message key='relativename'/></label>
                            <input name="relativename" class="form-control" value="" maxlength="255" />
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key='relative-email'/></label>
                            <input name="email" class="form-control" maxlength="255" />
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key='booking.customer.phone'/></label>
                            <input name="phone" class="form-control" value="" maxlength="255" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-update"><fmt:message key='label.save'/></button>
                <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="d-none countryid">${country.countryid}</div>