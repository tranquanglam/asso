<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="colsmclass" value="row-cols-1"/>
<c:set var="colsmNumber" value="1"/>
<c:if test="${param.colsm != null}">
    <c:set var="colsmclass" value="row-cols-${param.colsm}"/>
    <c:set var="colsmNumber" value="${param.colsm}"/>
</c:if>

<c:set var="colclass" value="row-cols-1"/>
<c:set var="colNumber" value="1"/>
<c:if test="${param.col != null}">
    <c:set var="colclass" value="row-cols-${param.col}"/>
    <c:set var="colNumber" value="${param.col}"/>
</c:if>

<c:set var="colmdclass" value="row-cols-md-2"/>
<c:set var="colmdNumber" value="2"/>
<c:choose>
    <c:when test="${not empty param.colmd}">
        <c:set var="colmdclass" value="row-cols-md-${param.colmd}"/>
        <c:set var="colmdNumber" value="${param.colmd}"/>
    </c:when>
    <c:otherwise>
        <c:set var="colmdclass" value="row-cols-md-2"/>
        <c:set var="colmdNumber" value="2"/>
    </c:otherwise>
</c:choose>
<c:set var="showName" value="false"/>
<c:if test="${not empty param.showname}">
    <c:set var="showName" value="${param.showname}"/>
</c:if>

<c:if test="${not empty banners}">
    <c:if test="${type eq 'slide'}">
        <div class="swiper-js-container">
            <div class="swiper-container py-5"
                 data-swiper-items="${colsmNumber}"
                 data-swiper-sm-items="${colsmNumber}"
                 data-swiper-md-items="${colmdNumber}"
                 data-swiper-lg-items="${colmdNumber}"
                 data-swiper-row-items="1"
                 data-swiper-space-between="10"
                 data-swiper-autoplay="true">
                <div class="swiper-wrapper" >
                    <c:forEach items="${banners}" var="banner" varStatus="theCount">
                        <div class="swiper-slide ">
                            <c:choose>
                                <c:when test="${not empty banner.tag}">
                                    <a href="${banner.tag}">
                                        <img class="img-fluid " loading="lazy" src="${banner.image}" alt="${banner.name}">
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <img class="img-fluid " loading="lazy" src="${banner.image}" alt="${banner.name}"
                                         data-toggle="lightbox"
                                         data-src="${banner.image}"
                                         data-gallery="banners-group-${flag}"
                                    >
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${not empty banner.name && showName}">
                                <h5 class="product-name card-title mt-2 text-center">${banner.name}</h5>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
            </div>
        </div>
    </c:if>
    <c:if test="${type eq 'list'}">
        <div class="row ${colsmclass} ${colmdclass}">
            <c:forEach items="${banners}" var="banner" varStatus="st">
                <div class="col">
                    <c:choose>
                        <c:when test="${not empty banner.tag}">
                            <a href="${banner.tag}">
                                <img src="${banner.image}" alt="${banner.name}" class="d-block w-100">
                            </a>
                        </c:when>
                        <c:otherwise>
                            <img src="${banner.image}" alt="${banner.name}" class="d-block w-100">
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
        </div>
    </c:if>
</c:if>


