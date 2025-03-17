<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<div class="d-none">
    <div class="access-token">${accesstoken}</div>
</div>
<c:if test="${isappointment}">
    <div class="appointment-section dragable-section" id="appointment-section">
        <div class="appointment-section-container">
            <div class="appointment-section-header d-none">
                <div class="d-flex justify-content-between">
                    <h5 class="title p-3">Calendar</h5>
                    <div class="btn-close p-3" onclick="closeSectionAppointment()">
                        <i class="fa 2x fa-times"></i>
                    </div>
                </div>
            </div>
            <div class="appointment-section-body" id="appointment-section-body">

            </div>
            <div class="appointment-section-footer d-none">
                <div class="d-flex justify-content-between px-3">
                    <div>
                        <button class="btn btn-outline-secondary" onclick="closeSectionAppointment()">Close</button>
                    </div>
                    <div class="actions">

                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>
