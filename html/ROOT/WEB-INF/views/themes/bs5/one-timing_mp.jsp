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
<div class="bg-gradient-primary delimiter-bottom" data-offset-top="#header-main">

</div>
<section class="slice product-info">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mb-2">
                <div class="d-block d-md-none">
                    <h2 class="title">${lang eq 'en' ? product.name : product.namevi}</h2>
                    <div class="mt-3">
                        ${lang eq 'en' ? product.description : product.descriptionvi}
                    </div>
                </div>
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
                <div class="mt-4">
                    <div id='calendar'></div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="d-none d-md-block">
                    <div>
                        <h1 class="title">${lang eq 'en' ? product.name : product.namevi}</h1>
                    </div>
                    <div class="mt-3">
                        ${lang eq 'en' ? product.description : product.descriptionvi}
                    </div>
                </div>
                <section class="slice ">
                    <span class="tongue tongue-top"><i class="fas fa-angle-up"></i></span>
                    <div class="container">
                        <div class="mb-5 text-center">
                            <h3><fmt:formatDate value="${fromDate}" pattern="dd MMM yyyy"/></h3>
                            <h4 class=" mt-4"><fmt:message key="time.slots"/></h4>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <!-- Swiper -->
                                <c:set var="swiperItems" value="6"/>
                                <c:set var="swiperRowItems" value="3"/>

                                <c:choose>
                                    <c:when test="${productcalendars.size() < 10}">
                                        <c:set var="swiperItems" value="3"/>
                                        <c:set var="swiperRowItems" value="2"/>
                                    </c:when>
                                    <c:when test="${productcalendars.size() < 20}">
                                        <c:set var="swiperItems" value="5"/>
                                        <c:set var="swiperRowItems" value="3"/>
                                    </c:when>
                                    <c:otherwise></c:otherwise>
                                </c:choose>

                                <div class="swiper-js-container">
                                    <div class="swiper-container" data-swiper-items="${swiperItems}" data-swiper-row-items="${swiperRowItems}" data-swiper-space-between="10">
                                        <div class="swiper-wrapper" >
                                            <c:forEach items="${productcalendars}" var="apt" varStatus="theCount">
                                                <div class="swiper-slide ">
                                                    <c:set var="maxQty" value="${apt.maxpax - apt.bookedcount}"/>
                                                    <button class="js-choose-appointment btn btn-outline-default ${maxQty eq 0 ? 'bg-secondary' : ''} border-black w-100" ${maxQty eq 0 ? 'disabled' : ''} type="button" onclick="chooseAppointment(this)" data-appointmentid="${apt.productcalendarid}">
                                                        <fmt:formatDate value="${apt.starttime}" pattern="HH:mm"/>
                                                    </button>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <%--<div class="swiper-button-next"></div>
                                        <div class="swiper-button-prev"></div>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 mt-4 ">
                                <button id="btnBookNow" class="btn btn-primary w-100" onclick="bookAppointment(this)"><fmt:message key="book-now"/></button>
                            </div>
                        </div>
                    </div>
                </section>
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
</section>
<section class="slice">
    <div class="container">
        <h3 class="pt-3 title-line-bottom mb-3"><fmt:message key="product.others"/></h3>
        <div class="row row-cols-lg-4 row-cols-sm-2 row-cols-md-4 row-cols-1 local-product">
            <c:forEach items="${products}" var="oproduct">
                <div class="col one-product-content">
                    <div class="card border-0 shadow hover-translate-y-n10 hover-shadow-lg card-product h-full">
                        <a href="/${oproduct.code}.html"><img alt="${oproduct.name}" class="card-img-top product-image" src="${oproduct.image}" loading="lazy"></a>
                        <div class="card-body text-center py-3 px-1">
                            <h5 class="product-name card-title mb-0">${oproduct.name}</h5>
                            <div class="product-price card-text text-danger"><fmt:formatNumber value="${oproduct.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}</div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="d-none" id="currencyrate">${currencyrate}</div>
    <div class="d-none" id="currency">${currency}</div>
</section>
<div class="d-none">
    <div class="sdate">${sdate}</div>
    <div class="productcode">${product.code}</div>
</div>

