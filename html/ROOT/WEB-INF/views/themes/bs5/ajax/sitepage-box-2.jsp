<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>


<div class="row align-items-center">
    <div class="col-12 col-lg-6 mb-10 mb-lg-0 ps-lg-20 order-lg-2">
        <h3 class="ls-tight font-bolder lh-tight mb-2">
            ${item.name}
        </h3>
        ${item.content}
    </div>
    <div class="col-12 col-lg-6 order-lg-1">
        <a href="/page/${item.nameurl}"
           title="${item.name}">
            <img class="img-fluid w-full" loading="lazy"
                 alt="${item.name}"
                 title="${item.name}"
                 src="${item.image}"></a>
    </div>
</div>
