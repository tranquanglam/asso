<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item"><a href="/agent/apisites">Api sites</a></li>
                    <li class="breadcrumb-item active">Api site</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1>Add/Edit API site</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <form:form action="/agent/apisites/apisiteForm" method="post" id="apisiteForm" commandName="apisite" class="form-horizontal" role="form">
                <form:hidden path="apisiteid" />
                <div class="form-group">
                    <label class="col-sm-2 control-label">Site Url</label>
                    <div class="col-sm-8">
                        <form:input path="siteurl" cssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Stype</label>
                    <div class="col-sm-8">
                        <form:select path="stype" cssClass="form-control">
                            <form:options items="${stypes}" itemLabel="key" itemValue="key"/>
                        </form:select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Resource id</label>
                    <div class="col-sm-8">
                        <form:input path="resourceid" cssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Client id</label>
                    <div class="col-sm-8">
                        <form:input path="clientid" cssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Client secret</label>
                    <div class="col-sm-8">
                        <form:input path="clientsecret" cssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">&nbsp;</label>
                    <div class="col-sm-8">
                        <label class="radio-inline">
                            <form:radiobutton path="visible" value="true"/> Visible &nbsp;&nbsp;&nbsp;&nbsp;
                        </label>
                        <label class="radio-inline">
                            <form:radiobutton path="visible" value="false"/> Invisible
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-8">
                        <form:input path="email" cssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Full name</label>
                    <div class="col-sm-8">
                        <form:input path="fullname" cssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Phone</label>
                    <div class="col-sm-8">
                        <form:input path="phone" cssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Country</label>
                    <div class="col-sm-8">
                        <form:input path="country" cssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Code</label>
                    <div class="col-sm-8">
                        <form:input path="code" cssClass="form-control" maxlength="9" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Point</label>
                    <div class="col-sm-8">
                        <form:input path="point" cssClass="form-control" maxlength="15" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-8">
                        <a onclick="submitForm();" class="btn btn-primary">&nbsp;Save</a>
                        <a href="/agent/apisites" class="btn btn-link">&nbsp;Cancel</a>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>