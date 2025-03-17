<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item"><a href="/agent/apisites">Api sites</a></li>
                    <li class="breadcrumb-item active">Api products</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <h1>API products</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <table id="products_table" class="table table-hover">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Remote id</th>
                    <th>Brand</th>
                    <th>Site url</th>
                    <th>Clientid</th>
                    <th>Visible</th>
                    <th>Category</th>
                    <th></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<div class="modal" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="categoryModalLabel">Category</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="col-md-12">
                        <form id="categoryForm" action="/agent/apiproducts/updateCategory.html" class="form-horizontal" method="post" role="form">
                            <input type="hidden" id="apiproductid" name="apiproductid" value="0">
                            <div class="form-group">
                                <label>Category</label>
                                <select id="categoryurl" name="categoryurl" class="form-control">
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat.nameurl}">${cat.nameurl}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary saveCategoryBtn">&nbsp;Save</button>
                <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


