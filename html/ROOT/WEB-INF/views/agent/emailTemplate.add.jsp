<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page"><a href="/agent/emailTemplates">Email Templates</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1>Add/Edit Template</h1>
            <c:if test="${not empty errors}">
                <div class="alert alert-danger" id="error-message">${errors}</div>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <form:form id="emailTemplateFrom" commandName="emailTemplateFrom" class="form-horizontal" action="${requestScope['javax.servlet.forward.request_uri']}" method="POST">

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="form-group">
                    <label>Code</label>
                    <form:input path="code" cssClass="form-control" placeholder="Code" />
                </div>

                <div class="form-group">
                    <label>Subject</label>
                    <form:input path="subject" cssClass="form-control" placeholder="Subject"/>
                </div>

                <div class="form-group">
                    <label>Content</label>
                    <form:textarea path="content" cssClass="richTextEditor form-control"/>
                </div>

                <div class="form-group">
                    <div class="mt-3">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <a href="${pageContext.request.contextPath}/agent/emailTemplates" class="btn btn-warning">Cancel</a>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>
<script language="JavaScript">
    var base64_encoded_path = '${base64_encoded_path}';
</script>

