<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="px-4">
    <div class="customers-container">
        <form id="customerOrderForm" method="post" autocomplete="off">
            <input type="hidden" name="customerorderid" value="${booking.customerorderid}"/>
            <input type="hidden" name="customerid" value="0"/>
            <input type="hidden" name="maxN" value="${maxN}"/>
            <h4>Customer information</h4>
            <div class="row">
                <div class="form-group col">
                    <input id="cfullname" name="fullname" value="${customer.fullname}" placeholder="<fmt:message key='fullname'/>" class="form-control" maxlength="255"/>
                </div>
                <div class="form-group col">
                    <input name="phone" class="form-control" value="${customer.phone}" placeholder="Phone" maxlength="15" />
                </div>
                <div class="form-group col">
                    <input name="email" class="form-control" value="${customer.email}" placeholder="Email" maxlength="255" />
                </div>
            </div>
            <div class="row">
                <c:if test="${not empty states}">
                <div class="form-group col-md">
                    <select name="state" class="form-control cus-state">
                        <c:forEach items="${states}" var="state">
                            <option value="${state.code}">${state.name}</option>
                        </c:forEach>
                    </select>
                </div>
                </c:if>
                <div class="form-group col-md">
                    <select name="city" class="form-control cus-city">
                        <c:forEach items="${cities}" var="ct">
                            <option value="${ct.code}" ${ct.code eq customer.city ? 'selected' : ''}>${ct.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md">
                    <select name="zip" class="form-control custom-select cus-zip">
                        <option value=""><fmt:message key="label.ward"/></option>
                        <c:forEach items="${wards}" var="w">
                            <option value="${w.zip}" ${w.zip eq customer.zip ? 'selected' : ''}>${w.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-12">
                    <input name="address" class="form-control" value="${customer.address}" placeholder="<fmt:message key='address'/>" maxlength="255" />
                </div>
            </div>
            <div class="row">
                <div class="form-group col">
                    <input type="text" name="specialrequest" class="form-control" placeholder="<fmt:message key='booking.customer.special_request'/>" value="${booking.specialrequest}">
                </div>
            </div>
            <h4 class="product-label">Products</h4>
            <div id="item-list">
            <c:forEach begin="1" end="${maxN}" step="1" var="n">
                <div id="product${n}container" class="form-row mt-3 item-container">
                    <div class="col-1"><a href="#" onclick="removeItem('${n}')"><i class="fa fa-minus"></i></a> ${n}</div>
                    <div class="col-3">
                        <input name="productname" id="product${n}" type="text" class="form-control" value="${items[n-1].productname}" autocomplete="off">
                        <input name="productid" type="hidden" value="${items[n-1].productid}">
                    </div>
                    <div class="col-4">
                        <select name="productpriceid" class="form-control" onchange="updateProductprice('product${n}');">
                            <option value="${items[n-1].productpriceid}">${items[n-1].description}: ${items[n-1].price}</option>
                        </select>
                    </div>
                    <div class="col-1">
                        <input type="number" name="quantity" class="form-control" onchange="updateProductprice('product${n}');" value="${items[n-1].quantity}"/>
                    </div>
                    <div class="col-3">
                        <input type="text" name="amount" class="form-control" value="${items[n-1].amount}" readonly/>
                    </div>
                </div>
            </c:forEach>
            </div>
            <div class="form-row my-3">
                <div class="col-2">
                    <a href="#" class="btn btn-outline-secondary" onclick="addItem()"><i class="fa fa-plus"></i></a>
                </div>
                <div class="col-2 text-right">
                    <fmt:message key="shipping.date"/>
                </div>
                <div class="col-3">
                    <input type="text" name="shippingdate" class="form-control shipping-datetime" value="${shippingdate}" placeholder="<fmt:message key='shipping.date'/>">
                </div>
                <div class="col-2 text-right">
                    <fmt:message key="shipping.fee"/>
                </div>
                <div class="col-3 justify-content-end">
                    <input type="number" name="shippingfee" class="form-control" value="${booking.servicescharge}" onchange="updateTotalAmount();">
                </div>
            </div>
            <div class="form-row my-3">
                <div class="col-9 text-right">
                    <fmt:message key="label.discount"/>
                </div>
                <div class="col-3 justify-content-end">
                    <input type="number" name="discount" class="form-control" value="${booking.discount}" onchange="updateTotalAmount();">
                </div>
            </div>
            <div class="form-row">
                <div class="col-9 text-right">
                    <fmt:message key="booking.total_amount"/>
                </div>
                <div class="col-3 justify-content-end">
                    <input type="text" name="finalamount" class="form-control" readonly value="${booking.finalamount}">
                </div>
            </div>
        </form>
        <div class="mt-3 mb-2">
            <div class="text-center">
                <a href="javascript:void(0)" onclick="submitCustomerOrderForm('DRAFT')" class="btn btn-secondary w-25 mr-3">
                    <span class="text-white">
                    <i class="fa fa-floppy-o"></i> <fmt:message key="draft"/>
                    </span>
                </a>
                <a href="javascript:void(0)" onclick="submitCustomerOrderForm('CONFIRMED')" class="btn btn-primary  w-25 mr-3">
                    <span class="text-white">
                    <i class="fa fa-check"></i> <fmt:message key="confirm"/>
                    </span>
                </a>
                <a href="javascript:void(0)" onclick="submitCustomerOrderForm('SHIPPING')" class="btn btn-success w-25 mr-3">
                    <span class="text-white">
                    <i class="fa fa-money"></i> <fmt:message key="shipping"/>
                    </span>
                </a>
                <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                    <c:if test="${booking.customerorderid gt 0}">
                        <a href="javascript:void(0)" onclick="deleteBooking()" class="btn btn-link">
                            <i class="fa fa-trash"></i>
                        </a>
                    </c:if>
                </security:authorize>
            </div>
        </div>
    </div>
</div>
<div class="d-none" id="item-template">
    <div id="product{n}container" class="form-row mt-3 item-container">
        <div class="col-1"><a href="#" onclick="removeItem('{n}')"><i class="fa fa-minus"></i></a> {n}</div>
        <div class="col-3">
            <input name="productname" id="product{n}" type="text" class="form-control" autocomplete="off">
            <input name="productid" type="hidden" value="">
        </div>
        <div class="col-4">
            <select name="productpriceid" class="form-control" onchange="updateProductprice('product{n}');">
                <option value="0"></option>
            </select>
        </div>
        <div class="col-1">
            <input type="number" name="quantity" class="form-control" onchange="updateProductprice('product{n}');"/>
        </div>
        <div class="col-3">
            <input type="text" name="amount" class="form-control" value="" readonly/>
        </div>
    </div>
</div>
<div class="d-none" id="access_token">${userInfo.access_token}</div>
<div class="d-none" id="countryid">${country.countryid}</div>
