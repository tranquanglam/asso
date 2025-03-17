<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<link rel="stylesheet" type="text/css" href="/themes/grayscale/js/pagination/pagination.min.css" />

<c:set var="currency" value="${site.agent.currency}"/>
<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
</c:if>
<c:set var="mappingProducts" value="products"/>
<c:if test="${not empty siteStyle.mappingProducts}">
    <c:set var="mappingProducts" value="${siteStyle.mappingProducts}"/>
</c:if>
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

<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
</c:if>
<c:set var="layoutitem" value="product-box"/>
<c:if test="${not empty siteStyle.layoutOneBox}">
    <c:set var="layoutitem" value="${siteStyle.layoutOneBox}"/>
</c:if>

<style>
    .enet-products-filter-container .simple-filter {
        display: flex;
    }
    .enet-products-filter-container .advance-filter {
        display: none;
    }
    .enet-products-filter-container.advance .simple-filter {
        display: none;
    }
    .enet-products-filter-container.advance .advance-filter {
        display: block;
    }
</style>
<div class="slice slice-sm" data-offset-top="#header-main">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/"> <fmt:message key="title.home_page"/> </a></li>
                <c:if test="${not empty h1}">
                    <li class="breadcrumb-item"><a href="/${mappingProducts}"> <fmt:message key="label.product"/> </a></li>
                    <li class="breadcrumb-item active" aria-current="page"> ${h1} </li>
                </c:if>
                <c:if test="${empty h1}">
                    <li class="breadcrumb-item active" aria-current="page"> <fmt:message key="label.product"/> </li>
                </c:if>
            </ol>
        </nav>
        <c:choose>
            <c:when test="${not empty h1}">
                <h1>${h1}</h1>
            </c:when>
            <c:otherwise>
                <h1><fmt:message key="label.product"/> </h1>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div class="py-4 bg-white">
    <div class="container enet-products-filter-container">
        <div class="d-flex justify-content-start">
            <div class="me-4">
                <a class="toggle-advance-filter" href="javascript:void(0);"><i class="bi bi-filter me-2"></i></a>
            </div>
            <div class="advance-filter">
                <form id="formProductFilter" action="/${mappingProducts}" method="GET">
                    <div class="row">
                        <div class="col-lg-4 col-sm-12">
                            <div class="card mb-grid-gutter border">
                                <div class="card-body px-4">
                                    <div class="widget-one">
                                        <p class="widget-title pe-0 me-0 mb-2"><fmt:message key="label.categories"/></p>
                                        <div class="">
                                            <div class="d-flex pb-1">
                                                <select class="form-select form-select-sm" name="caturl" aria-label="Default select example">
                                                    <option selected value=""><fmt:message key="label.categories"/></option>
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

                        <div class="col-lg-4 col-sm-12">

                            <div class="card mb-grid-gutter border">
                                <div class="card-body px-4">
                                    <div class="widget-one">
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

                        <div class="col-lg-4 col-sm-12">
                            <div class="card mb-grid-gutter border">
                                <div class="card-body px-4">
                                    <div class="widget-one">
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
        <div class="hstack scrollable-x gap-4 simple-filter">
            <c:forEach items="${categories}" var="cat">
            <a href="/${mappingProducts}/${cat.nameurl}" class="btn btn-sm bg-secondary bg-opacity-20 bg-opacity-40-hover text-heading text-opacity-80 text-opacity-100-hover font-bold rounded-pill ${caturl eq cat.nameurl ? 'active' : ''}">
                    <span class="h6">${cat.name}</span>
            </a>
            </c:forEach>
        </div>
        </div>
    </div>
</div>
<section class="py-3 bg-section-secondary ${layoutitem}">
<div class="container">
    <div class="row" id="products-list">
        <c:forEach var="product" items="${products}" varStatus="theCount">
            <div class="one-product-content ${colmdclass} ${colclass}">
                <%@ include file="ajax/product-box.jsp" %>
            </div>
        </c:forEach>
    </div>

    <c:if test="${not empty products && not empty totalItems && not empty maxPageItems && totalItems > maxPageItems}">
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <div id="pagination-container" class="mt-md-4"></div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty products}">
        <div class="row">
            <div class="col py-lg-32 py-md-32 py-sm-16 d-flex justify-content-center">
                <p><fmt:message key="label.product_empty"/></p>
            </div>
        </div>
    </c:if>
</div>
</section>

<div class="d-none">
    <input type="hidden" id="caturl" value="${caturl}">
    <input type="hidden" id="currentPage" value="${currentPage}">
    <input type="hidden" id="totalItems" value="${totalItems}">
    <input type="hidden" id="maxPageItems" value="${maxPageItems}">
</div>
<script language="JavaScript">
    $('.toggle-advance-filter').on('click',function(){
        if ($('.enet-products-filter-container.advance').length) {
            $('.enet-products-filter-container').removeClass('advance');
        } else {
            $('.enet-products-filter-container').addClass('advance');
        }
    });

	function getFilterValue(key, val) {
		if (val == null || val == undefined || val == '') {
			return '';
		}
		return '&' + key + "=" + val;
	}

	function loadPage(data, pagination){
		var url = window.location.origin + window.location.pathname;
		url += "?page=" + pagination;
		url += getFilterValue('minPrice',$('#formProductFilter input[name="minPrice"]').val());
		url += getFilterValue('maxPrice',$('#formProductFilter input[name="maxPrice"]').val());
		url += getFilterValue('q',$('#formProductFilter input[name="q"]').val());
		url += getFilterValue('caturl',$('#caturl').val());
		window.location.href = url;
    }
	$(document).ready(function () {
		if ($('#pagination-container').length) {
			$('#pagination-container').pagination({
				pageNumber: Number($('#currentPage').val()),
				pageSize: Number($('#maxPageItems').val()),
				showGoInput: false,
				showGoButton: false,
				showNavigator: false,
				dataSource: function (callback) {
					var result = [];
					for (var i = 1; i < Number($('#totalItems').val()); i++) {
						result.push(i);
					}
					callback(result);
				},
				afterNextOnClick: function (data, pagination){
					loadPage(data, pagination);
				},
				afterPreviousOnClick: function (data, pagination){
					loadPage(data, pagination);
				},
				afterPageOnClick: function(data, pagination) {
					loadPage(data, pagination);
				}
			});
		}
	});
</script>

<script type="text/javascript" src="/themes/grayscale/js/pagination/pagination.min.js"></script>
