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
<c:set var="showprice" value="true"/>
<c:if test="${param.showprice != null}">
    <c:set var="showprice" value="${param.showprice}"/>
</c:if>
<c:set var="showcart" value="true"/>
<c:if test="${param.showcart != null}">
    <c:set var="showcart" value="${param.showcart}"/>
</c:if>
<c:set var="colmdclass" value="col-xl-3 col-md-4 mb-3"/>
<c:if test="${param.colmd != null}">
    <c:choose>
        <c:when test="${param.colmd eq 2}">
            <c:set var="colmdclass" value="col-md-6"/>
        </c:when>
        <c:when test="${param.colmd eq 3}">
            <c:set var="colmdclass" value="col-md-4"/>
        </c:when>
        <c:when test="${param.colmd eq 4}">
            <c:set var="colmdclass" value="col-md-3"/>
        </c:when>
        <c:otherwise>
            <c:set var="colmdclass" value="col-md"/>
        </c:otherwise>
    </c:choose>
</c:if>
<c:set var="colclass" value="col-6"/>
<c:if test="${param.col != null}">
    <c:choose>
        <c:when test="${param.col eq 1}">
            <c:set var="colclass" value="col-12"/>
        </c:when>
        <c:otherwise>
            <c:set var="colclass" value="col-6"/>
        </c:otherwise>
    </c:choose>
</c:if>
<div class="slice bg-gradient-primary pb-5" data-offset-top="#header-main">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <form id="productFilterForm" action="/products.html" method="post">
                    <div class="form-group bg-white rounded-pill px-2 py-2 shadow">
                        <div class="row">
                            <div class="col-8 col-md-9">
                                <input type="hidden" name="caturl" value="${caturl}"/>
                                <div class="input-group input-group-merge shadow-none">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text bg-transparent border-0"><i class="fas fa-search"></i></span>
                                    </div>
                                    <input type="text" name="q" value="${q}" class="form-control form-control-flush shadow-none" placeholder="Search for products ...">
                                </div>
                            </div>
                            <div class="col-4 col-md-3">
                                <button type="submit" class="btn btn-block btn-primary rounded-pill">
                                    <span class="d-block d-md-none"><i class="fas fa-search"></i></span>
                                    <span class="d-none d-md-block">Search</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="products-cat-container pb-0">
                    <c:forEach items="${categories}" var="cat">
                        <div class="products-cat-item">
                            <a  href="/products.html?caturl=${cat.nameurl}" class="cat-link ${caturl eq cat.nameurl ? 'active' : ''}">${cat.name}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <a href="#products-list" class="tongue tongue-bottom tongue-section-primary" data-scroll-to>
        <i class="fas fa-angle-down"></i>
    </a>
</div>
<section class="slice bg-section-secondary">
<div class="container">
    <div class="row" id="products-list">
        <c:forEach var="product" items="${products}" varStatus="theCount">
            <div class="one-product-content ${colmdclass} ${colclass}">
                <div class="card border-0 shadow hover-translate-y-n10 hover-shadow-lg"><a href="/${product.code}.html"><img alt="${product.name}" class="card-img-top product-image" src="${product.image}"></a>
                    <div class="card-body text-center py-3 px-1">
                        <h5 class="product-name card-title mb-0"><a href="/${product.code}.html">${product.name}</a></h5>
                        <c:set var="pprice" value="${product.productprices[0]}"/>
                        <c:if test="${showprice}">
                            <div class="product-price card-text text-danger"><fmt:formatNumber value="${pprice.price * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}</div>
                        </c:if>
                    </div>
                    <div class="card-footer border-0 text-center px-0 py-2">
                        <c:if test="${showcart and product.quantity gt 0}">
                            <div class="product-cart py-2"><a onclick="addQtyToCart('${pprice.productpriceid}','${product.productid}','1')" class="btn btn-sm btn-primary btn-icon rounded-pill add-one-to-cart-btn" href="javascript:void(0)"><span class="text-nowrap"><fmt:message key="add-to-cart"/></span> <span class="d-none d-md-inline"><i class="fas fa-shopping-cart"></i></span></a></div>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</section>
