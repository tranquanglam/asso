<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>

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
                            <form:option value="${ct.name}">
                                <c:choose>
                                    <c:when test="${not empty lang && lang eq 'vi'}">
                                        ${ct.namevi}
                                    </c:when>
                                    <c:otherwise>
                                        ${ct.name}
                                    </c:otherwise>
                                </c:choose>
                            </form:option>
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
                <form:select path="keyword" cssClass="form-control" multiple="multiple">
                    <c:forEach var="keyword" items="${keywordList}">
                        <c:choose>
                            <c:when test="${not empty mapKeywordProduct[keyword]}">
                                <form:option value="${keyword}" selected="selected">${keyword}</form:option>
                            </c:when>
                            <c:otherwise>
                                <form:option value="${keyword}">${keyword}</form:option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </form:select>
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
                    <div class="d-flex flex-row-reverse">
                        <security:authorize access="hasAnyAuthority('AGT_ADMIN','PRODUCT_W')">
                            <button class="btn btn-primary" type="button" onclick="itemFormSubmit()">Save</button>
                        </security:authorize>
                    </div>
                </div>
            </div>
        </form:form>
        <h4>Gallery</h4>
        <div class="row row-cols-1">
            <div class="col">
                <form action="/bo/data/${product.productid}/file-upload" class="dropzone">

                </form>
            </div>
            <c:if test="${not empty albumitems}">
                <div class="col">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                            <tr>
                                <th>Image</th>
                                <th>No.</th>
                                <th>Name</th>
                                <th>Image URL</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach items="${albumitems}" var="item">
                                <tr id="item_${item.albumitemid}" class="albumItem-${item.albumitemid}">
                                    <td><img src="${item.url}" alt="${item.name}" width="100px;"></td>
                                    <td class="item_ordernumber">1</td>
                                    <td class="item_name">${item.name}</td>
                                    <td class="item_url">${item.url}</td>
                                    <td class="text-end">
                                        <a class="item-url" href="#" onclick="setProductImage(this)" data-imageurl="${item.url}" title="click to set as product avatar">Set Avatar</a>
                                        |
                                        <a href="#"  class="btn "onclick="deleteAlbumItem(${item.albumitemid})">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </div>
            </c:if>


            <div class="col mt-5">
                <div class="d-flex flex-row-reverse">
                    <security:authorize access="hasAnyAuthority('AGT_ADMIN','PRODUCT_W')">
                        <button class="btn btn-danger" type="button" onclick="itemFormDelete()">Delete Product</button>
                    </security:authorize>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="d-none" id="base64_encoded_path">${base64_encoded_path}</div>
