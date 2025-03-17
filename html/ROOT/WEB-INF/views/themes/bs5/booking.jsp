<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="currency" value="đ"/>
<c:set var="currencyrate" value="1"/>
<c:set var="maxF" value="0"/>
<c:if test="${site.agent.currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="currency" value="USD"/>
</c:if>

<%--<div class="slice " data-offset-top="#header-main"></div>--%>

<c:choose>
    <c:when test="${not empty shoppingcart}">

        <div class="booking-container py-5">

            <div class="row">
                <div class="col-12 col-md-12 col-lg-8">

                    <div class="card">
                        <div class="card-header border-bottom">
                            <h4><fmt:message key="booking.customer.info"/></h4>
                        </div>
                        <div class="card-body">
                            <form:form method="post" modelAttribute="shoppingcart" id="contact-form"
                                       action="/bookingSubmit.html">
                                <form:hidden path="customerorderid"/>

                                <div class="form-floating">
                                    <c:set var="pfullname"><fmt:message key="booking.customer.full_name"/>*</c:set>
                                    <form:input path="customer.fullname" placeholder='${pfullname}'
                                                class="form-control"/>
                                    <label>${pfullname}</label>
                                </div>

                                <div class="row">

                                    <div class="col-12 col-md-6">
                                        <div class="form-floating">
                                            <form:input path="customer.email" placeholder='Email*'
                                                        class="form-control"/>
                                            <label>Email</label>
                                        </div>
                                    </div>

                                    <div class="col-12 col-md-6">
                                        <div class="form-floating ">
                                            <form:input path="customer.phone" placeholder='Phone*'
                                                        class="form-control"/>
                                            <label><fmt:message key="label.phone"/></label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                        <%--<div class="form-group col-md col-12">
                                            <div class="d-none countryid">${country.countryid}</div>
                                            <label><fmt:message key="label.country"/></label>
                                            <form:select path="customer.country"
                                                         class="form-control custom-select cus-country">
                                                <c:forEach var="ct" items="${countries}">
                                                    <option value="${ct.code}" ${country.code eq ct.code ? 'selected' : ''}>${ct.name}</option>
                                                </c:forEach>
                                            </form:select>
                                        </div>--%>

                                    <div class="col-12 ${not empty states ? 'col-md-6' : 'col-md-12'}">
                                        <div class="form-floating">
                                            <div class="d-none countryid">${country.countryid}</div>
                                            <form:select id="selectCountry"
                                                         path="customer.country"
                                                         class="form-select custom-select cus-country">
                                                <c:forEach var="ct" items="${countries}">
                                                    <option value="${ct.code}" ${country.code eq ct.code ? 'selected' : ''}>${ct.name}</option>
                                                </c:forEach>
                                            </form:select>
                                            <label for="selectCountry"><fmt:message key="label.country"/></label>
                                        </div>
                                    </div>

                                    <c:if test="${not empty states}">
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating">
                                                <form:select
                                                        id="selectStateCode"
                                                        path="customer.statecode"
                                                        class="form-select custom-select cus-state">
                                                    <c:forEach items="${states}" var="state">
                                                        <form:option value="${state.code}">${state.name}</form:option>
                                                    </c:forEach>
                                                </form:select>
                                                <label for="selectStateCode"><fmt:message key="label.state"/></label>
                                            </div>
                                        </div>

                                    </c:if>
                                </div>
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <div class="form-floating ">
                                            <form:select path="customer.city"
                                                         class="form-select custom-select cus-city">
                                                <option value="0"><fmt:message key="label.city"/></option>
                                                <c:forEach items="${cities}" var="ct">
                                                    <form:option value="${ct.code}">${ct.name}</form:option>
                                                </c:forEach>
                                            </form:select>
                                            <label for="selectStateCode"><fmt:message key="label.city"/></label>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <div class="form-floating">
                                            <form:select id="selectZip" path="customer.zip"
                                                         class="form-select custom-select cus-zip">
                                                <option value="0"><fmt:message key="label.ward"/></option>
                                                <c:if test="${shoppingcart.customer.wardName != null}">
                                                    <form:option
                                                            value="${shoppingcart.customer.zip}">${shoppingcart.customer.wardName}</form:option>
                                                </c:if>
                                            </form:select>
                                            <label for="selectZip"><fmt:message key="label.ward"/></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <div class="form-floating">
                                            <c:set var="paddress"><fmt:message key="booking.customer.address"/>*</c:set>
                                            <form:input id="cusAddress" path="customer.address"
                                                        value="${customer.address}"
                                                        placeholder='${paddress}' class="form-control"/>
                                            <label for="cusAddress">${paddress}</label>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <div class="form-floating">
                                            <input id="specialrequest" name="specialrequest" class="form-control"
                                                   placeholder='<fmt:message key="booking.customer.special_request"/>'/>
                                            <label for="specialrequest"><fmt:message
                                                    key="booking.customer.special_request"/></label>
                                        </div>
                                    </div>
                                </div>


                                <div class="form-row mt-2">
                                    <div class="col-12">
                                        <label><span id="couponLabel"></span></label>
                                        <div class="input-group w-100">
                                            <input class="form-control input-coupon" id="couponCode" name="couponCode"
                                                   value="${shoppingcart.couponCode}" type="text"
                                                   placeholder='<fmt:message key="label.coupon_code" />'>
                                            <span class="input-group-btn">
                                <button class="btn-coupon h-100" type="button" onclick="applyCoupon();"><fmt:message
                                        key="label.apply_coupon"/></button>
                            </span>
                                        </div>
                                    </div>

                                </div>

                            </form:form>
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
                                <c:forEach var="item" items="${shoppingcart.products}">
                                    <div class="border-bottom pt-2 pb-2">
                                        <div class="row">
                                            <c:if test="${not empty item.image}">
                                                <div class="col-2">
                                                    <span class="pe-2 pt-2"><img src="${item.image}" class="w-100"
                                                                                 alt=""></span>
                                                </div>
                                            </c:if>
                                            <div class="col-10">
                                                <p class="font-size-1">${item.productname}</p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span class="product-items-price">
                                                    <fmt:formatNumber value="${item.price * currencyrate}"
                                                                      minFractionDigits="${maxF}"
                                                                      maxFractionDigits="${maxF}"/>${currency}
                                                    </span>
                                                    <span class="product-items-quantity">
                                                    x ${item.quantity}
                                                    </span>

                                                        <%--<span><fmt:formatNumber value="${item.amount * currencyrate}"
                                                                                                    minFractionDigits="${maxF}"
                                                                                                    maxFractionDigits="${maxF}"/>${currency}</span>--%>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </c:forEach>
                                <div class="pt-2">
                                    <span><strong><fmt:message key="label.discount"/>:</strong></span>
                                    <span class="d-none float-right" id="widget-coupon">
                                        <span class="d-none"
                                              id="totalproductprice">${shoppingcart.amount * currencyrate}</span>
                                        <span id="couponValue" class="label-info"></span>${currency}
                                    </span>
                                </div>

                                <hr>
                                <div class="d-flex justify-content-between align-items-center border-0">
                                    <strong><fmt:message key="booking.total_amount"/></strong>
                                    <span class="float-right">
                         <span class="price booking_total"><fmt:formatNumber
                                 value="${shoppingcart.amount * currencyrate}" minFractionDigits="${maxF}"
                                 maxFractionDigits="${maxF}"/>${currency}</span>
                        </span>
                                </div>
                            </div>


                            <div class="form-group mt-3">
                                <div class="text-right">
                                    <button class="btn btn-primary continue w-100" onclick="submitContactForm()">
                                        <fmt:message
                                                key="booking.continue"/> <i class="fa fa fa-chevron-right"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </c:when>
    <c:otherwise>
        <div class="w-100">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 mt-4 d-flex align-items-center justify-content-center">
                        <article class="mg-post">
                            <header>
                                <h1 class="mg-post-title"><fmt:message key="label.shoppingcart.empty"/></h1>
                            </header>
                            <div class="blog-content text-center">

                                <a href="/"><fmt:message key="label.back-to-home"/> </a>
                            </div>
                        </article>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<div class="d-none" id="currencyrate">${currencyrate}</div>
<div class="d-none" id="currency">${currency}</div>

