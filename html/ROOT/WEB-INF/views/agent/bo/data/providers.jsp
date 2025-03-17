<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<header>
    <div class="">
        <div class="border-bottom pt-6">
            <div class="row align-items-center">
                <div class="col-sm col-12">
                    <h1 class="h2 ls-tight">
                        <fmt:message key="label.providers"/>
                    </h1>
                </div>

                <div class="col-sm-auto col-12 mb-1">
                    <div class="hstack gap-2 justify-content-sm-end">
                        <button class="btn btn-sm btn-primary" onclick="addContent()"> <fmt:message key="title.add"/> </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<div class="mt-2 mb-4">
    <div class="provider-container">
        <div class="my-3  vstack gap-4 ">
            <div class="card">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto"><fmt:message key="label.providers"/></h5>
                </div>
                <div class="table-responsive table-responsive-last">
                    <table class="table table-borderless table-striped">
                        <thead class="table-light">
                        <tr>
                            <th><fmt:message key="admin.agent.company.companycode"/> </th>
                            <th><fmt:message key="admin.agent.company.name"/></th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${companies}" var="em">
                            <tr id="item_${em.companyid}" class="item-${em.companyid}">
                                <td class="item_companycode">${em.companycode}</td>
                                <td class="item_name">${em.name}</td>
                                <td class="text-end">
                                    <button type="button" class="btn btn-sm btn-square btn-neutral text-danger-hover"onclick="javascript:editContent(${em.companyid});">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="card-footer">

                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby="formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel"><fmt:message key="label.providers"/></h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/bo/data/providerForm.html" method="post" id="itemForm">
                    <input type="hidden" name="companyid" value="0">

                    <div class="form-group">
                        <label> <fmt:message key="admin.agent.company.companycode"/> </label>
                        <input name="companycode" class="form-control" type="text" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label> <fmt:message key="admin.agent.company.name"/></label>
                        <input name="name" class="form-control" type="text" maxlength="255">
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
