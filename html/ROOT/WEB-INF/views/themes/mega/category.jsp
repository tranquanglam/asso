<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="banner-containter">
    <c:if test="${not empty banners}">
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
    </c:if>
</div>
<c:forEach var="page" items="${pages}" varStatus="theCount">
    <c:choose>
        <c:when test="${page.type eq 0}">
            <div class="section-page" data-bgcolor="${page.bgcolor}" data-bgimage="${page.image}">
                    ${page.content}
            </div>
        </c:when>
        <c:otherwise>
            <c:set var="oe" value="${theCount.count % 2 eq 0 ? 'even' : 'odd'}"/>
            <section class="${oe}">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <article class="mg-post text-center">
                                <header>
                                    <h2 class="mg-post-title"><span>${page.name}</span></h2>
                                </header>
                                <div class="blog-content">
                                    <c:choose>
                                        <c:when test="${empty sectionMap[page.nameurl]}">
                                            ${page.content}
                                        </c:when>
                                        <c:when test="${page.type eq 20}">
                                            <c:set var="subpages" value="${sectionMap[page.nameurl]}"/>
                                            <div class="blog-content tab">
                                                <ul class="nav nav-tabs nav-justified">
                                                    <c:set var="first" value="true"/>
                                                    <c:forEach var="sub" items="${subpages}">
                                                        <li class="nav-item"><a class="${first ? 'nav-link active' : 'nav-link'}" data-toggle="tab" href="#tab-${sub.sitepageid}">${sub.name}</a></li>
                                                        <c:set var="first" value="false"/>
                                                    </c:forEach>
                                                </ul>
                                                <div class="tab-content">
                                                    <c:set var="first" value="true"/>
                                                    <c:forEach var="sub" items="${subpages}">
                                                        <div id="tab-${page.sitepageid}" class="tab-pane fade ${first ? 'active show' : ''}">
                                                            <c:if test="${not empty sub.image}">
                                                                <img class="img-responsive" src="${applicationScope['hostmedia']}${sub.image}">
                                                            </c:if>
                                                            <div class="description">${sub.content}</div>
                                                        </div>
                                                        <c:set var="first" value="false"/>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${not empty page.content}">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                            ${page.content}
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:set var="subpages" value="${sectionMap[page.nameurl]}"/>
                                            <c:set var="colPage" value="col-md-4"/>
                                            <c:if test="${fn:length(subpages) eq 2}">
                                                <c:set var="colPage" value="col-md-6"/>
                                            </c:if>
                                            <c:if test="${fn:length(subpages) eq 4}">
                                                <c:set var="colPage" value="col-md-3"/>
                                            </c:if>
                                            <div class="row">
                                                <c:forEach items="${subpages}" var="sub">
                                                    <div class="${colPage}">
                                                        <div class="card">
                                                            <img class="card-img-top" src="${applicationScope['hostmedia']}${sub.image}">
                                                            <div class="card-body">
                                                                <h3><a href="${sub.link}">${sub.name}</a></h3>
                                                                <div class="separator"></div>
                                                                <div class="card-text text-justify">${sub.content}</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </article>
                        </div>
                    </div>
                </div>
            </section>
        </c:otherwise>
    </c:choose>
</c:forEach>
