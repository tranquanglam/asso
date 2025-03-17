<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <h1><fmt:message key="admin.agent.user.add.title"/></h1>
    <div class="row">
        <div class="col">
            <form:form method="post" id="formBean" modelAttribute="userFormBean" class="form-horizontal" role="form">
                <div class="row">
                    <div class="form-group col-md">
                        <label for="email">Username:</label>
                        <form:input type="text" class="form-control" path="username"/>
                    </div>
                    <div class="form-group col-md">
                        <label for="email">Email:</label>
                        <form:input type="text" class="form-control" path="email"/>
                    </div>
                    <div class="form-group col-md">
                        <label for="password"><fmt:message key="membership.register.password"/>:</label>
                        <form:input  type="password" class="form-control" path="password" id="password"/>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="form-group col-md">
                        <label for="firstName"><fmt:message key="membership.register.firstname"/>:</label>
                        <form:input  class="form-control" path="firstName" />
                    </div>
                    <div class="form-group col-md">
                        <label for="lastName"><fmt:message key="membership.register.lastname"/>:</label>
                        <form:input  class="form-control" path="lastName" />
                    </div>
                    <div class="form-group col-md">
                        <label for="phone"><fmt:message key="label.phone"/>:</label>
                        <form:input  cssClass="form-control" path="phone" />
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="form-group col-md">
                        <label><fmt:message key="label.authority"/>:</label>
                        <form:select path="role" cssClass="custom-select form-control">
                            <form:option value="AGT_USER"><fmt:message key="AGT_USER"/></form:option>
                            <form:option value="AGT_SUSER"><fmt:message key="AGT_SUSER"/></form:option>
                            <form:option value="MAPI">MAPI</form:option>
                            <form:option value="PM">PM</form:option>
                            <form:option value="ASSISTANT"><fmt:message key="ASSISTANT"/></form:option>
                            <form:option value="CUSTOMER"><fmt:message key="CUSTOMER"/> </form:option>
                        </form:select>
                    </div>
                    <div class="form-group col-md">
                        <label>UUID:</label>
                        <form:input  cssClass="form-control" path="uuid" readonly="true" />
                    </div>
                    <c:if test="${!(userFormBean.role eq 'MAPI')}">
                        <div class="form-group col-12 mt-3">
                            <label><fmt:message key="label.authority"/></label>

                            <div class="row row-cols-4">
                                <c:forEach items="${authorities}" var="auth">
                                    <div class="col">
                                        <label class="checkbox-inline me-3">
                                            <form:checkbox path="authorities" cssClass="" value="${auth}"/>
                                            <c:choose>
                                                <c:when test="${not empty mapBranch[auth]}">
                                                    ${mapBranch[auth].name}
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:message key="${auth}"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </label>
                                    </div>

                                </c:forEach>
                            </div>

                        </div>
                    </c:if>
                    <c:if test="${userFormBean.role eq 'MAPI'}">
                        <div class="form-group col">
                            <label>Marketplace</label>
                            <c:forEach items="${marketplaces}" var="mp">
                                <label class="radio-inline">
                                    <form:radiobutton path="passportNumber" value="${mp.code}"/> ${mp.domain}
                                </label>
                            </c:forEach>
                        </div>
                    </c:if>
                    <div class="col-12 mt-3">
                        <label class="checkbox-inline"><form:checkbox path="active" label="Active"/></label>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">&nbsp;<fmt:message key="label.save" /></button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" class="btn btn-default" id="deleteUser">&nbsp;<fmt:message key="label.delete"/></button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="/agent/users" class="btn btn-secondary"> <fmt:message key="title.cancel"/>&nbsp;</a>
                    </div>
                </div>
                <input type="hidden" name="formAction" id="formAction">
            </form:form>
        </div>
    </div>
</div>
