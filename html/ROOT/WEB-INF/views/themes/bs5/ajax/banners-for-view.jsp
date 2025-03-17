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

<c:if test="${not empty banners}">
    <c:if test="${type eq 'slide'}">
        <div id="${not empty slideId ? slideId : 'mega-slider'}" class="carousel slide" data-bs-ride="carousel">
            <ol class="carousel-indicators d-none">
                <c:forEach items="${banners}" var="banner" varStatus="st">
                    <li data-bs-target="#mega-slider" data-bs-slide-to="${st.index}" class="${st.index eq 0 ? 'active' : ''}"></li>
                </c:forEach>
            </ol>
            <div class="carousel-inner">
                <c:forEach items="${banners}" var="banner" varStatus="st">
                    <div class="carousel-item ${st.index eq 0 ? 'active' : ''}">
                        <img src="${banner.image}" alt="${banner.name}" class="d-block w-100">
                        <c:if test="${not empty banner.content}">
                            <div class="carousel-caption">
                                <h2><a href="${banner.url}">${banner.name}</a></h2>
                                <p>${banner.content}</p>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#mega-slider" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#mega-slider" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </c:if>

    <c:if test="${type eq 'list'}">
        <div class="row">
            <c:forEach items="${banners}" var="banner" varStatus="st">
                <div class="col-12">
                    <a href="${banner.url}">
                        <img src="${banner.image}" alt="${banner.name}" class="d-block w-100">
                    </a>
                </div>
            </c:forEach>
        </div>
    </c:if>
</c:if>

