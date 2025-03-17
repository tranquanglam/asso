<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="text-right">
    <a href="javascript:void(0)" class="show-hide-filter p-4"><i class="fa fa-cog" aria-hidden="false"></i></a>
</div>
<section id="summary-report-filter" class="summary-report-filter d-none">
    <div class="container-fluid">
        <form id="summaryReportForm" action="/bo/report/summary.html" method="GET">
            <div class="row">
                <c:if test="${not empty states}">
                    <div class="form-group col-md col-6">
                        <select name="statecode" class="form-control custom-select cus-state">
                            <option value="">--<fmt:message key="label.state"/>--</option>
                            <c:forEach items="${states}" var="state">
                                <option value="${state.code}">${state.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>
                <div class="form-group col-md col-6">
                    <select name="citycode" class="form-control custom-select cus-city">
                        <option value="">--<fmt:message key="label.city"/>--</option>
                        <c:forEach items="${cities}" var="ct">
                            <option value="${ct.code}">${ct.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md col-6">
                    <select name="zip" class="form-control custom-select cus-zip">
                        <option value="">--<fmt:message key="label.ward"/>--</option>
                        <c:forEach items="${wards}" var="w">
                            <option value="${w.zip}">${w.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md col-6">
                    <input class="from-date form-control datepicker mr-2" name="fromDate" placeholder="from date"/>
                </div>
                <div class="form-group col-md col-6">
                    <input class="to-date form-control datepicker mr-2" name="toDate" placeholder="to date"/>
                </div>
                <div class="form-group col-md col-6">
                    <a href="javascript:void (0)" class="btn btn-refresh-report btn-outline-secondary mr-2">Report</a>
                </div>
            </div>
        </form>
    </div>
</section>
<div class="mt-4">
    <canvas id="daily-chart"></canvas>
</div>
<div class="mt-4">
    <canvas id="product-chart"></canvas>
</div>
<div class="d-none countryid">${country.countryid}</div>
