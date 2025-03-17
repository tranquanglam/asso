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
<div class="w-100">
    <div class="container text-left">
        <div class="row">
            <div class="col-lg-12 px-0 px-md-1">
                <div id="item-list">
                    <c:forEach var="product" items="${products}" varStatus="theCount">
                        <c:set var="n" value="${theCount.count}"/>
                        <div id="product${n}container" class="form-row mt-3 item-container active" data-productid="${product.productid}">
                            <div class="col-4"><img class="img-fluid" src="${product.image}" alt="${product.name}" /></div>
                            <div class="col-8">
                                <div class="row">
                                    <div class="col-10">
                                        <h3 class="p-name">${product.name}</h3>
                                        <div class="p-description">${product.description}</div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-5 col-12 pb-3">
                                        <select name="productpriceid" data-n="${n}" class="form-control change-update-product-price money">
                                            <c:forEach var="pprice" items="${product.productprices}">
                                                <option value="${pprice.productpriceid}">${pprice.description} <fmt:formatNumber value="${pprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}</option>
                                            </c:forEach>
                                        </select>
                                        <div class="d-none">
                                            <c:forEach var="pprice" items="${product.productprices}">
                                                <span class="productpriceid_${pprice.productpriceid}" data-weight="${pprice.weight}" data-numofavailable="${pprice.numofavailable}">${pprice.price * currencyrate}</span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-6">
                                        <c:choose>
                                            <c:when test="${product.quantity gt 0}">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <a href="javascript:void(0)" class="btn btn-sm btn-secondary btn-icon order-minus-btn" data-n="${n}"><i class="fas fa-minus"></i></a>
                                                    </div>
                                                    <input name="quantity" data-n="${n}" type="text" class="form-control change-update-product-price" value="1" min="0" max="${product.quantity}">
                                                    <div class="input-group-append">
                                                        <a href="javascript:void(0)" class="btn btn-sm btn-primary btn-icon order-plus-btn" data-n="${n}"><i class="fas fa-plus"></i></a>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <input name="quantity" data-n="${n}" type="hidden" value="0">
                                                <span class="sold-out text-warning"><fmt:message key="detail.sold-out"/> </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-3 col-6">
                                        <c:if test="${product.quantity gt 0}">
                                            <a href="javascript:void(0)" class="btn btn-sm btn-primary btn-icon rounded-pill add-to-cart-btn" data-n="${n}"><span class="text-nowrap"><fmt:message key="add-to-cart"/></span> <span class="d-none d-md-inline"><i class="fas fa-shopping-cart"></i></span></a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" name="maxN" value="${maxN}"/>
    <div class="d-none access_token">${access_token}</div>
    <div class="d-none scurrency">${scurrency}</div>
</div>

