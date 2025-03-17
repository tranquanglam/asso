<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/news">News</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Add/Edit</li>
                </ol>
            </nav>
        </div>
    </div>
<div class="row">
    <div class="col-lg-12">
        <h1>Add/Edit News</h1>
        <c:if test="${not empty errors}">
            <div class="alert alert-danger" id="error-message">${errors}</div>
        </c:if>
    </div>
</div>
<div class="row">
    <div class="col-12">
        <form:form id="newsForm" enctype="multipart/form-data" commandName="news" class="form-horizontal" action="${requestScope['javax.servlet.forward.request_uri']}" method="POST">

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="row">
                <div class="form-group col-md-3">
                    <label >Lang</label>
                    <form:select path="lang"  cssClass="form-control">
                        <c:forEach items="${langs}" var="lang">
                            <form:option value="${lang}" label="${lang}"/>
                        </c:forEach>
                    </form:select>
                </div>
                <div class="form-group col-md-3">
                    <label >Title</label>
                    <form:input path="title" cssClass="form-control" placeholder="Title" />
                </div>
                <div class="form-group col-md-3">
                    <label >Titolo</label>
                    <form:input path="titleit" cssClass="form-control" placeholder="Titolo" />
                </div>
                <div class="form-group col-md-3">
                    <label >Tiêu đề Tiếng Việt</label>
                    <form:input path="titlevn" cssClass="form-control" placeholder="Tiêu đề Tiếng Việt" />
                </div>
            </div>
            <div class="row mt-3">
                <div class="form-group col-md-3">
                    <label>Url</label>
                    <form:input path="urlname" cssClass="form-control" placeholder="url"/>
                </div>
                <div class="form-group col-md-3">
                    <label >Keywords</label>
                    <form:input path="keyword" cssClass="form-control" placeholder="keywords"/>
                </div>
                <div class="form-group col-md-3">
                    <label >Links</label>
                    <form:select id="subContent" path="subContent" placeHolder="select hotels" cssClass="form-control"/>
                </div>
            </div>

            <div class="row mt-3">
                <div class="form-group col-md-12">
                    <label >Image</label>

                    <div>
                        <c:if test="${not empty news.image1}">
                            <img src="${news.image1}" height="100px">
                        </c:if>
                        <form:input type="file" path="image1File"/>
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <label>Short description</label>
                    <form:textarea path="subContent" cssClass="form-control" placeholder="subContent"/>
                </div>

                <div class="form-group checkboxes">
                    <label><fmt:message key="label.categories"/></label>
                    <div>
                        <form:checkboxes items="${categoryDTOS}" itemValue="categoryid" cssClass="ms-3 mb-3" path="categoryids" itemLabel="name"/>
                    </div>
                </div>

                <div class="form-group">
                    <label >&nbsp;</label>
                    <div>
                        <label class="radio-inline">
                            <form:radiobutton path="visible" value="true"/> Visible &nbsp;&nbsp;&nbsp;&nbsp;
                        </label>
                        <label class="radio-inline">
                            <form:radiobutton path="visible" value="false"/> Invisible
                        </label>
                    </div>
                </div>
            </div>


            <c:choose>
                <c:when test="${param.l == 'vi'}">
                    <div class="form-group">
                        <label for="contentvn" >Nội dung Tiếng Việt</label>
                        <form:textarea path="contentvn" cssClass="form-control richTextEditor"/>
                    </div>
                </c:when>
                <c:when test="${param.l == 'it'}">
                    <div class="form-group">
                        <label for="contentit" >Italian</label>
                        <form:textarea path="contentit" cssClass="form-control richTextEditor"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="form-group">
                        <label >Content</label>
                        <form:textarea path="content" cssClass="richTextEditor form-control"/>
                    </div>
                </c:otherwise>
            </c:choose>


            <div class="form-group">
                <div class="my-3">
                    <button type="submit" class="btn btn-primary">Save</button>
                    <a href="${pageContext.request.contextPath}/agent/news" class="btn btn-warning">Cancel</a>
                </div>
            </div>

        </form:form>
    </div>
</div>
</div>
<script language="JavaScript">
    var base64_encoded_path = '${base64_encoded_path}';
    var linksData;
    <c:if test="${not empty linksData}">
    linksData = ${linksData};
    </c:if>
    var l='en';
    <c:if test="${param.l == 'vi'}">
    l='vi';
    </c:if>
    <c:if test="${param.l == 'it'}">
    l='it';
    </c:if>
</script>

