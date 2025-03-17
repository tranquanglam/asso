<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<style>
    @media (max-width: 767px) {
        #product-for-view-${flag} .tab-content > .tab-pane {
            display: block !important;
            opacity: 1;
        }
    }
</style>
<c:set var="showprice" value="true"/>
<c:if test="${param.showprice != null}">
    <c:set var="showprice" value="${param.showprice}"/>
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
<c:set var="swiper" value="false"/>
<c:if test="${param.swiper != null}">
    <c:set var="swiper" value="${param.swiper}"/>
</c:if>
<c:set var="colNumber" value="4"/>
<c:if test="${param.colmd != null}">
    <c:set var="colNumber" value="${param.colmd}"/>
</c:if>
<c:set var="colxsNumber" value="1"/>
<c:if test="${param.colxs != null}">
    <c:set var="colxsNumber" value="${param.colxs}"/>
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

<c:set var="colmdclass" value="col-md-3"/>
<c:set var="colmdNumber" value="4"/>
<c:if test="${param.colmd != null}">
    <c:choose>
        <c:when test="${param.colmd eq 2}">
            <c:set var="colmdclass" value="col-md-6"/>
            <c:set var="colmdNumber" value="2"/>
        </c:when>
        <c:when test="${param.colmd eq 3}">
            <c:set var="colmdclass" value="col-md-4"/>
            <c:set var="colmdNumber" value="3"/>
        </c:when>
        <c:when test="${param.colmd eq 4}">
            <c:set var="colmdclass" value="col-md-3"/>
            <c:set var="colmdNumber" value="4"/>
        </c:when>
        <c:otherwise>
            <c:set var="colmdclass" value="col-md-3"/>
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
<c:set var="showfeature" value="true"/>
<c:if test="${param.showfeature != null}">
    <c:set var="showfeature" value="${param.showfeature}"/>
</c:if>
<c:set var="layoutitem" value="product-box"/>
<c:if test="${param.layoutitem != null}">
    <c:set var="layoutitem" value="${param.layoutitem}"/>
</c:if>
<div class="container">
    <c:if test="${not empty title}">
        <div class="row section-title-box ${not empty titleCssClass ? titleCssClass : ''}">
            <div class="col">
                <div class="section-title">
                    <h2>${title}</h2>
                </div>
            </div>
        </div>
    </c:if>
</div>
<div id="product-for-view-${flag}" class="container justify-content-center pb-5 px-0">
    <div class="slick-js-container">
        <div class="slick-container">
            <div class="slider slider-nav">
                <c:forEach items="${categories}" var="cat" varStatus="theCount">
                    <div><h3 class="text-center">${cat.name}</h3></div>
                </c:forEach>
            </div>

            <div class="slider slider-for">
                <c:forEach items="${categories}" var="cat" varStatus="theCount">
                    <div class="row row-cols-4">
                        <c:forEach items="${products}" var="product" varStatus="theCount">
                            <c:if test="${product.categoryid eq cat.categoryid}">
                                <div class="col">
                                    <%@ include file="product-box.jsp" %>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

