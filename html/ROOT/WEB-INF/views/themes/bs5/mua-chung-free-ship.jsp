<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:choose>
    <c:when test="${not empty page.content}">
        ${page.content}
    </c:when>
    <c:otherwise>
        <section class="slice bg-gradient-primary" data-offset-top="#header-main">
            <div class="text-center">Chọn chung cư mà bạn sinh sống để mua chung nhé</div>
        </section>
    </c:otherwise>
</c:choose>
<section class="slice bg-light">
    <c:if test="${not empty nextevents}">
        <div class="mt-3 mb-3 bg-dark text-warning">
            <marquee behavior="scroll" direction="left" scrollamount="2">
                <c:forEach items="${nextevents}" var="desnext">
                    <span class="px-3"><a href="/mua-chung/${desnext.nameurl}">${desnext.name}</a></span>
                </c:forEach>
            </marquee>
        </div>
    </c:if>
    <div class="container">
        <div class="row">
            <c:if test="${not empty states}">
                <div class="form-group form-group-state col-6">
                    <select name="state" class="form-select custom-select cus-state">
                        <c:forEach items="${states}" var="state">
                            <option value="${state.code}">${state.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </c:if>
            <div class="form-group form-group-city col-6">
                <select name="city" class="form-select custom-select cus-city">
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
        <a href="/mua-chung/{code}"><i class="fas fa-map-marker-alt"></i> {name}</a>
    </div>
</div>
