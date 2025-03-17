<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="d-flex flex-column flex-lg-row h-lg-full">
    <nav class="navbar show navbar-vertical h-lg-screen navbar-expand-lg px-0 py-0 navbar-light bg-white border rounded-top">
        <div class="container-fluid">
            <!-- Toggler -->
            <button class="navbar-toggler ms-n2" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarCollapse" aria-controls="sidebarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- User menu (mobile) -->
            <div class="navbar-user d-md-none">
                <!-- Dropdown -->
                <div class="dropdown">
                    <!-- Toggle -->
                    <a href="#" id="sidebarAvatar" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <div class="avatar-parent-child">
                            <span class="avatar-child avatar-badge bg-success"></span>
                        </div>
                    </a>
                    <!-- Menu -->
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="sidebarAvatar">
                        <c:forEach items="${menuList}" var="menu">
                            <c:set var="menuname" value="${menu.name}"/>
                            <c:choose>
                                <c:when test="${empty menu.subList}">
                                    <li class="nav-item"><a class="nav-link" href="${menu.link}">${menuname}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item dropdown">
                                        <a class="dropdown-toggle no-caret" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${menuname}</a>
                                        <ul class="dropdown-menu">
                                            <c:forEach items="${menu.subList}" var="sub">
                                                <c:set var="menuname" value="${sub.name}"/>
                                                <li><a href="${sub.link}">${menuname}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <!-- Collapse -->
            <div class="collapse navbar-collapse" id="sidebarCollapse">
                <!-- Form -->
                <div class="menu-header border-top bg-warning px-3 pt-1 d-flex justify-content-start">
                    <div class="ps-2 me-3"><i class="bi bi-filter-circle"></i> </div>
                    <div class="text-uppercase"><fmt:message key="label.categories"/> </div>
                </div>
                <!-- Navigation -->
                <ul class="navbar-nav">
                    <c:forEach items="${menuList}" var="menu">
                        <c:set var="menuname" value="${menu.name}"/>
                        <c:choose>
                            <c:when test="${empty menu.subList}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${menu.link}">
                                        <c:choose>
                                            <c:when test="${empty menu.image}">
                                                <i class="bi bi-house"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${menu.image}" alt="..." class="img-fluid"/>
                                            </c:otherwise>
                                        </c:choose>
                                        ${menuname}
                                    </a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="#sidebarPages-${menu.categoryid}" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarPages-${menu.categoryid}">
                                        <c:choose>
                                            <c:when test="${empty menu.image}">
                                                <i class="bi bi-files"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${menu.image}" alt="..." class="img-fluid"/>
                                            </c:otherwise>
                                        </c:choose>
                                        ${menuname}
                                    </a>
                                    <div class="collapse" id="sidebarPages-${menu.categoryid}">
                                        <ul class="nav nav-sm flex-column">
                                            <c:forEach items="${menu.subList}" var="sub">
                                                <c:set var="menuname" value="${sub.name}"/>
                                                <li class="nav-item"><a class="nav-link" href="${sub.link}">${menuname}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </nav>
    <div class="h-screen flex-grow-1">
        <div class="container-fluid">
            <c:if test="${not empty banners}">
                <div id="section-menu-left-banner-slider" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <c:forEach items="${banners}" var="banner" varStatus="st">
                            <div class="carousel-item ${st.index eq 0 ? 'active' : ''}">
                                <img src="${banner.url}" alt="${banner.name}" class="d-block w-100">
                                <c:if test="${not empty banner.tag}">
                                    <div class="carousel-caption">
                                        <h2><a href="${banner.tag}">${banner.name}</a></h2>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#section-menu-left-banner-slider" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#section-menu-left-banner-slider" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </c:if>
            <c:if test="${not empty subbanners}">
                <div class="row mt-2">
                    <c:forEach items="${subbanners}" var="sub" varStatus="st">
                        <div class="col">
                            <img src="${sub.url}" alt="${sub.name}" class="img-fluid banner-link" data-link="${sub.tag}">
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>
</div>