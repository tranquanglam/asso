<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="currency" value="đ"/>
<c:set var="currencyrate" value="1"/>
<c:set var="maxF" value="0"/>
<c:if test="${site.agent.currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="currency" value="USD"/>
</c:if>

<div class="mybooking mt-2 mb-4">
    <div class="booking-container">
        <div class="row mt-4 p-3">
            <div class="col-md-9">
                <h1><fmt:message key="material.output"/></h1>
            </div>
            <div class="col-md-3 text-right">
                <form id="myBookingForm" class="form-inline mr-auto" action="/my/booking.html" method="post">
                    <div class="input-group">
                        <input name="orderNumber" placeholder="booking number" maxlength="64" class="form-control"/>
                        <button type="submit" class="btn btn-secondary"><i class="bi bi-search"></i></button>
                    </div>
                    <input name="page" type="hidden" value="1"/>
                </form>
            </div>
        </div>
        <div class="row mt-4 d-none">
            <div class="col-sm-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><fmt:message key="booking.order_info"/></h5>
                        <p class="card-text"><fmt:message key="booking.number"/>: ${booking.ordernumber}</p>
                        <security:authorize
                                access="hasAnyAuthority('AGT_ADMIN','AGT_SUSER','AGT_USER','PM','ASSISTANT','CASHIER')">
                            <p class="card-text"><fmt:message key="booking.booker"/>: ${booking.booker}</p>
                        </security:authorize>
                        <p class="card-text"><fmt:message key="booking.order-date"/>: <fmt:formatDate type="both"
                                                                                                      value="${booking.orderdate}"/></p>
                        <p class="card-text"><fmt:message key="booking.status"/>: <span
                                class="status ${booking.status}"><fmt:message key="${booking.status}"/></span></p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><fmt:message key="booking.customer.info"/></h5>
                        <p class="card-text"><fmt:message key="booking.customer.full_name"/>: ${customer.fullname}</p>
                        <p class="card-text"><fmt:message key="booking.customer.email"/>: ${customer.email} /
                            <span><fmt:message key="booking.customer.phone"/>: ${customer.phone}</span></p>
                        <p class="card-text"><span><fmt:message key="label.address"/>: ${customer.address} </span></p>
                        <div class="card-text d-flex justify-content-between">
                            <span><fmt:message key="label.ward"/>: ${customer.wardName}</span>
                            <span><fmt:message key="label.city"/>: ${customer.cityName} / ${customer.statecode}</span>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${not empty booking.specialrequest}">
                <div class="col-12 mt-4">
                    <strong><fmt:message key="booking.customer.special_request"/>:</strong>
                        ${booking.specialrequest}
                </div>
            </c:if>
        </div>

        <div class="box-table">
            <div class="p-3">
                <h2>Phiếu xuất kho</h2>
            </div>

            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th>Tên nguyên liệu</th>
                        <th>Số lô xuất</th>
                        <th>Số lượng xuất</th>
                        <th>Số lượng tồn</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${materialOutputs}" var="materialOutput">
                        <tr>
                            <td>${materialOutput.materialinput.material.name}</td>
                            <td>${materialOutput.materialinput.slotno}</td>
                            <td>${materialOutput.quantity}</td>
                            <td>${materialOutput.materialinput.qtyinstock}/${materialOutput.materialinput.quantity}</td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>

        <div class="row my-3">
            <div class="col-12">
                <div class="d-flex justify-content-end">
                    <div>
                        <button class="btn btn-primary js-action-edit">Chỉnh sửa phiếu xuất kho</button>
                    </div>
                </div>
            </div>
        </div>

        <div id="editMaterialOutputForm" class="d-none">
            <div class="box-table mt-4">
                <c:forEach items="${booking.customerorderitems}" var="item">
                    <div class="p-3">
                        <h2 class="mb-2">Cập nhật phiếu xuất kho</h2>

                        <div class="row">
                            <div class="col-2">Sản phẩm cần xuất:</div>
                            <div class="col-10">${item.productname} - ${item.description}</div>
                        </div>
                        <div class="row">
                            <div class="col-2">Số lượng cần xuất:</div>
                            <div class="col-10">
                                <div id="item_quantity">${item.quantity}</div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive table-responsive-last">
                        <table class="table table-borderless "
                               id="table-item-${item.customerorderitemid}-material-${material.materialid}">
                            <thead class="blue">
                            <tr>
                                <th>Mã lô nhập</th>
                                <th>Ngày hết hạn</th>
                                <th>Ngày sản xuất</th>
                                <th>Tồn kho</th>
                                <th>Số lượng muốn xuất</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${materialOutputs}" var="materialOutput">
                                <c:set var="materialinput" value="${materialOutput.materialinput}"/>
                                <%--<c:set var="material" value="${materialOutput.materialinput.material}"/>--%>
                                <c:if test="${not empty materialOutput.materialinput  && materialOutput.signed == 1 }">
                                    <tr>
                                        <td width="30%">
                                            <select
                                                    class="js-material-input w-100"
                                                    data-customerorderitemid="${item.customerorderitemid}"
                                                    data-materialid="${material.materialid}"
                                                    data-quantity="${item.quantity}">
                                                <option value="-1">Chọn lô nhập hàng</option>
                                            </select>
                                        </td>
                                        <td><span class="expdate"></span></td>
                                        <td><span class="mfgdate"></span></td>
                                        <td><span class="qtyinstock"></span></td>
                                        <td><input type="number" name="quantity"
                                                   class="form-control js-material-input-quantity"></td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            <c:forEach begin="0" end="${5-materialOutputs.size()}" step="1">
                                <tr>
                                    <td width="30%">
                                        <select
                                                class="js-material-input w-100"
                                                data-customerorderitemid="${item.customerorderitemid}"
                                                data-materialid="${mapMaterialProduct[item.productid].material.materialid}"
                                                data-quantity="${item.quantity}">
                                            <option value="-1">Chọn lô nhập hàng</option>
                                        </select>
                                    </td>
                                    <td><span class="expdate"></span></td>
                                    <td><span class="mfgdate"></span></td>
                                    <td><span class="qtyinstock"></span></td>
                                    <td><input type="number" name="quantity"
                                               class="form-control js-material-input-quantity">
                                    </td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </c:forEach>

            </div>

            <div class="row my-3">
                <div class="col-12">
                    <div class="d-flex justify-content-end">
                        <div class="actions">
                            <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                                <button class="btn btn-primary px-3 js-submit-material-output">Submit Material Output
                                </button>
                            </security:authorize>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>
<div class="modal fade" id="actionFormModal" tabindex="-1" role="dialog" aria-labelledby="actionFormModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="actionFormModalLabel"></h3>
            </div>
            <div class="modal-body">
                <form method="post" id="actionForm">
                    <input type="hidden" name="action" value="">

                    <%--
                    <div class="form-group">
                        <label id="paymentinfoLabel">Infomation</label>
                        <input type="text" class="form-control" name="paymentinfo" maxlength="255" value="">
                    </div>--%>

                    <div class="form-group">
                        <label id="paymentinfoLabel">Infomation</label>
                        <input type="text" class="form-control" name="paymentinfo" maxlength="255" value="">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-success btn-action-submit">Submit</button>
                <button class="btn btn-info" data-bs-dismiss="modal" aria-hidden="true">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="d-none">
    <div id="load-ordernumber">${booking.ordernumber}</div>
</div>
