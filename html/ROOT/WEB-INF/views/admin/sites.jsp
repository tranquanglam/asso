<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-4">
    <div class="container">
        <h1 class="title">Sites</h1>
    </div>
</div>
<div class="mt-2 mb-4">
    <div class="container">
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th>Domain</th>
                        <th>Name</th>
                        <th>Title</th>
                        <th>Agent id | name</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${sites}" var="em">
                        <tr id="item_${em.siteid}">
                            <td class="item_name">${em.domain}</td>
                            <td class="item_name">${em.name}</td>
                            <td class="item_address">${em.title}</td>
                            <td class="item_country">${em.agent.agentid} | ${em.agent.name}</td>
                            <td>
                                <a href="/admin/sites/${em.siteid}/siteForm">Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="mt-4 text-right">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#formContentModal">
                Add Site
            </button>
        </div>
    </div>
</div>
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby=formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="formContentModalLabel">Add New Site</h4>
            </div>
            <div class="modal-body">
                <form action="/admin/sites/siteForm" method="post" name="agentRegisterBean" id="agentRegisterBean">
                    <div class="form-group">
                        <label>Company Name</label>
                        <input name="companyName" class="form-control" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label>domain</label>
                        <input name="siteBean.domainName" class="form-control" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label>admin email</label>
                        <input name="adminEmail" class="form-control" maxlength="255" type="email">
                    </div>
                    <div class="form-group">
                        <label>password</label>
                        <input name="password" class="form-control" maxlength="255" type="password">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="document.getElementById('agentRegisterBean').submit();">Add Site</button>
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>