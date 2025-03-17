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

<div class="container container-md">
    <div class="row row-cols-2 gx-10">
        <c:forEach items="${productfeatures}" var="feature">
            <c:choose>
                <c:when test="${empty feature.jvalueDTO || empty feature.firstValue}"></c:when>
                <c:when test="${empty feature.jvalueDTO.items}"></c:when>
                <c:otherwise>
                    <div class="col ">
                        <div class="p-2 border-top w-full d-flex justify-content-between ">
                            <div>

                                <p><c:if test="${not empty feature.firstIconCss}">
                                    <i class="${feature.firstIconCss} me-3"></i>
                                </c:if>${feature.name}</p>
                            </div>
                            <div>
                                <p>${feature.firstValue}</p>
                            </div>
                        </div>

                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</div>

