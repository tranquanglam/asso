<%@ include file="/common/taglibs.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
    <form:form id="userForm" class="form-horizontal" commandName="item" method="POST" action="/admin/user/edit.html" validate="validate">
        <c:set var="passwordVar" value="${item.pojo.password}"></c:set>
            <form:hidden path="pojo.userID"/>
                <div class="row form-group">
                    <label class="col-md-2">
                        First Name
                        <span class="field_required">*</span>
                    </label>
                    <div class="col-md-8">
                        <form:input path="pojo.firstName" cssClass="required form-control"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-md-2">
                        Last Name
                        <span class="field_required">*</span>
                    </label>
                    <div class="col-md-8">
                        <form:input path="pojo.lastName" cssClass="required form-control"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-md-2">
                        Email
                        <span class="field_required">*</span>
                    </label>
                    <div class="col-md-8">
                        <form:input id="email" path="pojo.email" cssClass="required form-control"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-md-2">
                        Password
                        <span class="field_required">*</span>
                    </label>
                    <div class="col-md-8">
                        <input type="password" id="adminPassword" name="pojo.password" class="required form-control" value="${passwordVar}"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-md-2">
                        Password confirm
                        <span class="field_required">*</span>
                    </label>
                    <div class="col-md-8">
                        <input type="password" password id="adminConfirmedPassword" name="adminConfirmedPassword" class="required form-control" value="${passwordVar}"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-md-2"></label>
                    <div class="col-md-8">
                        <a class="btn btn-success" onclick="trimAndSubmitForm('#userForm');return false;" style="cursor: pointer;">
                            <i class="icon-save"></i>
                            Update Profile
                        </a>
                        <a class="link_cancel" href="/admin/user/list.html" style="cursor: pointer;">Cancel</a>
                    </div>
                </div>
        <input type="hidden" name="crudaction" value="insert-update" />
    </form:form>
    </div>
        </div>
    </div>
<script type="text/javascript">

    function trimAndSubmitForm(formId) {
        $('input:text').each(function () {
            $(this).val($.trim($(this).val()));
        });
        $(formId).submit();
    }
</script>