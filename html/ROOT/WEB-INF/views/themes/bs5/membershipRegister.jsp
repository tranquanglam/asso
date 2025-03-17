<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="pageName"><fmt:message key="customer.register"/></c:set>
<c:if test="${page.name != null}">
    <c:set var="pageName">${page.name}</c:set>
</c:if>
<section class="slice slice-lg min-vh-100 d-flex align-items-center bg-gradient-primary" data-offset-top="#header-main">
    <!-- SVG background -->
    <%--<div class="bg-absolute-cover bg-size--contain d-none d-lg-block">
        <figure class="w-100">
            <img alt="Login image" src="https://membooking.com/themes/purpose/img/svg/backgrounds/login.svg" class="svg-inject">
        </figure>
    </div>--%>
    <div class="container py-1 px-md-0 d-flex align-items-center">
        <div class="w-100"><script src="/themes/mega/js/jquery.validate.min.js"></script>
            <div class="row row-grid justify-content-center justify-content-lg-between align-items-center">
                <div class="col-sm-8 col-lg-7 order-lg-2">
                    <div class="card shadow zindex-100 mb-0">
                        <div class="card-body px-md-12 py-12">
                            <div class="mb-5">
                                <h1 class="h3">${pageName}</h1>
                                <p class="text-muted mb-0">${page2.name}</p>
                            </div>
                            <form method="post" class="justify-content-center" id="membershipForm">
                                <input type="hidden" name="hash" value="${bean.hash}">
                                <div class="row g-5">

                                    <div class="col-md-6">
                                        <div class="">
                                            <label class="form-label" for="email"><fmt:message key="membership.register.email"/></label>
                                            <input name="email" type="email" class="form-control input-block-level required email"
                                                   placeholder="Email"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="">
                                            <label class="form-label" for="password"><fmt:message key="membership.register.password"/></label>
                                            <input name="password" type="password" class="form-control input-block-level required"
                                                   placeholder="<fmt:message key='registry.password'/>"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="">
                                            <label class="form-label" for="firstName"><fmt:message key="membership.register.firstname"/></label>
                                            <input name="firstName" class="form-control input-block-level" placeholder="<fmt:message key='membership.register.firstname'/>"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="">
                                            <label class="form-label" for="lastName"><fmt:message key="membership.register.lastname"/></label>
                                            <input name="lastName" class="form-control input-block-level required"
                                                   placeholder="<fmt:message key='membership.register.lastname'/>"/>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="">
                                            <label class="form-label" for="phone"><fmt:message key="membership.register.phone"/></label>
                                            <input name="phone" class="form-control input-block-level required" placeholder="Phone"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="">
                                            <label class="form-label" for="lastName"><fmt:message key="membership.register.country"/></label>
                                            <select name="countryCode" class="form-select">
                                                <option value=""><fmt:message key="membership.register.country"/></option>
                                                <c:forEach var="country" items="${countryList}">
                                                    <option value="${country.code}">${country.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="">
                                            <button class="btn btn-success" type="submit"><fmt:message key="customer.register"/></button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 order-lg-1 d-none d-lg-block zindex-100">
                    <blockquote>
                        <h2 class="h2 mb-4">${page2.content}</h2>
                        <footer>— <cite class="text-lg">${page2.name}</cite></footer>
                    </blockquote>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="modal" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h2 class="modal-title" id="resultModalLabel"></h2>
            </div>
            <div class="modal-body">
                <h2 class="result-success d-none">
                    <c:choose>
                        <c:when test="${page.content != null}">
                            ${page.content}
                        </c:when>
                        <c:otherwise>
                            You have been registered successfully!
                        </c:otherwise>
                    </c:choose>
                </h2>
                <h2 class="result-error d-none">

                </h2>
            </div>
            <div class="modal-footer">
                <a href="/" class="btn btn-primary gohomeBtn"><i class="bi bi-house" aria-hidden="true"></i></a>
                <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
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
