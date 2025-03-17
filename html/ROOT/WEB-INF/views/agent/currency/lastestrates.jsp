<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Currency Lastest Rates</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6">
            <h1>Currency Lastest Rates</h1>
        </div>
        <div class="col-lg-6">
            <div class="text-end">Site currency: ${agentCurrency} <a href="/agent/currency/agentCurrency">change</a></div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>Base Currency</th>
                        <th>To Currency</th>
                        <th>Rate</th>
                        <th></th>
                    </tr>
                    </thead>
                    <c:forEach var="lrate" items="${lastestRates}">
                        <tr>
                            <td>${lrate.code}</td>
                            <td>${lrate.tocode}</td>
                            <td>${lrate.rate}</td>
                            <td class="text-center">
                                <a class="btn btn-primary btn-xs" href="/agent/currency/lastestRateForm/${lrate.lastestrateid}"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="my-4"><a class="btn btn-primary" href="/agent/currency/lastestRateForm">Add</a></div>
        </div>
    </div>
</div>