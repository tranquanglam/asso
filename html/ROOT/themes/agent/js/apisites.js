$(document).ready(function() {
    $('#apisites_table').DataTable( {
        pageLength: 25,
        paging: true,
        processing: true,
        serverSide: true,
        ajax: {
            url: '/agent/apisites.json' + window.location.search,
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: function ( d ) {
                return JSON.stringify(d);
            }
        },
        columns: [
            { data: 'code' },
            { data: 'stype' },
            { data: 'siteurl' },
            { data: 'clientid' },
            { data: 'visible' },
            { data: 'apisiteid' }
        ],
        columnDefs: [
            {
                "render": function ( data, type, row ) {
                    return row.visible + ' / ' + row.point;
                },
                "targets": 4
            },
            {
                "render": function ( data, type, row ) {
                    var sss = '&nbsp;<a href="/agent/apisites/apisiteForm?apisiteid=' + row.apisiteid + '" title="Edit"><i class="fa fa-edit" aria-hidden="true"></i></a>';
                    if (!row.visible) {
                        sss +=  '&nbsp; <a href="#" onclick="javascript:updateStatus('+row.apisiteid+',1)" title="Enable"><i class="fa fa-check" aria-hidden="true"></i></a>';
                        sss +=  '&nbsp; <a href="#" onclick="javascript:deleteApisite('+row.apisiteid+')" title="Remove">Remove All</a>';
                    } else {
                        sss += '&nbsp; <a href="#" onclick="javascript:updateStatus('+row.apisiteid+',0)" title="Disable"><i class="fa fa-trash" aria-hidden="true"></i></a>';
                    }
                    sss += '&nbsp; <a href="#" onclick="javascript:updateData('+row.apisiteid+')" title="Refresh"><i class="fa fa-refresh" aria-hidden="true"></i></a>';
                    return sss;
                },
                "targets": 5
            }
        ],
        'sDom': 'lTfr<"clearfix">tip',
        'oTableTools': {
            'aButtons': [

            ]
        }
    } );

});
function updateStatus(apisiteid,status) {
    var updateVisibleUrl = '/agent/apisites/'+apisiteid+'/ajax/updateStatus.html?status=' + status;
    $.ajax({
        cache: false,
        type: "GET",
        url: updateVisibleUrl,
        contentType: "application/json",
        success: function (res) {
            window.location.href = '/agent/apisites';
        }
    });
}
function updateData(apisiteid) {
    var updateDataUrl = '/agent/apisites/'+apisiteid+'/ajax/updateData.json';
    $.ajax({
        cache: false,
        type: "GET",
        url: updateDataUrl,
        contentType: "application/json",
        success: function (res) {
            alert("result="+res.result);
        }
    });
}
function deleteApisite(apisiteid) {
    var deleteUrl = '/agent/apisites/'+apisiteid+'/ajax/delete.json';
    var dialog = bootbox.dialog({
        title: 'Delete Site',
        message: "<p>Are you sure you want to delete all of this site ?</p>",
        size: 'large',
        buttons: {
            confirm: {
                label: "YES",
                className: 'btn-success pl-5 pr-5',
                callback: function(){
                    $.ajax({
                        cache: false,
                        type: "POST",
                        url: deleteUrl,
                        contentType: "application/json",
                        success: function (res) {
                            window.location.href = '/agent/apisites';
                        }
                    });
                }
            },
            cancel: {
                label: "NO",
                className: 'btn-danger',
                callback: function(){
                    //nothing
                }
            }
        }
    });

}
