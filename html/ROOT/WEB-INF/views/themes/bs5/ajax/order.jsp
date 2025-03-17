<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="currency" value="${site.agent.currency}"/>
<c:set var="currencyrate" value="1"/>
<c:set var="scurrency" value="đ"/>
<c:set var="maxF" value="0"/>
<c:if test="${currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="scurrency" value="USD"/>
</c:if>
<c:set var="initqty" value="1"/>
<c:if test="${param.initqty != null}">
    <c:set var="initqty" value="${param.initqty}"/>
</c:if>
<form id="customerOrderForm" method="post" autocomplete="off">
    <input type="hidden" name="customerorderid" value="0"/>
    <input type="hidden" name="customerid" value="0"/>
    <input type="hidden" name="maxN" value="${maxN}"/>
    <div class="container text-left">
        <div class="row">
            <div class="col-lg-8 px-0 px-md-1">
                <h4 class="product-label"><fmt:message key="title.shopping-cart"/></h4>
                <div id="item-list">
                    <c:forEach var="product" items="${products}" varStatus="theCount">
                        <c:set var="numavailable" value="${product.quantity}"/>
                        <c:set var="n" value="${theCount.count}"/>
                        <input name="productid" type="hidden" value="${product.productid}">
                        <div id="product${n}container" class="form-row mt-3 item-container active">
                            <div class="col-2"><img class="img-fluid" src="${product.image}" alt="${product.name}" /></div>
                            <div class="col-10">
                                <div class="row">
                                    <div class="col-10">
                                    <h3>${product.name}</h3>
                                    <div>${product.description}</div>
                                    </div>
                                    <div class="col-2">
                                        <a href="javascript:void(0)" data-n="${n}" class="remove-order-item-btn"><i class="bi bi-trash"></i></a>
                                        <a href="javascript:void(0)" data-n="${n}" class="readd-order-item-btn text-white"><i class="bi bi-plus"></i></a>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-5 col-12 pb-sm-0 pb-3">
                                        <select name="productpriceid" data-n="${n}" class="form-select change-update-product-price money">
                                            <c:forEach var="pprice" items="${product.productprices}">
                                                <option value="${pprice.productpriceid}">${pprice.description} <fmt:formatNumber value="${pprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}</option>
                                            </c:forEach>
                                        </select>
                                        <div class="d-none">
                                        <c:forEach var="pprice" items="${product.productprices}">
                                            <c:if test="${pprice.numofavailable lt numavailable}">
                                                <c:set var="numavailable" value="${pprice.numofavailable}"/>
                                            </c:if>
                                            <span class="productpriceid_${pprice.productpriceid}" data-weight="${pprice.weight}" data-numofavailable="${pprice.numofavailable}">${pprice.price * currencyrate}</span>
                                        </c:forEach>
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-6">
                                        <c:choose>
                                            <c:when test="${numavailable gt 0}">

                                                <div class="d-flex justify-content-between">
                                                    <div class="input-group mr-2">
                                                        <div class="input-group-prepend">
                                                            <button class="btn btn-sm btn-secondary order-minus-btn"  data-n="${n}"><i class="bi bi-dash"></i></button>
                                                        </div>
                                                        <input name="quantity" data-n="${n}"  class="form-control quantity-${product.productid}X${productprice.productpriceid}" value="${initqty}" min="0" max="${numavailable}">
                                                        <div class="input-group-append">
                                                            <button class="btn btn-sm btn-primary order-plus-btn" data-n="${n}"><i class="bi bi-plus"></i></button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <input name="quantity" data-n="${n}" type="hidden" value="0">
                                                <span class="sold-out text-warning"><fmt:message key="detail.sold-out"/> </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-3 col-6">
                                        <input type="text" name="amount" class="form-control money" value="" readonly/>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <hr>
                    </c:forEach>
                </div>
                <c:set var="showdiscount" value="d-none"/>
                <security:authorize access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
                    <c:set var="showdiscount" value="show"/>
                </security:authorize>
                <div class="form-row my-3">
                    <div class="col-9 text-end">
                        <fmt:message key="shipping.fee.temp"/>
                    </div>
                    <div class="col-3 justify-content-end">
                        <input type="text" name="shippingfee" class="form-control change-update-total-amount money" readonly value="0">
                    </div>
                </div>
                <div class="form-row my-3 ${showdiscount}">
                    <div class="col-9 text-end">
                        <fmt:message key="label.discount"/>
                    </div>
                    <div class="col-3 justify-content-end">
                        <input type="number" name="discount" class="form-control change-update-total-amount money" value="">
                    </div>
                </div>
                <div class="form-row mt-4 pb-4">
                    <div class="col-md-9 col-6 text-end">
                        <fmt:message key="booking.total_amount"/>
                    </div>
                    <div class="col-md-3 col-6 justify-content-end">
                        <input type="text" name="finalamount" class="form-control money" readonly value="">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div id="customerInfoSticky" data-toggle="sticky" data-sticky-offset="30">
                    <div class="card">
                        <div class="card-body">
                            <h4><fmt:message key="booking.customer.info"/> </h4>
                            <div class="row ">
                                <div class="form-group col-12">
                                    <input id="cfullname" name="fullname" value="${customer.fullname}" placeholder="<fmt:message key='fullname'/>" class="form-control" maxlength="255"/>
                                </div>
                                <div class="form-group col-12">
                                    <input name="phone" class="form-control" value="${customer.phone}" placeholder="Phone" maxlength="15" />
                                </div>
                                <div class="form-group col-12">
                                    <input name="email" class="form-control" value="${customer.email}" placeholder="Email" maxlength="255" />
                                </div>
                            </div>
                            <div class="row">
                                <c:if test="${not empty states}">
                                    <div class="form-group form-group-state col-6">
                                        <select name="state" class="form-select  custom-select cus-state">
                                            <c:forEach items="${states}" var="state">
                                                <option value="${state.code}">${state.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </c:if>
                                <div class="form-group form-group-city col-6">
                                    <select name="city" class="form-select  custom-select cus-city">
                                        <c:forEach items="${cities}" var="ct">
                                            <option value="${ct.code}">${ct.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <c:if test="${isgroup}">
                                    <div class="form-group form-group-destination col-12">
                                        <select name="destinationid" class="form-select  custom-select cus-destination">
                                            <option value="0"><fmt:message key="pickup.destination"/></option>
                                            <c:forEach items="${destinations}" var="des">
                                                <option value="${des.destinationID}">${des.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </c:if>
                                <c:if test="${!isgroup}">
                                    <div class="form-group form-group-ward col-12">
                                        <select name="zip" class="form-select  custom-select cus-zip">
                                            <option value="0"><fmt:message key="label.ward"/></option>
                                        </select>
                                    </div>
                                </c:if>
                                <div class="form-group col-md-12">
                                    <input name="address" class="form-control" value="${customer.address}" placeholder="<fmt:message key='address'/>" maxlength="255" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col">
                                    <input type="text" name="specialrequest" class="form-control" placeholder="<fmt:message key='booking.customer.special_request'/>" value="">
                                </div>
                            </div>
                            <div class="mt-3 mb-2">
                                <div class="text-end action-submit-btn">
                                    <a href="javascript:void(0)" class="btn btn-primary submit-order-form-btn w-50">
                            <span class="text-white">
                            <i class="fa fa-floppy-o"></i> <fmt:message key="book-now"/>
                            </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
    <div class="d-none access_token">${access_token}</div>
    <div class="d-none countryid">${country.countryid}</div>
    <div class="d-none message-successful">${page_success.content}</div>
    <div class="d-none scurrency">${scurrency}</div>
</form>

