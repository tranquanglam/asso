<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="currency" value="${sessionScope.SESSION_CURRENCY.tocode}"/>
<c:set var="currencyrate" value="1"/>
<c:forEach var="currencyItem" items="${sessionScope.SESSION_CURRENCY_LIST}">
    <c:if test="${currencyItem.code eq site.agent.currency and currencyItem.tocode eq currency}">
        <c:set var="currencyrate" value="${currencyItem.rate}"/>
    </c:if>
</c:forEach>
<c:set var="maxF" value="0"/>
<c:if test="${currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
</c:if>
<header class="phead"></header>
<div class="product-info mt-4">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mb-2">
                <c:choose>
                    <c:when test="${empty banners}">
                        <img src="${product.image}" alt="${product.name}" class="w-100">
                    </c:when>
                    <c:when test="${fn:length(banners) eq 1}">
                        <img src="${product.image}" alt="${product.name}" class="w-100">
                    </c:when>
                    <c:otherwise>
                        <ul id="productSlider">
                            <c:forEach items="${banners}" var="banner" varStatus="st">
                                <li data-thumb="${banner.image}">
                                    <img src="${banner.image}" alt="${banner.name}" width="100%">
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-md-6">
                <div>
                    <h1 class="title">${lang eq 'en' ? product.name : product.namevi}</h1>
                </div>
                <div class="mt-3">
                    ${lang eq 'en' ? product.description : product.descriptionvi}
                </div>
                <div class="one-productprices">
                    <c:forEach var="productprice" items="${productprices}" varStatus="pcount">
                        <c:set var="promo" value=""/>
                        <c:set var="priceLabel"><fmt:message key="product.original_price"/></c:set>
                        <c:if test="${not empty productprice.description}">
                            <c:set var="priceLabel" value="${lang eq 'en' ? productprice.description : productprice.descriptionvi}"/>
                            <c:set var="promo" value="promo"/>
                        </c:if>
                        <div class=" mt-3">
                            <div class="row product-rate-box ${promo}">
                                <div class="col-12 product-rate-name">${priceLabel}</div>
                                <div class="col-12 price-rate price-wrapper">
                                    <c:if test="${not empty productprice.strikeprice}">
                                        <div class="price-strike">
                                                ${currency} <fmt:formatNumber value="${productprice.strikeprice * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>
                                        </div>
                                    </c:if>
                                    <div class="price">
                                            ${currency} <fmt:formatNumber value="${productprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>
                                    </div>
                                </div>
                                <div class="col-12 addToCart">
                                    <div class="input-group">
                                        <input name="quantity" type="number" class="form-control quantity-${product.productid}X${productprice.productpriceid}" value="0" min="0" max="${productprice.numofavailable}">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button" onclick="addToCart('${product.productid}X${productprice.productpriceid}','${product.productid}')"><fmt:message key="add-to-cart"/> &nbsp;<i class="fa fa-cart-plus" aria-hidden="true"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <c:if test="${pageOneProduct.sitepageid gt 0}">
            <div class="row">
                <div class="col-12">
                        ${pageOneProduct.content}
                </div>
            </div>
        </c:if>
    </div>
</div>

<div class="container">
    <h3 class="pt-3 title-line-bottom"><fmt:message key="product.others"/></h3>
    <div class="row local-product">
        <c:forEach items="${products}" var="oproduct">
            <c:set var="desUrl" value="/${oproduct.code}.html"/>
            <div class="thumb col-md-2 col-6">
                <div class="product-box">
                    <div class="image-wrapper">
                        <img class="product__image banner-link" src="${oproduct.image}" alt="${oproduct.name}" data-link="${desUrl}">
                        <div class="price">
                            <span class="right">${currency}  <fmt:formatNumber value="${oproduct.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/></span>
                        </div>
                    </div>
                    <div class="detail-wrapper">
                        <div class="product-title"><a href="${desUrl}">${lang eq 'en' ? oproduct.name : oproduct.namevi}</a></div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<div class="d-none" id="currencyrate">${currencyrate}</div>
<div class="d-none" id="currency">${currency}</div>

<script>
    $(document).ready(function() {
        $("#productSlider").lightSlider({
            gallery: true,
            item: 1,
            loop: true,
            slideMargin: 0,
            thumbItem: 9
        });
    });
</script>
