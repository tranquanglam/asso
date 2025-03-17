<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<div class="container-fluid">
<div class="row">
    <div class="col-md-2">
        <h1>Promotions</h1>
    </div>
    <div class="col-md-8 pt-3">
        <div class="text-center">
        <a href="/bo/data/promotions/0/products">Level 0 # Products</a> | <a href="/bo/data/promotions/1/products">Level 1 # Products</a>
        | <a href="/bo/data/promotions/2/products">Level 2 # Products</a>
        </div>
    </div>
    <div class="col-md-2">
        <div class="pull-right"><a class="btn btn-primary" href="/bo/data/promotions/add">Add</a></div>
    </div>
</div>
    <div class="row mt-4">
        <div class="col-12">
            <form:form id="myForm" class="form-inline" action="/bo/data/promotions" method="GET" commandName="promoBean">
                <form:select path="level" cssClass="form-control mr-2">
                    <form:option value="0">Level 0</form:option>
                    <form:option value="1">Level 1</form:option>
                    <form:option value="2">Level 2</form:option>
                </form:select>
                <form:input path="validTo" cssClass="form-control datepicker mr-2" />
                <form:input  path="searchTerm" placeholder="code" maxlength="64" cssClass="input-search form-control mr-2"/>
                <button type="submit" class="btn btn-info pl-4 pr-4"><span><i class="fa fa-search"></i></span></button>
                <input type="hidden" name="page" id="formPage" value="1">
            </form:form>
        </div>
    </div>
<div class="row mt-4">
    <div class="col-lg-12">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Level</th>
                    <th>Code</th>
                    <th>Type</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th> % </th>
                    <th>Discount</th>
                    <th>Minimum</th>
                    <th></th>
                </tr>
                </thead>
                <c:forEach var="p" items="${promotions}">
                    <tr>
                        <td>${p.level}</td>
                        <td>${p.code}</td>
                        <td>
                                ${p.promotiontype.name}
                        </td>
                        <td><fmt:formatDate value="${p.startdate}" pattern="MM/dd/yyyy"/></td>
                        <td><fmt:formatDate value="${p.enddate}" pattern="MM/dd/yyyy"/></td>
                        <td>${p.savingpercent}%</td>
                        <td>${p.discount}</td>
                        <td>${p.minimum}</td>
                        <td class="text-center">
                            <c:url var="editUrl" value="/bo/data/promotions/update/${p.promotionid}">

                            </c:url>
                            <a class="btn btn-primary btn-xs" href="${editUrl}"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Edit</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</div>