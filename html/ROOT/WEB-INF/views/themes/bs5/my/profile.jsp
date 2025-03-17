<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    #signatureCanvas {
        border:4px solid #444;
        border-radius: 15px;
        background-color: #fafafa;
    }
</style>
<div class="container-profile">
    <c:if test="${message != null}">
        <div class="alert alert-danger alert-dismissible">
            <fmt:message key="${message}"/>
            <a href="#" class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>
        </div>
    </c:if>
    <div class="my-4">
        <h1><fmt:message key="label.my-profile"/></h1>
    </div>
    <div class="row">
        <div class="col-md-3">
            <div class="d-block">
                <div class="card">
                    <div class="card-header">
                        <div class="">
                            <h6 class="">Avatar</h6>
                        </div>
                    </div>
                    <div class="card-body" style="margin: auto;padding: 0;">
                        <a href="#" data-bs-toggle="modal" data-bs-target="#uploadImageModal" title="Click to upload avatar">
                            <c:choose>
                                <c:when test="${not empty userProfileBean.avatar}">
                                    <img src="${userProfileBean.avatar}" alt="..." class="img-fluid" style="max-width: 100%">
                                </c:when>
                                <c:otherwise>Upload Avatar</c:otherwise>
                            </c:choose>
                        </a>
                    </div>
                </div>
            </div>
            <div class="mt-auto"></div>
            <div class="d-block">
                <a href="/my/change-password" class="btn btn-link">Change password</a>
            </div>

            <div class="text-start">

                <div class="card">
                    <div class="card-header">
                        <h6 class="">Signature</h6>
                    </div>
                    <div class="card-body" style="margin: auto;padding: 0;">
                        <a href="#" data-bs-toggle="modal" data-bs-target="#uploadSignatureModal" title="Click to upload Signature">
                            <c:choose>
                                <c:when test="${not empty userProfileBean.uprofile.signature}">
                                    <img src="${userProfileBean.uprofile.signature}" alt="..." class="img-responsive" style="max-width: 100%">
                                </c:when>
                                <c:otherwise>Upload Signature</c:otherwise>
                            </c:choose>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-9">
            <div class="card shadow border-0 mb-10">
                <div class="card-body">
            <form:form id="userProfileFormBean" class="justify-content-center" action="/my/profile.html" method="post" modelAttribute="userProfileBean">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="form-label"><fmt:message key="registry.username"/></label>
                            <span class="form-control">${userProfileBean.userName}</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label"><fmt:message key="membership.register.firstname"/></label>
                            <form:input path="firstName" cssClass="form-control" maxlength="100"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label"><fmt:message key="membership.register.lastname"/></label>
                            <form:input path="lastName" cssClass="form-control" maxlength="100"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label"><fmt:message key="booking.customer.email"/></label>
                            <form:input path="email" cssClass="form-control" maxlength="255"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label"><fmt:message key="booking.customer.phone"/></label>
                            <form:input path="phone" cssClass="form-control" maxlength="15"/>
                        </div>
                    </div>
                    <div class="col-md-6 d-none">
                        <div class="form-group">
                            <label class="form-label"><fmt:message key="label.country"/></label>
                            <form:select path="country" class="form-control">
                                <c:forEach var="country" items="${countryList}">
                                    <form:option value="${country.code}">${country.name}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </div>
                    <c:if test="${not empty states}">
                        <div class="form-group col-md-6">
                            <label class="form-label"><fmt:message key="label.state"/></label>
                            <form:select path="customer.statecode" cssClass="form-control cus-state">
                                <option value="">--<fmt:message key="label.state"/>--</option>
                                <c:forEach items="${states}" var="state">
                                    <form:option value="${state.code}">${state.name}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </c:if>
                    <div class="form-group col-md-6">
                        <label class="form-label"><fmt:message key="label.city"/></label>
                        <form:select path="customer.city" class="form-control cus-city">
                            <option value="">--<fmt:message key="label.city"/>--</option>
                            <c:forEach items="${cities}" var="ct">
                                <form:option value="${ct.code}">${ct.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="form-label"><fmt:message key="label.ward"/></label>
                        <form:select path="customer.zip" cssClass="form-control custom-select cus-zip">
                            <option value=""><fmt:message key="label.ward"/></option>
                            <c:forEach items="${wards}" var="w">
                                <form:option value="${w.zip}">${w.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="form-group col-md-12">
                        <label class="form-label"><fmt:message key='address'/></label>
                        <form:input path="customer.address" cssClass="form-control" maxlength="255"/>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary"><span><fmt:message key="label.save"/></span></button>
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
</div>
<div class="d-none countryid">${country.countryid}</div>
<div class="modal fade" id="uploadImageModal" tabindex="-1" role="dialog" aria-labelledby="uploadImageModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="uploadLogoModalLabel">Upload Image</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="uploadSignatureModal" tabindex="-1" role="dialog" aria-labelledby="uploadSignatureModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="uploadSignatureModalLabel">Upload Signature</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div class="">
                    <canvas id="signatureCanvas"  width=460 height=300 style="margin: auto"></canvas><br><br>
                    <input type="button" value="Reset" id='resetSign'>
                </div>
            </div>
            <div class="modal-footer">
                <button id="updateSignatureCanvas" class="btn btn-primary" type="button" ><fmt:message key="label.upload"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="/themes/mega/js/signature_pad.min.js"></script>

<script>

	function b64toBlob(b64Data, contentType, sliceSize) {
		contentType = contentType || '';
		sliceSize = sliceSize || 512;

		var byteCharacters = atob(b64Data);
		var byteArrays = [];

		for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
			var slice = byteCharacters.slice(offset, offset + sliceSize);

			var byteNumbers = new Array(slice.length);
			for (var i = 0; i < slice.length; i++) {
				byteNumbers[i] = slice.charCodeAt(i);
			}

			var byteArray = new Uint8Array(byteNumbers);

			byteArrays.push(byteArray);
		}

		var blob = new Blob(byteArrays, {type: contentType});
		return blob;
	}


	var signaturePad;
	$(document).ready(function() {
		var canvas = document.getElementById("signatureCanvas",{
			minWidth: 30,
			penColor: "rgb(66, 133, 244)"
		});
		signaturePad = new SignaturePad(canvas);

		var updateSignatureCanvas = document.getElementById('updateSignatureCanvas');
		updateSignatureCanvas.addEventListener('click', function (event) {
			var ImageURL = signaturePad.toDataURL('image/png');
			var block = ImageURL.split(";");
			var contentType = block[0].split(":")[1];// In this case "image/gif"
			var realData = block[1].split(",")[1];// In this case "R0lGODlhPQBEAPeoAJosM...."
			var blob = b64toBlob(realData, contentType);
			var formData = new FormData();
			formData.append("imageFile", blob);

			$.ajax({
				url : '/my/upload-signature.html',
				type : 'POST',
				data : formData,
				processData: false,
				contentType: false,
				success : function(data) {
					window.location.reload();
				}
			});
		});

		var resetSign = document.getElementById('resetSign');
		resetSign.addEventListener('click', function (event) {
			signaturePad.clear();
		});

	});
</script>
