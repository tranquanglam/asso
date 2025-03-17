<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/sites/B2B/settings">Site config</a></li>
                    <li class="breadcrumb-item"><a href="/agent/sites/pages">Pages</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Page</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1>${sitePage.name}</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <form:form id="sitePageForm" commandName="sitePage" method="post" class="form-horizontal" role="form"  enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="sitepageid">
                <div class="row">
                    <div class="form-group col-md">
                        <label for="type" class="control-label">Type:</label>
                        <form:select class="form-control" id="type" path="type">
                            <c:forEach items="${types}" var="typ">
                                <form:option value="${typ.key}">${typ}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="form-group col-md">
                        <label for="nameurl" class="control-label">Name URL:</label>
                        <form:input type="text" cssClass="form-control" path="nameurl"/>
                    </div>
                    <div class="form-group col-md">
                        <label for="name" class="control-label">Name:</label>
                        <form:input type="text" cssClass="form-control" path="name"/>
                    </div>
                    <div class="form-group col-md">
                        <label for="namevn" class="control-label">Tên Tiếng Việt:</label>
                        <form:input type="text" cssClass="form-control" path="namevn"/>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md">
                        <label>Link to</label>
                        <form:input path="link" cssClass="form-control" placeholder="Link to"/>
                    </div>
                    <div class="form-group col-md">
                        <label>Image</label>
                        <div>
                            <c:if test="${not empty sitePage.image}">
                                <img src="${sitePage.image}" height="100px">
                            </c:if>
                            <input type="file" name="imageFile"/>
                        </div>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${param.l == 'vi'}">
                        <div class="form-group">
                            <label for="contentvn" class="control-label">Nội dung Tiếng Việt:</label>
                            <form:textarea path="contentvn" cssClass="form-control richTextEditor" rows="10" />
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="form-group">
                            <label for="content" class="control-label">Content:</label>
                            <form:textarea path="content" cssClass="form-control richTextEditor" rows="10" />
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="row form-group my-3">
                    <div class="col-md-6">
                        <button type="submit" class="btn btn-primary">&nbsp;Submit</button>
                    </div>
                    <div class="col-md-6 text-end"><a class="btn btn-default" href="#" onclick="deleteSitePage('${sitePage.sitepageid}')">Delete</a></div>
                </div>
            </form:form>
        </div>
    </div>
</div>
<script language="JavaScript">
    var base64_encoded_path = '${base64_encoded_path}';
    var l='en';
    <c:if test="${param.l == 'vi'}">
    l='vi';
    </c:if>
</script>

