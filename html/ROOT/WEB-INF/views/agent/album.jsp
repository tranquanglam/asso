<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:url var="url" value="/agent/view3d/${cat}/files.html"/>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Album</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h2>Image files in album '${cat}'</h2>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                    <tr>
                        <th>Image</th>
                        <th>No.</th>
                        <th>Name</th>
                        <th>Link</th>
                        <th>Image URL</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${albumitems}" var="item">
                        <tr id="item_${item.albumitemid}">
                            <td><img src="${item.url}" alt="${item.name}" width="200px;"></td>
                            <td class="item_ordernumber">${item.ordernumber}</td>
                            <td class="item_name">${item.name}</td>
                            <td class="item_tag">${item.tag}</td>
                            <td class="item_url">${item.url}</td>
                            <td class="text-end">
                                <a href="#" itemid="${item.albumitemid}" class="btn btn-edit-caption-item">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                |
                                <a href="#" itemid="${item.albumitemid}" class="btn btn-delete-item">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row mb-4">
        <div class="col-lg-12">
            <div id="my-dropzone">Drop file here to upload</div>
        </div>
    </div>
</div>
<div class="d-none cat-files">${cat}</div>
<div class="d-none siteid">${site.siteid}</div>
<div class="modal fade" id="captionModal" tabindex="-1" role="dialog" aria-labelledby="captionModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="priceModalLabel">Caption</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="captionForm" action="/agent/sites/${site.siteid}/${cat}/update-caption.html" class="form-horizontal" method="post" role="form">
                    <input type="hidden" name="albumitemid" value="0">
                    <div class="form-group md-3">
                        <label>Order number</label>
                        <input type="number" class="form-control" name="ordernumber"/>
                    </div>
                    <div class="form-group mb-3">
                        <label>Name</label>
                        <input type="text" class="form-control" name="name" maxlength="100"/>
                    </div>
                    <div class="form-group mb-3">
                        <label>Link</label>
                        <input type="text" class="form-control" name="tag" maxlength="63"/>
                    </div>
                    <div class="form-group">
                        <label>Image Url</label>
                        <input type="text" class="form-control" name="url" readonly/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="captionSave" class="btn btn-primary">Save</button>
                <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
