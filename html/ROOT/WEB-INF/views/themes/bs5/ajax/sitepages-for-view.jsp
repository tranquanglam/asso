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

<c:set var="layout" value="sitepages-for-view"/>
<c:if test="${param.layout != null}">
    <c:set var="layout" value="${param.layout}"/>
</c:if>

<c:set var="layoutitem" value="sitepage-box-1"/>
<c:if test="${param.layoutitem != null}">
    <c:set var="layoutitem" value="${param.layoutitem}"/>
</c:if>

<div class="layout-${layout}"></div>
<div class="layoutitem-${layoutitem}"></div>

<c:choose>
    <c:when test="${layout eq 'sitepages-for-view-2'}">
        <%@ include file="sitepages-for-view-2.jsp" %>
    </c:when>
    <c:when test="${layout eq 'blogs-for-view-3'}">
        <%@ include file="blogs-for-view-3.jsp" %>
    </c:when>
    <c:otherwise>
        <div class="blogs-container">
            <div class="swiper-js-container mt-3">
                <div class="swiper-container" data-swiper-items="1"
                     data-swiper-sm-items="1"
                     data-swiper-md-items="3"
                     data-swiper-lg-items="3"
                     data-swiper-row-items="1"
                     data-swiper-space-between="15"
                     data-swiper-autoplay="true">
                    <div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
                        <c:forEach items="${sitepages}" var="sitepage">
                            <div class="swiper-slide ">
                                <c:set var="item" value="${sitepage}"/>
                                <%@ include file="sitepage-box.jsp" %>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

