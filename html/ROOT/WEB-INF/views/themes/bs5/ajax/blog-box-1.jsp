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


<div class="enet-nest blog-1">
    <div class="blog-inner">
        <div class="blog-overflow">
            <div class="blog-photo">
                <img src="${item.image1}" alt="${item.title}" class="img-fluid">
            </div>
        </div>
        <div class="detail">
            <h3>
                <a href="/blog/${item.urlname}" tabindex="0">${item.title}</a>
            </h3>
            <ul class="post-meta clearfix">
                <li>
                    <i class="bi bi-person"></i>&nbsp;admin
                </li>
                <li>
                    <i class="bi bi-calendar"></i>&nbsp;<fmt:formatDate value="${item.createdDate}" pattern="dd/MM/yyyy"/>
                </li>
                <li>
                    <i class="bi bi-chat-fill"></i>&nbsp;comment
                </li>
            </ul>
            <c:if test="${not empty item.subContent}">
                <p>${item.subContent}</p>
            </c:if>
        </div>
    </div>
</div>
