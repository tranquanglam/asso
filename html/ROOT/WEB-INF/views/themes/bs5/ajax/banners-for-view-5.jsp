<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<c:set var="colsmclass" value="row-cols-sm-2"/>
<c:set var="colsmNumber" value="2"/>
<c:if test="${param.colsm != null}">
    <c:choose>
        <c:when test="${param.colsm eq 2}">
            <c:set var="colsmclass" value="row-cols-sm-2"/>
            <c:set var="colsmNumber" value="2"/>
        </c:when>
        <c:when test="${param.colsm eq 3}">
            <c:set var="colsmclass" value="row-cols-sm-3"/>
            <c:set var="colsmNumber" value="3"/>
        </c:when>
        <c:otherwise>
            <c:set var="colsmclass" value="row-cols-sm-1"/>
            <c:set var="colsmNumber" value="1"/>
        </c:otherwise>
    </c:choose>
</c:if>

<c:set var="colmdclass" value="row-cols-md-4"/>
<c:set var="colmdNumber" value="4"/>
<c:if test="${param.colmd != null}">
    <c:choose>
        <c:when test="${param.colmd eq 1}">
            <c:set var="colmdclass" value="row-cols-md-1"/>
            <c:set var="colmdNumber" value="1"/>
        </c:when>
        <c:when test="${param.colmd eq 2}">
            <c:set var="colmdclass" value="row-cols-md-2"/>
            <c:set var="colmdNumber" value="2"/>
        </c:when>
        <c:when test="${param.colmd eq 3}">
            <c:set var="colmdclass" value="row-cols-md-3"/>
            <c:set var="colmdNumber" value="3"/>
        </c:when>
        <c:when test="${param.colmd eq 4}">
            <c:set var="colmdclass" value="row-cols-md-4"/>
            <c:set var="colmdNumber" value="4"/>
        </c:when>
        <c:otherwise>
            <c:set var="colmdclass" value="row-cols-md-4"/>
            <c:set var="colmdNumber" value="4"/>
        </c:otherwise>
    </c:choose>
</c:if>

<c:set var="animation" value="animate__animated animate__fadeIn"/>
<c:if test="${param.animation != null}">
    <c:set var="animation" value="animate__animated ${param.animation}"/>
</c:if>

<c:if test="${not empty banners}">
    <c:choose>
        <c:when test="${type eq 'slide'}">
            <div class="swiper-js-container position-relative">
                <div class="swiper-container py-5"
                     data-swiper-sm-items="1"
                     data-swiper-md-items="${colmdNumber}"
                     data-swiper-lg-items="${colmdNumber}"
                     data-swiper-row-items="1"
                     data-swiper-space-between="10"
                     data-swiper-autoplay="true">
                    <div class="swiper-wrapper" >
                        <c:forEach items="${banners}" var="banner" varStatus="theCount">
                            <div class="swiper-slide ">
                                <div class="card rounded ${animation} h-full">
                                    <div class="bg-cover card-img rounded py-24"
                                         data-toggle="lightbox"
                                         data-src="${banner.image}"
                                         data-gallery="banners-group-${flag}"
                                         style="background-image: url(${banner.image})"></div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="swiper-button-next swiper-button-outside"></div>
                <div class="swiper-button-prev swiper-button-outside"></div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="border-0 row row-cols-1 ${colmdclass}">
                <c:forEach items="${banners}" var="banner" varStatus="st">
                    <div class="col">
                        <div class="card rounded ${animation} h-full">
                            <div class="bg-cover card-img rounded py-24"
                                 data-toggle="lightbox"
                                 data-src="${banner.image}"
                                 data-gallery="banners-group-${flag}"
                                 style="background-image: url(${banner.image})"></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</c:if>


