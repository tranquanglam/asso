<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:choose>
    <c:when test="${not empty page.content}">
        ${page.content}
    </c:when>
    <c:otherwise>
        <div class="slice bg-gradient-primary" data-offset-top="#header-main">
            <div class="text-center">Chọn chung cư mà bạn sinh sống để mua chung nhé</div>
        </div>
    </c:otherwise>
</c:choose>
<c:if test="${not empty nextevents}">
    <div class="bg-dark py-2">
        <marquee behavior="scroll" direction="left" scrollamount="5">
            <span class="px-3 text-white"><fmt:message key="shipping.date"/>:</span>
            <c:forEach items="${nextevents}" var="desnext">
                <span class="px-3"><a class="text-warning" href="/mua-chung/${desnext.nameurl}">${desnext.name} - <strong><fmt:formatDate pattern="dd/MM/yyyy" value="${desnext.nextevent}"/></strong></a></span>
            </c:forEach>
        </marquee>
    </div>
</c:if>
<section class="slice bg-light">
    <div class="container">
        <div class="row">
            <c:if test="${not empty states}">
                <div class="form-group form-group-state col-6">
                    <select name="state" class="form-control custom-select cus-state">
                        <c:forEach items="${states}" var="state">
                            <option value="${state.code}">${state.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </c:if>
            <div class="form-group form-group-city col-6">
                <select name="city" class="form-control custom-select cus-city">
                    <c:forEach items="${cities}" var="ct">
                        <option value="${ct.code}">${ct.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="row destination-list">

        </div>
    </div>
</section>
<div class="d-none countryid">${country.countryid}</div>
<div class="d-none" id="des-template">
    <div class="col-md-4 col-6 py-2">
        <a href="/mua-chung/{code}"><i class="fas fa-map-marker-alt"></i> {name} <span class="text-warning group-count" data-groupid="{groupid}"></span></a>
    </div>
</div>