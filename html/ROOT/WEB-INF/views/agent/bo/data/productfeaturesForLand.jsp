<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<style>
    #formContentModal .table td {
        padding: 5px !important;
    }
</style>

<div class="mt-4">
    <div class="mg-sec-title">
        <h1 class="title"><fmt:message key="product.features"/></h1>
    </div>
</div>
<div class="mt-2 mb-4">
    <div class="medicine-container">
        <div class="row">
            <div class="col-md-9">
                <c:if test="${not empty product}">
                    ${product.name} - ${product.manufacturer.name}
                </c:if>

            </div>
            <div class="col-md-3">
                <c:if test="${empty productfeatures}">
                    <button class="btn btn-primary float-right" onclick="addContent()">Add</button>
                </c:if>
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
                                <a href="#" class="pl-2" onclick="javascript:deleteItem(${em.productfeatureid});"> Delete</a>
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
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/bo/data/${not empty product ? product.productid : 0}/productfeatureForm.html" method="post" id="itemForm">
                    <input type="hidden" name="productfeatureid" value="0">
                    <input type="hidden" name="action" value="ae">
                    <div class="form-group">
                        <label></label>
                        <c:if test="${not empty product}">
                            <p><fmt:message key="feature.product"/>: ${product.name}</p>
                        </c:if>
                    </div>

                    <div class="row">
                        <div class="form-group col">
                            <label>Code</label>
                            <input name="code" class="form-control" type="text" readonly value="feature-land-home-${product.productid}">
                        </div>

                        <div class="form-group col">
                            <label><fmt:message key="feature.name"/></label>
                            <input name="name" class="form-control" type="text" value="Feature land home">
                        </div>


                        <div class="form-group col">
                            <label><fmt:message key="feature.lang"/></label>
                            <select name="lang" id="selLang" class="form-control">
                                <option value="">All languages</option>
                                <c:forEach items="${langs}" var="lang">
                                    <option value="${lang}" ${lang eq 'vi' ? 'selected' : ''}>${lang}</option>
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
                                        <th>iconCss</th>
                                        <th>Content</th>
                                        <th>Ordernumber</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <c:set var="row" value="0"/>
                                    <td>${row + 1}</td>
                                    <td><input name="jvalueDTO.items[${row}].code" readonly class="form-control" type="text" value="feature-room"></td>
                                    <td><input name="jvalueDTO.items[${row}].name" readonly class="form-control" type="text" value="Phòng ngủ"></td>
                                    <td><input name="jvalueDTO.items[${row}].iconCss" class="form-control" type="text" value="flaticon-bed"></td>
                                    <td><input name="jvalueDTO.items[${row}].content" class="form-control" type="text" value=""></td>
                                    <td><input name="jvalueDTO.items[${row}].orderNumber" class="form-control" type="number" value=""></td>
                                </tr>
                                <tr>
                                    <c:set var="row" value="1"/>
                                    <td>${row + 1}</td>
                                    <td><input name="jvalueDTO.items[${row}].code" readonly class="form-control" type="text" value="feature-bath"></td>
                                    <td><input name="jvalueDTO.items[${row}].name" readonly class="form-control" type="text" value="Phòng tắm"></td>
                                    <td><input name="jvalueDTO.items[${row}].iconCss" class="form-control" type="text" value="flaticon-holidays"></td>
                                    <td><input name="jvalueDTO.items[${row}].content" class="form-control" type="text" value=""></td>
                                    <td><input name="jvalueDTO.items[${row}].orderNumber" class="form-control" type="number" value=""></td>
                                </tr>
                                <tr>
                                    <c:set var="row" value="${row + 1}"/>
                                    <td>${row + 1}</td>
                                    <td><input name="jvalueDTO.items[${row}].code" readonly class="form-control" type="text" value="feature-tv"></td>
                                    <td><input name="jvalueDTO.items[${row}].name" readonly class="form-control" type="text" value="TV"></td>
                                    <td><input name="jvalueDTO.items[${row}].iconCss" class="form-control" type="text" value="flaticon-monitor"></td>
                                    <td><input name="jvalueDTO.items[${row}].content" class="form-control" type="text" value=""></td>
                                    <td><input name="jvalueDTO.items[${row}].orderNumber" class="form-control" type="number" value=""></td>
                                </tr>
                                <tr>
                                    <c:set var="row" value="${row + 1}"/>
                                    <td>${row + 1}</td>
                                    <td><input name="jvalueDTO.items[${row}].code" readonly class="form-control" type="text" value="feature-airconditioning"></td>
                                    <td><input name="jvalueDTO.items[${row}].name" readonly class="form-control" type="text" value="Máy lạnh"></td>
                                    <td><input name="jvalueDTO.items[${row}].iconCss" class="form-control" type="text" value="flaticon-air-conditioner"></td>
                                    <td><input name="jvalueDTO.items[${row}].content" class="form-control" type="text" value=""></td>
                                    <td><input name="jvalueDTO.items[${row}].orderNumber" class="form-control" type="number" value=""></td>
                                </tr>
                                <tr>
                                    <c:set var="row" value="${row + 1}"/>
                                    <td>${row + 1}</td>
                                    <td><input name="jvalueDTO.items[${row}].code" readonly class="form-control" type="text" value="feature-area"></td>
                                    <td><input name="jvalueDTO.items[${row}].name" readonly class="form-control" type="text" value="Diện tích"></td>
                                    <td><input name="jvalueDTO.items[${row}].iconCss" class="form-control" type="text" value="flaticon-square-layouting-with-black-square-in-east-area"></td>
                                    <td><input name="jvalueDTO.items[${row}].content" class="form-control" type="text" value=""></td>
                                    <td><input name="jvalueDTO.items[${row}].orderNumber" class="form-control" type="number" value=""></td>
                                </tr>
                                <tr>
                                    <c:set var="row" value="${row + 1}"/>
                                    <td>${row + 1}</td>
                                    <td><input name="jvalueDTO.items[${row}].code" readonly class="form-control" type="text" value="feature-balcony"></td>
                                    <td><input name="jvalueDTO.items[${row}].name" readonly class="form-control" type="text" value="Ban công"></td>
                                    <td><input name="jvalueDTO.items[${row}].iconCss" class="form-control" type="text" value="flaticon-building"></td>
                                    <td><input name="jvalueDTO.items[${row}].content" class="form-control" type="text" value=""></td>
                                    <td><input name="jvalueDTO.items[${row}].orderNumber" class="form-control" type="number" value=""></td>
                                </tr>
                                <tr>
                                    <c:set var="row" value="${row + 1}"/>
                                    <td>${row + 1}</td>
                                    <td><input name="jvalueDTO.items[${row}].code" readonly class="form-control" type="text" value="feature-pool"></td>
                                    <td><input name="jvalueDTO.items[${row}].name" readonly class="form-control" type="text" value="Hồ tắm"></td>
                                    <td><input name="jvalueDTO.items[${row}].iconCss" class="form-control" type="text" value="flaticon-people-2"></td>
                                    <td><input name="jvalueDTO.items[${row}].content" class="form-control" type="text" value=""></td>
                                    <td><input name="jvalueDTO.items[${row}].orderNumber" class="form-control" type="number" value=""></td>
                                </tr>
                                </tbody>
                            </table>
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
<div class="d-none " id="load-productid">${product.productid}</div>
