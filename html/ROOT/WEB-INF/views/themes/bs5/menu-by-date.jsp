<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<style>
    .shippingdate-info.text-info {
        color: var(--primary-gradient-color) !important;
        font-size: 2rem;
    }
    .order-sidebar  .order-sidebar-item .cat-link {
        color: var(--primary-gradient-color);
    }
    .order-sidebar  .order-sidebar-item .cat-link.active {
        color: var(--primary-color);
        font-weight: 700;
    }
    @media (min-width: 768px) {
        .ajax-products-for-order .input-group {
            max-width: 160px !important;
        }
        .p-name {
            font-size: 1.5rem;
            font-weight: 500;
            margin-bottom: 0;
        }
        .p-description {
            font-size: 1rem;
            font-weight: 400;
            padding-top: 0;
        }
    }
    @media (max-width: 767px) {
        .order-sidebar{
            display: inline-flex;
            justify-content: space-between;
            max-width: 767px;
            overflow-x: scroll;
        }
        .order-sidebar .order-sidebar-item {
            white-space: nowrap;
        }
        .order-sidebar  .order-sidebar-item .cat-link.active {
            color: var(--primary-color);
            font-weight: 700;
        }
        .order-main-content {
            padding: 0.5rem;
        }
        .ajax-products-for-order .form-control {
            padding: 6px 4px;
            letter-spacing: .8px;
            font-weight: 400;
            height: 32px;
            font-size: 0.875rem;
        }
        .ajax-products-for-order .btn-sm {
            padding: 0.2rem .6rem;
            font-size: 0.875rem;
            height: 32px;
        }
        .ajax-products-for-order .input-group {
            max-width: 120px !important;
        }
        .p-name {
            font-size: 2rem;
            font-weight: 500;
            margin-bottom: 0;
        }
        .p-description {
            font-size: 1rem;
            font-weight: 400;
            padding-top: 0;
            padding-left: 0.5rem;
        }
    }
    @media (max-width: 480px) {
        .p-name {
            font-size: 1.6rem;
            font-weight: 500;
            margin-bottom: 0;
        }
        .p-description {
            font-size: 0.8rem;
            font-weight: 400;
            padding-top: 0;
            padding-left: 0.5rem;
        }
        .ajax-products-for-order .add-to-cart-btn {
            padding: 0.4rem .6rem;
            font-size: 0.66rem;
        }
    }
    .ajax-products-for-order .add-to-cart-btn {
        padding: .75rem 1.25rem;
        width: 100%;
    }
</style>
<div class="bg-gradient-primary" data-offset-top="#header-main">
</div>
<section class="slice bg-white">
    <div class="text-center">
        <h1>${page.name} <span class="px-3 select-a-date shippingdate-info text-info"></span></h1>
        ${page.content}
    </div>
    <div class="container-fluid">
        <div class="row flex-xl-nowrap">
            <div class="col-12 col-md-2 order-sidebar pl-0 pr-0">
                <c:forEach items="${categories}" var="cat" varStatus="theCount">
                    <div class="order-sidebar-item border-bottom p-3">
                       <span class="badge badge-pill badge-info mr-3">${theCount.count}</span>  <a href="javascript:void(0)" class="cat-link" data-cat="${cat.nameurl}"> ${cat.name}</a>
                    </div>
                </c:forEach>
            </div>
            <main class="col-12 col-md-10 py-md-3 pl-md-3" role="main">
                <div class="order-main-content ajax-products-for-order" id="ajax-products-for-order" maxN="16" query="" cat="">

                </div>
            </main>
        </div>
    </div>
</section>
<div class="modal fade" id="selectShippingdateModal" tabindex="-1" role="dialog" aria-labelledby="selectShippingdateModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 500px;">
        <div class="modal-content">
            <fmt:message var="datetxt" key="select.a-date"/>
            <div class="modal-header">
                <h4 class="modal-title" id="selectShippingdateModalLabel">${datetxt}</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <input type="text" class="form-control shippingdate" name="shippingdate" value="${shippingdate}" placeholder="${datetxt}">
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary continue-shippingdate-btn" type="button"><fmt:message key="booking.continue"/></button>
            </div>
        </div>
    </div>
</div>
