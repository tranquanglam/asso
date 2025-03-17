<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-4">
    <div class="mg-sec-title text-center">
        <h1 class="title">${product.name}</h1>
    </div>
</div>
<div class="mt-2 mb-4">
    <div class="product-container">
        <form:form action="/bo/data/productForm.html" method="post" id="itemForm" modelAttribute="product">
            <form:hidden path="productid"/>
            <div class="row">
                <div class="form-group col-4">
                    <label>Code</label>
                    <form:input path="code" cssClass="form-control" maxlength="255"/>
                </div>
                <div class="form-group col-8">
                    <label>Name</label>
                    <form:input path="name" cssClass="form-control" maxlength="255"/>
                </div>
            </div>
            <div class="row">
                <div class="form-group col">
                    <label><fmt:message key="label.product.namevi"/></label>
                    <form:input path="namevi" cssClass="form-control" maxlength="255"/>
                </div>
                <div class="form-group col">
                    <label><fmt:message key="label.product.category"/></label>
                    <form:select path="categoryurl" cssClass="form-control">
                        <c:forEach var="ct" items="${categories}">
                            <form:option value="${ct.nameurl}">${ct.name}</form:option>
                        </c:forEach>
                    </form:select>
                </div>
                <div class="form-group col">
                    <label><fmt:message key="label.manufacturer"/></label>
                    <form:select path="manufacturer.manufacturerid" cssClass="form-control">
                        <c:forEach var="ct" items="${manufacturers}">
                            <form:option value="${ct.manufacturerid}">${ct.name}</form:option>
                        </c:forEach>
                    </form:select>
                </div>
            </div>
            <div class="row">
                <div class="form-group col">
                    <label><fmt:message key="label.product.quantity"/></label>
                    <form:input path="quantity" cssClass="form-control" type="number"/>
                </div>
                <div class="form-group col">
                    <label><fmt:message key="label.product.unit"/></label>
                    <form:select path="unit" cssClass="form-control">
                        <c:forEach var="ct" items="${units}">
                            <form:option value="${ct.name}">${ct.name}</form:option>
                        </c:forEach>
                    </form:select>
                </div>
                <div class="form-group col">
                    <label>Price</label>
                    <form:input path="price" cssClass="form-control" />
                </div>
                <div class="form-group col">
                    <label>Weight (for shiping fee)</label>
                    <form:input path="weight" cssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label>Keyword</label>
                <form:input path="keyword" cssClass="form-control" maxlength="255"/>
            </div>
            <div class="form-group">
                <label>Image</label>
                <form:input path="image" cssClass="form-control" maxlength="255"/>
            </div>
            <div class="row">
                <div class="form-group col-md-6">
                    <label><fmt:message key="label.product.description"/></label>
                    <textarea name="description" class="form-control">
                            ${product.description}
                    </textarea>
                </div>
                <div class="form-group col-md-6">
                    <label><fmt:message key="label.product.description-local-lang"/></label>
                    <textarea name="descriptionvi" class="form-control">
                            ${product.descriptionvi}
                    </textarea>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-2">
                    <form:checkbox path="visible"/>
                    <label class="form-check-label">Visible</label>
                </div>
                <div class="form-group col-2">
                    <c:choose>
                        <c:when test="${fn:contains(site.agent.supplierproducts,'APPOINTMENT')}">
                            <form:checkbox path="timing"/>
                            <label class="form-check-label">Timing</label>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="timing" value="false">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="form-group col-8">
                    <div class="float-right">
                    <button class="btn btn-primary" type="button" onclick="itemFormSubmit()">Save</button>
                    </div>
                </div>
            </div>
        </form:form>
        <h4>Gallery</h4>
        <div class="row">
            <div class="col">
                <form action="/bo/data/${product.productid}/file-upload" class="dropzone">

                </form>
            </div>
            <c:if test="${not empty albumitems}">
                <div class="col">
                    <div class="card-group">
                    <c:forEach items="${albumitems}" var="item">
                        <div class="card albumItem-${item.albumitemid}">
                            <img src="${item.url}" alt="${item.name}" class="card-img-top">
                            <div class="card-body">
                                <a class="item-url" href="#" onclick="setProductImage(this)" title="click to set as product avatar">${item.url}</a>
                                <span class="float-right">
                                    <a href="#" onclick="deleteAlbumItem(${item.albumitemid})"><i class="fa fa-trash" aria-hidden="true"></i></a>
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>
<div class="d-none" id="base64_encoded_path">${base64_encoded_path}</div>
