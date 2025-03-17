<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-4">
    <div class="mg-sec-title">
        <h1 class="title"><fmt:message key="label.productid-calendar"/></h1>
    </div>
</div>
<div class="productid-calendar">
    <div class="container">
        <div class="row">
            <div class="col-md-9">
                <form:form id="myForm" role="form"  cssClass="filter-form" method="post" modelAttribute="mineBean">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="input-group date mg-check-in">
                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                <form:input path="date" type="text" cssClass="form-control" placeholder="Working date" autocomplete="off"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <form:select path="productid" cssClass="custom-select">
                                <c:forEach items="${dotors}" var="productid">
                                    <form:option value="${productid.userID}">${productid.firstName} ${productid.lastName}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-success btn-block" type="submit"><fmt:message key="label.search"/></button>
                        </div>
                    </div>
                    <form:hidden path="page" id="formPage"/>
                </form:form>
            </div>
            <div class="col-md-3">
                <button class="btn btn-primary float-right" onclick="addContent()">Add</button>
            </div>
        </div>
    </div>
</div>
<div class="mt-2 mb-4 pl-2 pr-2">
    <div class="container-fluid">
        <c:forEach items="${items.listResult}" var="dc">
            <div class="row">
                <div class="col-md-12">
                    <span><strong>Doctor:</strong> ${dc.productid.lastName} ${dc.productid.firstName} </span>
                    <span> | <strong>Time range:</strong> ${dc.timerange}  </span>
                    <span> | <strong>Start number:</strong> ${dc.startnumber}  </span>
                    <span> | <strong>End number:</strong> ${dc.endnumber}  </span>
                    <span> | <strong>Session duration:</strong> ${dc.sessionduration}  </span>
                    <span> | <strong>Status:</strong> ${dc.status}  </span>
                    <span>  <a href="#" class="btn btn-link float-right" onclick="deleteItem(${dc.productcalendarid})"><i class="fa fa-trash" aria-hidden="true"></i></a></span>
                </div>
            </div>
            <c:choose>
                <c:when test="${not empty dc.doctorsessions}">
            <div class="row">
                <c:forEach items="${dc.doctorsessions}" var="em">
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
                <c:otherwise>

                </c:otherwise>
            </c:choose>
        </c:forEach>
        <ul class="pagination pull-right">
            <c:if test="${items.hasPrevious}">
                <li><a href="#"><i class="fa fa-play arrow-left"></i></a></li>
            </c:if>
            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                <li><a ${items.page eq loop.count?'class="current"':''} href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
            </c:forEach>
            <c:if test="${items.hasNext}">
                <li><a href="#"><i class="fa fa-play arrow-right"></i></a></li>
            </c:if>
        </ul>
    </div>
</div>
<div class="modal fade" id="formContentModal" tabindex="-1" role="dialog"
     aria-labelledby=formContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 96%;max-width: 960px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="formContentModalLabel"><fmt:message key="productid"/> <span class="productid-name"></span> | <fmt:message key="label.productid-calendar"/></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/clinic/data/${clinic.urlname}/doctorCalendarForm.html" method="post" id="itemForm">
                    <input type="hidden" name="branchid" value="${clinic.branchid}"/>
                    <input type="hidden" name="productid.userID" value="0"/>

                    <div class="form-group">
                        <label><fmt:message key='workingdate'/></label>
                        <input name="sdate" class="form-control" value="" readonly/>
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
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="itemFormSubmit()">Save</button>
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
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
                            <input type="text" name="customer.cusNote.weight" class="form-control" value="10kg" maxlength="20">
                        </div>
                        <div class="form-group col-md-2">
                            <label><fmt:message key='height'/></label>
                            <input type="text" name="customer.cusNote.height" class="form-control" value="1.3m" maxlength="20">
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
