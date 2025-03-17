function ProviderCalendar(){
    var me = this;
    var INITIALIZED = false;
    var ACCESSS_TOKEN = null;
    var CONTAINER = null;
    var sdate = null;
    this.initialize = function (container, token, callBackFunc){
        if(INITIALIZED){
            callBackFunc();
        } else {
            ACCESSS_TOKEN = token;
            CONTAINER = $(container);
            INITIALIZED = true;
            sdate = getDBformat(new Date());
            _triggerLoadedData(callBackFunc);
        }
    };

    function _triggerLoadedData(callBackFunc){
        if(INITIALIZED){
            me.loadCalendar(sdate,function(html) {
                CONTAINER.html(html);
                _loadEvent();
                callBackFunc();
            });
        }
    }

    function _loadEvent() {
        sdate = $('.sdate').html();
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next',
                center: 'title',
                right: ''
            },
            defaultDate: moment(sdate),
            selectable: true,
            selectHelper: true,
            dayClick: function(date, jsEvent, view, resourceObj) {
                me.gotoDate(date.format());
            },
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            eventSources: [
                // your event source
                {
                    events: function (start, end, timezone, callback) {
                        $.ajax({
                            url: "/loyalty/provider/get-calendar.json?start=" + start.unix(),
                            type: 'GET',
                            cache: false,
                            contentType: "application/json",
                            dataType: 'json',
                            beforeSend: function(xhr) {
                                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
                            },
                            success: function (res) {
                                if (res.success) {
                                    callback(res.data);
                                } else {
                                    callback([]);
                                }
                            },
                            error: function (data, status, er) {
                            }
                        });
                    },
                    durationEditable: false,
                    startEditable: false,
                    color: '#e3e3e3',   // an option!
                    //textColor: 'white' // an option!
                },
                // any other sources...
            ],
            eventRender: function (event, element) {
                var ss = element.find('span.fc-title').text();
                if (ss.indexOf("Available: 0") >=0 ) {
                    ss = ss.replace("calendar-special","calendar-special zero");
                }
                element.find('span.fc-title').html(ss);
            },
            eventClick: function(calEvent, jsEvent, view) {
                me.showEventDetail(calEvent.id);
            }
        });
    }

    this.loadCalendar = function(sdate,callback) {
        $.ajax({
            url: '/loyalty/provider/ajax/'+sdate+'/calendar.html',
            type: 'POST',
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
            },
            success: function(result){
                callback(result);
            },
            error: function (e){
                console.log('...................', e)
            }
        });
    };

    this.createDateAppointment = function(dateAppointment, callback) {
        $.ajax({
            url: '/loyalty/provider/create-date-appointment.json',
            type: 'POST',
            data: JSON.stringify(dateAppointment),
            dataType: "json",
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
            },
            success: function(result){
                callback(result);
            },
            error: function (e){
                console.log('...................', e)
            }
        });
    };

    this.createAppointment = function(appointmentRequest, callback) {
        $.ajax({
            url: '/loyalty/provider/create-appointment.json',
            type: 'POST',
            data: JSON.stringify(appointmentRequest),
            dataType: "json",
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
            },
            success: function(result){
                callback(result);
            },
            error: function (e){
                console.log('...................', e)
            }
        });
    };

    this.createRemoteLDeal = function(createLDealRequest, callback) {
        var serverpath = $('#loyalty-container').data('serverpath');
        var mydomain = window.location.hostname;
        $.ajax({
            url: serverpath + '/loyalty/core/deals/create-deal.json',
            type: 'POST',
            data: JSON.stringify(createLDealRequest),
            dataType: "json",
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("domain", mydomain);
                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
            },
            success: function(result){
                callback(result);
            },
            error: function (e){
                console.log('...................', e)
            }
        });
    };

    this.deleteAppointment = function(appointmentid, callback) {
        $.ajax({
            url: '/loyalty/provider/'+appointmentid+'/delete-appointment.json',
            type: 'POST',
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
            },
            success: function(result){
                callback(result);
            },
            error: function (e){
                console.log('...................', e)
            }
        });
    };

    this.bookAppointment = function(appointmentid, customer, callback) {
        $.ajax({
            url: '/loyalty/provider/'+appointmentid+'/book-appointment.json',
            type: 'POST',
            data: JSON.stringify(customer),
            dataType: "json",
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
            },
            success: function(result){
                callback(result);
            },
            error: function (e){
                console.log('...................', e)
            }
        });
    };

    this.showEventDetail = function(id) {

    };

    this.gotoDate = function(d) {
        if (d != sdate) {
            sdate = d;
            me.reloadCalendar();
        }
    };

    this.reloadCalendar = function() {
        CONTAINER.html('');
        me.loadCalendar(sdate,function(html) {
            CONTAINER.html(html);
            _loadEvent();
            bindAppointmentStatus();
        });
    };

    this.getAppointment = function(id,callback) {
        $.ajax({
            url: '/loyalty/'+id+'/get-appointment.json',
            type: 'GET',
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
            },
            success: function(result){
                callback(result);
            },
            error: function (e){
                console.log('...................', e)
            }
        });
    }
}
var PROVIDER_CALENDAR = new ProviderCalendar();
function addTimerangeItem() {
    var item = $('#timerangeItem').html();
    item = '<div class="col-12 d-flex">' + item + '</div>';
    $('#timerangeBox').append(item);
}
function formatTime(hour, minute, ampm) {
    if (ampm == 'PM') {
        hour = Number(hour) + 12;
    }
    return hour + ':' + minute;
}
function appointmentFormSubmit(){
    var timerange = [];
    var listHourStart = $('.hourselect.start');
    var listMinuteStart = $('.minuteselect.start');
    var listAmPmselectStart = $('.ampmselect.start');
    var listHourEnd = $('.hourselect.end');
    var listMinuteEnd = $('.minuteselect.end');
    var listAmPmselectEnd = $('.ampmselect.end');
    for(var i = 0; i < listHourStart.length; i++){
        var hourStart = listHourStart[i].value;
        var minStart = listMinuteStart[i].value;
        var ampmStart = listAmPmselectStart[i].value;
        var hourEnd = listHourEnd[i].value;
        var minEnd = listMinuteEnd[i].value;
        var ampmEnd = listAmPmselectEnd[i].value;
        if (ampmStart === ampmEnd) {
            if (hourStart <= hourEnd) {
                timerange.push(formatTime(hourStart, minStart, ampmStart) + "-" + formatTime(hourEnd, minEnd, ampmEnd));
            }
        } else {
            timerange.push(formatTime(hourStart, minStart, ampmStart) + "-" + formatTime(hourEnd, minEnd, ampmEnd));
        }
    }
    var dateAppointment = {};
    dateAppointment.timerange = timerange.join("+");
    dateAppointment.sdate = $('.sdate').html();
    dateAppointment.slotduration = $('#appointmentForm .slotduration').val();
    dateAppointment.productid = $('#appointmentForm .productid').val();
    PROVIDER_CALENDAR.createDateAppointment(dateAppointment,function(result){
        if (result.appointments != null && result.appointments.length > 0) {
            PROVIDER_CALENDAR.reloadCalendar();
        }
    });
}
function getDBformat(date) {
    var yyyy = '' + date.getFullYear();
    var mm = date.getMonth() < 9 ? '0' + (date.getMonth() + 1) : '' + (date.getMonth() + 1);
    var dd = date.getDate() < 10 ? '0' + date.getDate() : '' + date.getDate();
    return yyyy + '-' + mm + '-' + dd;
}
function closeSectionAppointment() {
    $('#appointment-section').removeClass('show');
}
function addNewAppointment() {
    $('#addAppointmentModal').modal('show');
}
function addNewAppointmentSubmit() {
    $('#addAppointmentModal').modal('hide');
    var appointmentRequest = {};
    var hourStart = $('#addAppointmentForm .hour').val();
    var minuteStart = $('#addAppointmentForm .minute').val();
    var amStart = $('#addAppointmentForm .am').val();
    appointmentRequest.starttime = $('.sdate').html() + ' ' + formatTime(hourStart,minuteStart,amStart);
    appointmentRequest.duration = $('#addAppointmentForm .duration').val();
    appointmentRequest.productid = $('#addAppointmentForm .productid').val();
    PROVIDER_CALENDAR.createAppointment(appointmentRequest,function(result){
        if (result.appointmentid != null) {
            PROVIDER_CALENDAR.reloadCalendar();
        }
    });
}
function showOneAppointment(ele) {
    var appointmentid = $(ele).data('appointmentid');
    PROVIDER_CALENDAR.getAppointment(appointmentid,function(result){
        if (result.appointmentid != null) {
            $('#appointmentInfoModal').modal('show');
            $('#customerForm').find('input[name="appointmentid"]').val(appointmentid);
            $('.appointment-info .name').html(result.product.name);
            $('.appointment-info .starttime').html(result.starttime);
            $('.appointment-info .endtime').html(result.endtime);
            $('.appointment-info .status').html(result.status);
            if (result.participants != null && result.participants.length > 0) {
                var ss = "";
                for (var i=0;i<result.participants.length;i++) {
                    var part = result.participants[i];
                    ss += '<span class="badge badge-secondary">#' + part.slotnumber + ' ' + part.customer.fullname + '</span>';
                }
                $('.appointment-info .participants').html(ss);
                $('.btn-delete-appointment').addClass('d-none');
            } else {
                $('.appointment-info .participants').html('');
                $('.btn-delete-appointment').data('appointmentid',appointmentid);
                $('.btn-delete-appointment').removeClass('d-none');
            }
        }
    });
}
function deleteOneAppointment(ele) {
    var appointmentid = $(ele).data('appointmentid');
    if (appointmentid != null && appointmentid != '') {
        PROVIDER_CALENDAR.deleteAppointment(appointmentid,function(result){
            $('#appointmentInfoModal').modal('hide');
            if (result) {
                PROVIDER_CALENDAR.reloadCalendar();
            }
        });
    }
}
function gotoMeetingRoom(ele) {
    var appointmentid = $(ele).data('appointmentid');
    PROVIDER_CALENDAR.getAppointment(appointmentid,function(appointment){
        if (appointment.appointmentid != null) {
            var createLDealRequest = {};
            createLDealRequest.dealnumber = appointment.appointmentnumber;
            createLDealRequest.starttime = appointment.starttime;
            createLDealRequest.endtime = appointment.endtime;
            createLDealRequest.luseremail = $('.fake-guest .email').html();
            createLDealRequest.access_token = $('.fake-guest .access_token').html();
            createLDealRequest.scope = 'read';
            PROVIDER_CALENDAR.createRemoteLDeal(createLDealRequest,function(ldeal){
                if (ldeal.loyaltydealid != null && ldeal.loyaltydealid > 0) {
                    closeSectionAppointment();
                    showOnlineDeals(0,ldeal.loyaltydealid);
                }
            });
        }
    });
}
function toggleCustomerForm() {
    if ($('.customer-form.show').length) {
        $('#customerForm').removeClass('show');
    } else {
        $('#customerForm').addClass('show');
    }
}
function addCustomerToAppointment() {
    var customer = {};
    customer.fullname = $('#customerForm').find('input[name="fullname"]').val();
    if (customer.fullname == '') {
        $('#customerForm').find('input[name="fullname"]').focus();
        return;
    }
    customer.email = $('#customerForm').find('input[name="email"]').val();
    if (customer.email == '') {
        $('#customerForm').find('input[name="email"]').focus();
        return;
    }
    customer.phone = $('#customerForm').find('input[name="phone"]').val();
    customer.address = $('#customerForm').find('input[name="address"]').val();
    var appointmentid  = $('#customerForm').find('input[name="appointmentid"]').val();
    PROVIDER_CALENDAR.bookAppointment(appointmentid,customer,function(result){
        if (result) {
            PROVIDER_CALENDAR.reloadCalendar();
        }
    });
}
function bindAppointmentStatus() {
    $('.appointments-container').addClass('appointments');
    $('.btn-appointments').on('click',function(){
        $('.appointments-container').removeClass('available-slots');
        $('.appointments-container').removeClass('reports');
        $('.appointments-container').addClass('appointments');
    });
    $('.btn-available-slots').on('click',function(){
        $('.appointments-container').removeClass('appointments');
        $('.appointments-container').removeClass('reports');
        $('.appointments-container').addClass('available-slots');
    });
    $('.btn-reports').on('click',function(){
        $('.appointments-container').removeClass('available-slots');
        $('.appointments-container').removeClass('appointments');
        $('.appointments-container').addClass('reports');
    });
}
$(document).ready(function() {
    var accessToken = $('#loyalty-container').data('accesstoken');
    $('.menu-calendar').on('click',function(){
        var calendarContainer = document.getElementById('appointment-section-body');
        PROVIDER_CALENDAR.initialize(calendarContainer,accessToken,function() {
            $('#appointment-section').addClass('show');
            bindAppointmentStatus();
        });
    });
});



