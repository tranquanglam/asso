<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
</c:if>
<c:set var="oneLayout" value="one_mp-1"/>
<c:if test="${not empty siteStyle.layoutOneMP}">
    <c:set var="oneLayout" value="${siteStyle.layoutOneMP}"/>
</c:if>
<jsp:include page="${oneLayout}.jsp"/>
<div id="checkrateLayout" class="d-none">${oneLayout}</div>
