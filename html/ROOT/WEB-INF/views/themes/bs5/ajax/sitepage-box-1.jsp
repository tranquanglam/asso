<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<figure class="layoutitem-${layoutitem} figure">
    <div class="figure-image">
        <a href="/page/${item.nameurl}"
           title="${item.name}">
            <img class="img-fluid"
                 alt="${item.name}"
                 title="${item.name}"
                 src="${item.image}"></a>
    </div>
    <div class="figure-caption">
        <p class="title font-bolder mt-2"><a
                href="/page/${item.nameurl}"
                title="${item.name}">${item.name}</a>
        </p>
    </div>
</figure>
