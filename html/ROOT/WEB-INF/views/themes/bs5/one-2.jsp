<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="url" value="https://${site.domain}${requestScope['javax.servlet.forward.request_uri']}"/>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="currency" value="${site.agent.currency}"/>
<c:set var="currencyrate" value="1"/>
<c:set var="scurrency" value="đ"/>
<c:set var="maxF" value="0"/>
<c:if test="${currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="scurrency" value="USD"/>
</c:if>

<style>
    .btn-productprice-option {
        border-color: #ccc !important;
    }
    .btn-productprice-option:disabled {
        border-color: #ccc !important;
        background-color: #ccc !important;
    }

    .btn-productprice-option.active {
        background-color: var(--primary-color);
        color: #fff;
    }
</style>
<div class="bg-gradient-primary delimiter-bottom" data-offset-top="#header-main">
</div>

<c:choose>
    <c:when test="${lang eq 'en'}">
        <c:set var="productDescription" value="${product.description}"/>
    </c:when>
    <c:otherwise>
        <c:set var="productDescription" value="${product.descriptionvi}"/>
    </c:otherwise>
</c:choose>
<section class="slice product-info one-2">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/"> <fmt:message key="title.home_page"/> </a></li>
                        <li class="breadcrumb-item"><a href="/products"> <fmt:message key="label.product"/> </a></li>
                        <c:if test="${not empty category}">
                            <li class="breadcrumb-item"><a href="/products/category/${category.nameurl}"> ${category.name} </a></li>
                        </c:if>
                        <li class="breadcrumb-item active" aria-current="page">${lang eq 'en' ? product.name : product.namevi} </li>
                    </ol>
                </nav>
            </div>
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
                <div>

                    <ul class="list-group">
                        <li class="">
                            <fmt:message key="label.product.quantity.status">
                                <fmt:param value="${product.quantity}"/>
                            </fmt:message>
                        </li>
                    </ul>
                </div>

                <div class="mt-3 product-short-description">
                    ${lang eq 'en' ? product.description : product.descriptionvi}
                </div>


                <div class="one-productprices ">
                    <c:forEach var="productprice" items="${productprices}" varStatus="pcount">
                        <div class="productprice-item"
                             data-productpriceid="${productprice.productpriceid}"
                             data-scurrency="${scurrency}"
                             data-numofavailable="${productprice.numofavailable}"
                             data-price="<fmt:formatNumber value="${productprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>"
                             data-pricestrike="<fmt:formatNumber value="${not empty productprice.strikeprice ?productprice.strikeprice * currencyrate : 0}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>"
                             data-color="${not empty productprice.color ? productprice.color.colorid : ''}"
                             data-size="${not empty productprice.size ? productprice.size.sizeid : ''}">
                        </div>
                    </c:forEach>

                    <c:if test="${not empty colorList}">
                        <div class=" mt-3 ">
                            <div><fmt:message key="label.color"/></div>
                            <div class="d-flex flex-row bd-highlight productprice-option-type" data-type="color">
                                <c:forEach var="color" items="${colorList}" varStatus="pcount">
                                    <button type="button"
                                            class="btn btn-sm btn-light me-1 btn-productprice-option color"
                                            data-type="color"
                                            data-color="${color.colorid}">
                                        <c:choose>
                                            <c:when test="${lang eq 'vi'}">
                                                ${color.namevi}
                                            </c:when>
                                            <c:otherwise>
                                                ${color.name}
                                            </c:otherwise>
                                        </c:choose>
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty sizeList}">
                        <div class=" mt-3 ">
                            <div class=""><fmt:message key="label.size"/></div>
                            <div class="d-flex flex-row bd-highlight productprice-option-type" data-type="size">
                                <c:forEach var="size" items="${sizeList}" varStatus="pcount">
                                    <button type="button"
                                            class="btn btn-sm btn-light me-1 btn-productprice-option size"
                                            data-type="size"
                                            data-size="${size.sizeid}">
                                            ${size.name}
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <c:forEach var="productprice" items="${productprices}" varStatus="pcount">
                        <c:set var="promo" value=""/>
                        <c:set var="priceLabel"><fmt:message key="product.original_price"/></c:set>
                        <c:if test="${not empty productprice.description}">
                            <c:set var="priceLabel" value="${lang eq 'en' ? productprice.description : productprice.descriptionvi}"/>
                            <c:set var="promo" value="promo"/>
                        </c:if>
                        <div class=" mt-3 ${not empty sizeList || not empty colorList ? 'd-none' : ''} productprice-box" id="productprice-${productprice.productpriceid}">
                            <div class="d-none">
                                <div class="color">${not empty productprice.color ? productprice.color.colorid : ''}</div>
                                <div class="size">${not empty productprice.size ? productprice.size.sizeid : ''}</div>
                            </div>
                            <div class="d-flex flex-row bd-highlight">
                                <div class="bd-highlight">
                                    <div class="price">
                                        <fmt:formatNumber value="${productprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}
                                    </div>
                                    <c:if test="${not empty productprice.strikeprice}">
                                        <div class="price-strike">
                                            <fmt:formatNumber value="${productprice.strikeprice * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            <div class="d-flex flex-row bd-highlight mb-3">
                                <c:if test="${productprice.numofavailable gt 0}">
                                    <div class="d-flex justify-content-between">
                                        <div class="input-group input-group-quantity mr-2">
                                            <div class="input-group-prepend">
                                                <button class="btn btn-sm btn-secondary minus-btn" id="minus-btn_${product.productid}X${productprice.productpriceid}"><i class="bi bi-dash"></i></button>
                                            </div>
                                            <input name="quantity" class="form-control quantity-${product.productid}X${productprice.productpriceid}" value="1" min="0" max="${productprice.numofavailable}">
                                            <div class="input-group-append">
                                                <button class="btn btn-sm btn-primary plus-btn" id="plus-btn_${product.productid}X${productprice.productpriceid}"><i class="bi bi-plus"></i></button>
                                            </div>
                                        </div>

                                    </div>
                                    <button class="btn btn-sm btn-primary btn-icon me-2" type="button" onclick="addToCart('${product.productid}X${productprice.productpriceid}','${product.productid}')"><fmt:message key="add-to-cart"/> <span class="d-none d-md-inline"><i class="bi bi-cart-plus" aria-hidden="true"></i></span></button>
                                    <button class="btn btn-sm btn-buy-now btn-icon font-bolder text-uppercase" type="button" onclick="bookingNow('${product.productid}X${productprice.productpriceid}','${product.productid}')"><fmt:message key="buy-now"/> <span class="d-none d-md-inline"><i class="bi bi-cart-plus" aria-hidden="true"></i></span></button>
                                </c:if>
                            </div>

                            <div class="d-flex flex-row bd-highlight mb-3">
                                <div class="fb-share-button"
                                     data-href="${url}"
                                     data-layout="button"
                                     data-size="large"></div>
                            </div>
                            <%--<div class="d-flex flex-row bd-highlight mb-3">
                                <div class="fb-share-button"
                                     data-href="${url}"
                                     data-layout="button_count">
                                </div>
                            </div>--%>
                        </div>
                    </c:forEach>
                </div>


            </div>
        </div>
        <c:if test="${not empty extras}">
            <h3 class="pt-3 title-line-bottom"><fmt:message key="product.extras"/></h3>
            <div class="row" id="extra-products-list">
                <c:forEach var="product" items="${extras}" varStatus="theCount">
                    <div class="one-product-content col-md-3 col-6 mb-2">
                        <div class="card border-0 shadow hover-translate-y-n10 hover-shadow-lg h-full"><a href="/${product.code}"><img alt="${product.name}" class="card-img-top product-image" src="${product.image}"></a>
                            <div class="card-body text-center py-3 px-1">
                                <h5 class="product-name card-title mb-0"><a href="/${product.code}">${product.name}</a></h5>
                                <c:set var="pprice" value="${product.productprices[0]}"/>
                                <div class="product-price card-text text-danger mt-2"><fmt:formatNumber value="${pprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}</div>
                            </div>
                            <div class="card-footer border-0 text-center px-0 py-2">
                                <c:if test="${product.quantity gt 0}">
                                    <div class="product-cart py-2"><a onclick="addQtyToCart('${pprice.productpriceid}','${product.productid}','1')" class="btn btn-sm btn-primary btn-icon rounded-pill add-one-to-cart-btn" href="javascript:void(0)"><span class="text-nowrap"><fmt:message key="add-to-cart"/></span> <span class="d-none d-md-inline"><i class="fas fa-shopping-cart"></i></span></a></div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <div class="mt-5">
            <%@ include file="one-description-1.jsp" %>
        </div>

    </div>
</section>
<section class="slice">
<div class="container">
    <h3 class="pt-3 title-line-bottom mb-3"><fmt:message key="product.others"/></h3>
    <div class="row row-cols-lg-4 row-cols-sm-2 row-cols-md-4 row-cols-1 local-product">
        <c:forEach items="${products}" var="oproduct">
            <div class="col one-product-content mb-2">
                <div class="card border-0 shadow hover-translate-y-n10 hover-shadow-lg card-product h-full">
                    <a href="/${oproduct.code}.html"><img alt="${oproduct.name}" class="card-img-top product-image" src="${oproduct.image}" loading="lazy"></a>
                    <div class="card-body text-center py-3 px-1">
                        <h5 class="product-name card-title mb-0">${oproduct.name}</h5>
                        <div class="product-price card-text text-danger mt-2"><fmt:formatNumber value="${oproduct.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}</div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<div class="d-none" id="currencyrate">${currencyrate}</div>
<div class="d-none" id="currency">${currency}</div>
</section>
