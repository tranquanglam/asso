<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<h1>Add/Edit Promotion</h1>
<div class="mt-3">
    <div class="product-container">
        <form:form id="promotionFormBean" commandName="promotionForm" class="form-horizontal" action="${requestScope['javax.servlet.forward.request_uri']}" method="POST">
            <form:hidden path="promotionid"/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="row">
            <div class="form-group col-md">
                <label>Level</label>
                <form:input path="level" cssClass="form-control" min="0" maxlength="2" />
            </div>
            <div class="form-group col-md">
                <label>Type</label>
                <form:select path="promotiontypeid" cssClass="form-control" placeholder="Type" id="promotiontypeid">
                    <form:options items="${promotiontypes}" itemLabel="name" itemValue="promotiontypeid"/>
                </form:select>
            </div>
            <div class="form-group col-md">
                <label>Code</label>
                <form:input path="code" cssClass="form-control" placeholder="Code" />
            </div>
            </div>
            <div class="row">
            <div class="form-group col-md">
                <label>Book from date</label>
                <div>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i> </span>
                        <form:input path="startdate" cssClass="form-control" id="groupStartdate" />

                    </div>
                    <span class="help-block">format mm/dd/yyyy</span>
                </div>
            </div>
            <div class="form-group col-md">
                <labe>To Date</labe>
                <div>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i> </span>
                        <form:input path="enddate" cssClass="form-control" id="groupEnddate"/>
                    </div>

                    <span class="help-block">format mm/dd/yyyy</span>
                </div>
            </div>
            </div>
            <div class="row">
            <div class="form-group col-md">
                <label>Check In</label>
                <div>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i> </span>
                        <form:input path="checkin" cssClass="form-control" id="checkin" />
                    </div>
                    <span class="help-block">format mm/dd/yyyy</span>
                </div>
            </div>
            <div class="form-group col-md">
                <label>Check Out</label>
                <div>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i> </span>
                        <form:input path="checkout" cssClass="form-control" id="checkout"/>
                    </div>
                    <span class="help-block">format mm/dd/yyyy</span>
                </div>
            </div>
            </div>
            <div class="row">
            <div class="form-group col-md">
                <label>% Discount</label>
                <form:input type="number" max="100" min="0" step="0.01" path="savingpercent" cssClass="form-control" placeholder="0"/>
            </div>
            <div class="form-group col-md" id="g-discount">
                <label>Discount</label>
                <form:input type="number" path="discount" cssClass="form-control" placeholder="Discount"/>
            </div>
            <div class="form-group col-md d-none">
                <label></label>
                <div class="col-md-7">
                    <div class="checkbox-nice">
                        <form:checkbox path="adultonly" label="For adult only"/>
                    </div>
                </div>
            </div>
            <div class="form-group col-md">
                <label>Minimum</label>
                <form:input type="number" path="minimum" cssClass="form-control" placeholder="Minimum"/>
            </div>
            </div>
            <div class="form-group">
                <label>Description</label>
                <form:input path="description" cssClass="form-control" placeholder="Description" />
            </div>
            <div class="form-group">
                <div>
                    <button type="submit" class="btn btn-primary">Save</button>
                    <a href="${pageContext.request.contextPath}/agent/promotions" class="btn btn-warning">Cancel</a>
                </div>
            </div>
        </form:form>
    </div>
</div>

<%--
<div class="row">
    <div class="col-xs-12">
        <div class="main-box clearfix">
            <header class="main-box-header clearfix">
                <c:if test="${not empty errors}">
                    <div class="alert alert-danger" id="error-message">
                        <c:forEach items="${errors}" var="e">
                            ${e.defaultMessage} <br>
                        </c:forEach>
                    </div>
                </c:if>
            </header>
            <div class="main-box-body clearfix">

            </div>
        </div>
    </div>
</div>

--%>
