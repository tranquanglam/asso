<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    .table-responsive {
        min-height: 60vh;
    }
</style>

<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>

<header>
    <div class="">
        <div class="border-bottom pt-6">
            <div class="row align-items-center">
                <div class="col-sm col-12">
                    <h1 class="h2 ls-tight">
                        <fmt:message key="label.product"/>
                    </h1>
                </div>

                <div class="col-sm-auto col-12 mb-1">
                    <div class="hstack gap-2 justify-content-sm-end">
                        <security:authorize access="hasAnyAuthority('AGT_ADMIN','PRODUCT_W')">
                            <button class="btn btn-sm btn-primary" onclick="addContent()"> <fmt:message key="title.add"/> <fmt:message key="label.product"/> </button>
                        </security:authorize>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="mt-2 mb-4">
    <div class="product-container">


        <div class="my-3  vstack gap-4 ">
            <div class="row">
                <c:if test="${not empty messageResponse}">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>${messageResponse}</strong>
                    </div>
                </c:if>
                <div class="col-md-9">
                    <form:form id="myForm" cssClass="form-inline" action="/bo/data/products.html" method="post" commandName="mineBean">
                        <div class="row d-flex justify-content-start">
                            <div class="col-4 form-group">
                                <form:select path="categoryurl" cssClass="form-select ">
                                    <option value=""><fmt:message key="label.product.category"/></option>
                                    <c:forEach var="ct" items="${categories}">
                                        <form:option value="${ct.nameurl}">${ct.name}</form:option>
                                    </c:forEach>
                                </form:select>
                            </div>
                            <div class="col-4 form-group">
                                <c:set var="mdc"><fmt:message key='label.product'/></c:set>
                                <form:input  path="searchTerm" placeholder="${mdc}" maxlength="64" cssClass="form-control "/>
                            </div>
                            <div class="col-4 form-group">
                                <button type="submit" class="btn btn-primary"><span><fmt:message key="label.search"/> </span></button>
                            </div>
                        </div>
                        <form:hidden path="page" id="formPage"/>
                    </form:form>
                </div>
                <div class="col-md-3 text-end">

                </div>
            </div>
            <div class="card">
                <div class="card-header border-bottom d-flex align-items-center">
                    <h5 class="me-auto"><fmt:message key="label.product"/></h5>
                </div>
                <div class="box-table">
                    <div class="table-responsive table-responsive-last">
                        <table id="table_products" class="table table-borderless table-striped">
                            <thead class="table-light">
                            <tr>
                                <th></th>
                                <th><fmt:message key="label.product.name"/>/<fmt:message key="label.product.code"/></th>
                                <th class=" text-end"><fmt:message key="label.product.quantity"/></th>
                                <th class=" text-end"><fmt:message key="label.product.unit"/></th>
                                <th class=" text-end"><fmt:message key="price"/></th>
                                <th class=" text-end"><fmt:message key="booking.inputprice"/></th>
                                <th class=" text-end"><fmt:message key="weight"/></th>
                                <th><fmt:message key="label.product.category"/></th>
                                <th><fmt:message key="label.manufacturer"/></th>
                                <th><fmt:message key="label.visible"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${items.listResult}" var="em">
                                <tr id="item_${em.productid}" class="item-${em.visible}">
                                    <td>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-sm btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="bi bi-gear"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item py-1" href="/bo/data/${em.productid}/productprices.html"><fmt:message key="price"/></a></li>
                                                <li><a class="dropdown-item py-1" href="/bo/data/${em.productid}/productForm.html"> <fmt:message key="title.edit"/> </a></li>
                                                <li><a class="dropdown-item py-1" href="/bo/data/${em.productid}/productdescription.html"> <fmt:message key="label.product.description"/> </a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item" href="/bo/data/${em.productid}/productfeatures.html"><fmt:message key="label.product.feature"/></a></li>
                                                <li><a class="dropdown-item py-1" href="/bo/data/${em.productid}/productmaterials.html"> <fmt:message key="label.material"/> </a></li>
                                            </ul>
                                        </div>
                                    </td>
                                    <td class=" text-primary">
                                        <span class="item_name"></span>${em.name}
                                        <br>
                                        <span class="item_code font-italic">${em.code}</span>
                                        <span class="item_namevi d-none">${em.namevi}</span>
                                    </td>
                                    <td class="item_quantity text-end">${em.quantity}</td>
                                    <td class="item_unit text-end">${em.unit}</td>
                                    <td class="item_price text-end">
                                        <c:if test="${not empty em.price}">
                                            <fmt:formatNumber value="${em.price}" maxFractionDigits="0"/>
                                        </c:if>
                                    </td>
                                    <td class="item_price text-end">
                                        <c:if test="${not empty em.price}">
                                            <fmt:formatNumber value="${em.inputprice}" maxFractionDigits="0"/>
                                        </c:if>
                                    </td>
                                    <td class="item_weight text-end">${em.weight}</td>
                                    <td class="item_categoryurl">${em.categoryurl}</td>
                                    <td class="item_manufacturer" data-manufacturerid="${em.manufacturer.manufacturerid}">${em.manufacturer.name}</td>
                                    <td class="item_visible">${em.visible}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer">
                    <ul class="nav">
                        <c:if test="${items.hasPrevious}">
                            <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-arrow-left"></i></a></li>
                        </c:if>
                        <c:if test="${items.totalPages > 1}">
                            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                                <li class="nav-item"><a class="nav-link ${items.page eq loop.count?'current':''}" href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
                            </c:forEach>
                        </c:if>
                        <c:if test="${items.hasNext}">
                            <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-arrow-right"></i></a></li>
                        </c:if>
                    </ul>
                </div>
            </div>

        </div>

    </div>
</div>
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby=formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel">Add/Edit <fmt:message key="label.product"/></h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/bo/data/productForm.html" method="post" id="itemForm">
                    <input type="hidden" name="productid" value="0"/>
                    <div class="row">
                        <div class="form-group col-4">
                            <label>Code</label>
                            <input name="code" class="form-control" maxlength="255"/>
                        </div>
                        <div class="form-group col-8">
                            <label>Name</label>
                            <input name="name" class="form-control" maxlength="255"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.product.namevi"/></label>
                            <input name="namevi" class="form-control" maxlength="255"/>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.product.category"/></label>
                            <select name="categoryurl" class="form-control">
                                <c:forEach var="ct" items="${categories}">
                                    <option value="${ct.nameurl}">${ct.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.manufacturer"/></label>
                            <select name="manufacturer.manufacturerid" class="form-control">
                                <c:forEach var="ct" items="${manufacturers}">
                                    <option value="${ct.manufacturerid}">${ct.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key="label.product.quantity"/></label>
                            <input name="quantity" class="form-control" type="number" value="1" />
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key="label.product.unit"/></label>
                            <select name="unit" class="form-control">

                                <c:forEach var="ct" items="${units}">
                                    <option value="${ct.name}">
                                        <c:choose>
                                            <c:when test="${not empty lang && lang eq 'vi'}">
                                                ${ct.namevi}
                                            </c:when>
                                            <c:otherwise>
                                                ${ct.name}
                                            </c:otherwise>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col">
                            <label>Price</label>
                            <input name="price" class="form-control" type="number" value="10"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="checkbox" name="visible" class=""/>
                        <label class="form-check-label">Visible</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="itemFormSubmit()">Save</button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
