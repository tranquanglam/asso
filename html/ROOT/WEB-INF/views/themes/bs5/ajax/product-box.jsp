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

<c:choose>
    <c:when test="${empty layoutitem}">
        <%@ include file="product-box-1.jsp" %>
    </c:when>
    <c:when test="${layoutitem eq 'product-box-land' || layoutitem eq 'product-box-for-land'}">
        <%@ include file="product-box-for-land.jsp" %>
    </c:when>
    <c:otherwise>
        <%@ include file="product-box-1.jsp" %>
    </c:otherwise>
</c:choose>


