<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="py-4">
    <div class="product-container">
        <div class="row">
            <div class="col-md-6">
                <h1><fmt:message key="materials.produce.product"/> '${product.name}'</h1>
            </div>
            <div class="col-md-6 text-end">
                <button class="btn btn-primary" onclick="addMaterialProduct()">Add</button>
            </div>
        </div>
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table id="materialproducts_table" class="table table-borderless table-striped">
                    <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th><fmt:message key="material.code"/></th>
                        <th><fmt:message key="material.name"/></th>
                        <th><fmt:message key="label.product.quantity"/></th>
                        <th><fmt:message key="booking.inputprice"/></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="formMaterialProductModal" tabindex="-1" role="dialog" aria-labelledby="formContentModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit <fmt:message key="label.material"/></h4>
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
