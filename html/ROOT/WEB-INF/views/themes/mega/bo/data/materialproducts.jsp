<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    .modal {
        z-index: 1001;
    }
    .modal-backdrop {
        z-index: 1000;
    }

</style>
<div class="container mt-2 mb-4">
    <div class="product-container">
        <div class="row">
            <div class="col-lg-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                        <li class="breadcrumb-item active">Material Product</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row">

            <div class="col-md-6">
                <h1>Materials Product '${product.name}'</h1>
            </div>
            <div class="col-md-6 text-end">
                <button class="btn btn-primary float-right" onclick="addMaterialProduct()">Add</button>
            </div>
        </div>
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table id="materialproducts_table" class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th>ID</th>
                        <th><fmt:message key="label.product.code"/></th>
                        <th><fmt:message key="label.product.namevi"/></th>
                        <th><fmt:message key="label.product.quantity"/></th>
                        <th><fmt:message key="booking.inputprice"/></th>
                        <th><fmt:message key="booking.inputprice"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <!--  -->
        <ul class="pagination pull-right">
            <c:if test="${items.hasPrevious}">
                <li><a href="#"><i class="fa fa-play arrow-left"></i></a></li>
            </c:if>
            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                <li><a ${items.page eq loop.count?'class="current"':''} href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
            </c:forEach>
            <c:if test="${items.hasNext}">
                <li><a href="#"><i class="fa fa-play arrow-right"></i></a></li>
            </c:if>
        </ul>
    </div>
</div>
<div class="modal fade" id="formMaterialProductModal" tabindex="-1" role="dialog"
     aria-labelledby=formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit <fmt:message key="label.product"/></h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form method="post" id="itemMaterialProductForm">
                    <input type="hidden" name="productid" value="${productid}"/>
                    <div class="row">
                        <div class="form-group col">
                            <label>Material</label>
                            <select name="materialid" id="selectMaterialid" class="form-control" style="width: 100%;height: 38px;" ></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="itemMaterialProductSubmit()">Save</button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="d-none" id="js_productid">${productid}</div>
