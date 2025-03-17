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

<div class="product-filter mt-4 mb-4">
    <div class="container-fluid">
        <div class="row">
            <div class="d-none d-md-block col-sm-12 col-md-2">
            </div>

            <div class="col-sm-12 col-md-10">
                <form id="productFilterForm" class="form-inline"  action="/products.html" method="post">
                    <div class="form-group mb-2 mr-2">
                        <select class="form-control" name="caturl">
                            <option value=""><fmt:message key="label.product.category"/> </option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.nameurl}" ${caturl eq cat.nameurl ? 'selected':''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <c:set var="label_search"><fmt:message key="label.search"/></c:set>
                    <div class="form-group mx-sm-3 mb-2">
                        <input class="form-control" name="q" placeholder="${label_search}" type="text" value="${q}">
                    </div>
                    <input type="submit" class="btn btn-more mb-2" value="${label_search}">
                </form>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="d-none d-md-block col-sm-12 col-md-2">
            <div class="widget widget-category">
                <h5 class="widget-title line-bottom"><fmt:message key="label.categories"/></h5>
                <div class="categories">
                    <ul class="list list-border angle-double-right">
                        <c:forEach items="${categories}" var="cat">
                            <li><a class="${cat.nameurl}" href="/products.html?caturl=${cat.nameurl}">${cat.name}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-sm-12 col-md-10">
            <div class="row local-product">
                <c:forEach items="${products}" var="product">
                    <c:set var="desUrl" value="/${product.code}.html"/>
                    <div class="thumb col-md-3 col-6">
                        <div class="product-box">
                            <div class="image-wrapper">
                                <img class="product__image banner-link" src="${product.image}" alt="${product.name}" data-link="${desUrl}">
                                <div class="price">
                                    <span class="right"><fmt:formatNumber value="${product.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/>${scurrency}</span>
                                </div>
                            </div>
                            <div class="detail-wrapper">
                                <div class="product-title"><a href="${desUrl}">${product.name}</a></div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<div class="d-none" id="currencyrate">${sessionScope.SESSION_CURRENCY.rate}</div>
<div class="d-none" id="currency">${currency}</div>

<script language="JavaScript">
    $(document).ready(function () {
        let queryString = window.location.search;
        let urlParams = new URLSearchParams(queryString);
        let caturl = urlParams.get('caturl');
        $('.widget-category').find(`.${caturl}`).addClass('active');
    });
</script>
