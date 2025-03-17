<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="section-provider-calendar">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-5 appointments-container p-0 border-right border-bottom">
                <div class="border-0">
                    <div class="d-flex p-3 justify-content-between">
                        <c:if test="${not empty appointments}">
                        <span>
                            <a href="javascript:void(0)" class="btn btn-link btn-appointments">Appointments</a>
                            <a href="javascript:void(0)" class="btn btn-link btn-available-slots">Available slots</a>
                            <a href="javascript:void(0)" class="btn d-none btn-reports">Reports</a>
                        </span>
                        </c:if>
                        <span class="align-baseline"><strong class="sdate">${sdate}</strong></span>
                    </div>
                    <div class="appointments-body">
                        <c:choose>
                            <c:when test="${not empty appointments}">
                                <div class="list-appointments px-3">
                                    <c:forEach items="${appointments}" var="em">
                                        <div class="border-bottom py-2 appointment-item ${em.status}">
                                            <div class="d-flex justify-content-between">
                                                <button class="btn btn-outline-primary" type="button" onclick="gotoMeetingRoom(this)" data-appointmentid="${em.appointmentid}">GO</button>
                                                <button class="btn btn-outline-primary" type="button" onclick="showOneAppointment(this)" data-appointmentid="${em.appointmentid}">${em.product.name}</button>
                                                <span class="starttime-title">${em.starttime}</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="appointment-item py-3 BOOKABLE">
                                        <a href="javascript:void(0)" onclick="addNewAppointment()" class="btn btn-outline-secondary btn-add-new-appointment">Manually add new appointment</a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="px-3">
                                    <form method="post" id="appointmentForm">
                                        <div class="form-group">
                                            <div id="timerangeBox" class="row">
                                                <div id="timerangeItem" class="col-12 d-flex">
                                                    <div class="calendar-time mr-5">
                                                        <select class="hourselect start">
                                                            <option value="00">00</option>
                                                            <option value="01">01</option>
                                                            <option value="02">02</option>
                                                            <option value="03">03</option>
                                                            <option value="04" selected="selected">04</option>
                                                            <option value="05">05</option>
                                                            <option value="06">06</option>
                                                            <option value="07">07</option>
                                                            <option value="08">08</option>
                                                            <option value="09">09</option>
                                                            <option value="10">10</option>
                                                            <option value="11">11</option>
                                                            <option value="12">12</option>
                                                        </select> :
                                                        <select class="minuteselect start">
                                                            <option value="00">00</option>
                                                            <option value="05">05</option>
                                                            <option value="10">10</option>
                                                            <option value="15">15</option>
                                                            <option value="20">20</option>
                                                            <option value="25">25</option>
                                                            <option value="30" selected="selected">30</option>
                                                            <option value="35">35</option>
                                                            <option value="40">40</option>
                                                            <option value="45">45</option>
                                                            <option value="50">50</option>
                                                            <option value="55">55</option>
                                                        </select>
                                                        <select class="ampmselect start">
                                                            <option value="AM">AM</option>
                                                            <option value="PM" selected="selected">PM</option>
                                                        </select>
                                                    </div>
                                                    -
                                                    <div class="calendar-time ml-5">
                                                        <select class="hourselect end">
                                                            <option value="01">01</option>
                                                            <option value="02">02</option>
                                                            <option value="03">03</option>
                                                            <option value="04">04</option>
                                                            <option value="05">05</option>
                                                            <option value="06">06</option>
                                                            <option value="07">07</option>
                                                            <option value="08">08</option>
                                                            <option value="09" selected="selected">09</option>
                                                            <option value="10">10</option>
                                                            <option value="11">11</option>
                                                            <option value="12">12</option>
                                                        </select> :
                                                        <select class="minuteselect end">
                                                            <option value="00">00</option>
                                                            <option value="05">05</option>
                                                            <option value="10">10</option>
                                                            <option value="15">15</option>
                                                            <option value="20">20</option>
                                                            <option value="25">25</option>
                                                            <option value="30" selected="selected">30</option>
                                                            <option value="35">35</option>
                                                            <option value="40">40</option>
                                                            <option value="45">45</option>
                                                            <option value="50">50</option>
                                                            <option value="55">55</option>
                                                        </select>
                                                        <select class="ampmselect end">
                                                            <option value="AM">AM</option>
                                                            <option value="PM" selected="selected">PM</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12">
                                                    <a href="javascript:void(0)" onclick="addTimerangeItem()">add time range</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col">
                                                <label>Slot duration</label>
                                                <select name="slotduration" class="form-control slotduration">
                                                    <option value="300">5 minutes</option>
                                                    <option value="600">10 minutes</option>
                                                    <option value="900" selected="selected">15 minutes</option>
                                                    <option value="1200">20 minutes</option>
                                                    <option value="1500">25 minutes</option>
                                                    <option value="1800">30 minutes</option>
                                                    <option value="2700">45 minutes</option>
                                                    <option value="3600">1 hour</option>
                                                    <option value="5400">1.5 hours</option>
                                                    <option value="7200">2 hours</option>
                                                    <option value="10800">3 hours</option>
                                                    <option value="14400">4 hours</option>
                                                    <option value="28800">8 hours</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col">
                                                <label>Service</label>
                                                <select name="productid" class="form-control productid">
                                                    <c:forEach items="${products}" var="product">
                                                        <option value="${product.productid}">${product.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col">
                                                <label>Max pax</label>
                                                <select name="maxax" class="form-control maxpax">
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col">
                                                <label>Max Slot</label>
                                                <input type="number" name="maxnumber" class="form-control maxnumber" value="5"/>
                                            </div>
                                        </div>
                                        <button class="btn btn-primary" type="button" onclick="appointmentFormSubmit()">Save</button>
                                    </form>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div class="col-md-7 p-0">
                <div class="px-3">
                    <div id='calendar' class="pt-3"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addAppointmentModal" tabindex="-1" role="dialog" aria-labelledby="addAppointmentModalLabel" data-backdrop="false">
        <div class="modal-dialog" role="document" style="width: 96%;max-width: 900px;border: solid 2px #282828;">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-title" id="addAppointmentModalLabel">Add an appointment</div>
                </div>
                <div class="modal-body">
                    <form method="post" id="addAppointmentForm" autocomplete="off">
                        <input type="hidden" name="appointmentid" value="0"/>
                        <div id="and-appointment-time">
                            <div class="row">
                                <div class="col-2">Start Time</div>
                                <div class="col-2">
                                    <select class="form-control hour" name="hour">
                                        <option value="00">00</option>
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09" selected="selected">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>
                                </div>
                                <div class="col-2">
                                    <select class="form-control minute" name="minute">
                                        <option value="00">00</option>
                                        <option value="05">05</option>
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                        <option value="25">25</option>
                                        <option value="30" selected="selected">30</option>
                                        <option value="35">35</option>
                                        <option value="40">40</option>
                                        <option value="45">45</option>
                                        <option value="50">50</option>
                                        <option value="55">55</option>
                                    </select>
                                </div>
                                <div class="col-2">
                                    <select class="form-control am" name="am">
                                        <option value="AM">AM</option>
                                        <option value="PM" selected="selected">PM</option>
                                    </select>
                                </div>
                                <div class="col-2">Duration</div>
                                <div class="col-2">
                                    <select name="duration" class="form-control duration">
                                        <option value="300">5 minutes</option>
                                        <option value="600">10 minutes</option>
                                        <option value="900" selected="selected">15 minutes</option>
                                        <option value="1200">20 minutes</option>
                                        <option value="1500">25 minutes</option>
                                        <option value="1800">30 minutes</option>
                                        <option value="2700">45 minutes</option>
                                        <option value="3600">1 hour</option>
                                        <option value="5400">1.5 hours</option>
                                        <option value="7200">2 hours</option>
                                        <option value="10800">3 hours</option>
                                        <option value="14400">4 hours</option>
                                        <option value="28800">8 hours</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col">
                                    <label>Service</label>
                                    <select name="productid" class="form-control productid">
                                        <c:forEach items="${products}" var="product">
                                            <option value="${product.productid}">${product.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="button" onclick="addNewAppointmentSubmit()">Save</button>
                    <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="appointmentInfoModal" tabindex="-1" role="dialog" aria-labelledby="appointmentInfoModalLabel" data-backdrop="false">
        <div class="modal-dialog" role="document" style="width: 98%;max-width: 900px; border: solid 2px #282828;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="appointmentInfoModalLabel">Appointment information</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="appointment-info">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Name: <span class="name"></span></li>
                            <li class="list-group-item">Time slot: <span class="starttime"></span> - <span class="endtime"></span></li>
                            <li class="list-group-item">Status: <span class="status"></span></li>
                            <li class="list-group-item">
                                <div class="d-flex justify-content-start">
                                    <span>Participants:</span>
                                    <div class="participants ml-3"></div>
                                </div>

                            </li>
                        </ul>
                    </div>

                    <button class="btn btn-primary my-3" type="button" onclick="toggleCustomerForm()">
                        Add customer to this appointment
                    </button>
                    <div id="customerForm" class="customer-form">
                        <form>
                            <input type="hidden" name="appointmentid" value="0">
                            <div class="row">
                                <div class="form-group col">
                                    <label><fmt:message key='fullname'/></label>
                                    <input name="fullname" class="form-control" maxlength="255" />
                                </div>
                                <div class="form-group col">
                                    <label><fmt:message key='booking.customer.email'/></label>
                                    <input name="email" class="form-control" maxlength="255" />
                                </div>
                                <div class="form-group col">
                                    <label><fmt:message key='booking.customer.phone'/></label>
                                    <input name="phone" class="form-control" value="" maxlength="255" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label><fmt:message key='address'/></label>
                                    <input name="address" class="form-control" maxlength="255" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <button type="button" class="btn btn-primary" onclick="addCustomerToAppointment();">Save</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <a class="btn btn-warning btn-delete-appointment" data-appointmentid="" onclick="deleteOneAppointment(this)">Delete this appointment</a>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="cancelAppointmentModal" tabindex="-1" role="dialog" aria-labelledby="cancelAppointmentModalLabel" data-backdrop="false">
        <div class="modal-dialog" role="document" style="width: 98%;max-width: 900px;border: solid 2px #282828;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="cancelAppointmentModalLabel">Are you sure you want to mark this appointment as CANCELED ?</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Email to</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control-plaintext cancel-email-to" name="cancelEmailTo" value="">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Subject</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control cancel-email-subject" name="cancelEmailSubject" placeholder="Subject">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Content</label>
                            <div class="col-sm-10">
                                <div class="cancel-email-content border p-2" contenteditable="true"></div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="cancelAppointmentSubmit();">Yes & Send email</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>
</div>
