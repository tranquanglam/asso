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
<c:set var="showprice" value="true"/>
<c:if test="${param.showprice != null}">
    <c:set var="showprice" value="${param.showprice}"/>
</c:if>
<c:set var="showfeature" value="true"/>
<c:if test="${param.showfeature != null}">
    <c:set var="showfeature" value="${param.showfeature}"/>
</c:if>
<c:set var="showcart" value="true"/>
<c:if test="${param.showcart != null}">
    <c:set var="showcart" value="${param.showcart}"/>
</c:if>
<c:set var="title" value=""/>
<c:if test="${param.title != null}">
    <c:set var="title" value="${param.title}"/>
</c:if>
<c:set var="titleCssClass" value=""/>
<c:if test="${param.titleCssClass != null}">
    <c:set var="titleCssClass" value="${param.titleCssClass}"/>
</c:if>
<c:set var="layoutitem" value="product-box"/>
<c:if test="${param.layoutitem != null}">
    <c:set var="layoutitem" value="${param.layoutitem}"/>
</c:if>

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
<c:set var="colclass" value="row-cols-lg-6"/>
<c:set var="colNumber" value="6"/>
<c:if test="${param.colmd != null}">
    <c:set var="colclass" value="row-cols-lg-${param.colmd}"/>
    <c:set var="colNumber" value="${param.colmd}"/>
</c:if>

<c:set var="rowNumber" value="1"/>
<c:if test="${param.row != null}">
    <c:set var="rowNumber" value="${param.row}"/>
</c:if>
<c:set var="colxsclass" value="row-cols-2"/>
<c:set var="colxsNumber" value="2"/>
<c:if test="${param.col != null}">
    <c:choose>
        <c:when test="${param.col eq 2}">
            <c:set var="colxsclass" value="row-cols-2"/>
            <c:set var="colxsNumber" value="2"/>
        </c:when>
        <c:otherwise>
            <c:set var="colxsclass" value="row-cols-1"/>
            <c:set var="colxsNumber" value="1"/>
        </c:otherwise>
    </c:choose>
</c:if>
<c:set var="swiper" value="false"/>
<c:if test="${param.swiper != null}">
    <c:set var="swiper" value="${param.swiper}"/>
</c:if>

<c:if test="${not empty title}">
    <div class="row section-title-box ${not empty titleCssClass ? titleCssClass : ''}">
        <div class="col">
            <div class="section-title ${not empty titleCssClass ? titleCssClass : ''}">
                <h2>${title}</h2>
            </div>
        </div>
    </div>
</c:if>

<c:choose>
    <c:when test="${swiper eq true || swiper eq 'true'}">
        <div class="swiper-js-container position-relative">
            <div class="swiper-container pt-2"
                 data-swiper-items="2"
                 data-swiper-sm-items="${colsmNumber}"
                 data-swiper-md-items="${colmdNumber}"
                 data-swiper-lg-items="${colmdNumber}"
                 data-swiper-row-items="${rowNumber}"
                 data-swiper-space-between="10"
                 data-swiper-autoplay="true">
                <div class="swiper-wrapper" >
                    <c:forEach items="${products}" var="product" varStatus="theCount">
                        <div class="swiper-slide swiper-slide-height-auto">
                            <%@ include file="product-box.jsp" %>
                        </div>
                    </c:forEach>
                </div>
                <div class="swiper-button-next "></div>
                <div class="swiper-button-prev "></div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row ${colxsclass} ${colsmclass} ${colmdclass} g-4">
            <c:forEach var="product" items="${products}" varStatus="theCount">
                <div class="col one-product-content">
                    <%@ include file="product-box.jsp" %>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

