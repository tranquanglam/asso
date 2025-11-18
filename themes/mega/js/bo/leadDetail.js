function ApiCallback(func, dynamic) {
    if (func !== null && func !== undefined && func !== "" && typeof func === 'function') {
        var args = [];
        for (var i = 1; i < arguments.length; i++)
            args.push(arguments[i]);
        func.apply(this, args)
    }
}

function LeadDetail() {
    var me = this;
    var INITIALIZED = false;
    var ACCESSS_TOKEN = null;
    var CONTAINER = null;
    var LEADID = null;
    var DATA= {};
    var METADATA = {};
    METADATA.omnichannel = ['facebook', 'zalo', 'instagram', 'phone', 'youtube'];
    METADATA.channel = ['meeting', 'presentation', 'demo', 'call', 'message', 'rumor', 'other'];
    METADATA.outcome = [ 'strong_positive', 'positive', 'neutral', 'negative', 'strong_negative'];
    METADATA.score = [
        {
            name: 'product',
            items: ['product_outstanding', 'product_good', 'product_average', 'product_below_average', 'product_strong_negative']
        },
        {
            name: 'relationship',
            items: ['relationship_intimate', 'relationship_good', 'relationship_normal', 'relationship_bad', 'relationship_failed']
        },
        {
            name: 'budget',
            items: ['budget_intimate', 'budget_good', 'budget_normal', 'budget_bad', 'budget_failed']
        },{
            name: 'price',
            items: ['price_affordable', 'price_same_as_other', 'price_overpriced']
        }];
    var datatableActivities = null;
    me.executeAjaxPost = function (url, data, optionCallback) {
        $.ajax({
            type: 'POST',
            url: url,
            dataType: "json",
            data: JSON.stringify(data),
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
            },
            success: function (data) {
                ApiCallback(optionCallback.success, data);
            },
            error: function (data) {
                ApiCallback(optionCallback.error, data);
            }
        });
    };
    me.executeAjaxGet = function (url, data, optionCallback) {
        var queryString = Object.keys(data).map((key) => {
            return encodeURIComponent(key) + '=' + encodeURIComponent(data[key])
        }).join('&');
        $.ajax({
            type: 'GET',
            url: url + "?" + queryString,
            dataType: "json",
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
            },
            success: function (data) {
                ApiCallback(optionCallback.success, data);
            },
            error: function (data) {
                ApiCallback(optionCallback.error, data);
            }
        });
    };

    me.APIDATA = {};
    me.APIDATA.getLeadDetail = function (requestBody, optionCallback) {
        me.executeAjaxGet("/api/v0/supplier/lead/getLeadInfo.json", requestBody, {
            success: optionCallback
        });
    };
    me.APIDATA.addLeadActivity = function (requestBody, optionCallback) {
        me.executeAjaxPost("/api/v0/supplier/lead/addLeadActivity.json", requestBody, {
            success: optionCallback
        });
    };
    me.APIDATA.updateLeadInfo = function (requestBody, optionCallback) {
        me.executeAjaxPost("/api/v0/supplier/lead/updateLeadInfo.json", requestBody, {
            success: optionCallback
        });
    };

    this.initialize = function (token, extraData, callBackFunc){
        if(INITIALIZED){
            callBackFunc();
        } else {
            ACCESSS_TOKEN = token;
            INITIALIZED = true;
            LEADID = extraData.leadId;
            _triggerLoadedData(callBackFunc);
        }
    };

    function _formatSelectMetadata(list) {
        let array = [];
        list.forEach(function (item) {
            array.push({id: item,text:item});
        });
        return array;
    }
    function _formatSelectGroupMetadata(list) {
        let array = [];
        list.forEach(function (item) {
            array.push(
                {
                    text: item.name,
                    children: _formatSelectMetadata(item.items)
                }
            );
        });

        return array;
    }
    function _initModal() {
        $('#channels').select2({
            data: _formatSelectMetadata( METADATA.channel),
            dropdownParent: $('#activityForm'),
            theme: "bootstrap-5",
            allowClear: false,
            placeholder: "Materials",
            minimumResultsForSearch: Infinity,
        });

        $('#outcome').select2({
            data: _formatSelectMetadata( METADATA.outcome),
            dropdownParent: $('#activityForm'),
            theme: "bootstrap-5",
            allowClear: false,
            placeholder: "",
            minimumResultsForSearch: Infinity,
        })

        $('#feedbackList').select2({
            data:_formatSelectGroupMetadata(METADATA.score),
            dropdownParent: $('#activityForm'),
            theme: "bootstrap-5",
            allowClear: false,
            placeholder: "",
            minimumResultsForSearch: Infinity,
            closeOnSelect: false
        })


    }
    function _triggerLoadedData(callBackFunc){
        if(INITIALIZED){
            me.loadActivites(function(html) {
                callBackFunc();
            });
            _initModal();
            $('.js-add-activity').on('click', function () {
                let fullname = $('#load_leadInfo_firstName').html() + " " + $('#load_leadInfo_lastName').html()
                $('#activityForm').find('input[name="fullName"]').val(fullname);
                $('#activityModal').modal('show');
            });
            $('.js-lead-newComment').on('click', function (e) {
                let leadid =$('#load_leadId').html();
                let data = {
                    leadInfoComment: $('#activityForm').serializeFormJSON(),
                    leadId: leadid
                }
                me.APIDATA.addLeadActivity(data, function (response) {
                    console.log(response);
                    window.location.reload();
                });
            });
            $('.js-lead-updateLeadInfo').on('click', function (e) {
                var data = $('#formLeadInfo').serializeFormJSON();
                data.leadId = $('#load_leadId').html();
                me.APIDATA.updateLeadInfo(data, function (response) {
                    console.log(response);
                    window.location.reload();
                });
            });

        }
    }

    function _datatableListActivity() {
        
        let list = DATA.mLead.leadInfo.commentList;
        if (datatableActivities != null) {
            //
        }
        datatableActivities = $('#tableActivity').DataTable( {
            pageLength: 25,
            paging: true,
            processing: true,
            data: list,
            columns: [
                { data: 'date' },
                { data: 'fullName' },
                { data: 'channel' },
                { data: 'date' },
                { data: 'comment' },
                { data: 'date' },
                { data: 'outcome' },
            ],
            columnDefs: [ {
                title: 'Date',
                targets: 0
            },{
                title: 'Name',
                targets: 1
            },{
                title: 'Channel',
                targets: 2
            },{
                title: 'When',
                targets: 3
            },{
                title: 'Message',
                targets: 4
            }, {
                title: 'Feedback',
                targets: 5,
                render: function ( data, type, row ) {
                    if (row.feedbackList != null) {
                        return "row.feedbackList";
                    }
                    return "";
                },
            }, {
                title: 'Outcome',
                targets: 6
            }]

        });
    }

    me.loadActivites = function () {
        let requestBody = {
            leadid: LEADID
        };
        me.APIDATA.getLeadDetail(requestBody, function (response) {
            console.log(response);
            DATA.mLead = response.mLead;
            _datatableListActivity();
        });
    };
};
var LEAD_DETAIL = new LeadDetail();

$(document).ready(function () {
    var accessToken = $('#load_accessToken').html();
    LEAD_DETAIL.initialize(accessToken,{
        leadId: $('#load_leadId').html()
    },function() {});
});
