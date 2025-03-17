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
    <div class="carousel slide" id="mega-slider" data-ride="carousel">
        <ol class="carousel-indicators d-none">
            <c:forEach items="${banners}" var="banner" varStatus="st">
                <li data-target="#mega-slider" data-slide-to="${st.count}" class="${st.count eq 1 ? 'active' : ''}"></li>
            </c:forEach>
        </ol>
        <div class="carousel-inner">
            <c:forEach items="${banners}" var="banner" varStatus="st">
                <div class="carousel-item ${st.count eq 1 ? 'active beactive' : ''}">
                    <c:choose>
                        <c:when test="${fn:startsWith(banner.image, 'http')}">
                            <img src="${banner.image}" alt="..." width="100%">
                        </c:when>
                        <c:otherwise>
                            <img src="${applicationScope['hostmedia']}${banner.image}" alt="..." width="100%">
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${not empty banner.content}">
                        <div class="carousel-caption">
                            <h2><a href="${banner.url}">${banner.name}</a></h2>
                            <p>${banner.content}</p>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
        <div class="carousel-control-prev carousel-control left" href="#mega-slider" role="button" data-slide="prev"></div>
        <div class="carousel-control-next carousel-control right" href="#mega-slider" role="button" data-slide="next"></div>
    </div>
