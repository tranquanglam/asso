<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-2 mb-4">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <form:form id="myForm" cssClass="form-inline" action="/bo/data/leads.html" method="post" commandName="mineBean">
                    <div class="d-flex justify-content-start">
                    <div class="form-group me-3">
                        <label>Search all information &nbsp;&nbsp;</label>
                        <form:checkbox  path="searchAll" cssClass="form-check-inline"/>
                    </div>
                    <div class="form-group me-3">
                        <form:input  path="searchTerm" placeholder="leads" maxlength="64" cssClass="form-control"/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-outline-primary"><span><i class="bi bi-search"></i> <fmt:message key="label.search"/> </span></button>
                    </div>
                    </div>
                    <form:hidden path="page" id="formPage"/>
                </form:form>
            </div>
        </div>
        <div class="box-table mt-3">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th>Email</th>
                        <th>IP</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Phone</th>
                        <th>Country</th>
                        <th>Company</th>
                        <th>Type</th>
                        <th>TemplateID</th>
                        <th>Comment</th>
                        <th>Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${leads}" var="lead">
                        <c:set var="em" value="${lead.leadInfo}"/>
                        <tr id="item_${lead.leadid}">
                            <td class="item_email"><a href="/bo/data/leads/${lead.leadid}/detail.html">${lead.email}</a></td>
                            <td class="item_language">${em.language} - ${em.ip}</td>
                            <td class="item_firstName">${em.firstName}</td>
                            <td class="item_lastName">${em.lastName}</td>
                            <td class="item_phone">${em.phone}</td>
                            <td class="item_country">${em.country}</td>
                            <td class="item_companyName">${em.companyName}</td>
                            <td class="item_companyType">${em.companyType}</td>
                            <td class="item_companyType">${em.templateid}</td>
                            <td class="item_comment">
                                <c:choose>
                                    <c:when test="${not empty em.commentList && em.commentList.size() > 0}">
                                        ${em.commentList[em.commentList.size()-1].comment}
                                    </c:when>
                                    <c:otherwise>
                                        ${em.comment}
                                    </c:otherwise>
                                </c:choose>
                                <a class="js-view-commentList" data-leadid="${lead.leadid}" href="javascript:void(0)">view all</a>
                            </td>
                            <td class="item_comment">${lead.createddate}</td>
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

<div class="modal fade" id="leadInfoModal" tabindex="-1" role="dialog"
     aria-labelledby="leadInfoModalLabel">
    <div class="modal-dialog" role="document" style="width: 50%;max-width: 1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="leadInfoModalLabel">Lead info</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="leadid">
                <div id="leadInfoContainer">

                </div>

                <div id="leadInfoCommentContainer">

                </div>

                <div>
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label"></label>
                        <div class="col-sm-10">
                            <textarea id="newComment"  class="form-control" rows="3"></textarea>
                            <button class="btn btn-primary mt-3 js-lead-newComment">Send comment</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
