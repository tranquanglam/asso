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

<div class="product-box-1 card border-0 shadow hover-translate-y-n10 hover-shadow-lg card-product h-full">
            <a href="/${product.code}"><img alt="${product.name}" class="card-img-top product-image" src="${product.image}" height="300" loading="lazy"></a>
            <div class="card-body text-center py-3 px-1">
                <a href="/${product.code}">
                    <h5 class="product-name card-title mb-0">${product.name}</h5>
                </a>
                <c:set var="pprice" value="${product.productprices[0]}"/>
                <c:if test="${showprice}">
                    <div class=" mt-2">
                        <c:if test="${not empty pprice.strikeprice && pprice.strikeprice ne pprice.price}">
                            <div class="price-strike">
                                <fmt:formatNumber value="${pprice.strikeprice * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}
                            </div>
                        </c:if>
                        <div class="product-price card-text text-danger font-bolder"><fmt:formatNumber value="${pprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}</div>
                    </div>
                </c:if>

                <c:if test="${showfeature && not empty mapProductFeature[product.productid]}">
                    <div class="row row-cols-3 px-3">
                        <c:forEach items="${mapProductFeature[product.productid].items}" var="feature" end="${mapProductFeature[product.productid].items.size() >= 6 ? 6 : mapProductFeature[product.productid].items.size() }">
                            <div class="col text-start">
                                <c:if test="${not empty feature.iconCss}">
                                    <i class="${feature.iconCss}"></i>
                                </c:if>
                                    ${feature.content}
                            </div>
                        </c:forEach>
                        <div class="col"></div>
                    </div>
                </c:if>

                <c:if test="${showRate || true}">
                    <div class=" mt-2">
                        <c:if test="${not empty mapProductComroom && not empty mapProductComroom[product.productid] && not empty mapProductComroom[product.productid].rate}">
                            <c:set var="division" ><fmt:formatNumber value="${mapProductComroom[product.productid].rate}" minFractionDigits="${0}" maxFractionDigits="${0}"/></c:set>
                            <div class="rating rating-${division}"></div>(${mapProductComroom[product.productid].count})
                        </c:if>
                    </div>
                </c:if>
            </div>
            <div class="card-footer border-0 text-center px-0 py-2">
                <c:if test="${showcart and product.quantity gt 0}">
                    <div class="product-cart py-2"><a onclick="addQtyToCart('${pprice.productpriceid}','${product.productid}','1')" class="btn btn-sm btn-primary btn-icon rounded-pill add-one-to-cart-btn" href="javascript:void(0)"><span class="text-nowrap"><i class="bi bi-cart-plus"></i>&nbsp;<fmt:message key="add-to-cart"/></span> <span class="d-none d-md-inline"></span></a></div>
                </c:if>
            </div>
        </div>


