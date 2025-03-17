<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<div class="slice bg-gradient-primary" data-offset-top="#header-main">
    <c:if test="${not empty albumName}">
        <div class="container">
            <h1 class="text-white">${albumName}</h1>
        </div>
    </c:if>
</div>
<section class="slice bg-light">
    <div class="container justify-content-center pb-5 px-0">
        <div class="row g-4">
            <c:forEach items="${albumitems}" var="aitem" varStatus="theCount">
                <div class="col-12 col-md-3">
                    <a href="${aitem.url}" data-toggle="lightbox" data-src="${aitem.url}">
                        <img src="${aitem.url}" class="img-responsive" alt=""/>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
