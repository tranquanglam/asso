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
                <section class="slice bg-gradient-primary">
                    <span class="tongue tongue-top"><i class="fas fa-angle-up"></i></span>
                    <div class="container">
                        <div class="mb-5 text-center">
                            <h3><fmt:formatDate value="${fromDate}" pattern="dd MMM yyyy"/></h3>
                            <h4 class="text-white mt-4"><fmt:message key="time.slots"/></h4>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="table-responsive-lg">
                                    <table class="table table-hover table-scale--hover table-cards align-items-center">
                                        <tbody>
                                        <c:forEach items="${productcalendars}" var="apt" varStatus="theCount">
                                            <tr>
                                                <th scope="row">
                                                    <div class="media align-items-center">
                                                        <div class="media-body">
                                                            <div><fmt:formatDate value="${apt.starttime}" pattern="dd MMM yyyy HH:mm"/></div>
                                                            <div><fmt:formatDate value="${apt.endtime}" pattern="dd MMM yyyy HH:mm"/></div>
                                                        </div>
                                                        <div>
                                                            <span class="h6">${currency} <fmt:formatNumber value="${apt.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/></span>
                                                        </div>
                                                    </div>
                                                </th>
                                                <td>
                                                    <c:set var="maxQty" value="${apt.maxpax - apt.bookedcount}"/>
                                                    <c:if test="${maxQty gt 20}">
                                                        <c:set var="maxQty" value="20"/>
                                                    </c:if>
                                                    <c:choose>
                                                        <c:when test="${maxQty gt 0}">
                                                            <div class="input-group">
                                                                <select class="custom-select quantity-${apt.productcalendarid}" name="quantity">
                                                                    <option value="0" selected>Qty</option>
                                                                    <c:forEach var="qty" begin="1" end="${maxQty}" step="1">
                                                                        <option value="${qty}">${qty}</option>
                                                                    </c:forEach>
                                                                </select>
                                                                <div class="input-group-append">
                                                                    <button class="btn btn-outline-primary" type="button" onclick="bookAppointment(this)" data-appointmentid="${apt.productcalendarid}"><fmt:message key="book-now"/></button>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span><fmt:message key="detail.sold-out"/></span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr class="table-divider"></tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
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
</section>
<div class="d-none">
    <div class="sdate">${sdate}</div>
    <div class="productcode">${product.code}</div>
</div>

