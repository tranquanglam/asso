<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<header>
    <div class="">
        <div class="border-bottom pt-6">
            <div class="row align-items-center">
                <div class="col-sm col-12">
                    <h1 class="h2 ls-tight">
                        <fmt:message key="label.report-booker"/>
                    </h1>
                </div>

                <div class="col-sm-auto col-12 mb-1">
                    <div class="hstack gap-2 justify-content-sm-end">
                        <a href="#" class="btn btn-sm btn-outline-primary btn-export-zip"><i class="bi bi-save"></i> <fmt:message key="label.export.excel" /> </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="report-group mt-4">
    <div class="">
        <form id="reportForm" action="/bo/report/booker.html" method="GET">
            <div class="row">
                <c:if test="${not empty states}">
                    <div class="form-group form-group-state col-md-2">
                        <select name="statecode" class="form-select custom-select cus-state">
                            <option value="">--<fmt:message key="label.state"/>--</option>
                            <c:forEach items="${states}" var="state">
                                <option value="${state.code}" ${param.statecode eq state.code ? 'selected' : ''}>${state.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>
                <div class="form-group form-group-city col-md-2">
                    <select name="citycode" class="form-select custom-select cus-city">
                        <option value="">--<fmt:message key="label.city"/>--</option>
                        <c:forEach items="${cities}" var="ct">
                            <option value="${ct.code}" ${param.citycode eq ct.code ? 'selected' : ''}>${ct.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md-2">
                    <select name="zip" class="form-select custom-select cus-zip">
                        <option value="">--<fmt:message key="label.ward"/>--</option>
                        <c:forEach items="${wards}" var="w">
                            <option value="${w.zip}" ${param.zip eq w.zip ? 'selected' : ''}>${w.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md-3">
                    <select class="form-select custom-select" name="status">
                        <option value=""><fmt:message key="status.all"/> </option>
                        <c:forEach var="st" items="${statuses}">
                            <option value="${st}" ${param.status eq st ? 'selected' : ''}><fmt:message key="${st}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md-3">
                    <button type="submit" class="btn btn-sm btn-primary"> <fmt:message key="menu.title.report"/> </button>
                </div>
            </div>
        </form>

        <div class="my-3  vstack gap-4 ">
            <div class="card">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto">Số lượng đơn hàng</h5>
                </div>
                <table class="table table-hover">
                    <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th>Saler</th>
                        <th class="text-end">DRAFT</th>
                        <th class="text-end">CANCELLED</th>
                        <th class="text-end">SHIPPING</th>
                        <th class="text-end">PAID</th>
                        <th class="text-end">DONE</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${records}" var="rc" varStatus="loop">
                        <tr class="tr-zip" >
                            <td>${loop.index + 1}</td>
                            <td class="">${rc.booker}</td>
                            <td class="text-end">${rc.mapQuantity['DRAFT']}</td>
                            <td class="text-end">${rc.mapQuantity['CANCELLED']}</td>
                            <td class="text-end">${rc.mapQuantity['SHIPPING']}</td>
                            <td class="text-end">${rc.mapQuantity['PAID']}</td>
                            <td class="text-end">${rc.mapQuantity['DONE']}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="card">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto">Giá trị đơn hàng</h5>
                </div>

                <table class="table table-hover">
                    <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th>Saler</th>
                        <th class="text-end">DRAFT</th>
                        <th class="text-end">CANCELLED</th>
                        <th class="text-end">SHIPPING</th>
                        <th class="text-end">PAID</th>
                        <th class="text-end">DONE</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${records}" var="rc" varStatus="loop">
                        <tr class="tr-zip" >
                            <td>${loop.index + 1}</td>
                            <td>${rc.booker}</td>
                            <td class="text-end"><fmt:formatNumber value="${rc.mapAmount['DRAFT']}" maxFractionDigits="0"/></td>
                            <td class="text-end"><fmt:formatNumber value="${rc.mapAmount['CANCELLED']}" maxFractionDigits="0"/></td>
                            <td class="text-end"><fmt:formatNumber value="${rc.mapAmount['SHIPPING']}" maxFractionDigits="0"/></td>
                            <td class="text-end"><fmt:formatNumber value="${rc.mapAmount['PAID']}" maxFractionDigits="0"/></td>
                            <td class="text-end"><fmt:formatNumber value="${rc.mapAmount['DONE']}" maxFractionDigits="0"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
<div class="d-none countryid">${country.countryid}</div>
