<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="headerid" value="header_jcontent_${site.siteid}"/>
<c:choose>
    <c:when test="${applicationScope[headerid] != null}">
        <c:set var="bmenu" value="${applicationScope[headerid].localmenu}"/>
        <c:if test="${lang eq 'en'}">
            <c:set var="bmenu" value="${applicationScope[headerid].menu}"/>
        </c:if>
        <c:choose>
            <c:when test="${bmenu.headerType eq 'left-right'}">
                <jsp:include page="header-menu-left-right.jsp"/>
            </c:when>
            <c:when test="${bmenu.headerType eq 'search-center-top-main-header'}">
                <jsp:include page="header-menu-search-center.jsp"/>
            </c:when>
            <c:when test="${bmenu.headerType eq 'submenu-horizontal'}">
                <jsp:include page="header-menu-submenu-horizontal.jsp"/>
            </c:when>
            <c:otherwise>
                <jsp:include page="header-menu-left-center-right.jsp"/>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <jsp:include page="old-header.jsp"/>
    </c:otherwise>
</c:choose>
