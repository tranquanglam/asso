<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    table.dataTable {
        margin-top: 0px !important;
    }

    div.dataTables_wrapper div.dataTables_paginate ul.pagination {
        margin-left: 10px;
        margin-right: 10px;
    }
</style>

<header>
    <div class="">
        <div class="border-bottom pt-6">
            <div class="row align-items-center">
                <div class="col-sm col-12">
                    <h1 class="h2 ls-tight">
                        <fmt:message key="material.output"/>
                    </h1>
                </div>

                <div class="col-sm-auto col-12 mb-1">
                    <div class="hstack gap-2 justify-content-sm-end">

                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="py-4">
    <div class="product-container">
        <div class="my-3  vstack gap-4 ">
            <div class="card">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto"><fmt:message key="material.output"/></h5>
                </div>
                <div class="box-table">
                    <div class="table-responsive table-responsive-last">
                        <table id="materialoutput_table" class="table table-borderless table-striped">
                            <thead class="table-light">
                            <tr>
                                <th><fmt:message key="label.branch"/></th>
                                <th><fmt:message key="label.material"/></th>
                                <th><fmt:message key="label.manufacturer"/></th>
                                <th><fmt:message key="slotno"/></th>
                                <th><fmt:message key="mfg.date"/></th>
                                <th><fmt:message key="exp.date"/></th>
                                <th><fmt:message key="label.product.quantity"/></th>
                                <th><fmt:message key="outputtime"/></th>
                                <th><fmt:message key="ordernumber"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="card-footer">

                </div>
            </div>
        </div>


    </div>
</div>
<div class="modal fade" id="formMaterialOutputModal" tabindex="-1" role="dialog" aria-labelledby="formContentModalLabel">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel"><fmt:message key="purchase.material"/></h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post" id="itemMaterialInputForm">
                    <input type="hidden" name="materialinputid" value="0"/>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="purchase.number"/></label>
                            <input name="purchasenumber" class="form-control" type="text" value="" />
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.material"/></label>
                            <select name="materialid" id="selectMaterialid" class="form-control form-select"></select>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.branch"/></label>
                            <select name="branchid" class="form-control form-select select-branchid">
                                <option value="0">---</option>
                                <c:if test="${not empty branches}">
                                    <c:forEach var="branch" items="${branches}">
                                        <option value="${branch.branchid}">${branch.name}</option>
                                    </c:forEach>
                                </c:if>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.manufacturer"/></label>
                            <select name="manufacturerid" class="form-control">
                                <c:forEach var="ct" items="${manufacturers}">
                                    <option value="${ct.manufacturerid}">${ct.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="slotno"/></label>
                            <input name="slotno" class="form-control" type="text" value="" />
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="mfg.date"/></label>
                            <input name="mfgdate" class="form-control datepicker" type="text" value=""/>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="exp.date"/></label>
                            <input name="expdate" class="form-control datepicker" type="text" value=""/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.product.quantity"/></label>
                            <input name="quantity" class="form-control" type="number" value="1" />
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="purchase.price"/></label>
                            <input name="price" class="form-control" type="number" />
                        </div>
                        <div class="form-group col">
                            <label>Tax %</label>
                            <input name="tax" class="form-control" type="number" value="10"/>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="itemMaterialInputSubmit(1)">Save & Sign</button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

