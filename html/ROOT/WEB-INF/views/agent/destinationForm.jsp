<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item"><a href="/agent/destinations">Destinations</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${formBean.pojo.name}</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <form:form method="post" id="siteForm" commandName="formBean" class="form-horizontal" role="form" enctype="multipart/form-data">
                <input type="hidden" name="pojo.destinationid">
                <div class="row">
                <div class="form-group col-md-6 mb-3">
                    <label><fmt:message key="label.destype"/></label>
                    <form:select path="pojo.destype"  cssClass="form-control">
                        <c:forEach items="${destypes}" var="destype">
                            <form:option value="${destype}"><fmt:message key="${destype}"/></form:option>
                        </c:forEach>
                    </form:select>
                </div>
                <div class="form-group col-md-6 mb-3">
                    <label><fmt:message key="admin.agent.destination.name"/>:</label>
                    <form:input type="text" class="form-control" path="pojo.name"/>
                </div>
                <div class="form-group col-md-6 mb-3">
                    <label>Page Name Url:</label>
                    <form:input type="text" class="form-control" path="pojo.nameurl"/>
                </div>
                <div class="form-group col-md-6 mb-3">
                    <label>Longitude:</label>
                    <form:input type="number" class="form-control" path="pojo.longitude" step="0.000001"/>
                </div>
                <div class="form-group col-md-6 mb-3">
                    <label>Latitude:</label>
                    <form:input type="number" class="form-control" path="pojo.latitude" step="0.000001"/>
                </div>
                <c:if test="${not empty states}">
                    <div class="form-group col-md-6 mb-3">
                        <label><fmt:message key="label.state"/></label>
                        <select name="pojo.state.code" class="form-control cus-state">
                            <option value=""></option>
                            <c:forEach items="${states}" var="state">
                                <option value="${state.code}" ${(formBean.pojo.state != null && formBean.pojo.state.code eq state.code) ? 'selected' : ''}>${state.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>
                <div class="form-group col-md-6 mb-3">
                    <label><fmt:message key="label.city"/></label>
                    <form:hidden path="pojo.country.countryid" cssClass="countryid"/>
                    <form:select path="pojo.city.cityid"  cssClass="form-control cus-city">
                        <option value="0"></option>
                        <form:options items="${cities}" itemValue="cityid" itemLabel="name"></form:options>
                    </form:select>
                </div>
                <div class="form-group col-md-6 mb-3">
                    <label>Avatar</label>
                    <div id="avatar">
                        <c:choose>
                            <c:when test="${not empty formBean.pojo.avatar}">
                                <img src="${formBean.pojo.avatar}"/>
                                <a href="#" onclick="editAvatar();" title="Edit Avatar">
                                    Edit
                                </a>
                            </c:when>
                            <c:otherwise>
                                <input type='file' name='avatarFile' size='40' />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group col-md-6 mb-3">
                    # <form:input type="number" class="form-control" path="pojo.ordernumber" step="1"/>
                </div>
                <div class="form-group col-md-6 mb-3">
                    <form:checkbox cssClass="form-check-inline" path="pojo.visible" label=""/>  Visible
                </div>
                </div>
                <div class="form-group my-4">
                    <button type="submit" class="btn btn-primary">&nbsp;<fmt:message key="title.submit"/></button>
                </div>
            </form:form>
        </div>
    </div>
</div>