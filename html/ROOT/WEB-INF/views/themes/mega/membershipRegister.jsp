<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="/themes/mega/css/login.css" />
<c:set var="pageName"><fmt:message key="customer.register"/></c:set>
<c:if test="${page != null}">
    <c:set var="pageName">${page.name}</c:set>
</c:if>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="mg-sec-title mt-3">
                    <h3>${pageName}</h3>
                </div>
                <div class="d-flex justify-content-center align-items-center">
                    <div class="login-container container">
                        <form method="post" class="justify-content-center" id="membershipForm">
                            <input type="hidden" name="hash" value="${bean.hash}">

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input name="email" type="email" class="form-control input-block-level required email"
                                               placeholder="<fmt:message key='registry.username'/>"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input name="password" type="password" class="form-control input-block-level required"
                                               placeholder="<fmt:message key='registry.password'/>"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input name="firstName" class="form-control input-block-level" placeholder="<fmt:message key='membership.register.firstname'/>"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input name="lastName" class="form-control input-block-level required"
                                               placeholder="<fmt:message key='membership.register.lastname'/>"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input name="phone" class="form-control input-block-level required" placeholder="Phone"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <select name="countryCode" class="form-control">
                                            <option value=""><fmt:message key="label.country"/></option>
                                            <c:forEach var="country" items="${countryList}">
                                                <option value="${country.code}">${country.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <button class="btn btn-success" type="submit"><fmt:message key="customer.register"/></button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

<div class="modal" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="resultModalLabel"></h4>
            </div>
            <div class="modal-body">
                <h4 class="result-success d-none">
                    <c:choose>
                        <c:when test="${page != null}">
                            ${page.content}
                        </c:when>
                        <c:otherwise>
                            You have been registered successfully!
                        </c:otherwise>
                    </c:choose>
                </h4>
                <h4 class="result-error d-none">

                </h4>
            </div>
            <div class="modal-footer">
                <a href="/" class="btn btn-primary gohomeBtn"><i class="fa fa-home" aria-hidden="true"></i></a>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script src="/themes/mega/js/jquery.validate.min.js"></script>
<script>
    $('#membershipForm').validate({
        rules: {
            lastName: 'required',
            email: 'required',
            password: 'required',
            phone: 'required'
        },
        messages: {
            lastName: "<fmt:message key='membership.register.lastname'/>",
            email: "Email",
            password: "<fmt:message key='registry.password'/>",
            phone: "Phone is required",
        },
        submitHandler: function(form) {
            var formData = $("#membershipForm").serializeFormJSON();
            $.ajax({
                url: '/membershipRegister.json',
                type: 'POST',
                data: JSON.stringify(formData),
                contentType: "application/json",
                dataType: 'json',
                success: function(result) {
                    if (result.errorCode == null) {
                        $('#resultModal').find('.result-success').removeClass('d-none');
                        $('#resultModal').find('.result-error').addClass('d-none');
                    } else {
                        $('#resultModal').find('.result-success').addClass('d-none');
                        $('#resultModal').find('.result-error').removeClass('d-none');
                        $('#resultModal').find('.result-error').html(result.errorMessage);
                    }
                    $('#resultModal').modal('show');
                }
            });
        }
    });
</script>
