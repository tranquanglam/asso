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

<c:set var="layout" value="blogs-for-view"/>
<c:if test="${param.layout != null}">
    <c:set var="layout" value="${param.layout}"/>
</c:if>

<c:set var="layoutitem" value="blog-box-1"/>
<c:if test="${param.layoutitem != null}">
    <c:set var="layoutitem" value="${param.layoutitem}"/>
</c:if>

<c:choose>
    <c:when test="${layout eq 'blogs-for-view-2'}">
        <%@ include file="blogs-for-view-2.jsp" %>
    </c:when>
    <c:when test="${layout eq 'blogs-for-view-3'}">
        <%@ include file="blogs-for-view-3.jsp" %>
    </c:when>
    <c:otherwise>
        <div class="blogs-container">
            <c:if test="${not empty mainBlogs && mainBlogs.size() eq 2}">
                <div class="row main-blogs-contaner">
                    <c:forEach items="${mainBlogs}" var="item">
                        <div class="col-12 col-md-6">
                            <div class="news-banner">
                                <a href="/blog/${item.urlname}" title="${item.title}">
                                    <img class="img-fluid " width="850" height="496" src="${item.image1}"
                                         alt="${item.title}" title="${item.title}">
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <div class="swiper-js-container mt-3">
                <div class="swiper-container" data-swiper-items="1"
                     data-swiper-sm-items="1"
                     data-swiper-md-items="4"
                     data-swiper-lg-items="4"
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
    </c:otherwise>
</c:choose>

