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
<c:set var="showfeature" value="true"/>
<c:if test="${param.showfeature != null}">
    <c:set var="showfeature" value="${param.showfeature}"/>
</c:if>
<c:set var="showcart" value="true"/>
<c:if test="${param.showcart != null}">
    <c:set var="showcart" value="${param.showcart}"/>
</c:if>
<c:set var="title" value=""/>
<c:if test="${param.title != null}">
    <c:set var="title" value="${param.title}"/>
</c:if>
<c:set var="titleCssClass" value=""/>
<c:if test="${param.titleCssClass != null}">
    <c:set var="titleCssClass" value="${param.titleCssClass}"/>
</c:if>
<c:set var="layoutitem" value="product-box"/>
<c:if test="${param.layoutitem != null}">
    <c:set var="layoutitem" value="${param.layoutitem}"/>
</c:if>

<c:set var="colsmclass" value="row-cols-sm-2"/>
<c:set var="colsmNumber" value="2"/>
<c:if test="${param.colsm != null}">
    <c:choose>
        <c:when test="${param.colsm eq 2}">
            <c:set var="colsmclass" value="row-cols-sm-2"/>
            <c:set var="colsmNumber" value="2"/>
        </c:when>
        <c:when test="${param.colsm eq 3}">
            <c:set var="colsmclass" value="row-cols-sm-3"/>
            <c:set var="colsmNumber" value="3"/>
        </c:when>
        <c:otherwise>
            <c:set var="colsmclass" value="row-cols-sm-1"/>
            <c:set var="colsmNumber" value="1"/>
        </c:otherwise>
    </c:choose>
</c:if>

<c:set var="colmdclass" value="row-cols-md-4"/>
<c:set var="colmdNumber" value="4"/>
<c:if test="${param.colmd != null}">
    <c:choose>
        <c:when test="${param.colmd eq 2}">
            <c:set var="colmdclass" value="row-cols-md-2"/>
            <c:set var="colmdNumber" value="2"/>
        </c:when>
        <c:when test="${param.colmd eq 3}">
            <c:set var="colmdclass" value="row-cols-md-3"/>
            <c:set var="colmdNumber" value="3"/>
        </c:when>
        <c:when test="${param.colmd eq 4}">
            <c:set var="colmdclass" value="row-cols-md-4"/>
            <c:set var="colmdNumber" value="4"/>
        </c:when>
        <c:otherwise>
            <c:set var="colmdclass" value="row-cols-md-4"/>
            <c:set var="colmdNumber" value="4"/>
        </c:otherwise>
    </c:choose>
</c:if>
<c:set var="colclass" value="row-cols-lg-6"/>
<c:set var="colNumber" value="6"/>
<c:if test="${param.colmd != null}">
    <c:set var="colclass" value="row-cols-lg-${param.colmd}"/>
    <c:set var="colNumber" value="${param.colmd}"/>
</c:if>

<c:set var="colxsclass" value="row-cols-2"/>
<c:set var="colxsNumber" value="2"/>
<c:if test="${param.col != null}">
    <c:choose>
        <c:when test="${param.col eq 2}">
            <c:set var="colxsclass" value="row-cols-2"/>
            <c:set var="colxsNumber" value="2"/>
        </c:when>
        <c:otherwise>
            <c:set var="colxsclass" value="row-cols-1"/>
            <c:set var="colxsNumber" value="1"/>
        </c:otherwise>
    </c:choose>
</c:if>
<c:set var="swiper" value="false"/>
<c:if test="${param.swiper != null}">
    <c:set var="swiper" value="${param.swiper}"/>
</c:if>

<c:if test="${not empty title}">
    <div class="row section-title-box ${not empty titleCssClass ? titleCssClass : ''}">
        <div class="col">
            <div class="section-title ${not empty titleCssClass ? titleCssClass : ''}">
                <h2>${title}</h2>
            </div>
        </div>
    </div>
</c:if>

