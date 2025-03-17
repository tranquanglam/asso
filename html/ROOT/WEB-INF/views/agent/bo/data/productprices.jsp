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
            <div class="col-md-3 text-end">
                <security:authorize access="hasAnyAuthority('AGT_ADMIN','PRODUCT_W')">
                    <button class="btn btn-primary" onclick="addContent()">Add</button>
                </security:authorize>
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
                        <th><fmt:message key="label.size"/></th>
                        <th><fmt:message key="label.color"/></th>
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
                            <td class="item_size">
                                <div class="item_sizeid d-none">${em.sizeid}</div>
                                    ${sizeMap[em.sizeid].name}
                            </td>
                            <td class="item_color">
                                <div class="item_colorid d-none">${em.colorid}</div>
                                <span class="badge" style=" background-color: ${colorMap[em.colorid].code}">${colorMap[em.colorid].name}</span>
                            </td>
                            <td class="item_strikeprice">${em.strikeprice}</td>
                            <td class="item_price">${em.price}</td>
                            <td class="item_numofavailable">${em.numofavailable}</td>
                            <td>
                                <security:authorize access="hasAnyAuthority('AGT_ADMIN','PRODUCT_W')">
                                    <a href="#" class="btn btn-sm btn-neutral pr-2" onclick="javascript:editContent(${em.productpriceid});">Edit </a>
                                    <a href="#" class="btn btn-sm btn-neutral" onclick="javascript:deleteItem(${em.productpriceid});"> <i class="bi bi-trash"></i></a>
                                </security:authorize>
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
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
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
                            <select class="form-select" id="size" name="sizeid">
                                <option value="">-</option>
                                <c:forEach items="${sizes}" var="size">
                                    <option value="${size.sizeid}">${size.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.color"/></label>
                            <select class="form-select" id="color" name="colorid">
                                <option value="">-</option>
                                <c:forEach items="${colors}" var="color">
                                    <option value="${color.colorid}">${color.name}</option>
                                </c:forEach>
                            </select>
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
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
