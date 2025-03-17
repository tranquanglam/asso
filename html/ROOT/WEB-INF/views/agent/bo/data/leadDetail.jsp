<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-2 mb-4">
    <div class="container">

        <div class="row mb-5 bg-light rounded-2 ps-2 pl-2 py-2">
            <div class="col-md-12">
                <h3 class="mb-5">Lead Info</h3>
                <c:set value="${lead.leadInfo}" var="leadInfo"/>
                <form id="formLeadInfo" class=" g-3">
                    <div class="row">
                        <div class="col">
                            <label for="inputEmail4" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${leadInfo.email}">
                        </div>
                        <div class="col">
                            <label for="firstName" class="form-label">firstName</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" value="${leadInfo.firstName}">
                        </div>
                        <div class="col">
                            <label for="lastName" class="form-label">lastName</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" value="${leadInfo.lastName}">
                        </div>
                        <div class="col">
                            <label for="lastName" class="form-label">phone</label>
                            <input type="text" class="form-control" id="phone" name="phone" value="${leadInfo.phone}">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <label for="companyName" class="form-label">companyName</label>
                            <input type="text" class="form-control" id="companyName" name="companyName" value="${leadInfo.companyName}">
                        </div>
                        <div class="col">
                            <label for="country" class="form-label">country</label>
                            <input type="text" class="form-control" id="country" name="country" value="${leadInfo.country}">
                        </div>
                        <div class="col">
                            <label for="language" class="form-label">language</label>
                            <input type="text" class="form-control" id="language" name="language" value="${leadInfo.language}">
                        </div>
                        <div class="col-12 d-flex justify-content-end mt-4">
                            <button type="button"  class="btn btn-primary js-lead-updateLeadInfo">Update</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="row mb-5 bg-light rounded-2 ps-2 pl-2 py-3">
            <div class="col-12">
                <h3 class="mb-5">Lead Activity</h3>
            </div>
            <div class="col-md-12 text-right mb-2 d-flex justify-content-end">
                <button class="btn btn-primary js-add-activity">
                    add
                </button>
            </div>
            <div class="col-md-12">
                <div class="">
                    <table id="tableActivity" class="table table-borderless table-striped is-striped"></table>
                </div>
            </div>
        </div>
        <div class="box-table mt-3">

        </div>
    </div>
</div>

<div class="modal fade" id="activityModal" tabindex="-1" aria-labelledby="activityModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="activityModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form class="row g-3 needs-validation" id="activityForm">
                    <div class="col-md-6">
                        <label for="fullName" class="form-label">Full name</label>
                        <input type="text" name="fullName" class="form-control" id="fullName">
                    </div>
                    <div class="col-md-6">
                        <label for="channels" class="form-label">Channel</label>
                        <select id="channels" name="channel" class="select2"></select>
                    </div>

                    <div class="col-md-6">
                        <label for="date" class="form-label">When</label>
                        <input type="date" id="date" name="date" class="form-control" />
                    </div>
                    <div class="col-md-6">
                        <label for="outcome" class="form-label">Outcome</label>
                        <select id="outcome" name="outcome" class="select2"></select>
                    </div>
                    <div class="col-md-12">
                        <label for="feedbackList" class="form-label">Feedback</label>
                        <select id="feedbackList" name="feedbackList" class="select2" multiple="multiple"></select>
                    </div>

                    <div class="col-12">
                        <label for="comment" class="form-label">Note</label>
                        <textarea id="comment" name="comment" class="form-control"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary js-lead-newComment" id="js-lead-newComment">Save activity</button>
            </div>
        </div>
    </div>
</div>

<div class="d-none">
    <div id="load_accessToken">${accesstoken}</div>
    <div id="load_leadId">${lead.leadid}</div>
    <div id="load_leadInfo_firstName">${lead.leadInfo.firstName}</div>
    <div id="load_leadInfo_lastName">${lead.leadInfo.lastName}</div>
    <div id="load_leadInfo_fullName">${lead.leadInfo.firstName} ${lead.leadInfo.lastName}</div>
</div>
