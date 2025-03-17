<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/common/taglibs.jsp" %>

<section class="p-4">
    <div class="container-fluid">
        <div class="row mt-3">
            <div class="col">
                <c:if test="${message != null}">
                    <div class="alert alert-info alert-dismissible">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <fmt:message key="${message}"/>
                    </div>
                </c:if>

                <h1>Change password</h1>
                <form:form method="post" id="formBean" modelAttribute="changePasswordForm" class="form-horizontal" role="form">

                    <spring:bind path="currentPassword">
                        <div class="form-group ${status.error ? 'has-error' : '' }">
                            <form:label path="currentPassword" cssClass="col-lg-4 control-label">Current Password:</form:label>
                            <div class="col-lg-8">
                                <form:password path="currentPassword" class="form-control" placeholder="Current Password"/>
                                <c:if test="${status.error}">
                                    <span class="help-block">${status.errorMessage}</span>
                                </c:if>
                            </div>
                        </div>
                    </spring:bind>

                    <spring:bind path="password">
                        <div class="form-group ${status.error ? 'has-error' : '' }">
                            <form:label path="password" cssClass="col-lg-4 control-label">New Password:</form:label>
                            <div class="col-lg-8">
                                <form:password path="password" class="form-control" placeholder="New Password"/>
                                <c:if test="${status.error}">
                                    <span class="help-block">${status.errorMessage}</span>
                                </c:if>
                            </div>
                        </div>
                    </spring:bind>

                    <spring:bind path="confirmPassword">
                        <div class="form-group ${status.error ? 'has-error' : '' }">
                            <form:label path="confirmPassword" cssClass="col-lg-4 control-label">Confirm New Password:</form:label>
                            <div class="col-lg-8">
                                <form:password path="confirmPassword" class="form-control" placeholder="Confirm Password"/>
                                <c:if test="${status.error}">
                                    <span class="help-block">${status.errorMessage}</span>
                                </c:if>
                            </div>
                        </div>
                    </spring:bind>

                    <div class="form-group">
                        <div class="col-lg-offset-2 col-lg-8">
                            <button type="submit" class="btn btn-primary">&nbsp;Save</button>
                            <a class="btn btn-default" href="/my/booking.html">&nbsp;Cancel</a>

                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</section>
