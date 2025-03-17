<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-4 d-flex justify-content-between">
    <div class="mg-sec-title">
        <h1 class="title">Category</h1>
    </div>
    <div>
        <button class="btn btn-primary" onclick="addContent()">Add</button>
    </div>
</div>
<div class="mt-2 mb-4">
    <div class="category-container">
        <div class="table-responsive table-responsive-last">
            <table class="table table-borderless table-striped">
                <thead class="blue">
                <tr>
                    <th>#</th>
                    <th>Name url</th>
                    <th><fmt:message key="admin.agent.category.name"/></th>
                    <th><fmt:message key="label.product.namevi"/></th>
                    <th><fmt:message key="label.visible"/></th>
                    <th><fmt:message key="admin.agent.category.type"/></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${categories}" var="em">
                    <tr id="item_${em.categoryid}" class="item-${em.visible}">
                        <td class="item_ordernumber">${em.ordernumber}</td>
                        <td class="item_nameurl">${em.nameurl}</td>
                        <td class="item_name">${em.name}</td>
                        <td class="item_namevi">${em.namevi}</td>
                        <td class="item_visible">${em.visible}</td>
                        <td class="item_type">${em.type eq 11 ? 'EXTRA' : 'MAIN' }</td>
                        <td>
                            <a href="#" onclick="javascript:editContent(${em.categoryid});">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby="formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit Category</h4>
            </div>
            <div class="modal-body">
                <form action="/bo/data/categoryForm.html" method="post" id="itemForm">
                    <input type="hidden" name="categoryid" value="0">
                    <div class="form-group">
                        <label>No.</label>
                        <input name="ordernumber" class="form-control" type="number">
                    </div>
                    <div class="form-group">
                        <label>Nameurl</label>
                        <input name="nameurl" class="form-control" type="text" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label>Name</label>
                        <input name="name" class="form-control" type="text" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="label.product.namevi"/></label>
                        <input name="namevi" class="form-control" type="text" maxlength="255">
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="admin.agent.category.type"/></label>
                        <select name="type" class="form-control">
                            <option value="8">Main</option>
                            <option value="11">Exra</option>
                        </select>
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