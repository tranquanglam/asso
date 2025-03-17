<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<section class="report-group">
    <div class="container-fluid">
        <form id="reportForm" action="/bo/report/booker.html" method="GET">
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
                <h3>Số lượng đơn hàng</h3>
                <table class="table table-striped table-bordered">
                    <thead class="blue">
                    <tr>
                        <th>#</th>
                        <th>Saler</th>
                        <th class="text-right">DRAFT</th>
                        <th class="text-right">CANCELLED</th>
                        <th class="text-right">SHIPPING</th>
                        <th class="text-right">PAID</th>
                        <th class="text-right">DONE</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${records}" var="rc" varStatus="loop">
                        <tr class="tr-zip" >
                            <td>${loop.index + 1}</td>
                            <td class="">${rc.booker}</td>
                            <td class="text-right">${rc.mapQuantity['DRAFT']}</td>
                            <td class="text-right">${rc.mapQuantity['CANCELLED']}</td>
                            <td class="text-right">${rc.mapQuantity['SHIPPING']}</td>
                            <td class="text-right">${rc.mapQuantity['PAID']}</td>
                            <td class="text-right">${rc.mapQuantity['DONE']}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="col-12">
                <h3>Giá trị đơn hàng</h3>
                <table class="table table-striped table-bordered">
                    <thead class="blue">
                    <tr>
                        <th>#</th>
                        <th>Saler</th>
                        <th class="text-right">DRAFT</th>
                        <th class="text-right">CANCELLED</th>
                        <th class="text-right">SHIPPING</th>
                        <th class="text-right">PAID</th>
                        <th class="text-right">DONE</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${records}" var="rc" varStatus="loop">
                        <tr class="tr-zip" >
                            <td>${loop.index + 1}</td>
                            <td>${rc.booker}</td>
                            <td class="text-right">${rc.mapAmount['DRAFT']}</td>
                            <td class="text-right">${rc.mapAmount['CANCELLED']}</td>
                            <td class="text-right">${rc.mapAmount['SHIPPING']}</td>
                            <td class="text-right">${rc.mapAmount['PAID']}</td>
                            <td class="text-right">${rc.mapAmount['DONE']}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
<div class="d-none countryid">${country.countryid}</div>
