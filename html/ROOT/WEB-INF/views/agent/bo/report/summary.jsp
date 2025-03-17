<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<header>
    <div class="">
        <div class="border-bottom pt-6">
            <div class="row align-items-center">
                <div class="col-sm col-12">
                    <h1 class="h2 ls-tight">
                        <fmt:message key="menu.title.summary_report"/>
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

<div class="text-end">
    <a href="javascript:void(0)" class="show-hide-filter p-4"><i class="bi bi-filter" aria-hidden="false"></i></a>
</div>
<div id="summary-report-filter" class="summary-report-filter d-none">
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
                    <c:set var="mdc"><fmt:message key='detail.fromdate'/></c:set>
                    <input class="from-date form-control form-control-sm bg-light datepicker" name="fromDate" placeholder="${mdc}"/>
                </div>
                <div class="form-group col-md col-6">
                    <c:set var="mdc"><fmt:message key='detail.enddate'/></c:set>
                    <input class="to-date form-control form-control-sm bg-light datepicker" name="toDate" placeholder="${mdc}"/>
                </div>
                <div class="form-group col-md col-6">
                    <a href="javascript:void (0)" class="btn btn-sm btn-refresh-report btn-primary"> <fmt:message key="menu.title.report"/> </a>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="">
    <div class="summary-container">
        <div class="my-3  vstack gap-4 ">
            <div class="card p-2">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto"><fmt:message key="menu.title.daily_report"/></h5>
                </div>
                <div class="mt-4">
                    <canvas id="daily-chart"></canvas>
                </div>
            </div>

            <div class="card p-2">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto"><fmt:message key="label.report-product"/></h5>
                </div>
                <canvas id="product-chart"></canvas>
            </div>

        </div>
    </div>
</div>

<div class="d-none countryid">${country.countryid}</div>
