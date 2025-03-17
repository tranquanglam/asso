<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="text-center">
    <h1 class="title"><c:if test="${not empty productid}">${productid.firstName} ${productid.lastName} - </c:if><fmt:message key="label.productid-calendar"/></h1>
</div>
<div class="mt-2 mb-4 pl-2 pr-2">
    <c:choose>
        <c:when test="${doctorcalendar != null && not empty doctorcalendar.doctorsessions}">
        <div class="row">
            <c:forEach items="${doctorcalendar.doctorsessions}" var="em">
                <div class="col-md-1 col-3 col-sm-2 mt-2 pl-1 pr-1">
                    <div class="doctorsession border border-primary text-center bg-${em.status}" data-productsessionid="${em.productsessionid}">
                        <div class="start-time pr-1"><fmt:formatDate value="${em.starttime}" pattern="HH:mm:ss"/></div>
                        <div class="slot-number">
                                ${em.slotnumber}
                        </div>
                        <div class="customer">
                            <c:if test="${em.customer != null}">
                                <span class="customer-name">${em.customer.fullname}</span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        </c:when>
        <c:when test="${not empty productid}">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <form action="/clinic/data/${clinic.urlname}/doctorCalendarForm.html" method="post" id="itemForm">
                            <input type="hidden" name="branchid" value="${clinic.branchid}"/>
                            <input type="hidden" name="productid.userID" value="${productid.userID}"/>

                            <div class="form-group">
                                <label><fmt:message key='workingdate'/></label>
                                <input name="sdate" class="form-control" value="${sdate}" readonly/>
                            </div>
                            <div class="form-group">
                                <label><fmt:message key='timerange'/> ex: 06:00-07:30+17:00-21:30</label>
                                <input name="timerange" class="form-control" maxlength="255" value="16:30-21:30"/>
                            </div>
                            <div class="row">
                                <div class="form-group col">
                                    <label><fmt:message key='startnumber'/></label>
                                    <input name="startnumber" class="form-control" type="number" value="10"/>
                                </div>
                                <div class="form-group col">
                                    <label><fmt:message key='endnumber'/></label>
                                    <input name="endnumber" class="form-control" type="number" value="60"/>
                                </div>
                                <div class="form-group col">
                                    <label><fmt:message key='sessionduration'/></label>
                                    <input name="sessionduration" class="form-control" type="number" value="90"/>
                                </div>
                                <div class="form-group col">
                                    <label><fmt:message key='status'/></label>
                                    <select name="status" class="form-control">
                                        <option value="ACTIVE">ACTIVE</option>
                                        <option value="INACTIVE">INACTIVE</option>
                                        <option value="DONE">DONE</option>
                                    </select>
                                </div>
                            </div>
                            <button class="btn btn-primary" type="button" onclick="itemFormSubmit()">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <fmt:message key="doctorsessions.empty"/>
        </c:otherwise>
    </c:choose>
</div>
<div class="d-none">
    <form action="/clinic/data/${clinic.urlname}/deleteDoctorCalendar.html" method="post" id="deleteForm">
        <input type="hidden" name="id" value=""/>
    </form>
    <div id="cliniccode">${clinic.urlname}</div>
    <div class="sessionStatuses">
        <c:forEach var="st" items="${sessionStatuses}">
            <div class="${st.key}"><fmt:message key='${st}'/></div>
        </c:forEach>
    </div>
</div>
<div class="modal fade" id="sessionModal" tabindex="-1" role="dialog"
     aria-labelledby=sessionModalLabel">
    <div class="modal-dialog" role="document" style="width: 96%;max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title" id="sessionModalLabel">
                    <fmt:message key="label.productid-session"/>
                    / <fmt:message key='slotnumber'/> <span class="slotnumber"></span>
                    / <fmt:message key='starttime'/>  <span class="starttime"></span>
                    / <fmt:message key='status'/>  <span id="sessionStatus" class=""></span>
                </div>
            </div>
            <div class="modal-body">
                <form action="/clinic/data/${clinic.urlname}/sessionForm.html" method="post" id="sessionForm" autocomplete="off">
                    <input type="hidden" name="productsessionid" value="0"/>
                    <input type="hidden" name="customer.customerid" value="0"/>
                    <input type="hidden" name="action" value="book">
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label><fmt:message key='fullname'/></label>
                            <input id="cfullname" name="customer.fullname" class="form-control"/>
                        </div>
                        <div class="form-group col-md-4">
                            <label><fmt:message key='dateofbirth'/></label>
                            <input name="cdateofbirth" class="form-control dateofbirth" />
                            <input type="hidden" name="customer.dateofbirth" value="">
                        </div>
                        <div class="form-group col-md-2">
                            <label><fmt:message key='weight'/></label>
                            <input type="text" name="customer.cusNote.weight" class="form-control" value="" maxlength="20">
                        </div>
                        <div class="form-group col-md-2">
                            <label><fmt:message key='height'/></label>
                            <input type="text" name="customer.cusNote.height" class="form-control" value="" maxlength="20">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key='address'/></label>
                            <input name="customer.address" class="form-control" maxlength="255" />
                        </div>
                    </div>
                    <hr/>
                    <div class="row">
                        <div class="form-group col">
                            <label><fmt:message key='relativename'/></label>
                            <input name="customer.relativename" class="form-control" value="" maxlength="255" />
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key='relative-email'/></label>
                            <input name="customer.email" class="form-control" maxlength="255" />
                        </div>
                        <div class="form-group col">
                            <label><fmt:message key='booking.customer.phone'/></label>
                            <input name="customer.phone" class="form-control" value="" maxlength="255" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="btn-book" class="btn btn-primary" type="button" onclick="sessionFormSubmit()"><fmt:message key='action.book'/></button>
                <button id="btn-prescribe" class="btn btn-success" type="button" onclick="prescribeSession()"><fmt:message key='action.prescribe'/></button>
                <button id="btn-attend" class="btn btn-info" type="button" onclick="attendSession()"><fmt:message key='action.attend'/></button>
                <button id="btn-cancel" class="btn btn-link" type="button" onclick="cancelSession()"><fmt:message key='action.cancel'/></button>
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
