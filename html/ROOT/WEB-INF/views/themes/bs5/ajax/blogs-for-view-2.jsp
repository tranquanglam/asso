<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="currency" value="${site.agent.currency}"/>
<c:set var="currencyrate" value="1"/>
<c:set var="scurrency" value="đ"/>
<c:set var="maxF" value="0"/>
<c:if test="${currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="scurrency" value="USD"/>
</c:if>
<c:set var="layoutitem" value="blog-box-1"/>
<c:if test="${param.layoutitem != null}">
    <c:set var="layoutitem" value="${param.layoutitem}"/>
</c:if>
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
<div class="blogs-container blogs-for-view-2">
    <div class="swiper-js-container">
        <div class="swiper-container"
             data-swiper-items="1"
             data-swiper-sm-items="1"
             data-swiper-md-items="${colmdNumber}"
             data-swiper-lg-items="${colmdNumber}"
             data-swiper-row-items="1"
             data-swiper-space-between="15"
             data-swiper-autoplay="true">
            <div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
                <c:forEach items="${blogs}" var="item">
                    <div class="swiper-slide ">
                        <%@ include file="blog-box.jsp" %>
                    </div>
                </c:forEach>
            </div>
        </div>

    </div>
</div>
