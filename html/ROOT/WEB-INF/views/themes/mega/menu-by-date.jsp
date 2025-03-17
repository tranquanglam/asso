<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<style>
    .order-sidebar  .order-sidebar-item .cat-link {
        color: #01c4ff;
    }
    .order-sidebar  .order-sidebar-item .cat-link.active {
        color: #0913ff;
    }
    @media (min-width: 768px) {

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
            color: #0913ff;
        }
        .order-main-content {
            padding: 0.5rem;
        }
    }
</style>
<section class="slice bg-gradient-primary" data-offset-top="#header-main">
</section>
<section class="slice bg-white">
    <div class="text-center my-2">
        <h1>${page.name}</h1>
        ${page.content}
    </div>
    <div class="container-fluid">
        <div class="row flex-xl-nowrap">
            <div class="col-12 col-md-2 order-sidebar pl-0 pr-0">
                <div class="order-sidebar-item border-bottom p-3">
                    <a class="select-a-date"><i class="fas fa-calendar-day"></i> <span class="badge badge-info shippingdate-info"></span></a>
                </div>
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
