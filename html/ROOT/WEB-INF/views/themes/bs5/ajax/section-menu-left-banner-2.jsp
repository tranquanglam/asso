<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<section class="slider_section mt-3 ">
    <div class="">
        <div class="row">
            <div class="col-lg-3">
                <div class="categories_menu">
                    <div class="categories_title">
                        <h2 class="text-uppercase"><fmt:message key="label.categories"/></h2>
                        <i class="bi bi-list d-block d-lg-none d-md-block" data-action="slide-toggle" data-target="categories_menu_toggle"></i>
                    </div>
                    <div id="categories_menu_toggle" class="categories_menu_toggle">
                        <ul>
                            <c:forEach items="${menuList}" var="menu">
                                <c:set var="menuname" value="${menu.name}"/>
                                <c:choose>
                                    <c:when test="${empty menu.subList}">
                                        <li><a class=" menu_item_children__1" href="${menu.link}">
                                            <c:choose>
                                                <c:when test="${empty menu.image}">
                                                    <i class="bi bi-house"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${menu.image}" alt="..." class="img-fluid"/>
                                                </c:otherwise>
                                            </c:choose>
                                                ${menuname}</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="menu_item_children">
                                            <a class=" menu_item_children__1">
                                                <c:choose>
                                                    <c:when test="${empty menu.image}">
                                                        <i class="bi bi-house"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${menu.image}" alt="..." class="img-fluid"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                ${menuname}
                                                <i class="bi bi-chevron-right"></i>
                                            </a>
                                            <ul class="categories_mega_menu column_2" >
                                                <c:forEach items="${menu.subList}" var="sub">
                                                    <c:set var="menuname" value="${sub.name}"/>
                                                    <li class="menu_item_children"><a href="${sub.link}">
                                                        <c:choose>
                                                            <c:when test="${empty menu.image}">
                                                                <i class="bi bi-house"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${menu.image}" alt="..." class="img-fluid"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                            ${menuname}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-9 categories_content ">
                <c:if test="${not empty banners}">
                    <div class="swiper-js-container" style="height: auto;margin-bottom: 10px;">
                        <div class="swiper-container "
                             data-swiper-items="1"
                             data-swiper-row-items="1"
                             data-swiper-space-between="0"
                             data-swiper-autoplay="true">
                            <div class="swiper-wrapper">
                                <c:forEach items="${banners}" var="banner" varStatus="st">
                                    <div class="swiper-slide ">
                                        <a href="${ not empty sub.tag ? sub.tag : 'javascript:void(0)'}">
                                            <img alt="${banner.name}" class=" product-image"
                                                 src="${banner.url}"
                                                 height="300" loading="lazy">
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty subbanners}">
                    <div class="swiper-js-container d-none d-md-block d-lg-block">
                        <div class="swiper-container "
                             data-swiper-sm-items="1"
                             data-swiper-md-items="3"
                             data-swiper-lg-items="3"
                             data-swiper-row-items="1"
                             data-swiper-autoplay="true"
                             data-swiper-space-between="10">
                            <div class="swiper-wrapper">

                                <c:forEach items="${subbanners}" var="sub" varStatus="st">
                                    <div class="swiper-slide ">
                                        <a href="${ not empty sub.tag ? sub.tag : 'javascript:void(0)'}">
                                            <figure class="figure">
                                                <div class="figure-image">
                                                    <img class="img-fluid "
                                                         width="100%" height="203" alt="${sub.name}"
                                                         src="${sub.url}">
                                                </div>
                                            </figure>
                                        </a>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                    </div>
                </c:if>


            </div>
        </div>
    </div>
</section>
