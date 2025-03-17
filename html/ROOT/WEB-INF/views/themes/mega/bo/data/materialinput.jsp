<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    .modal {
        z-index: 1001;
    }
    .modal-backdrop {
        z-index: 1000;
    }

</style>
<div class="container mt-2 mb-4">
    <div class="product-container">
        <div class="row">
            <div class="col-lg-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                        <li class="breadcrumb-item active"><fmt:message key="purchase.material"/></li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <h1><fmt:message key="purchase.material"/></h1>
            </div>
            <div class="col-md-6 text-end">
                <button class="btn btn-primary" onclick="addMaterialInput()">Add</button>
            </div>
        </div>
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table id="materialinput_table" class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th>ID</th>
                        <th><fmt:message key="label.material"/></th>
                        <th><fmt:message key="label.manufacturer"/></th>
                        <th><fmt:message key="slotno"/></th>
                        <th><fmt:message key="exp.date"/></th>
                        <th><fmt:message key="price"/></th>
                        <th><fmt:message key="medquantity"/></th>
                        <th>VAT</th>
                        <th><fmt:message key="booking.total_amount"/></th>
                        <th><fmt:message key="date"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="formMaterialInputModal" tabindex="-1" role="dialog" aria-labelledby="formContentModalLabel">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">FORM <fmt:message key="purchase.material"/></h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form method="post" id="itemMaterialInputForm">
                    <input type="hidden" name="materialinputid" value="0"/>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="purchase.number"/></label>
                            <input name="purchasenumber" class="form-control" type="text" value="" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.material"/></label>
                            <select name="materialid" id="selectMaterialid" class="form-control" style="width: 100%;height: 38px;" ></select>
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
                            <label><fmt:message key="price"/></label>
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
                <button class="btn btn-primary" type="button" onclick="itemMaterialInputSubmit()">Save</button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
