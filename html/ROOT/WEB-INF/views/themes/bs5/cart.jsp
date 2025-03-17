<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="currency" value="đ"/>
<c:set var="currencyrate" value="1"/>
<c:set var="maxF" value="0"/>
<c:if test="${site.agent.currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="currency" value="USD"/>
</c:if>

<div class="" data-offset-top="#header-main"></div>

<c:choose>
    <c:when test="${not empty shoppingcart}">

        <div class="booking-container container py-5">

            <div class="row">
                <div class="col-12 col-md-12 col-lg-12">
                    <h1 class="h2 mb-2"><fmt:message key="title.shopping-cart"/> </h1>
                    <div class="card mb-2 d-none d-md-block">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-1 font-bold">Hình ảnh</div>
                                <div class="col-md-4 font-bold">Tên</div>
                                <div class="col-md-2 font-bold">Đơn giá</div>
                                <div class="col-md-2 font-bold">Số lượng</div>
                                <div class="col-md-2 font-bold"><div class="w-100 text-end">Tổng tiền</div></div>
                                <div class="col-md-1 font-bold"></div>
                            </div>
                        </div>
                    </div>
                    <div class="card mb-2">
                        <div class="card-body">
                            <c:forEach var="item" items="${shoppingcart.products}">
                            <div class="row mb-3" id="item-${item.productcode}">
                                <input type="hidden" id="item-${item.productcode}-productid" value="${item.productid}">
                                <input type="hidden" id="item-${item.productcode}-price" value="${item.price * currencyrate}">
                                <input type="hidden" id="item-${item.productcode}-currency" value="${currency}">

                                <div class="col-4 col-md-1">
                                    <c:if test="${not empty item.image}">

                                                    <span class="pt-2"><img src="${item.image}" class="w-100"
                                                                            alt=""></span>

                                    </c:if>
                                </div>

                                <div class="col-8 col-md-4"><p class="font-size-1">${item.productname}</p></div>
                                <div class="col-4 d-block d-md-none"></div>
                                <div class="col-8 col-md-2">
                                    <span class="product-items-price">
                                                    <fmt:formatNumber value="${item.price * currencyrate}"
                                                                      minFractionDigits="${maxF}"
                                                                      maxFractionDigits="${maxF}"/>${currency}
                                                    </span>
                                </div>
                                <div class="col-4 d-block d-md-none"></div>
                                <div class="col-8 col-md-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <button class="btn btn-sm btn-secondary minus-btn" id="minus-btn_${item.productcode}" ><i class="bi bi-dash"></i></button>
                                        </div>
                                        <input name="quantity" class="form-control product-items-quantity quantity-${item.productcode}" value="${item.quantity}" min="0" max="${not empty mapProductprice[item.productcode] ? mapProductprice[item.productcode].numofavailable : 1}">
                                        <div class="input-group-append">
                                            <button class="btn btn-sm btn-primary plus-btn" id="plus-btn_${item.productcode}"><i class="bi bi-plus"></i></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-4 d-block d-md-none"></div>
                                <div class="col-8 col-md-2">
                                    <div class="w-100 text-start text-md-end">
                                    <span class="product-items-amount product-items-${item.productcode}-amount"><fmt:formatNumber value="${item.amount * currencyrate}"
                                                                                                                                  minFractionDigits="${maxF}"
                                                                                                                                  maxFractionDigits="${maxF}"/></span>&nbsp;${currency}
                                    </div>

                                </div>
                                <div class="col-12 col-md-1 text-end">
                                    <a href="javascript:void(0);" onclick="removePriceitem('${item.productcode}')"><i class="bi bi-trash"></i></a>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12 col-md-9 text-end">
                                    <span class="product-items-totalamount">
                                        <fmt:formatNumber value="${shoppingcart.amount * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>&nbsp;${currency}</span></div>
                                <div class="col-12 col-md-3">
                                    <a href="/booking.html" class="btn btn-primary w-100"><fmt:message key="book-now"/> </a>
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


