<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>


<!-- Main content -->
<div class="h-screen flex-grow-1 overflow-y-lg-auto">
    <!-- Header -->
    <div class="card mt-4">
        <div class="card-body">
            <div class="mb-npx">
                <div class="row align-items-center">
                    <div class="col-sm-6 col-12 mb-4 mb-sm-0">
                        <!-- Title -->
                        <h1 class="h2 mb-0 ls-tight">Sizes</h1>
                    </div>
                    <!-- Actions -->
                    <div class="col-sm-6 col-12 text-sm-end">
                        <div class="mx-n1">
                            <a href="javascript:void(0)" onclick="addContent();" class="btn d-inline-flex btn-sm btn-primary mx-1">
                                    <span class=" pe-2">
                                        <i class="bi bi-plus"></i>
                                    </span>
                                <span> <fmt:message key="title.add"/></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped">
                    <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th><fmt:message key="label.name"/></th>
                        <th>Unit name</th>
                        <th>Unit value</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${items}" var="em" varStatus="loop">
                        <tr id="item_${em.sizeid}">
                            <td>${loop.index + 1}</td>
                            <td class="item_name">${em.name}</td>
                            <td class="item_unitname">${em.unitname}</td>
                            <td class="item_unitvalue">${em.unitvalue}</td>
                            <td class="text-end">
                                <a href="#" class="btn btn-sm btn-neutral" onclick="editContent(${em.sizeid})"><fmt:message key="label.view-detail"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby="formContentModalLabel">
    <div class="modal-dialog" role="document" >
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit <fmt:message key="label.size"/></h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/bo/data/sizes.html" method="post" id="itemForm">
                    <input type="hidden" name="sizeid" value="0">
                    <div class="form-group">
                        <label><fmt:message key="label.name"/></label>
                        <input name="name" class="form-control" type="text" maxlength="63">
                    </div>
                    <div class="form-group">
                        <label>Unit name</label>
                        <input name="unitname" class="form-control" type="text" maxlength="63">
                    </div>
                    <div class="form-group">
                        <label>Unit value</label>
                        <input name="unitvalue" class="form-control" type="text" maxlength="63">
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
