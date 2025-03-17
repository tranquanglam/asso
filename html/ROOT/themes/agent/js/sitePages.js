var sitepageTable;

function postData(formData){
    var postUrl = window.location.pathname + "/add.json";
    if(formData.sitepageid){
        postUrl = window.location.pathname + "/" + formData.sitepageid + ".json";
    } else {
        delete formData.sitepageid;
    }
    var jsonString = JSON.stringify(formData);

    $.ajax({
        url: postUrl,
        type: 'POST',
        data: jsonString,
        contentType: "application/json",
        dataType: 'json',
        success: function(data) {
            $('#sitePageFormModal').modal('hide');
            $('#saveButton').button('reset');
            sitepageTable.ajax.reload();
        },
        error:function(data,status,er) {
            $('#sitePageFormModal').modal('hide');
            $('#saveButton').button('reset');
            alert("Error when update "+data+": "+er);
        }
    });
}


function showAddForm(){
    $('#sitePageForm')[0].reset(0);
    //reset hidden fields
    $('#sitePageForm').find('input[name="sitepageid"]').val('');
    CKEDITOR.instances.content.setData("");
    $('#sitePageFormModal').modal('show');
}

$(document).ready(function() {
    // Edit record
    $('#sitePages_table').on('click', 'a.add-sub', function (e) {
        e.preventDefault();
        var tr = $(this).closest('tr');
        var data = sitepageTable.row( tr ).data();
        $('#sitePageForm').find('input[name="sitepageid"]').val('');
        $('#sitePageForm').find('input[name="nameurl"]').val(data.nameurl+'/');
        $('#sitePageForm').find('input[name="name"]').val('');
        CKEDITOR.instances.content.setData("");
        $("#sitePageFormModal").modal("show");
    } );

    sitepageTable = $('#sitePages_table').DataTable( {
        pageLength: 25,
        processing: true,
        serverSide: true,
        searching: false,
        lengthChange: false,
        ajax: {
            url: window.location.pathname + '.json',
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: function ( d ) {
                var filterMap = $("#sitePageFilterForm").serializeFormJSON();
                d.filterMap=filterMap;
                return JSON.stringify(d);
            }
        },
        columns: [
            { data: 'nameurl'},
            { data: 'name' },
            { data: 'namevn'},
            { data: 'sigepageid'}
        ],
        columnDefs: [
            {
                "render": function ( data, type, row ) {
                    var ahtml = '<span class="text-info">' + data + '</span>';
                    if (data!=null && data.indexOf('landing-page/') == 0) {
                        var pageurl = data.split('/')[1];
                        ahtml += '<a class="px-3" href="/'+pageurl+'/lp.html"><i class="bi bi-eye"></i></a>';
                    }
                    return ahtml;
                },
                "targets": 0
            },
            {
                "render": function ( data, type, row ) {
                    return '<a href="/agent/sites/'+row.site.siteid+'/pages/'+row.sitepageid+'?l=en">'+row.name+'</a>';
                },
                "targets": 1
            },
            {
                "render": function ( data, type, row ) {
                    return '<a href="/agent/sites/'+row.site.siteid+'/pages/'+row.sitepageid+'?l=vi">'+row.namevn+'</a>';
                },
                "targets": 2
            },
            {
                "render": function ( data, type, row ) {
                    return '<a href="#" class="add-sub"><i class="bi bi-plus-circle"></i></a>';
                },
                "targets": 3
            }
        ],
        'sDom': 'lTfr<"clearfix">tip',
        'oTableTools': {
            'aButtons': [

            ]
        }
    } );


    $('#saveButton').on('click', function () {
        var $btn = $(this).button('loading');
        var formData = $("#sitePageForm").serializeFormJSON();
        formData.content = CKEDITOR.instances.content.getData();
        postData(formData);
    });

    $('#sitePageFilter').on('click', function(){
        sitepageTable.ajax.reload();
    });
});
