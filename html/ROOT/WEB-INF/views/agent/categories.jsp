<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page"><fmt:message key="admin.agent.category.title"/></li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-10">
            <h1><fmt:message key="admin.agent.category.title"/></h1>
        </div>
        <div class="col-2 text-end">
            <a href="/agent/categories/add" class="btn btn-success"><i class="bi bi-plus" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Add</a>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="card bg-dark text-white my-3">
                <div class="card-body">
                    <form id="categoryFilterForm" class="form-inline" role="form" action="/agent/categories">
                        <div class="row">
                            <div class="form-group col-md">
                                <select name="lang" id="selLang" class="form-control">
                                    <option value="">All languages</option>
                                    <c:forEach items="${langs}" var="lang">
                                        <option value="${lang}">${lang}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group col-md">
                                <select name="type" id="catType" class="form-control">
                                    <option value="">All Types</option>
                                    <c:forEach items="${categoryTypes}" var="categoryType">
                                        <option value="${categoryType.keyLong}">${categoryType}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group col-md">
                                <input type="text" class="form-control" name="nameurl" placeholder="Unique Url" id="nameurl">
                            </div>
                            <div class="form-group col-md">
                                <button type="button" class="btn btn-success" id="categoryFilter">Apply Filter</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <table id="categories_table" class="table table-hover">
                <thead>
                <tr>
                    <th>Order number</th>
                    <th>Unique Url</th>
                    <th>Name</th>
                    <th>Language</th>
                    <th>Link</th>
                    <th><fmt:message key="admin.agent.category.type"/></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    <div class="hide d-none" id="siteid">${site.siteid}</div>
</div>
