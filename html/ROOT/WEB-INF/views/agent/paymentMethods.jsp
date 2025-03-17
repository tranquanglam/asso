<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Payment methods</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <h2>Payment methods</h2>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Code</th>
                    <th>Content</th>
                    <th>Settings</th>
                    <th>Activated</th>
                    <th></th>
                </tr>
                </thead>
                <c:forEach var="pm" items="${paymentMethods}">
                    <tr>
                        <td>${pm.key}</td>
                        <td>${pmMap[pm.key].content}</td>
                        <td>
                            <div style="max-width: 500px;overflow: scroll;">
                                    ${pmMap[pm.key].settings}
                            </div>
                        </td>
                        <td>${pmMap[pm.key].activated}</td>
                        <td class="text-center">
                            <a class="btn btn-primary btn-xs" href="/agent/paymentMethods/${pm.key}/edit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Edit</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>