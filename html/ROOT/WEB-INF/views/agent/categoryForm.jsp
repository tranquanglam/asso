<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    .select2-search input {
        height: 36px;
    }

</style>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/categories">All categories</a></li>
                    <li class="breadcrumb-item active" aria-current="page"><fmt:message key="admin.agent.category.title"/></li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1><fmt:message key="admin.agent.category.add.title"/></h1>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-12">
            <form:form method="post" id="categoryForm" commandName="formBean" class="form-horizontal" role="form" enctype="multipart/form-data">
                <div class="form-group">
                    <label>Lang</label>
                    <form:select path="pojo.lang"  cssClass="form-control">
                        <c:forEach items="${langs}" var="lang">
                            <form:option value="${lang}" label="${lang}"/>
                        </c:forEach>
                    </form:select>
                </div>
                <div class="form-group">
                    <label for="pojo.nameurl">Unique Url</label>
                    <form:input type="text" class="form-control" path="pojo.nameurl"/>
                </div>
                <div class="form-group">
                    <label>Order number</label>
                    <form:input type="number" class="form-control" path="pojo.ordernumber" step="1"/>
                </div>
                <div class="form-group">
                    <label for="pojo.name">Name</label>
                    <form:input type="text" class="form-control" path="pojo.name"/>
                </div>
                <div class="form-group">
                    <label for="pojo.name">Name Vi</label>
                    <form:input type="text" class="form-control" path="pojo.namevi"/>
                </div>
                <div class="form-group">
                    <label>Image</label>
    
                    <div>
                        <c:if test="${not empty formBean.pojo.image}">
                            <img src="${formBean.pojo.image}" height="100px">
                        </c:if>
                        <input type="file" name="imageFile"/>
                    </div>
                </div>
                <div class="form-group">
                    <label><fmt:message key="admin.agent.category.type"/></label>
                    <form:select path="pojo.type"  cssClass="form-control">
                        <c:forEach items="${categoryTypes}" var="ctype">
                            <form:option value="${ctype.keyLong}" label="${ctype}"/>
                        </c:forEach>
                    </form:select>
                </div>

                <c:choose>
                    <c:when test="${isFeatureLandHome}">
                        <div class="form-group">
                            <label for="pojo.link">Feature</label>
                            <form:input type="text" class="form-control" path="pojo.link"/>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="form-group">
                            <label for="pojo.link">Link</label>
                            <form:input type="text" class="form-control" path="pojo.link"/>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <div>
                        <label class="radio-inline">
                            <form:radiobutton path="pojo.visible" value="true"/> Visible &nbsp;&nbsp;&nbsp;&nbsp;
                        </label>
                        <label class="radio-inline">
                            <form:radiobutton path="pojo.visible" value="false"/> Invisible
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="my-3">
                        <button type="submit" class="btn btn-primary">&nbsp;<fmt:message key="title.save"/></button>
                    </div>
                </div>
    
            </form:form>
        </div>
    </div>
</div>
