<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Email Templates</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="text-end"><a class="btn btn-primary" href="/agent/emailTemplate/add">Add</a></div>
        </div>
        <div class="col-lg-12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Code</th>
                    <th>Subject</th>
                    <th></th>
                </tr>
                </thead>
                <c:forEach var="template" items="${emailTemplates}">
                    <tr>
                        <td>${template.code}</td>
                        <td>${template.subject}</td>
                        <td class="text-center">
                            <c:url var="editUrl" value="/agent/emailTemplate/update/${template.emailtemplateid}">
                                <c:if test="${empty template.subject}">
                                    <c:param name="loadDefault" value="true"/>
                                </c:if>
                            </c:url>
                            <a class="btn btn-primary btn-xs" href="${editUrl}"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Edit</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>