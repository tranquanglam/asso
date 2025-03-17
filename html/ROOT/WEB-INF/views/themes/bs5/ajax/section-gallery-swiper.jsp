<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="currency" value="${site.agent.currency}"/>
<c:set var="currencyrate" value="1"/>
<c:set var="scurrency" value="đ"/>
<c:set var="maxF" value="0"/>
<c:if test="${currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="scurrency" value="USD"/>
</c:if>

<c:if test="${not empty banners}">
    <c:if test="${type eq 'slide'}">
        <div class="row d-flex justify-content-center">
            <div class="col-12">
                <c:set var="firstBanner" value="${banners[0]}" />
                <img class="img-fluid img-fluid border-0 shadow-3 w-full" loading="lazy" src="${firstBanner.image}" alt="${firstBanner.name}"
                     data-toggle="lightbox"
                     data-src="${firstBanner.image}"
                     data-gallery="banners-group-${flag}">
            </div>
            <div class="col-12">
                <div class="swiper-js-container">
                    <div class="swiper-container py-5"
                         data-swiper-sm-items="1"
                         data-swiper-md-items="4"
                         data-swiper-lg-items="4"
                         data-swiper-row-items="1"
                         data-swiper-space-between="10"
                         data-swiper-autoplay="true">
                        <div class="swiper-wrapper" >
                            <c:forEach items="${banners}" var="banner" varStatus="theCount" begin="1">
                                <div class="swiper-slide ">
                                    <img class="img-fluid border-0 shadow-3 " loading="lazy" src="${banner.image}" alt="${banner.name}"
                                         data-toggle="lightbox"
                                         data-src="${banner.image}"
                                         data-gallery="banners-group-${flag}"
                                    >
                                </div>
                            </c:forEach>
                        </div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </div>
            </div>
        </div>

    </c:if>
</c:if>


