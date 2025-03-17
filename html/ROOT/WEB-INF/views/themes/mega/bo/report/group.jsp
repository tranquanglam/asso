<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<section class="report-group">
    <div class="container-fluid">
        <form id="reportForm" action="/bo/report/group.html" method="GET">
            <div class="row">
        <c:if test="${not empty states}">
            <div class="form-group form-group-state col-md-2">
                <select name="statecode" class="form-control custom-select cus-state">
                    <option value="">--<fmt:message key="label.state"/>--</option>
                    <c:forEach items="${states}" var="state">
                        <option value="${state.code}" ${param.statecode eq state.code ? 'selected' : ''}>${state.name}</option>
                    </c:forEach>
                </select>
            </div>
        </c:if>
        <div class="form-group form-group-city col-md-3">
            <select name="citycode" class="form-control custom-select cus-city">
                <option value="">--<fmt:message key="label.city"/>--</option>
                <c:forEach items="${cities}" var="ct">
                    <option value="${ct.code}" ${param.citycode eq ct.code ? 'selected' : ''}>${ct.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group col-md-3">
            <select class="form-control " name="status">
                <option value=""><fmt:message key="status.all"/> </option>
                <c:forEach var="st" items="${statuses}">
                    <option value="${st}" ${param.status eq st ? 'selected' : ''}><fmt:message key="${st}"/></option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group col-md-1">
            <select name="destype" class="form-control custom-select">
                <c:forEach items="${destypes}" var="destype">
                    <option value="${destype}" ${param.destype eq destype ? 'selected' : ''}><fmt:message key="${destype}"/></option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group col-md-3">
            <button type="submit" class="btn btn btn-outline-secondary mr-3">Report</button>
            <a href="#" class="btn btn-success btn-export-group"><i class="fa fa-download"></i> Export to Exel</a>
        </div>
            </div>
        </form>

        <div class="row">
            <div class="col-12">
                <table class="table table-striped">
                    <thead class="blue">
                    <tr>
                        <th><fmt:message key="pickup.destination"/> </th>
                        <th><fmt:message key="shipping.date"/></th>
                        <th class="text-right"><fmt:message key="shipping.fee"/></th>
                        <th class="text-right"><fmt:message key="booking.total_amount"/></th>
                        <c:forEach items="${products}" var="product">
                            <th>${product.name}</th>
                        </c:forEach>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="tr-summay-group bg-warning">
                        <td>
                            <fmt:message key="menu.title.summary_report"/>
                        </td>
                        <td></td>
                        <td class="text-right"><span class="shippingfee"><fmt:formatNumber value="${sumaryRecord.shippingfee}" maxFractionDigits="0"/></span></td>
                        <td class="text-right"><span class="finalamount"><fmt:formatNumber value="${sumaryRecord.totalamount}" maxFractionDigits="0"/></span></td>
                        <c:forEach items="${products}" var="product">
                            <td>${sumaryRecord.pquantityMap[product.productid]}</td>
                        </c:forEach>
                    </tr>
                    <c:forEach items="${records}" var="rc">
                        <tr class="tr-group" data-groupid="${rc.groupid}">
                            <td>
                                <a href="/my/group-booking.html?groupid=${rc.groupid}&status=PENDING" class="groupname">${rc.groupname}</a>
                            </td>
                            <td>
                                <a href="javascript:void(0)" data-groupid="${rc.groupid}" data-nextevent="${rc.shippingdate}" class="btn btn-link edit-shipping-date-link">${rc.shippingdate} <i class="fa fa-edit"></i></a>
                            </td>
                            <td class="text-right"><span class="shippingfee"><fmt:formatNumber value="${rc.shippingfee}" maxFractionDigits="0"/></span></td>
                            <td class="text-right"><span class="finalamount"><fmt:formatNumber value="${rc.totalamount}" maxFractionDigits="0"/></span></td>
                            <c:forEach items="${products}" var="product">
                                <td class="g-${rc.groupid}-product-${product.productid}">${rc.pquantityMap[product.productid]}</td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                    <tr class="tr-summay-group bg-warning">
                        <td>
                            <fmt:message key="menu.title.summary_report"/>
                        </td>
                        <td class="text-right"><span class="discount"><fmt:formatNumber value="${sumaryRecord.discount}" maxFractionDigits="0"/></span></td>
                        <td class="text-right"><span class="shippingfee"><fmt:formatNumber value="${sumaryRecord.shippingfee}" maxFractionDigits="0"/></span></td>
                        <td class="text-right"><span class="finalamount"><fmt:formatNumber value="${sumaryRecord.totalamount}" maxFractionDigits="0"/></span></td>
                        <c:forEach items="${products}" var="product">
                            <td>${sumaryRecord.pquantityMap[product.productid]}</td>
                        </c:forEach>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
<div class="d-none countryid">${country.countryid}</div>
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog" aria-labelledby="formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel"><fmt:message key="shipping.date"/></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/bo/report/group-set-nextevent.html" method="post" id="nexteventForm">
                    <input type="hidden" name="groupid" value="0">
                    <h5 class="groupname"></h5>
                    <div class="form-group">
                        <input name="nextevent" class="form-control nextevent" maxlength="255">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="nexteventFormSubmit()">Save</button>
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
