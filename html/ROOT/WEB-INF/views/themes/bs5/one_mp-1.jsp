<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
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
<div class="bg-gradient-primary delimiter-bottom" data-offset-top="#header-main">

</div>
<%--<div class="one-product-title-container">
    <div class="one-product-title">
        <h1 class="rounded-pill bg-white py-2 px-3">${lang eq 'en' ? product.name : product.namevi}</h1>
    </div>
</div>--%>
<section class="slice product-info">
    <div class="container-fluid">
        <div class="row px-lg-4">
            <div class="col-md-5">
                <div data-toggle="sticky" data-sticky-offset="30" style="" class="">
                    <div class="mt-3">
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
                    <%--<div class="mt-3">
                        ${lang eq 'en' ? product.description : product.descriptionvi}
                    </div>
                    <div class="one-productprices pb-4">
                        <c:forEach var="productprice" items="${productprices}" varStatus="pcount">
                            <c:set var="promo" value=""/>
                            <c:set var="priceLabel"><fmt:message key="product.original_price"/></c:set>
                            <c:if test="${not empty productprice.description}">
                                <c:set var="priceLabel" value="${lang eq 'en' ? productprice.description : productprice.descriptionvi}"/>
                                <c:set var="promo" value="promo"/>
                            </c:if>
                            <div class=" mt-3">
                                <div class="row product-rate-box ${promo}">
                                    <div class="col-6 product-rate-name">${priceLabel}</div>
                                    <div class="col-6 price-rate price-wrapper">
                                        <c:if test="${not empty productprice.strikeprice}">
                                            <div class="price-strike">
                                                <fmt:formatNumber value="${productprice.strikeprice * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}
                                            </div>
                                        </c:if>
                                        <div class="price">
                                            <fmt:formatNumber value="${productprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}
                                        </div>
                                    </div>
                                    <div class="col-12 addToCart">
                                        <c:if test="${productprice.numofavailable gt 0}">
                                            <div class="d-flex justify-content-between">
                                                <div class="input-group w-50 mr-2">
                                                    <div class="input-group-prepend">
                                                        <button class="btn btn-sm btn-secondary minus-btn" id="minus-btn_${product.productid}X${productprice.productpriceid}"><i class="fas fa-minus"></i></button>
                                                    </div>
                                                    <input name="quantity" class="form-control quantity-${product.productid}X${productprice.productpriceid}" value="1" min="0" max="${productprice.numofavailable}">
                                                    <div class="input-group-append">
                                                        <button class="btn btn-sm btn-primary plus-btn" id="plus-btn_${product.productid}X${productprice.productpriceid}"><i class="fas fa-plus"></i></button>
                                                    </div>
                                                </div>
                                                <button class="btn btn-sm btn-primary btn-icon rounded-pill" type="button" onclick="addToCart('${product.productid}X${productprice.productpriceid}','${product.productid}')"><fmt:message key="add-to-cart"/> <span class="d-none d-md-inline"><i class="fa fa-cart-plus" aria-hidden="true"></i></span></button>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>--%>
                </div>
            </div>
            <div class="col-md-7">
                <div>
                    <h1 class="h1">${lang eq 'en' ? product.name : product.namevi}</h1>
                </div>
                <c:if test="${not empty apiproducts}">
                    <div class="py-4 my-4 border-top border-bottom">
                        <h6 class="text-sm font-italic mb-2"><fmt:message key="buy.this.item.at.provider"/> </h6>
                        <div class="list-group list-group-space">
                            <c:forEach var="apiproduct" items="${apiproducts}">
                                <div data-link="${apiproduct.remotelink}"  class="banner-link list-group-item list-group-item-action d-flex flex-column flex-md-row align-items-center px-sm text-center text-md-left shadow border-0 mb-4 hover-scale-110" data-toggle="tooltip" data-original-title="${apiproduct.remoteProduct.remote.name}">
                                    <div class="col-sm-2 mr-md-4 mb-4 mb-md-0">
                                        <img alt="Image" src="${apiproduct.remoteProduct.remote.image}" class="img-center" style="height: 80px; width: auto;">
                                    </div>
                                    <div class="list-group-content pl-4">
                                        <div class="h5">${apiproduct.apisite.domain}</div>
                                        <p class="mb-0">${apiproduct.apisite.fullname}</p>
                                        <div class="text-end"><fmt:formatNumber value="${apiproduct.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <div class="row">
                    <div class="col-md-12">
                        <div class="mt-3">
                            ${lang eq 'en' ? product.description : product.descriptionvi}
                        </div>
                        <div class="one-productprices pb-4">
                            <c:forEach var="productprice" items="${productprices}" varStatus="pcount">
                                <c:set var="promo" value=""/>
                                <c:set var="priceLabel"><fmt:message key="product.original_price"/></c:set>
                                <c:if test="${not empty productprice.description}">
                                    <c:set var="priceLabel" value="${lang eq 'en' ? productprice.description : productprice.descriptionvi}"/>
                                    <c:set var="promo" value="promo"/>
                                </c:if>
                                <div class=" mt-3">
                                    <div class="row product-rate-box ${promo}">
                                        <div class="col-6 product-rate-name">${priceLabel}</div>
                                        <div class="col-6 price-rate price-wrapper">
                                            <c:if test="${not empty productprice.strikeprice}">
                                                <div class="price-strike">
                                                    <fmt:formatNumber value="${productprice.strikeprice * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}
                                                </div>
                                            </c:if>
                                            <div class="price">
                                                <fmt:formatNumber value="${productprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}
                                            </div>
                                        </div>
                                        <div class="col-12 addToCart">
                                            <c:if test="${productprice.numofavailable gt 0}">
                                                <div class="d-flex justify-content-between">
                                                    <div class="input-group w-50 mr-2">
                                                        <div class="input-group-prepend">
                                                            <button class="btn btn-sm btn-secondary minus-btn" id="minus-btn_${product.productid}X${productprice.productpriceid}"><i class="bi bi-dash"></i></button>
                                                        </div>
                                                        <input name="quantity" class="form-control quantity-${product.productid}X${productprice.productpriceid}" value="1" min="0" max="${productprice.numofavailable}">
                                                        <div class="input-group-append">
                                                            <button class="btn btn-sm btn-primary plus-btn" id="plus-btn_${product.productid}X${productprice.productpriceid}"><i class="bi bi-plus"></i></button>
                                                        </div>
                                                    </div>
                                                    <button class="btn btn-sm btn-primary btn-icon rounded-pill" type="button" onclick="addToCart('${product.productid}X${productprice.productpriceid}','${product.productid}')"><fmt:message key="add-to-cart"/> <span class="d-none d-md-inline"><i class="fa fa-cart-plus" aria-hidden="true"></i></span></button>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${not empty extras}">
            <h3 class="pt-3 title-line-bottom"><fmt:message key="product.extras"/></h3>
            <div class="row" id="extra-products-list">
                <c:forEach var="product" items="${extras}" varStatus="theCount">
                    <div class="one-product-content col-md-3 col-6">
                        <div class="card border-0 shadow hover-translate-y-n10 hover-shadow-lg h-full"><a href="/${product.code}"><img alt="${product.name}" class="card-img-top product-image" src="${product.image}"></a>
                            <div class="card-body text-center py-3 px-1">
                                <h5 class="product-name card-title mb-0"><a href="/${product.code}">${product.name}</a></h5>
                                <c:set var="pprice" value="${product.productprices[0]}"/>
                                <div class="product-price card-text text-danger"><fmt:formatNumber value="${pprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}</div>
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
        <c:if test="${pageOneProduct.sitepageid gt 0}">
            <div class="row">
                <div class="col-12">
                        ${pageOneProduct.content}
                </div>
            </div>
        </c:if>
    </div>
