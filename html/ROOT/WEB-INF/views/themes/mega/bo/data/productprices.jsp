<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-4">
    <div class="mg-sec-title">
        <h1 class="title"><fmt:message key="product.prices"/></h1>
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
                        <th><fmt:message key="price.info"/></th>
                        <th><fmt:message key="price.info-local-lang"/></th>
                        <th><fmt:message key="price.unitquantity"/></th>
                        <th><fmt:message key="strikeprice"/></th>
                        <th><fmt:message key="price"/></th>
                        <th><fmt:message key="price.numofavailable"/></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${productprices}" var="em">
                        <tr id="item_${em.productpriceid}">
                            <td class="item_description">${em.description}</td>
                            <td class="item_descriptionvi">${em.descriptionvi}</td>
                            <td class="item_unitquantity">${em.unitquantity}</td>
                            <td class="item_strikeprice">${em.strikeprice}</td>
                            <td class="item_price">${em.price}</td>
                            <td class="item_numofavailable">${em.numofavailable}</td>
                            <td>
                                <a href="#" class="pr-2" onclick="javascript:editContent(${em.productpriceid});">Edit </a>
                                |
                                <a href="#" class="pl-2" onclick="javascript:deleteItem(${em.productpriceid});"> <i class="fa fa-trash" aria-hidden="true"></i></a>
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
     aria-labelledby="formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit <fmt:message key="price"/></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/bo/data/${product.productid}/productpriceForm.html" method="post" id="itemForm">
                    <input type="hidden" name="productpriceid" value="0">
                    <input type="hidden" name="action" value="ae">
                    <div class="form-group">
                        <label><fmt:message key="price.info"/></label>
                        <input name="description" class="form-control" type="text" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="price.info-local-lang"/></label>
                        <input name="descriptionvi" class="form-control" type="text" maxlength="255">
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.size"/></label>
                            <input class="form-control" list="sizeDatalistOptions" id="size" name="size" placeholder="Type to search...">
                            <datalist id="sizeDatalistOptions">
                                <c:forEach items="${sizes}" var="size">
                                    <option value="${size.id}" label="${size.name}">
                                </c:forEach>
                            </datalist>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.color"/></label>
                            <input class="form-control" list="colorDatalistOptions" id="color" name="color" placeholder="Type to search...">
                            <datalist id="colorDatalistOptions">
                                <c:forEach items="${colors}" var="color">
                                    <option value="${color.id}" label="${color.name}">
                                </c:forEach>
                            </datalist>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="unitquantity"/></label>
                            <input name="unitquantity" class="form-control" type="number">
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="strikeprice"/></label>
                            <input name="strikeprice" class="form-control" type="number">
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="price"/></label>
                            <input name="price" class="form-control" type="number">
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="price.numofavailable"/></label>
                            <input name="numofavailable" class="form-control" type="number" value="0">
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
