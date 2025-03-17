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
                    <div class="input-group">
                        <form:input  path="searchTerm" placeholder="search..." maxlength="64" cssClass="form-control"/>
                        <button type="submit" class="btn btn-secondary"><span><fmt:message key="label.search"/> </span></button>
                    </div>
                    <form:hidden path="page" id="formPage"/>
                </form:form>
            </div>
            <div class="col-md-6 text-end">
                <button class="btn btn-primary" onclick="addContent()">Add</button>
            </div>
        </div>
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th><fmt:message key="label.name"/></th>
                        <th><fmt:message key="label.address"/></th>
                        <th><fmt:message key="label.country"/></th>
                        <th><fmt:message key="label.state"/></th>
                        <th><fmt:message key="label.city"/></th>
                        <th><fmt:message key="label.ward"/></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${items.listResult}" var="em">
                        <tr id="item_${em.manufacturerid}">
                            <td class="item_name">${em.name}</td>
                            <td class="item_address">${em.address}</td>
                            <td class="item_country">${em.country}</td>
                            <td class="">
                                <c:if test="${not empty em.state}">
                                    ${em.state.name}
                                    <div class="item_stateid d-none">${em.state.stateid}</div>
                                    <div class="item_statename d-none">${em.state.name}</div>
                                </c:if>
                            </td>
                            <td class="">
                                <c:if test="${not empty em.city}">
                                    ${em.city.name}
                                    <div class="item_cityid d-none">${em.city.cityid}</div>
                                    <div class="item_cityname d-none">${em.city.name}</div>
                                </c:if>
                            </td>
                            <td class="">
                                <c:if test="${not empty em.ward}">
                                    ${em.ward.name}
                                    <div class="item_wardid d-none">${em.ward.wardid}</div>
                                    <div class="item_wardname d-none">${em.ward.name}</div>
                                </c:if>
                            </td>
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
        <ul class="nav">
            <c:if test="${items.hasPrevious}">
                <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-arrow-left"></i></a></li>
            </c:if>
            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                <li class="nav-item"><a class="nav-link ${items.page eq loop.count?'current':''}" href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
            </c:forEach>
            <c:if test="${items.hasNext}">
                <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-arrow-right"></i></a></li>
            </c:if>
        </ul>
    </div>
</div>
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby="formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit <fmt:message key="label.manufacturer"/> </h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

            </div>
            <div class="modal-body">
                <form action="/bo/data/manufacturerForm.html" method="post" id="itemForm">
                    <input type="hidden" name="manufacturerid" value="0">
                    <div class="form-group">
                        <label><fmt:message key="label.name"/></label>
                        <input name="name" class="form-control" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="label.address"/></label>
                        <input name="address" class="form-control" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="label.country"/></label>
                        <select name="country" class="form-control cus-country">
                            <c:forEach var="ct" items="${countries}">
                                <option value="${ct.name}" data-countryid="${ct.countryid}">${ct.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="label.state"/></label>
                        <select name="state.stateid" class="form-control cus-state">
                            <option value="">---</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="label.city"/></label>
                        <select name="city.cityid" class="form-control cus-city">
                            <option value="">---</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="label.ward"/> </label>
                        <select name="ward.wardid" class="form-control cus-ward">
                            <option value="">---</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="itemFormSubmit()">Save</button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
