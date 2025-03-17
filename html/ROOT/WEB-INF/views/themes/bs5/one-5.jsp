<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<link rel="stylesheet" type="text/css" media="all" href="/themes/grayscale/assets/flaticon/font/flaticon.css" />

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
<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
</c:if>
<c:set var="layoutitem" value="product-box"/>
<c:if test="${not empty siteStyle.layoutOneBox}">
    <c:set var="layoutitem" value="${siteStyle.layoutOneBox}"/>
</c:if>
<style type="text/css">
    .main-title-4 h1 {
        font-size: 20px;
        margin: 0 0 10px;
        font-weight: 600;
    }
    .main-title-4 h1 span {
        font-weight: 600;
    }
    ul {
        padding: 0;
        margin: 0;
        text-decoration: none;
        list-style: none;
    }
    .properties-condition ul, .properties-amenities ul {
        margin: 0;
        padding: 0;
    }
    .properties-condition li, .properties-amenities li {
        list-style: none;
    }
    .properties-condition ul li, .properties-amenities ul li {
        list-style: none;
        margin-bottom: 10px;
        color: #4a4747;
        font-size: 16px;
    }
    .properties-condition ul li i, .properties-amenities ul li i {
        margin-right: 5px;
        text-align: center;
        font-size: 15px;
        font-weight: 400;
    }
    .properties-condition ul li i, .properties-amenities ul li i {
        color: #95c41f;
    }
    .sidebar-widget {
        background: #fff;
        padding: 30px;
        margin-bottom: 25px;
    }
    .floor-plans table {
        width: 100%;
        margin-bottom: 40px;
        border: 1px solid rgba(0, 0, 0, 0.07);
    }
    .floor-plans table tr:first-child {
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    }
    .floor-plans table td, table th {
        padding: 10px 15px;
        border-right: 1px solid rgba(0, 0, 0, 0.07);
    }
    .floor-plans table td {
        font-size: 15px;
    }
    strong {
        font-weight: 600;
    }
    .map {
        -moz-transition: 0.4s;
        -webkit-transition: 0.4s;
        transition: 0.4s;
        height: 100%;
    }
    .contact-map {
        height: 300px !important;
    }
    .location .contact-map {
        height: 400px !important;
    }
    #map {
        width: 100%;
    }
    .btn-submit-sform{
        width: 100%;
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
<section class="enet-nest py-5 product-info one-4 bg-surface-secondary">
    <div class="container ">
        <div class="row d-flex justify-content-center">
            <div class="${pageRightSideBar.sitepageid gt 0 ? 'col-9' : 'col-12 col-md-10'}">
                <div class="row">
                    <div class="col-12">
                        <div class="sidebar-widget">
                            <div class="">
                                <h1 class="title secondary-font-family">${lang eq 'en' ? product.name : product.namevi}</h1>
                            </div>
                            <div class="mt-3">
                                ${productDescription}
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12 mb-2">
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
                </div>
                <c:if test="${not empty extras}">
                    <h3 class="pt-3 title-line-bottom"><fmt:message key="product.extras"/></h3>
                    <div class="row" id="extra-products-list">
                        <c:forEach var="product" items="${extras}" varStatus="theCount">
                            <div class="one-product-content mb-2 col-md-3 col-6">
                                <div class="card border-0 shadow hover-translate-y-n10 hover-shadow-lg h-full"><a
                                        href="/${product.code}"><img alt="${product.name}"
                                                                          class="card-img-top product-image"
                                                                          src="${product.image}"></a>
                                    <div class="card-body text-center py-3 px-1">
                                        <h5 class="product-name card-title mb-0"><a
                                                href="/${product.code}">${product.name}</a></h5>
                                        <c:set var="pprice" value="${product.productprices[0]}"/>
                                        <div class="product-price card-text text-danger mt-2"><fmt:formatNumber
                                                value="${pprice.price * currencyrate}" minFractionDigits="${maxF}"
                                                maxFractionDigits="${maxF}"/> ${scurrency}</div>
                                    </div>
                                    <div class="card-footer border-0 text-center px-0 py-2">
                                        <c:if test="${product.quantity gt 0}">
                                            <div class="product-cart py-2"><a
                                                    onclick="addQtyToCart('${pprice.productpriceid}','${product.productid}','1')"
                                                    class="btn btn-sm btn-primary btn-icon rounded-pill add-one-to-cart-btn"
                                                    href="javascript:void(0)"><span class="text-nowrap"><fmt:message
                                                    key="add-to-cart"/></span> <span class="d-none d-md-inline"><i
                                                    class="fas fa-shopping-cart"></i></span></a></div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${pageOneProduct.sitepageid gt 0}">
                    <div class="row">
                        <div class="col-12 pt-2">
                            <div class="sidebar-widget mb-0 py-2 pt-3">
                                <h3 class="mb-3"><fmt:message key="label.product.description"/> </h3>
                                    ${pageOneProduct.content}
                            </div>

                            <c:if test="${productDescriptionDTO.feature != null && productDescriptionDTO.feature.visible eq true}">
                                <div class="sidebar-widget mb-0 py-2">
                                    <h3 class="mb-3"> <fmt:message key="label.product.feature${labelProductFeature}"/></h3>
                                    <div class="feature-container">&nbsp;</div>
                                    <c:if test="${ not empty productDescriptionDTO.feature.content}">
                                        ${productDescriptionDTO.feature.content}
                                    </c:if>
                                </div>
                            </c:if>

                            <c:if test="${productDescriptionDTO.video != null && productDescriptionDTO.video.visible eq true && not empty productDescriptionDTO.video.content}">
                                <div class="sidebar-widget mb-0">
                                    <h3 class="mb-3">Video </h3>
                                        ${productDescriptionDTO.video.content}
                                </div>
                            </c:if>
                            <c:if test="${productDescriptionDTO.faq != null && productDescriptionDTO.faq.visible eq true && not empty productDescriptionDTO.faq.content}">
                                <div class="sidebar-widget mb-0">
                                    <h3 class="mb-3">FAQ </h3>
                                        ${productDescriptionDTO.faq.content}
                                </div>
                            </c:if>
                            <c:if test="${productDescriptionDTO.location != null && productDescriptionDTO.location.visible eq true && not empty productDescriptionDTO.location.content}">
                                <div class="sidebar-widget mb-0">
                                    <h3 class="mb-3"><fmt:message key="address"/> </h3>
                                        ${productDescriptionDTO.location.content}
                                </div>
                            </c:if>

                        </div>
                    </div>
                </c:if>
            </div>
            <c:if test="${pageRightSideBar.sitepageid gt 0}">
                <div class="col-3">
                        ${pageRightSideBar.content}
                </div>
            </c:if>
        </div>
    </div>
</section>
<section class="slice">
    <div class="container ">
        <h3 class="pt-3 title-line-bottom mb-3"><fmt:message key="product.others"/></h3>
        <div class="row row-cols-lg-4 row-cols-sm-2 row-cols-md-4 row-cols-1 local-product">
            <c:forEach items="${products}" var="product">
                <div class="col one-product-content mb-2">
                    <%@ include file="ajax/product-box.jsp" %>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="d-none" id="currencyrate">${currencyrate}</div>
    <div class="d-none" id="currency">${currency}</div>
    <div class="d-none" id="productCode">${product.code}</div>
</section>
