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
    <div class="border-0 g-0 row row-cols-1 row-cols-md-3 row-cols-sm-2">
        <c:forEach items="${banners}" var="banner" varStatus="st">
            <div class="col">
                <div class="card rounded-0 h-full">
                    <div class="bg-cover card-img rounded-0 py-32" style="background-image: url(${banner.image})"></div>
                    <span class="position-absolute top-0 start-0 w-full h-full bg-dark opacity-40"></span>
                    <div class="card-img-overlay d-flex align-items-center text-center" 
                         data-toggle="lightbox" 
                         data-src="${banner.image}"
                         data-gallery="banners-group-${flag}">
                        <div class="col">
                            <h4 class="text-white">${banner.name}</h4>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</c:if>


