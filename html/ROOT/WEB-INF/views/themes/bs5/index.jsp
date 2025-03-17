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
    <c:if test="${currencyItem.code eq agent.currency and currencyItem.tocode eq currency}">
        <c:set var="currencyrate" value="${currencyItem.rate}"/>
    </c:if>
</c:forEach>
<c:set var="maxF" value="0"/>
<c:if test="${currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
</c:if>
<c:if test="${not empty banners}">
    <div id="mega-slider" class="carousel slide" data-bs-ride="carousel">
        <ol class="carousel-indicators d-none">
            <c:forEach items="${banners}" var="banner" varStatus="st">
                <li data-bs-target="#mega-slider" data-bs-slide-to="${st.index}" class="${st.index eq 0 ? 'active' : ''}"></li>
            </c:forEach>
        </ol>
        <div class="carousel-inner">
            <c:forEach items="${banners}" var="banner" varStatus="st">
                <div class="carousel-item ${st.index eq 0 ? 'active' : ''}">
                    <img src="${banner.image}" alt="${banner.name}" class="d-block w-100">
                    <c:if test="${not empty banner.content}">
                        <div class="carousel-caption">
                            <h2><a href="${banner.url}">${banner.name}</a></h2>
                            <p>${banner.content}</p>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#mega-slider" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#mega-slider" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</c:if>
<c:if test="${not empty sections}">
    <c:forEach var="section" items="${sections}" varStatus="theCount">
        <c:set var="oe" value="${theCount.count % 2 eq 0 ? 'even' : 'odd'}"/>
        <c:set var="pages" value="${sectionMap[section]}"/>
        <c:choose>
            <c:when test="${fn:contains(section, 'product')}">
                <div class="container">
                    <h2 class="mg-sec-title mt-5">${pages[0].name}</h2>
                    <div class="row row-cols-lg-6 row-cols-sm-2 row-cols-md-4 row-cols-1 local-product">
                        <c:forEach items="${products}" var="product">
                            <c:set var="desUrl" value="/${product.code}"/>
                            <div class="thumb col">
                                <div class="product-box">
                                    <div class="image-wrapper">
                                        <img class="product__image banner-link" src="${product.image}" alt="${product.name}" data-link="${desUrl}">
                                        <div class="price">
                                            <span class="right">${currency}  <fmt:formatNumber value="${product.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/></span>
                                        </div>
                                    </div>
                                    <div class="detail-wrapper">
                                        <div class="product-title"><a href="${desUrl}">${lang eq 'en' ? product.name : product.namevi}</a></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="text-end mb-4">
                        <a href="/products.html" class="btn btn-more"><fmt:message key="home.see-more"/> </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                ${pages[0].content}
            </c:otherwise>
        </c:choose>
    </c:forEach>
</c:if>
