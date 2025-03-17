<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container-fluid">
    <c:if test="${message != null}">
        <div class="alert alert-danger alert-dismissible">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <fmt:message key="${message}"/>
        </div>
    </c:if>
    <div>
        <h1><fmt:message key="label.my-profile"/></h1>
    </div>
    <div class="row">
        <div class="col-md-3">
            <div>
                <div class="card">
                    <div class="card-header">
                        <div class="">
                            <h6 class="">Avatar</h6>
                        </div>
                    </div>
                    <div class="card-body" style="margin: auto;padding: 0;">
                        <a href="#" data-toggle="modal" data-target="#uploadImageModal" title="Click to upload avatar">
                            <c:choose>
                                <c:when test="${not empty userProfileBean.avatar}">
                                    <img src="${userProfileBean.avatar}" alt="..." class="img-responsive" style="max-width: 100%">
                                </c:when>
                                <c:otherwise>Upload Avatar</c:otherwise>
                            </c:choose>
                        </a>
                    </div>
                </div>
            </div>
            <div>
                <a href="/my/change-password" class="btn btn-link">Change password</a>
            </div>
        </div>

        <div class="col-md-9">
            <div class="login-container">
            <form:form id="userProfileFormBean" class="justify-content-center" action="/my/profile.html" method="post" modelAttribute="userProfileBean">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label><fmt:message key="registry.username"/></label>
                            <span class="form-control">${userProfileBean.userName}</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label><fmt:message key="membership.register.firstname"/></label>
                            <form:input path="firstName" cssClass="form-control" maxlength="100"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label><fmt:message key="membership.register.lastname"/></label>
                            <form:input path="lastName" cssClass="form-control" maxlength="100"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label><fmt:message key="booking.customer.email"/></label>
                            <form:input path="email" cssClass="form-control" maxlength="255"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label><fmt:message key="booking.customer.phone"/></label>
                            <form:input path="phone" cssClass="form-control" maxlength="15"/>
                        </div>
                    </div>
                    <div class="col-md-6 d-none">
                        <div class="form-group">
                            <label><fmt:message key="label.country"/></label>
                            <form:select path="country" class="form-control">
                                <c:forEach var="country" items="${countryList}">
                                    <form:option value="${country.code}">${country.name}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </div>
                    <c:if test="${not empty states}">
                        <div class="form-group col-md-6">
                            <label><fmt:message key="label.state"/></label>
                            <form:select path="customer.statecode" cssClass="form-control cus-state">
                                <option value="">--<fmt:message key="label.state"/>--</option>
                                <c:forEach items="${states}" var="state">
                                    <form:option value="${state.code}">${state.name}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </c:if>
                    <div class="form-group col-md-6">
                        <label><fmt:message key="label.city"/></label>
                        <form:select path="customer.city" class="form-control cus-city">
                            <option value="">--<fmt:message key="label.city"/>--</option>
                            <c:forEach items="${cities}" var="ct">
                                <form:option value="${ct.code}">${ct.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="form-group col-md-6">
                        <label><fmt:message key="label.ward"/></label>
                        <form:select path="customer.zip" cssClass="form-control custom-select cus-zip">
                            <option value=""><fmt:message key="label.ward"/></option>
                            <c:forEach items="${wards}" var="w">
                                <form:option value="${w.zip}">${w.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="form-group col-md-12">
                        <label><fmt:message key='address'/></label>
                        <form:input path="customer.address" cssClass="form-control" maxlength="255"/>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="form-group">
                            <button type="submit" class="btn btn-green"><span><fmt:message key="label.save"/></span></button>
                            <div class="btn btn-gray-dark">
                                <a href="javascript:window.location='/'; ">
                                    <span><fmt:message key="label.cancel"/></span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </form:form>
            </div>
        </div>
    </div>
</div>
<div class="d-none countryid">${country.countryid}</div>
<div class="modal fade" id="uploadImageModal" tabindex="-1" role="dialog" aria-labelledby="uploadImageModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="uploadLogoModalLabel">Upload Image</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="uploadImageForm" method="post" action="/my/upload-avatar.html" enctype="multipart/form-data">
                    <div class="form-group">
                        <input type="file" name="imageFile"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="document.getElementById('uploadImageForm').submit();"><fmt:message key="label.upload"/></button>
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

