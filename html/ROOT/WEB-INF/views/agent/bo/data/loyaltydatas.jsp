<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-2 mb-5">
    <div class="container">
        <div class="row mt-4">
            <div class="col-md-4">
                <h1>Rough data</h1>
            </div>
            <div class="col-md-8 text-end">
                <form:form id="myForm" cssClass="form-inline pull-right" action="/bo/data/loyaltydatas.html" method="post" modelAttribute="bean">
                    <div class="d-flex justify-content-end">
                        <div class="form-group me-2">
                            <form:input  path="servicenumber" placeholder="path" maxlength="255" cssClass="form-control"/>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-outline-info"><span><i class="bi bi-search" aria-hidden="true"></i> Search</span></button>
                        </div>
                    </div>
                    <form:hidden path="page" id="formPage"/>
                </form:form>
            </div>
        </div>
        <div class="box-table">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped" id="customer_table">
                    <thead class="blue">
                    <tr>
                        <th>Path</th>
                        <th>Date</th>
                        <th>Userid</th>
                        <th>Sformid</th>
                        <th>Sformata</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${loyaltydatas}" var="em">
                        <tr>
                            <td>${em.servicenumber}</td>
                            <td>${em.createddate}</td>
                            <td><c:choose>
                                    <c:when test="${not empty mapUser && not empty mapUser[em.loyaltyuserid]}">
                                        ${mapUser[em.loyaltyuserid].email}
                                    </c:when>
                                    <c:otherwise>
                                        em.loyaltyuserid
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${em.sformid}</td>
                            <td>
                                <c:if test="${not empty em.sformData}">
                                    <c:if test="${not empty em.sformData.data}">
                                        <p>
                                            <c:forEach items="${em.sformData.data}" var="sformData">
                                                <span class="js-fieldnames-${em.loyaltydataid}" data-fieldname="${sformData.fieldname}" data-fieldvalue="${sformData.value}">
                                                    ${sformData.fieldname}: ${sformData.value}
                                                </span>
                                            </c:forEach>
                                        </p>
                                    </c:if>
                                </c:if>


                            </td>
                            <td>
                                <div class="d-grid gap-2 d-md-block">
                                    <c:if test="${em.docstatus ne 2}">
                                        <button class="btn btn-outline-primary js-convert-to-lead" data-loyaltydataid="${em.loyaltydataid}" type="button">Convert to Lead</button>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!--  -->
        <ul class="pagination text-end">
            <c:if test="${items.hasPrevious}">
                <li><a href="#"><i class="bi bi-arrow-left"></i></a></li>
            </c:if>
            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                <li><a ${items.page eq loop.count?'class="current"':''} href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
            </c:forEach>
            <c:if test="${items.hasNext}">
                <li><a href="#"><i class="bi bi-arrow-right"></i></a></li>
            </c:if>
        </ul>
    </div>
</div>

<div class="modal fade" id="convertToLeadModal" tabindex="-1" role="dialog"
     aria-labelledby="convertToLeadModalLabel">
    <div class="modal-dialog" role="document" style="width: 50%;max-width: 1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="convertToLeadModalLabel">Content</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/bo/data/loyaltydatas/convertToLead.html" id="convertToLeadForm">
                    <input type="hidden" name="loyaltyDataId" id="lead_loyaltyDataId">
                    <div id="loyaltyDataInfo">

                    </div>

                    <div>
                        <div class="row mb-3">
                            <label for="lead_language" class="col-sm-2 col-form-label">Country</label>
                            <div class="col-sm-10">
                                <select name="country" class="form-control">
                                    <option value=""><fmt:message key="label.country"/></option>
                                    <c:forEach var="country" items="${countryList}">
                                        <option value="${country.code}" selected="${country.code eq 'VN' ? true : false}">${country.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="lead_language" class="col-sm-2 col-form-label">Language</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="language" id="lead_language">
                                    <option>VI</option>
                                    <option>EN</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="lead_Note" class="col-sm-2 col-form-label">Note</label>
                            <div class="col-sm-10">
                                <textarea rows="3" class="form-control" name="note" id="lead_Note"></textarea>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary js-convertToLeadSubmit" > Convert to Lead</button>
            </div>
        </div>
    </div>
</div>