</section>
<section class="slice">
    <div class="container-fluid">
        <h3 class="pt-3 px-lg-4 title-line-bottom"><fmt:message key="product.others"/></h3>
        <div class="row row-cols-lg-6 row-cols-sm-2 row-cols-md-4 row-cols-1 px-lg-4 local-product">
            <c:forEach items="${products}" var="oproduct">
                <c:set var="desUrl" value="/${oproduct.code}.html"/>
                <div class="thumb col">
                    <div class="card border-0 shadow hover-translate-y-n10 hover-shadow-lg card-product h-full mb-4">
                        <div class="p-0">
                            <a href="${desUrl}">
                                <img alt="${oproduct.name}" src="${oproduct.image}" class="img-center img-fluid">
                            </a>
                        </div>
                        <div class="card-body text-center pt-0">
                            <h6><a href="#">${lang eq 'en' ? oproduct.name : oproduct.namevi}</a></h6>
                            <span class="card-price">${currency}  <fmt:formatNumber value="${oproduct.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/></span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="d-none" id="currencyrate">${currencyrate}</div>
    <div class="d-none" id="currency">${currency}</div>
</section>
<script>
    $(document).ready(function() {
        $("#productSlider").lightSlider({
            gallery: true,
            item: 1,
            loop: true,
            slideMargin: 0,
            thumbItem: 6
        });
        $('.plus-btn').click(function(){
            var rateid = $(this).attr('id').split('_')[1];
            var max = parseInt($('.quantity-'+rateid).attr('max'));
            var qty = parseInt($('.quantity-'+rateid).val());
            if (qty < max) {
                qty++;
                $('.quantity-'+rateid).val(qty);
            }
        });
        $('.minus-btn').click(function(){
            var rateid = $(this).attr('id').split('_')[1];
            var min = parseInt($('.quantity-'+rateid).attr('min'));
            var qty = parseInt($('.quantity-'+rateid).val());
            if (qty > min) {
                qty--;
                $('.quantity-'+rateid).val(qty);
            }
        });
    });
</script>
