<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta property="og:url"           content="https://${site.domain}${requestScope['javax.servlet.forward.request_uri']}" />
    <meta property="og:type"          content="website" />
    <meta property="og:title"         content="Playing Game" />
    <meta property="og:description"   content="Playing Game for relax" />
    <meta name="description" content="Playing Game for relax">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="theme-color" content="#ffffff">
    <title>CRM</title>
    <link type="image/x-icon" href="${initParam.hostmedia}${site.favicon}" rel="shortcut icon"/>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap-datepicker3.min.css" />
    <link rel="stylesheet" type="text/css" href="https://membooking.com/themes/loyalty/css/loyalty.css" />
<c:if test="${isappointment}">
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/fullcalendar.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/appointment.min.css" />
</c:if>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css" integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">
    <style>
        html,body{
            min-width: unset !important;
            overflow-x: hidden;
            overflow-y: auto;
        }
        #wc-leave{
            width: auto !important;
            height: auto !important;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="video-section">
    <div id="loadingVideoCall" class="d-none">
        <div class="videocall-loading-swapper">
            <div class="videocall-loading-main">
                <div class="videocall-join-meeting-swapper">
                    <p>Waiting...</p>
                </div>
            </div>
        </div>
    </div>
    <div id="checkup-chatvideo" class="checkup-chatvideo dragable-section">
        <div class="checkup-chatvideo-container">
            <div class="checkup-chatvideo-header" id="checkup-chatvideo-header">
                <div class="d-flex justify-content-between">
                        <span class="text-white">
                            Camera
                        </span>
                        <span>
                            <a href="javascript:void(0)" id="endMeetingBtn" class="btn btn-danger d-none" type="button" data-bookingid="0"><span><i class="fas fa-video-slash" ></i>&nbsp;End meeting</span></a>
                        </span>
                </div>
            </div>
            <div class="checkup-chatvideo-body">
                <div id="zmmtg-root"><div class="root-inner"></div></div>
            </div>
            <div class="checkup-chatvideo-footer" id="checkup-chatvideo-footer">
                Happy day!
            </div>
        </div>
    </div>
</div>
<div class="container-fluid" id="loyalty-container" data-accesstoken="${access_token}" data-serverpath="https://membooking.com" data-userscope="${user_scope}">
    ${page.content}
</div>
<input type="hidden" id="ftoken" value="${ftoken}">
<c:if test="${isappointment}">
    <div class="appointment-section dragable-section" id="appointment-section">
        <div class="appointment-section-container">
            <div class="appointment-section-header" id="appointment-section-header">
                <div class="d-flex justify-content-between">
                    <h5 class="title p-3">Calendar</h5>
                    <div class="btn-close p-3" onclick="closeSectionAppointment()">
                        <i class="fas 2x fa-times"></i>
                    </div>
                </div>
            </div>
            <div class="appointment-section-body" id="appointment-section-body">

            </div>
            <div class="appointment-section-footer" id="appointment-section-footer">
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
    <div class="menu-calendar" data-toggle="tooltip" data-placement="right" title="<fmt:message key='label.product-calendar'/>"><i class="fas fa-calendar"></i></div>
</c:if>
</body>
<script type="text/javascript" src="/themes/mega/js/popper.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootbox.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/firebasejs/8.2.0/firebase-auth.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/firebasejs/8.2.0/firebase-database.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js"></script>
<script type="text/javascript" src="https://source.zoom.us/1.8.6/lib/vendor/react.min.js"></script>
<script type="text/javascript" src="https://source.zoom.us/1.8.6/lib/vendor/react-dom.min.js"></script>
<script type="text/javascript" src="https://source.zoom.us/1.8.6/lib/vendor/redux.min.js"></script>
<script type="text/javascript" src="https://source.zoom.us/1.8.6/lib/vendor/redux-thunk.min.js"></script>
<script type="text/javascript" src="https://source.zoom.us/1.8.6/lib/vendor/lodash.min.js"></script>
<script type="text/javascript" src="https://source.zoom.us/zoom-meeting-1.8.6.min.js"></script>
<script type="text/javascript" src="https://membooking.com/themes/loyalty/js/firebase-app.js"></script>
<script type="text/javascript" src="https://membooking.com/themes/loyalty/js/loyalty-sale.js"></script>
<c:if test="${isappointment}">
    <script type="text/javascript" src="/themes/mega/js/fullcalendar/moment.min.js"></script>
    <script type="text/javascript" src="/themes/mega/js/fullcalendar/fullcalendar.min.js"></script>
    <script type="text/javascript" src="/themes/mega/js/bo/provider-calendar.js"></script>
</c:if>
</html>
