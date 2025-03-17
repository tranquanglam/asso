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

<div class="enet-nest property-3">
    <img src="${product.image}"  alt="${product.name}" loading="lazy" class="img-fluid w-100">
    <%--<div class="featured-tag2">Featured</div>
    <div class="sale-tag">For Sale</div>--%>
    <div class="ling-section">
        <div class="h3 text-white">
            <a class="text-white" href="/${product.code}">${product.name}</a>
        </div>
        <c:if test="${showfeature && not empty mapProductFeature[product.productid]}">
            <ul class="facilities-list">
                <c:forEach items="${mapProductFeature[product.productid].items}" var="feature" end="${mapProductFeature[product.productid].items.size() >= 3 ? 3 : mapProductFeature[product.productid].items.size() }">
                    <li>${feature.content}</li>
                </c:forEach>
            </ul>
        </c:if>
        <a href="/${product.code}" class="read-more-btn"><fmt:message key="title.readmore" /></a>
    </div>
</div>


