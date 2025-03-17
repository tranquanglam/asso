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
<div class="py-3 bg-white">
    <div class="container">
        <div class="hstack scrollable-x gap-4">
            <c:forEach items="${categories}" var="cat">
            <a href="/products.html?caturl=${cat.nameurl}" class="btn btn-sm bg-secondary bg-opacity-20 bg-opacity-40-hover text-heading text-opacity-80 text-opacity-100-hover font-bold rounded-pill ${caturl eq cat.nameurl ? 'active' : ''}">
                    ${cat.name}
            </a>
            </c:forEach>
        </div>
    </div>
</div>
<section class="py-3 bg-section-secondary">
<div class="container">
    <div class="bg-light shadow-lg rounded-3 p-4 mt-n5 mb-4">
        <div class="d-flex justify-content-between align-items-center">
            <div class="dropdown me-2">
                <a class="btn btn-outline-secondary dropdown-toggle text-dark" href="#enet-products-filters" data-bs-toggle="collapse" aria-expanded="true"><i class="bi bi-filter me-2"></i> <fmt:message key="lable.filter"/></a></div>
            <div class="d-none d-sm-flex"><a class="btn btn-icon nav-link-style bg-primary text-light disabled opacity-100 me-2" href="#"><i class="ci-view-grid"></i></a><a class="btn btn-icon nav-link-style" href="shop-list-ft.html"><i class="ci-view-list"></i></a></div>
        </div>
        <div class="collapse" id="enet-products-filters" style="">
            <form action="/products.html" method="GET">
                <div class="row pt-4">
                    <div class="col-lg-4 col-sm-6">
                        <div class="card mb-grid-gutter border">
                            <div class="card-body px-4">
                                <div class="widget">
                                    <p class="widget-title pe-0 me-0 mb-2"><fmt:message key="label.categories"/></p>
                                    <div class="">
                                        <div class="d-flex pb-1">
                                            <select class="form-select form-select-sm" name="caturl" aria-label="Default select example">
                                                <option selected>Open this select menu</option>
                                                <c:forEach items="${categories}" var="cat">
                                                    <option value="${cat.nameurl}" ${cat.nameurl eq caturl ? 'selected' : ''}>${cat.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-sm-6">

                        <div class="card mb-grid-gutter border">
                            <div class="card-body px-4">
                                <div class="widget">
                                    <p class="widget-title pe-0 me-0 mb-2"><fmt:message key="label.filter_price"/></p>
                                    <div class="range-slider">
                                        <div class="d-flex pb-1">
                                            <div class="w-50 pe-2 me-2">
                                                <div class="input-group input-group-sm"><span class="input-group-text">${currency}</span>
                                                    <input class="form-control range-slider-value-min" type="text" name="minPrice" value="${param.minPrice}">
                                                </div>
                                            </div>
                                            <div class="w-50 ps-2">
                                                <div class="input-group input-group-sm"><span class="input-group-text">${currency}</span>
                                                    <input class="form-control range-slider-value-max" type="text" name="maxPrice" value="${param.maxPrice}">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="card mb-grid-gutter border">
                            <div class="card-body px-4">
                                <div class="widget">
                                    <p class="widget-title pe-0 me-0 mb-2"><fmt:message key="label.search"/></p>
                                    <div class="">
                                        <div class="d-flex pb-1">
                                            <div class="input-group input-group-sm input-group-inline shadow-none">
											<span class="input-group-text pe-2">
												<i class="bi bi-search"></i>
											</span>
                                                <input  type="text" class="form-control shadow-none" name="q" value="${param.q}" placeholder="Search for ..." aria-label="Search">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-full d-flex flex-row-reverse">
                            <button class="btn btn-primary w-full mt-3 w-lg-1/2" type="submit"><fmt:message key="title.filter"/></button>
                        </div>

                    </div>
                </div>
            </form>
        </div>
    </div>

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
