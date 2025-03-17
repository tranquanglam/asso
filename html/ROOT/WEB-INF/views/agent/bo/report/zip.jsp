<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<header>
    <div class="">
        <div class="border-bottom pt-6">
            <div class="row align-items-center">
                <div class="col-sm col-12">
                    <h1 class="h2 ls-tight">
                        <fmt:message key="label.report-zip"/>
                    </h1>
                </div>

                <div class="col-sm-auto col-12 mb-1">
                    <div class="hstack gap-2 justify-content-sm-end">
                        <a href="#" class="btn btn-sm btn-outline-primary btn-export-zip"><i class="bi bi-save"></i> Export to Exel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="report-group">
    <div class="">
        <form id="reportForm" action="/bo/report/zip.html" method="GET">
            <div class="row mt-4">
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
                <div class="form-group col-md-2">
                    <button type="submit" class="btn btn-sm btn-primary"> <fmt:message key="menu.title.report"/> </button>

                </div>
            </div>
        </form>

        <div class="my-3  vstack gap-4 ">
            <div class="card">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto"><fmt:message key="label.report-zip"/></h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                        <tr>
                            <th><fmt:message key="label.state"/> </th>
                            <th><fmt:message key="label.city"/> </th>
                            <th><fmt:message key="label.ward"/> </th>
                            <th class="text-end"><fmt:message key="booking.total_amount"/></th>
                            <c:forEach items="${products}" var="product">
                                <th style="">
                                    <c:choose>
                                        <c:when test="${fn:length(product.name) > 20}">
                                            ${fn:substring(product.name, 0, 20)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${product.name}
                                        </c:otherwise>
                                    </c:choose>
                                </th>
                            </c:forEach>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="tr-summay-group bg-warning">
                            <td colspan="3">
                                <fmt:message key="menu.title.summary_report"/>
                            </td>
                            <td class="text-end"><span class="finalamount"><fmt:formatNumber value="${sumaryRecord.totalamount}" maxFractionDigits="0"/></span></td>
                            <c:forEach items="${products}" var="product">
                                <td>${sumaryRecord.pquantityMap[product.productid]}</td>
                            </c:forEach>
                        </tr>
                        <c:forEach items="${records}" var="rc">
                            <tr class="tr-zip" data-zip="${rc.zip}">
                                <td>
                                    <c:if test="${not empty mapState && not empty rc.statecode && not empty mapState[rc.statecode]}">
                                        <a href="/my/booking.html?statecode=${rc.statecode}&status=PENDING&fromreport=true" class="groupname">${mapState[rc.statecode].name}</a>
                                    </c:if>
                                </td>
                                <td>
                                    <a href="/my/booking.html?city=${rc.citycode}&status=PENDING&fromreport=true" class="groupname">${not empty mapCity[rc.citycode] ? mapCity[rc.citycode].name : ''}</a>
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
                            <td colspan="3">
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

    </div>
</div>
<div class="d-none countryid">${country.countryid}</div>
