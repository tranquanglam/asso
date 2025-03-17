<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-2 mb-4">
    <div class="product-container">
        <div class="row">
            <div class="col-md-6">
                <form:form id="myForm" cssClass="form-inline" action="/bo/data/products.html" method="post" commandName="mineBean">
                    <div class="form-group mr-2">
                        <form:select path="categoryurl" cssClass="form-control">
                            <option value=""><fmt:message key="label.product.category"/></option>
                            <c:forEach var="ct" items="${categories}">
                                <form:option value="${ct.nameurl}">${ct.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="form-group mr-2">
                        <c:set var="mdc"><fmt:message key='label.product'/></c:set>
                        <form:input  path="searchTerm" placeholder="${mdc}" maxlength="64" cssClass="form-control"/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-info"><span><fmt:message key="label.search"/> </span></button>
                    </div>
                    <form:hidden path="page" id="formPage"/>
                </form:form>
            </div>
            <div class="col-md-6">
                <button class="btn btn-primary float-right" onclick="addContent()">Add</button>
            </div>
        </div>
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th><fmt:message key="label.product.code"/></th>
                        <th><fmt:message key="label.product.name"/></th>
                        <th><fmt:message key="label.product.namevi"/></th>
                        <th><fmt:message key="label.product.quantity"/></th>
                        <th><fmt:message key="label.product.unit"/></th>
                        <th><fmt:message key="price"/></th>
                        <th><fmt:message key="booking.inputprice"/></th>
                        <th><fmt:message key="weight"/></th>
                        <th><fmt:message key="label.product.category"/></th>
                        <th><fmt:message key="label.manufacturer"/></th>
                        <th><fmt:message key="label.visible"/></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${items.listResult}" var="em">
                        <tr id="item_${em.productid}" class="item-${em.visible}">
                            <td class="item_code">${em.code}</td>
                            <td class="item_name text-primary">${em.name}</td>
                            <td class="item_namevi">${em.namevi}</td>
                            <td class="item_quantity">${em.quantity}</td>
                            <td class="item_unit">${em.unit}</td>
                            <td class="item_price">${em.price}</td>
                            <td class="item_price">${em.inputprice}</td>
                            <td class="item_weight">${em.weight}</td>
                            <td class="item_categoryurl">${em.categoryurl}</td>
                            <td class="item_manufacturer" data-manufacturerid="${em.manufacturer.manufacturerid}">${em.manufacturer.name}</td>
                            <td class="item_visible">${em.visible}</td>
                            <td>
                                <a href="/bo/data/${em.productid}/productprices.html"><fmt:message key="price"/></a>
                                | <a href="/bo/data/${em.productid}/productForm.html">Edit</a>
                                | <a href="/agent/sites/${site.siteid}/pages/product/${em.code}/description">Description</a>
                                | <a href="/bo/data/${em.productid}/productfeatures.html">Features</a>
                                | <a href="/bo/data/${em.productid}/productmaterials.html">Materials</a>
                            </td>
                        </tr>
                    </c:forEach>
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
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby=formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit <fmt:message key="label.product"/></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/bo/data/productForm.html" method="post" id="itemForm">
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
                        <div class="form-group col">
                            <label><fmt:message key="label.manufacturer"/></label>
                            <select name="manufacturer.manufacturerid" class="form-control">
                                <c:forEach var="ct" items="${manufacturers}">
                                    <option value="${ct.manufacturerid}">${ct.name}</option>
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
