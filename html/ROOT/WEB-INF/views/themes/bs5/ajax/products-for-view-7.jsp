<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<style>
    @media (max-width: 767px){
        #product-for-view-${flag} .tab-content > .tab-pane {
            display: none !important;
        }

        #product-for-view-${flag} .tab-content > .tab-pane:not(.show) {
            opacity: 0;
        }

        #product-for-view-${flag} .tab-content > .tab-pane.show {
            display: block !important;
            opacity: 1;
        }
    }
</style>
<c:set var="showprice" value="true"/>
<c:if test="${param.showprice != null}">
    <c:set var="showprice" value="${param.showprice}"/>
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
<c:set var="swiper" value="false"/>
<c:if test="${param.swiper != null}">
    <c:set var="swiper" value="${param.swiper}"/>
</c:if>
<c:set var="colNumber" value="4"/>
<c:if test="${param.colmd != null}">
    <c:set var="colNumber" value="${param.colmd}"/>
</c:if>
<c:set var="colxsNumber" value="1"/>
<c:if test="${param.col != null}">
    <c:set var="colxsNumber" value="${param.col}"/>
</c:if>
<c:set var="showfeature" value="true"/>
<c:if test="${param.showfeature != null}">
    <c:set var="showfeature" value="${param.showfeature}"/>
</c:if>
<c:set var="layoutitem" value="product-box"/>
<c:if test="${param.layoutitem != null}">
    <c:set var="layoutitem" value="${param.layoutitem}"/>
</c:if>
<div class="container">
    <c:if test="${not empty title}">
        <div class="row section-title-box ${not empty titleCssClass ? titleCssClass : ''}">
            <div class="col">
                <div class="section-title">
                    <h2>${title}</h2>
                </div>
            </div>
        </div>
    </c:if>
</div>
<div id="product-for-view-${flag}" class="container justify-content-center px-0">
    <div class="container enet-products-filter-container ps-0 pe-0">
        <div class="d-flex justify-content-start">
            <div class="hstack scrollable-x gap-4 simple-filter list-group">
                <c:forEach items="${categories}" var="cat" varStatus="theCount">
                    <a href="#pane-${flag}-${cat.categoryid}"
                       role="tab"
                       data-cat="${cat.nameurl}"
                       data-bs-toggle="tab" href="#pane-${flag}-${cat.categoryid}"
                       data-targetid="ajax-products-by-cat-${flag}-${cat.categoryid}"
                       class="btn btn-sm bg-secondary bg-opacity-40-hover text-heading text-opacity-80 text-opacity-100-hover font-bold rounded-pill ${theCount.index eq 0 ? '' : ''} catalogue cat-link">
                        ${cat.name}
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>


    <div class="tab-content" id="content-${flag}" role="tablist" style="width: 100%;">
        <c:forEach items="${categories}" var="cat" varStatus="theCount">
            <div aria-labelledby="tab-${flag}-${cat.categoryid}" class=" tab-pane fade ${theCount.index eq 0 ? 'active show' : ''}" id="pane-${flag}-${cat.categoryid}" role="tabpanel">
                <div aria-labelledby="heading-${flag}-${cat.categoryid}" class="collapse ${theCount.index eq 0 ? 'show' : ''}" data-parent="#content-${flag}" id="collapse-${flag}-${cat.categoryid}" role="tabpanel">
                    <div class="px-0 pt-3">
                        <div class="order-main-content"
                             id="ajax-products-by-cat-${flag}-${cat.categoryid}"
                             maxN="${maxN}"
                             query="${q}"
                             showprice="${showprice}"
                             swiper="${swiper}"
                             colmd="${colNumber}"
                             colxs="${colxsNumber}"
                             col="${colxsNumber}"
                             showfeature="${showfeature}"
                             layoutitem="${layoutitem}"
                             showcart="${showcart}">empty</div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

</div>


<%--
<script type="text/javascript" src="/themes/mega/js/catalogue.min.js"></script>
--%>
