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
<div class="bg-gradient-primary" data-offset-top="#header-main"></div>
<div class="container advanced-search-container my-4">
    <div class="search-area bg-secondary">
        <div class="search-area-inner">
            <form action="/search.html" method="GET">
                <div class="row g-0">
                    <input type="hidden" name="type" value="advance">
                    <div class="col-md form-group b-right">
                        <input type="text" name="q" class="input-text search-fields" placeholder="Enter Keyword">
                    </div>
                    <div class="col-md form-group">
                        <select class="form-select form-select-lg search-fields advanced-search-state" name="state">
                            <option value="">--<fmt:message key="label.state"/>--</option>
                            <c:forEach items="${states}" var="st">
                                <option value="${st.code}" ${st.code eq state ? 'selected' : ''}>${st.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md form-group">
                        <select class="form-select form-select-lg search-fields advanced-search-city" name="city">
                            <option value="">--<fmt:message key="label.city"/>--</option>
                        </select>
                    </div>
                    <div class="col-md form-group">
                        <select class="form-select form-select-lg search-fields" name="caturl">
                            <option value="">-- <fmt:message key="label.categories"/> --</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.nameurl}" ${cat.nameurl eq caturl ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md form-group">
                        <button class="btn-search bg-gradient-primary text-white" type="submit">Search</button>
                    </div>

                </div>
            </form>
        </div>
    </div>
    <div class="d-none">
        <div class="advanced-search-country-id">${country.countryid}</div>
    </div>
</div>
<section class="py-3 bg-section-secondary">
    <div class="container">
        <div class="row" id="products-list">
            <c:forEach var="product" items="${products}" varStatus="theCount">
                <div class="one-product-content ${colmdclass} ${colclass}">
                    <div class="card border-0 shadow hover-translate-y-n10 hover-shadow-lg h-full"><a href="/${product.code}"><img alt="${product.name}" class="card-img-top product-image" src="${product.image}" loading="lazy"></a>
                        <div class="card-body text-center py-3 px-1">
                            <h5 class="product-name card-title mb-0"><a href="/${product.code}">${product.name}</a></h5>
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

        <c:if test="${empty products}">
            <div class="row">
                <div class="col py-lg-32 py-md-32 py-sm-16 d-flex justify-content-center">
                    <p><fmt:message key="label.product_empty"/></p>
                </div>
            </div>
        </c:if>

    </div>
</section>

