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
        <div id="checkup-chatvideo" class="checkup-chatvideo dragable-section">
            <div class="checkup-chatvideo-container">
                <div class="checkup-chatvideo-header" id="checkup-chatvideo-header">
                    <div class="d-flex justify-content-between">
                            <span class="text-white">
                                Camera
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
        <div id="modal_videocall" class="modal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>You have a new call</p>
                    </div>
                    <div class="modal-footer">
                        <%--<button id="btn-videocall-accept" type="button" class="btn btn-primary btn-videocall-accept">Answer</button>--%>
                    </div>
                </div>
            </div>
        </div>
        <div id="loadingVideoCall" class="d-none">
            <div class="videocall-loading-swapper">
                <div class="videocall-loading-main">
                    <div class="videocall-join-meeting-swapper">
                        <p>You have a new call</p>
                        <button id="btn-videocall-accept" type="button" class="btn btn-primary btn-videocall-accept">Answer</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid" id="loyalty-container" data-accesstoken="${access_token}" data-serverpath="https://membooking.com" data-userscope="${user_scope}" data-robot="YES">
        ${page.content}
    </div>
    <input type="hidden" id="ftoken" value="${ftoken}">
<c:if test="${isappointment}">
    <input type="hidden" id="remoteproviderid" value="${param.remoteproviderid}">
    <input type="hidden" id="remoteappointmentid" value="${param.remoteappointmentid}">
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
<script type="text/javascript" src="https://membooking.com/themes/loyalty/js/loyalty.js"></script>
<c:if test="${isappointment}">
    <script type="text/javascript" src="/themes/mega/js/customer-appointment.js"></script>
</c:if>
</html>
