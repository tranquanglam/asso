<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
</c:if>
<c:set var="oneLayout" value="one-1"/>
<c:if test="${not empty siteStyle.layoutOne}">
    <c:set var="oneLayout" value="${siteStyle.layoutOne}"/>
</c:if>
<jsp:include page="${oneLayout}.jsp"/>
<div id="checkrateLayout" class="d-none">${oneLayout}</div>
<c:if test="${fn:contains(pageOneProduct.link,'commentable')}">
    <div class="d-none">
        <div class="show-comments-for-productcode">${product.code}</div>
        <security:authorize access="isAuthenticated()">
            <div class="user_access_token">${userInfo.access_token}</div>
        </security:authorize>
    </div>
</c:if>
<div id="fb-root" data-lazy="true"></div>
<script async defer crossorigin="anonymous"
        src="https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v14.0&appId=412738923996515&autoLogAppEvents=1"
        nonce="y9sIypoM"></script>
