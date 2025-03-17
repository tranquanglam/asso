<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-4">
    <div class="mg-sec-title">
        <h1 class="title"><fmt:message key="label.manufacturer"/></h1>
    </div>
</div>
<div class="mt-2 mb-4">
    <div class="manufacturer-container">
        <div class="row">
            <div class="col-md-6">
                <form:form id="myForm" cssClass="form-inline" action="/bo/data/manufacturers.html" method="post" commandName="mineBean">
                    <div class="form-group">
                        <form:input  path="searchTerm" placeholder="search..." maxlength="64" cssClass="form-control"/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-info"><span><fmt:message key="label.search"/> </span></button>
                    </div>
                    <form:hidden path="page" id="formPage"/>
                </form:form>
            </div>
            <div class="col-md-6">
                <button class="btn btn-primary float-right" onclick="addContent()">Add</button>
            </div>
        </div>
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Country</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${items.listResult}" var="em">
                        <tr id="item_${em.manufacturerid}">
                            <td class="item_name">${em.name}</td>
                            <td class="item_address">${em.address}</td>
                            <td class="item_country">${em.country}</td>
                            <td>
                                <a href="#" onclick="javascript:editContent(${em.manufacturerid});">Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!--  -->
        <ul class="pagination pull-right">
            <c:if test="${items.hasPrevious}">
                <li><a href="#"><i class="fa fa-play arrow-left"></i></a></li>
            </c:if>
            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                <li><a ${items.page eq loop.count?'class="current"':''} href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
            </c:forEach>
            <c:if test="${items.hasNext}">
                <li><a href="#"><i class="fa fa-play arrow-right"></i></a></li>
            </c:if>
        </ul>
    </div>
</div>
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby="formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit Manufacturer</h4>
            </div>
            <div class="modal-body">
                <form action="/bo/data/manufacturerForm.html" method="post" id="itemForm">
                    <input type="hidden" name="manufacturerid" value="0">
                    <div class="form-group">
                        <label>Name</label>
                        <input name="name" class="form-control" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label>Address</label>
                        <input name="address" class="form-control" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label>Country</label>
                        <select name="country" class="form-control">
                            <c:forEach var="ct" items="${countries}">
                                <option value="${ct.name}">${ct.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="itemFormSubmit()">Save</button>
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>