<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<section class="report-group">
    <div class="container-fluid">
        <form id="reportForm" action="/bo/report/zip.html" method="GET">
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
                    <select name="zip" class="form-control custom-select cus-zip">
                        <option value="">--<fmt:message key="label.ward"/>--</option>
                        <c:forEach items="${wards}" var="w">
                            <option value="${w.zip}" ${param.zip eq w.zip ? 'selected' : ''}>${w.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md-1">
                    <select class="form-control " name="status">
                        <option value=""><fmt:message key="status.all"/> </option>
                        <c:forEach var="st" items="${statuses}">
                            <option value="${st}" ${param.status eq st ? 'selected' : ''}><fmt:message key="${st}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md-3">
                    <button type="submit" class="btn btn btn-outline-secondary mr-2">Report</button>
                    <a href="#" class="btn btn-success btn-export-zip"><i class="fa fa-download"></i> Export to Exel</a>
                </div>
            </div>
        </form>

        <div class="row">
            <div class="col-12">
                <table class="table table-striped">
                    <thead class="blue">
                    <tr>
                        <th><fmt:message key="label.city"/> </th>
                        <th><fmt:message key="label.ward"/> </th>
                        <th class="text-right"><fmt:message key="booking.total_amount"/></th>
                        <c:forEach items="${products}" var="product">
                            <th>${product.name}</th>
                        </c:forEach>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="tr-summay-group bg-warning">
                        <td colspan="2">
                            <fmt:message key="menu.title.summary_report"/>
                        </td>
                        <td class="text-right"><span class="finalamount"><fmt:formatNumber value="${sumaryRecord.totalamount}" maxFractionDigits="0"/></span></td>
                        <c:forEach items="${products}" var="product">
                            <td>${sumaryRecord.pquantityMap[product.productid]}</td>
                        </c:forEach>
                    </tr>
                    <c:forEach items="${records}" var="rc">
                        <tr class="tr-zip" data-zip="${rc.zip}">
                            <td>
                                <a href="/my/booking.html?city=${rc.citycode}&status=PENDING&fromreport=true" class="groupname">${rc.citycode}</a>
                            </td>
                            <td>
                                <a href="/my/booking.html?zip=${rc.zip}&city=${rc.citycode}&status=PENDING&fromreport=true" class="groupname">${rc.name}</a>
                            </td>
                            <td class="text-right"><span class="finalamount"><fmt:formatNumber value="${rc.totalamount}" maxFractionDigits="0"/></span></td>
                            <c:forEach items="${products}" var="product">
                                <td class="g-${rc.zip}-product-${product.productid}">${rc.pquantityMap[product.productid]}</td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                    <tr class="tr-summay-group bg-warning">
                        <td colspan="2">
                            <fmt:message key="menu.title.summary_report"/>
                        </td>
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
