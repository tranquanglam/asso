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


<c:choose>
    <c:when test="${not empty layoutitem && layoutitem eq 'blog-box-1'}">
        <%@ include file="blog-box-1.jsp" %>
    </c:when>
    <c:when test="${not empty layoutitem && layoutitem eq 'blog-box-2'}">
        <%@ include file="blog-box-2.jsp" %>
    </c:when>
    <c:otherwise>
        <figure class="layoutitem-${layoutitem} figure">
            <div class="figure-image">
                <a href="/blog/${item.urlname}"
                   title="${item.title}">
                    <img class="img-fluid "
                         alt="${item.title}"
                         title="${item.title}"
                         src="${item.image1}"></a>
            </div>
            <div class="figure-caption">
                <p class="title font-bolder mt-2"><a
                        href="/blog/${item.urlname}"
                        title="${item.title}">${item.title}</a>
                </p>
            </div>
        </figure>
    </c:otherwise>
</c:choose>