<c:choose>
    <c:when test="${swiper eq true || swiper eq 'true'}">
        <div class="swiper-js-container">
            <div class="swiper-container py-5"
                 data-swiper-items="2"
                 data-swiper-sm-items="${colsmNumber}"
                 data-swiper-md-items="${colmdNumber}"
                 data-swiper-lg-items="${colmdNumber}"
                 data-swiper-row-items="1"
                 data-swiper-space-between="10"
                 data-swiper-autoplay="true">
                <div class="swiper-wrapper">
                    <c:forEach items="${products}" var="product" varStatus="theCount">
                        <div class="swiper-slide swiper-slide-height-auto">
                            <div class="product-box-1 card border-0 shadow hover-translate-y-n10 hover-shadow-lg card-product h-full">
                                <a href="javascript:void(0)" data-action="modal-open" data-target="#modalProduct${product.productid}"><img alt="${product.name}" class="card-img-top product-image"
                                                          src="${product.image}"
                                                          height="300" loading="lazy"></a>
                                <div class="card-body text-center py-3 px-1">
                                    <h5 class="product-name card-title mb-0">${product.name}</h5>
                                    <c:set var="pprice" value="${product.productprices[0]}"/>
                                    <c:if test="${showprice}">
                                        <div class="product-price card-text text-danger mt-2"><fmt:formatNumber
                                                value="${pprice.price * currencyrate}" minFractionDigits="${maxF}"
                                                maxFractionDigits="${maxF}"/> ${scurrency}</div>
                                    </c:if>
                                    <c:if test="${showfeature && not empty mapProductFeature[product.productid]}">
                                        <div class="row row-cols-3 px-3">
                                            <c:forEach items="${mapProductFeature[product.productid].items}"
                                                       var="feature"
                                                       end="${mapProductFeature[product.productid].items.size() >= 6 ? 6 : mapProductFeature[product.productid].items.size() }">
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
                                </div>
                                <div class="card-footer border-0 text-center px-0 py-2">
                                    <c:if test="${showcart and product.quantity gt 0}">
                                        <div class="product-cart py-2"><a
                                                onclick="addQtyToCart('${pprice.productpriceid}','${product.productid}','1')"
                                                class="btn btn-sm btn-primary btn-icon rounded-pill add-one-to-cart-btn"
                                                href="javascript:void(0)"><span class="text-nowrap"><i
                                                class="bi bi-cart-plus"></i>&nbsp;<fmt:message
                                                key="add-to-cart"/></span> <span
                                                class="d-none d-md-inline"></span></a></div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                    </c:forEach>
                </div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row ${colxsclass} ${colsmclass} ${colmdclass} g-4">
            <c:forEach var="product" items="${products}" varStatus="theCount">
                <div class="col one-product-content">
                    <div class="product-box-1 card border-0 shadow hover-translate-y-n10 hover-shadow-lg card-product h-full">
                        <a href="javascript:void(0)"  data-action="modal-open" data-target="#modalProduct${product.productid}" ><img alt="${product.name}" class="card-img-top product-image"
                                                  src="${product.image}"
                                                  height="300" loading="lazy"></a>
                        <div class="card-body text-center py-3 px-1">
                            <h5 class="product-name card-title mb-0">${product.name}</h5>
                            <c:set var="pprice" value="${product.productprices[0]}"/>
                            <c:if test="${showprice}">
                                <c:if test="${not empty pprice.strikeprice && pprice.strikeprice ne pprice.price}">
                                    <div class="price-strike">
                                        <fmt:formatNumber value="${pprice.strikeprice * currencyrate}" minFractionDigits="${maxF}" maxFractionDigits="${maxF}"/> ${scurrency}
                                    </div>
                                </c:if>
                                <div class="product-price card-text text-danger font-bolder h3"><fmt:formatNumber
                                        value="${pprice.price * currencyrate}" minFractionDigits="${maxF}"
                                        maxFractionDigits="${maxF}"/> ${scurrency}</div>
                            </c:if>

                            <c:if test="${showfeature && not empty mapProductFeature[product.productid]}">
                                <div class="row row-cols-3 px-3">
                                    <c:forEach items="${mapProductFeature[product.productid].items}" var="feature"
                                               end="${mapProductFeature[product.productid].items.size() >= 6 ? 6 : mapProductFeature[product.productid].items.size() }">
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

                        </div>
                        <div class="card-footer border-0 text-center px-0 py-2">
                            <c:if test="${showcart and product.quantity gt 0}">
                                <div class="product-cart py-2"><a
                                        onclick="addQtyToCart('${pprice.productpriceid}','${product.productid}','1')"
                                        class="btn btn-sm btn-primary btn-icon rounded-pill add-one-to-cart-btn"
                                        href="javascript:void(0)"><span class="text-nowrap"><i
                                        class="bi bi-cart-plus"></i>&nbsp;<fmt:message key="add-to-cart"/></span> <span
                                        class="d-none d-md-inline"></span></a></div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<c:forEach items="${products}" var="product" varStatus="theCount">
    <div id="modalProduct${product.productid}" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">${product.name}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row d-flex justify-content-center">
                        <div class="col-5"><img alt="${product.name}" class="card-img product-image"
                                                src="${product.image}"
                                                width="100%" loading="lazy"></div>
                        <div class="col-12">
                            ${product.description}
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"> <fmt:message key="label.close"/></button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<script type="text/javascript">
    var $surveyModal = $('#productSformModal');

    function openModalSform() {
        $surveyModal.modal('show');
    }

    $(document).ready(function () {
        $('.open-modal-survey').on('click', function () {
            $surveyModal.modal('show');
        });
        if ($surveyModal.find('.sform-container').length) {
            $surveyModal.find('.sform-container').each(function () {
                ENET_LEAD_SERVICE.setSFormContainer(this);
                var code = $(this).data('code');
                ENET_LEAD_SERVICE.showSform(code);
            });
        }
    });
</script>
