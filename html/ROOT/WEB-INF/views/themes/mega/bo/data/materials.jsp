<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="py-4">
    <div class="product-container">
        <div class="row">
            <div class="col-lg-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                        <li class="breadcrumb-item active">Materials</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row">

            <div class="col-md-6">
                <h1>Materials</h1>
            </div>
            <div class="col-md-6 text-end">
                <a class="btn btn-warning float-right" href="/bo/data/products.html">Go to page products</a>
                <button class="btn btn-primary float-right" onclick="addContent()">Add</button>
            </div>
        </div>
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table id="materials_table" class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th><fmt:message key="label.product.code"/></th>
                        <th><fmt:message key="label.product.name"/></th>
                        <th><fmt:message key="label.product.namevi"/></th>
                        <th><fmt:message key="price"/></th>
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
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby=formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit <fmt:message key="label.product"/></h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form method="post" id="itemForm">
                    <input type="hidden" name="productid" value="0"/>
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
                            <label>Price</label>
                            <input name="price" class="form-control" type="number" value="10"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="checkbox" name="visible" class=""/>
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
