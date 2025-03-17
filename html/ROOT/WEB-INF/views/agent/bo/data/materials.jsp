<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="py-4">
    <div class="product-container">
        <div class="row">
            <div class="col-md-6">
                <h1><fmt:message key="label.materials"/></h1>
            </div>
            <div class="col-md-6 text-end">
                <a class="btn btn-warning float-right" href="/bo/data/products.html">Go to page products</a>
                <button class="btn btn-primary float-right" onclick="addContent()">Add</button>
            </div>
        </div>
        <div class="mt-3">
            <div class="table-responsive table-responsive-last">
                <table id="materials_table" class="table table-borderless table-striped">
                    <thead class="table-light">
                    <tr>
                        <th><fmt:message key="material.code"/></th>
                        <th><fmt:message key="material.name"/></th>
                        <th><fmt:message key="namevi"/></th>
                        <th><fmt:message key="purchase.price"/></th>
                        <th><fmt:message key="label.product.unit"/></th>
                        <th><fmt:message key="label.product.quantity"/></th>
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
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog" aria-labelledby=formContentModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Form <fmt:message key="label.material"/></h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form method="post" id="itemForm">
                    <input type="hidden" name="materialid" value="0"/>
                    <div class="row">
                        <div class="form-group col-4">
                            <label>Code</label>
                            <input name="code" class="form-control" maxlength="255"/>
                        </div>
                        <div class="form-group col-8">
                            <label>Name</label>
                            <input name="name" class="form-control" maxlength="255"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.product.namevi"/></label>
                            <input name="namevi" class="form-control" maxlength="255"/>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.product.category"/></label>
                            <select name="categoryurl" class="form-control">
                                <c:forEach var="ct" items="${categories}">
                                    <option value="${ct.nameurl}">${ct.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.product.quantity"/></label>
                            <input name="quantity" class="form-control" type="number" value="1" />
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.product.unit"/></label>
                            <select name="unit" class="form-control">
                                <c:forEach var="ct" items="${units}">
                                    <option value="${ct.name}">${ct.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="purchase.price"/></label>
                            <input name="price" class="form-control" type="number" value="10"/>
                        </div>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" name="visible" class="form-check-input"/>
                        <label class="form-check-label">Visible</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="itemFormSubmit()">Save</button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
