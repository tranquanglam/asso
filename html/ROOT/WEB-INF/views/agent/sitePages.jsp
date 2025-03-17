<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/sites/B2B/settings">Site config</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Pages</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-10">
            <h1>Pages <c:if test="${not empty category}"> in category '${category.name}' </c:if> </h1>
        </div>
        <div class="col-2">
            <div class="text-end">
                <a href="#" class="btn btn-success" onclick="showAddForm()"><i class="bi bi-plus" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Add</a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="card bg-dark text-white my-3">
                <div class="card-body">
                    <form id="sitePageFilterForm" class="form-inline" role="form" action="/agent/sites/${siteid}/pages">
                        <div class="row">
                            <div class="form-group col-md">
                                <select name="type" class="form-control">
                                    <option value="-1">All types</option>
                                    <c:forEach items="${types}" var="stype">
                                        <option value="${stype.key}">${stype}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group col-md">
                                <input type="text" class="form-control" name="q" placeholder="search code">
                            </div>
                            <div class="form-group col-md">
                                <button type="button" class="btn btn-success" id="sitePageFilter">Apply Filter</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <table id="sitePages_table" class="display table table-hover"  width="100%">
                <thead>
                <tr>
                    <th>Name in URL</th>
                    <th>Name</th>
                    <th>Tên Tiếng Việt</th>
                    <th></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="sitePageFormModal" tabindex="-1" role="dialog"
     aria-labelledby="sitePageFormModalLabel">
    <div class="modal-dialog" role="document" style="width: 98%;max-width: 1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="sitePageFormModalLabel">Add/Edit Page</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="sitePageForm">
                    <input type="hidden" name="sitepageid">
                    <div class="form-group">
                        <label>Type:</label>
                        <select class="form-control" name="type">
                            <c:forEach items="${types}" var="stype">
                                <option value="${stype.key}">${stype}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group mt-3">
                        <label for="nameurl" class="control-label">Name URL:</label>
                        <input type="text" class="form-control" id="nameurl" name="nameurl"/>
                    </div>
                    <div class="form-group mt-3">
                        <label for="name" class="control-label">Name:</label>
                        <input type="text" class="form-control" id="name" name="name"/>
                    </div>
                    <div class="form-group mt-3">
                        <textarea id="content" class="form-control ckeditor" name="content" rows="20">

                        </textarea>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="saveButton">Save changes</button>
            </div>
        </div>
    </div>
</div>
<!--end Modal -->
<script language="JavaScript">
    var base64_encoded_path = '${base64_encoded_path}';
</script>