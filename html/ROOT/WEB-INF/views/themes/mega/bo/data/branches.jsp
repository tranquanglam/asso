<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-4">
    <div class="mg-sec-title">
        <h1 class="title"><fmt:message key="label.branch"/></h1>
    </div>
</div>
<div class="mt-2 mb-4">
    <div class="branch-container">
        <div class="row">
            <div class="col-md-6">
                <form:form id="myForm" cssClass="form-inline" action="/bo/data/branches.html" method="post" commandName="mineBean">
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
                        <th><fmt:message key="label.urlname"/></th>
                        <th><fmt:message key="label.name"/></th>
                        <th><fmt:message key="label.address"/></th>
                        <th><fmt:message key="label.phone"/></th>
                        <th><fmt:message key="label.visible"/></th>
                        <th><fmt:message key="label.shortdescription"/></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${items.listResult}" var="em">
                        <tr id="item_${em.branchid}" class="item-${em.visible}">
                            <td class="item_urlname">${em.urlname}</td>
                            <td class="item_name">${em.name}</td>
                            <td class="item_address">${em.address}</td>
                            <td class="item_phone">${em.phone}</td>
                            <td class="item_visible">${em.visible}</td>
                            <td class="item_shortdescription">${em.shortdescription}</td>
                            <td class="item-others" data-image1="${em.image1}" data-keyword="${em.keyword}">
                                <a href="#" onclick="javascript:editContent(${em.branchid});" title="Click to Edit">
                                    <c:choose>
                                        <c:when test="${not empty em.image1}">
                                            <img src="${em.image1}" alt="..." class="img-responsive">
                                        </c:when>
                                        <c:otherwise>Edit</c:otherwise>
                                    </c:choose>
                                </a>
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
     aria-labelledby=formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit <fmt:message key="label.branch"/></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/bo/data/branchForm.html" method="post" id="itemForm">
                    <input type="hidden" name="branchid" value="0"/>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.urlname"/></label>
                            <input name="urlname" class="form-control" maxlength="255"/>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.name"/></label>
                            <input name="name" class="form-control" maxlength="255"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="label.address"/></label>
                        <input name="address" class="form-control" maxlength="255"/>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.phone"/></label>
                            <input name="phone" class="form-control" maxlength="32"/>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.working-hours"/></label>
                            <input name="keyword" class="form-control" maxlength="255"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="label.image"/></label>
                        <input name="image1" class="form-control" maxlength="255"/>
                    </div>

                    <div class="form-group">
                        <label><fmt:message key="label.shortdescription"/></label>
                        <textarea name="shortdescription" class="form-control"></textarea>
                    </div>
                    <div class="form-group">
                        <input type="checkbox" name="visible" class=""/>
                        <label class="form-check-label">Visible</label>
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