</c:if>
<c:if test="${not empty sitePageMap['index_home_description']}">
    <div class="position-relative overflow-hidden p-3 p-md-5 text-center bg-light">
        <div class="col-md-5 p-lg-5 mx-auto my-5">
            <h1 class="display-4 font-weight-normal">${sitePageMap['index_home_description'].name}</h1>
            <div class="lead font-weight-normal">${sitePageMap['index_home_description'].content}</div>
        </div>
        <div class="product-device box-shadow d-none d-md-block">
            <div class="product-device-content text-white">
                <i class="fa fa-5x fa-user" aria-hidden="true"></i>
            </div>
        </div>
        <div class="product-device product-device-2 box-shadow d-none d-md-block">
            <div class="product-device-content-2">
                <i class="fa fa-5x fa-users" aria-hidden="true"></i>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${not empty sections}">
    <c:forEach var="section" items="${sections}" varStatus="theCount">
        <c:set var="oe" value="${theCount.count % 2 eq 0 ? 'even' : 'odd'}"/>
        <c:set var="pages" value="${sectionMap[section]}"/>
        <c:choose>
            <c:when test="${pages[0].type eq 2000}">
                ${pages[0].content}
            </c:when>
            <c:when test="${fn:contains(section, 'product')}">
                <div class="container">
                    <h2 class="mg-sec-title mt-5">${pages[0].name}</h2>
                    <div class="row local-product">
                        <c:forEach items="${products}" var="product">
                            <c:set var="desUrl" value="/${product.code}.html"/>
                            <div class="thumb col-md-3 col-6">
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
                    <div class="text-right mb-4">
                        <a href="/products.html" class="btn btn-more"><fmt:message key="home.see-more"/> </a>
                    </div>
                </div>
            </c:when>
            <c:when test="${fn:length(pages) eq 1}">
                <c:set var="page" value="${pages[0]}"/>
                <c:choose>
                    <c:when test="${page.type eq 0}">
                        <div class="section-page" data-bgcolor="${page.bgcolor}" data-bgimage="${page.image}">
                                ${page.content}
                        </div>
                    </c:when>
                    <c:when test="${page.type eq 1}">
                        <c:set var="image" value="/themes/mega/images/blog-1.png"/>
                        <c:if test="${not empty page.image}">
                            <c:set var="image" value="${page.image}"/>
                        </c:if>
                        <div class="container">
                            <div class="card border-0">
                                <div class="row no-gutters">
                                    <div class="col-md-8 col-xs-12">
                                        <img src="${image}" class="img-fluid" alt="${page.name}"  width="100%">
                                    </div>
                                    <div class="col-md-4 col-xs-12">
                                        <div class="card-body text-center">
                                            <h3><a href="${page.link}">${page.name}</a></h3>
                                            <div class="separator"></div>
                                            <div class="card-text">${page.content}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${page.type eq 2}">
                        <c:set var="image" value="/themes/mega/images/slice-0.jpg"/>
                        <c:if test="${not empty page.image}">
                            <c:set var="image" value="${page.image}"/>
                        </c:if>
                        <figure class="figure w-100">
                            <img src="${image}" class="figure-img img-fluid" alt="${page.name}" width="100%">
                            <figcaption class="figure-caption">
                                <div class="figure-caption-title">${page.name}</div>
                                <div class="figure-caption-content"> ${page.content} </div>
                            </figcaption>
                        </figure>
                    </c:when>
                    <c:when test="${page.type eq 3}">
                        <c:set var="image" value="/themes/mega/images/blog-1.png"/>
                        <c:if test="${not empty page.image}">
                            <c:set var="image" value="${page.image}"/>
                        </c:if>
                        <section class="bg-light overflow-hidden">
                            <div class="container">
                                <div class="row no-gutters justify-content-between">
                                    <div class="col-12 col-md-5 col-lg-4 pt-3 pb-3">
                                        <h2 class="mb-4"><a href="${page.link}">${page.name}</a></h2>
                                        <div class="text-gray-500 mb-8">
                                                ${page.content}
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <div class="h-100 vw-50 bg-cover" style="background-image: url(${image});"></div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </c:when>
                    <c:otherwise>
                        <header>
                            <h2 class="mg-sec-title mt-5"><span>${page.name}</span></h2>
                        </header>
                        <div class="blog-content text-center">
                                ${page.content}
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <c:set var="pageType" value="0"/>
                            <header>
                                <c:forEach var="page" items="${pages}">
                                    <c:set var="urlParts" value="${fn:split(page.nameurl, '/')}" />
                                    <c:if test="${fn:length(urlParts) eq 2}">
                                        <h2 class="mg-sec-title"><span>${page.name}</span></h2>
                                        <c:set var="pageType" value="${page.type}"/>
                                    </c:if>
                                </c:forEach>
                            </header>
                            <c:choose>
                                <c:when test="${pageType eq 20}">
                                    <div class="blog-content tab">
                                        <ul class="nav nav-tabs nav-justified">
                                            <c:set var="first" value="true"/>
                                            <c:forEach var="page" items="${pages}">
                                                <c:set var="urlParts" value="${fn:split(page.nameurl, '/')}" />
                                                <c:if test="${fn:length(urlParts) gt 2}">
                                                    <li class="nav-item"><a class="${first ? 'nav-link active' : 'nav-link'}" data-toggle="tab" href="#tab-${page.sitepageid}">${page.name}</a></li>
                                                    <c:set var="first" value="false"/>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                        <div class="tab-content">
                                            <c:set var="first" value="true"/>
                                            <c:forEach var="page" items="${pages}">
                                                <c:set var="urlParts" value="${fn:split(page.nameurl, '/')}" />
                                                <c:if test="${fn:length(urlParts) gt 2}">
                                                    <div id="tab-${page.sitepageid}" class="tab-pane fade ${first ? 'active show' : ''}">
                                                        <c:if test="${not empty page.image}">
                                                            <img class="img-responsive" src="${applicationScope['hostmedia']}${page.image}">
                                                        </c:if>
                                                        <div class="description">${page.content}</div>
                                                    </div>
                                                    <c:set var="first" value="false"/>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="colPage" value="col-md-4"/>
                                    <c:if test="${fn:length(pages) eq 3}">
                                        <c:set var="colPage" value="col-md-6"/>
                                    </c:if>
                                    <c:if test="${fn:length(pages) eq 5}">
                                        <c:set var="colPage" value="col-md-3"/>
                                    </c:if>
                                    <c:if test="${fn:length(pages) eq 7}">
                                        <c:set var="colPage" value="col-md-2"/>
                                    </c:if>
                                    <div class="blog-content text-center">
                                        <div class="row">
                                            <c:forEach var="page" items="${pages}">
                                                <c:set var="urlParts" value="${fn:split(page.nameurl, '/')}" />
                                                <c:if test="${fn:length(urlParts) gt 2}">
                                                    <div class="${colPage}">
                                                        <div class="card">
                                                            <img class="card-img-top" src="${applicationScope['hostmedia']}${page.image}" alt="${page.name}">
                                                            <div class="card-body">
                                                                <h3><a href="${page.link}">${page.name}</a></h3>
                                                                <div class="separator"></div>
                                                                <div class="card-text">${page.content}</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</c:if>
