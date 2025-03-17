<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:if test="${not empty banners}">
    <div class="banner-containter">
    <div class="carousel slide" id="mega-slider" data-ride="carousel">
        <div class="carousel-inner">
            <c:forEach items="${banners}" var="banner" varStatus="st">
                <div class="carousel-item ${st.count eq 1 ? 'active' : ''}">
                    <c:choose>
                        <c:when test="${fn:startsWith(banner.image, 'http')}">
                            <img src="${banner.image}" alt="${banner.name}" width="100%">
                        </c:when>
                        <c:otherwise>
                            <img src="${applicationScope['hostmedia']}${banner.image}" alt="${banner.name}" width="100%">
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
        </div>
        <div class="carousel-control-prev carousel-control left" href="#mega-slider" role="button" data-slide="prev"></div>
        <div class="carousel-control-next carousel-control right" href="#mega-slider" role="button" data-slide="next"></div>
    </div>
    </div>
</c:if>
<c:forEach var="page" items="${pages}" varStatus="theCount">
    ${page.content}
</c:forEach>
