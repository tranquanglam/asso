<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active">Api sites</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <h1>API sites</h1>
        </div>
        <div class="col-lg-2 text-end">
            <c:if test="${ableToAdd}">
                <a href="/agent/apisites/apisiteForm"><i class="bi bi-plus-circle"></i></a>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
                <table id="apisites_table" class="table table-hover">
                    <thead>
                    <tr>
                        <th class="col-sm-1">Code</th>
                        <th class="col-sm-1">Site type</th>
                        <th class="col-sm-1">Site url</th>
                        <th class="col-sm-1">Clientid</th>
                        <th class="col-sm-1">Visible</th>
                        <th class="col-sm-1"></th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>

