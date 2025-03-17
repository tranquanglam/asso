<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<header>
    <div class="">
        <div class="border-bottom pt-6">
            <div class="row align-items-center">
                <div class="col-sm col-12">
                    <h1 class="h2 ls-tight">
                        <fmt:message key="purchase.material"/>
                    </h1>
                </div>

                <div class="col-sm-auto col-12 mb-1">
                    <div class="hstack gap-2 justify-content-sm-end">
                        <security:authorize access="hasAnyAuthority('AGT_ADMIN', 'INPUT_W')">
                            <a class="btn btn-sm btn-primary" href="/bo/data/material-input-form.html"> <fmt:message key="title.add"/> </a>
                        </security:authorize>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>


<div class="py-4">
    <div class="product-container">
        <div class="my-3  vstack gap-4 ">
            <div class="d-flex flex-column flex-md-row gap-3 justify-content-between">

                <div class="d-flex gap-3">
                    <form id="materialInputFilterForm" method="post" >
                        <div class="row">
                            <div class="form-group col-md-3 col-6">
                                <input class="form-control datepicker bg-light" name="fromDate" placeholder="<fmt:message  key="detail.fromdate"/>" autocomplete="off"/>
                            </div>
                            <div class="form-group col-md-3 col-6">
                                <input class="form-control datepicker bg-light" name="toDate" placeholder="<fmt:message  key="detail.enddate"/>" autocomplete="off"/>
                            </div>
                            <div class="form-group col-md col-6">
                                <c:set var="mdc"><fmt:message key='label.search'/> <fmt:message key='purchase.number'/></c:set>
                                <input  name="purchasenumber" placeholder="${mdc}" maxlength="64" class="form-control"/>
                            </div>
                            <div class="form-group col-md col-6">
                                <button type="submit" class="btn btn-secondary w-100"><i class="bi bi-search"></i></button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="btn-group">

                </div>
            </div>

            <div class="card">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto"><fmt:message key="material.input"/></h5>
                </div>
                <div class="box-table">
                    <div class="table-responsive table-responsive-last">
                        <table id="materialinput_table" class="table table-borderless table-striped">
                            <thead class="table-light">
                            <tr>
                                <th><fmt:message key="label.branch"/></th>
                                <th><fmt:message key="purchase.number"/></th>
                                <th><fmt:message key="label.material"/></th>
                                <th><fmt:message key="label.providers"/></th>
                                <th><fmt:message key="label.manufacturer"/></th>
                                <th><fmt:message key="slotno"/></th>
                                <th><fmt:message key="input.date"/></th>
                                <th><fmt:message key="exp.date"/></th>
                                <th><fmt:message key="purchase.price"/></th>
                                <th><fmt:message key="label.product.quantity"/></th>
                                <th>VAT</th>
                                <th><fmt:message key="booking.total_amount"/></th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-10 text-end"> <fmt:message key="booking.total_amount"/></div>
                        <div class="col-2 text-end"><span id="totalAmount" class="font-weight-bold"></span></div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<security:authorize access="hasAnyAuthority('AGT_ADMIN', 'INPUT_W')">
    <div class="modal fade" id="formMaterialInputModal" tabindex="-1" role="dialog" aria-labelledby="formContentModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="formContentModalLabel"><fmt:message key="purchase.material"/></h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form method="post" id="itemMaterialInputForm">
                        <input type="hidden" name="materialinputid" value="0"/>
                        <div class="row">
                            <div class="form-group col-12">
                                <label><fmt:message key="label.material"/></label>
                                <select name="materialid" id="selectMaterialid" placeholder="<fmt:message key="label.material"/>" class="form-control form-select"></select>
                            </div>
                            <div class="form-group col-12">
                                <label><fmt:message key="purchase.number"/></label>
                                <input name="purchasenumber" class="form-control"  type="text" value="" />
                            </div>
                            <div class="form-group col-12">
                                <label><fmt:message key="label.branch"/></label>
                                <select name="branchid" class="form-control form-select select-branchid">
                                    <c:if test="${not empty branches}">
                                        <c:forEach var="branch" items="${branches}">
                                            <option value="${branch.branchid}">${branch.name}</option>
                                        </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                            <div class="form-group col-12">
                                <label><fmt:message key="label.providers"/></label>
                                <select name="providercode" class="form-control form-select select-companyid">
                                    <c:if test="${not empty companies}">
                                        <c:forEach var="cm" items="${companies}">
                                            <option value="${cm.companycode}">${cm.name}</option>
                                        </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-12">
                                <label><fmt:message key="label.manufacturer"/></label>
                                <select name="manufacturerid" class="form-control">
                                    <c:forEach var="ct" items="${manufacturers}">
                                        <option value="${ct.manufacturerid}">${ct.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group col-12">
                                <label><fmt:message key="slotno"/></label>
                                <input name="slotno" class="form-control" type="text" value="" />
                            </div>
                            <div class="form-group col-12">
                                <label><fmt:message key="input.date"/></label>
                                <input name="inputtime" class="form-control datepicker bg-light" type="text" value=""/>
                            </div>
                            <div class="form-group col-12">
                                <label><fmt:message key="exp.date"/></label>
                                <input name="expdate" class="form-control datepicker bg-light" type="text" value=""/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-12">
                                <label><fmt:message key="label.product.quantity"/></label>
                                <input name="quantity" class="form-control" type="number" value="1" />
                            </div>
                            <div class="form-group col-12">
                                <label><fmt:message key="purchase.price"/></label>
                                <input name="price" class="form-control" type="number" />
                            </div>
                            <div class="form-group col-12">
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
</security:authorize>
