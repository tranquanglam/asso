<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Enet Store</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-10">
            <h1>Enet Store</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="card bg-dark text-white my-3">
                <div class="card-body">
                    <form id="enetStoreFilterForm" class="form-inline" role="form" action="/agent/enetstore/products.html">
                        <div class="row">
                            <div class="form-group col-md">
                                <select name="categoryurl" id="categoryurl" class="form-control">
                                    <option value="landing-page" ${categoryurl eq 'landing-page' ? 'selected':''}>Landing Page</option>
                                    <option value="sform" ${categoryurl eq 'sform' ? 'selected':''}>Sform</option>
                                </select>
                            </div>
                            <div class="form-group col-md">
                                <input type="text" class="form-control" name="q" value="${q}" placeholder="Keyword...">
                            </div>
                            <div class="form-group col-md">
                                <button type="button" class="btn btn-success btn-enetstore-search">Search</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row mt-4" id="products-list">
        <c:forEach var="product" items="${res.products}" varStatus="theCount">
            <div class="one-product-content col-md-4 col-6 mb-4">
                <div class="card border-0 shadow hover-translate-y-n10 hover-shadow-lg">
                    <img alt="${product.name}" class="card-img-top product-image" src="${product.image}">
                    <div class="card-body text-center py-3 px-1">
                        <h5 class="product-name card-title mb-0">${product.name}</h5>
                        <div class="product-price card-text text-danger"><fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2"/> ${product.currency}</div>
                    </div>
                    <div class="card-footer border-0 text-center px-0 py-2">
                        <div class="product-cart py-2"><a data-categoryurl="${product.categoryurl}" data-code="${product.code}" class="btn btn-sm btn-primary btn-icon rounded-pill btn-get-enet-product" href="javascript:void(0)"><span class="text-nowrap">Get</span> <span class="d-none d-md-inline"><i class="bi bi-download"></i></span></a></div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<div class="modal fade" id="pageModal" tabindex="-1" role="dialog" aria-labelledby="pageModalLabel">
    <div class="modal-dialog" role="document" style="width: 100%;max-width: 1920px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="pageModalLabel"></h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body" id="pageModalContent">

            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="previewPageModal" tabindex="-1" role="dialog" aria-labelledby="previewPageModalLabel">
    <div class="modal-dialog" role="document" style="width: 100%;max-width: 1920px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="previewPageModalLabel"></h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body" id="previewPageModalContent">
                <iframe id="previewProductIframe" src="/agent/enetstore/landing-page/landing-005/preview.html" title="description"></iframe>

            </div>
        </div>
    </div>
</div>

