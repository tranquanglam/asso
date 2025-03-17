<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item" aria-current="page"><a href="/agent/emailTemplates">Email Templates</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h2>Email Settings</h2>
            <form:form action="/agent/settings/email" method="post" id="formBean" commandName="emailSettingsFormBean"
                       class="form-horizontal" role="form">
                <div class="row">
                    <div class="form-group col-md">
                        <label>Host: ${emailSettingsFormBean.host}</label>
                    </div>
                    <div class="form-group col-md">
                        <label>Port: ${emailSettingsFormBean.port}</label>
                    </div>
                    <div class="form-group col-md">
                        <label>Username: ${emailSettingsFormBean.username}</label>
                    </div>
                    <div class="form-group col-md">
                        <label>Password: **********</label>
                    </div>
                    <div class="form-group col-md">
                        <label>Sender name: ${emailSettingsFormBean.fromname}</label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="mt-3">
                        <a href="/agent/settings/email" class="btn btn-success">&nbsp;Edit</a>
                        <button type="button" class="btn btn-default btn-send-test-email">&nbsp;Send Test Email</button>
                    </div>
                </div>

            </form:form>
        </div>
    </div>
    <div class="row mt-4 pt-4 border-top">
        <div class="col-md">
            <h3>Payment Methods</h3>
            <div class="mt-3">
                <a href="/agent/paymentMethods">Payment method settings</a>
            </div>
        </div>
        <div class="col-md">
            <h3>Single Sign On Settings</h3>
            <div class="mt-3">
                <a href="/agent/authenticationMethods/GG/edit">Google</a> | <a href="/agent/authenticationMethods/FB/edit">Facebook</a>
            </div>
        </div>
        <div class="col-md">
            <h3>Enet chat key</h3>
            <div class="mt-3">
                <span class="enet-chat-key px-3">${site.zendesk}</span> <a href="javascript:void(0)" class="btn btn-outline-secondary btn-refresh-enet-chat-key">Refresh</a>
                <c:if test="${not empty site.zendesk}"> | <a href="javascript:void(0)" class="btn btn-outline-secondary btn-disable-enet-chat">Disable</a></c:if>
            </div>
        </div>
    </div>

    <div class="row my-4 pt-4 border-top">
        <div class="col-lg-12">
            <h2>Company Information</h2>
            <div class="mt-3">
                <form:form action="/agent/settings/company" method="post" id="formBean" commandName="companyFormBean" class="form-horizontal" role="form"
                           enctype="multipart/form-data">
                    <div class="row">
                        <div class="form-group col-md">
                            <label>Name:</label>
                            <form:input type="text" class="form-control" path="pojo.name"/>
                        </div>
                        <div class="form-group col-md">
                            <label>Address:</label>
                            <form:input type="text" class="form-control" path="pojo.address"/>
                        </div>
                        <div class="form-group col-md">
                            <label>Country:</label>
                            <form:select path="countryid" class="form-control custom-select">
                                <c:forEach var="ct" items="${countries}">
                                    <form:option value="${ct.countryid}">${ct.name}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="form-group col-md">
                            <label>Invoice Logo:</label>
                            <div>
                                <img src="${companyFormBean.pojo.logo}" height="50px">
                                <br/>
                                <br/>
                                <form:input type="file" path="logo" />
                            </div>
                        </div>
                        <div class="form-group col-md">
                            <label>Signature:</label>
                            <div>
                                <img src="${companyFormBean.pojo.signature}" height="50px">
                                <br/>
                                <br/>
                                <form:input type="file" path="signature"/>
                            </div>
                        </div>
                        <div class="form-group col-md">
                            <label>Signature Name:</label>
                            <form:input type="text" class="form-control" path="pojo.signaturename"/>
                        </div>
                        <div class="form-group col-md">
                            <label>Document license:</label>
                            <div>
                                <c:if test="${not empty companyFormBean.pojo.documentlicense}">
                                    <a href="${companyFormBean.pojo.documentlicense}" download>Download file</a>
                                    <br/>
                                </c:if>
                                <form:input type="file" path="documentlicense"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group mt-3">
                        <label>Note:</label>
                        <form:textarea class="form-control" path="pojo.note"/>
                    </div>
                    <div class="form-group">
                        <div class="mt-3">
                            <button type="submit" class="btn btn-success">&nbsp;Save</button>
                        </div>
                    </div>

                </form:form>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="emailFormModal" tabindex="-1" role="dialog" aria-labelledby="emailFormModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="emailFormModalLabel">Send Test Email</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="emailForm" class="form-horizontal" action="/agent/settings/email/test" method="post">
                    <div class="form-group">
                        <label>To</label>
                        <input type="text" class="form-control" id="to" name="to"/>
                    </div>
                    <div class="form-group">
                        <label>Subject</label>
                        <input type="text" class="form-control" id="subject" name="subject"/>
                    </div>
                    <div class="form-group">
                        <label>Message</label>
                        <textarea type="text" class="form-control" rows="5" id="content" name="content"></textarea>
                    </div>
                    <div class="form-group">
                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary" id="saveButton">Send</button>
                            <button type="button" class="btn btn-default" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--end Modal -->
