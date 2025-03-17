<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-4">
    <div class="mg-sec-title">
        <h1 class="title"><fmt:message key="product.features"/></h1>
    </div>
</div>
<div class="mt-2 mb-4">
    <div class="medicine-container">
        <div class="row">
            <div class="col-md-9">
                ${product.name} - ${product.manufacturer.name}
            </div>
            <div class="col-md-3">
                <button class="btn btn-primary float-right" onclick="addContent()">Add</button>
            </div>
        </div>
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th>Code</th>
                        <th>Name</th>
                        <th>Lang</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${productfeatures}" var="em">
                        <tr id="item_${em.productfeatureid}">
                            <td class="item_description">${em.code}</td>
                            <td class="item_descriptionvi">${em.name}</td>
                            <td class="item_unitquantity">${em.lang}</td>
                            <td>
                                <a href="#" class="pr-2" onclick="javascript:editContent(${em.productfeatureid});">Edit </a>
                                |
                                <a href="#" class="pl-2" onclick="javascript:deleteItem(${em.productfeatureid});"> <i class="fa fa-trash" aria-hidden="true"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
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
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit features</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/bo/data/${product.productid}/productfeatureForm.html" method="post" id="itemForm">
                    <input type="hidden" name="productfeatureid" value="0">
                    <input type="hidden" name="action" value="ae">
                    <div class="form-group">
                        <label></label>
                        <p><fmt:message key="feature.product"/>: ${product.name}</p>
                    </div>

                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="feature.name"/></label>
                            <input name="name" class="form-control" type="text">
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="feature.code"/></label>
                            <input name="code" class="form-control" type="text">
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="feature.lang"/></label>
                            <select name="lang" id="selLang" class="form-control">
                                <option value="">All languages</option>
                                <c:forEach items="${langs}" var="lang">
                                    <option value="${lang}">${lang}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            Properties
                            <table id="tableProductFeature" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Code</th>
                                        <th>Name</th>
                                        <th>Visible</th>
                                        <th><button class="btn btn-primary" onclick="addFormFeatureValue(event)">Add</button></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Auto generate</td>
                                    <td><input name="jvalueDTO.items[0].name" class="form-control" type="text"></td>
                                    <td><input name="jvalueDTO.items[0].visible" class="form-control" type="checkbox"></td>
                                    <td><button class="btn btn-danger" onclick="deleteFeatureValue(event)">Delete</button></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="itemFormSubmit()">Save</button>
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="d-none " id="load-productid">${product.productid}</div>
