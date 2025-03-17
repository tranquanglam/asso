var users_table;
function convertStatus(status){
    switch(status) {
        case 0:
            return '<span class="label label-default">Inactive</span>';
            break;
        case 1:
            return '<span class="label label-success">Active</span>';
            break;


        default:
            return status;
    }
}

$(document).ready(function() {
    // Edit record
    $('#users_table').on('click', 'a.editor_edit', function (e) {
        e.preventDefault();
        var tr = $(this).closest('tr');
        var data = ordersTable.row( tr ).data();
        //console.log(data);
        $("#orderForm").populate(data);
        $("#orderFormModal").modal("show");
    } );

    users_table = $('#users_table').DataTable( {
        pageLength: 25,
        processing: true,
        serverSide: true,
        searching: false,
        lengthChange: false,
        ajax: {
            url: '/agent/users.json',
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: function ( d ) {
                var filterMap = $("#userFilterForm").serializeFormJSON();
                d.filterMap=filterMap;
                return JSON.stringify(d);
            }
        },
        columns: [
            { data: 'email' },
            { data: 'status' },
            { data: 'lastLogin' },
            { data: 'role' },
            { data: 'userID' }
        ],
        columnDefs: [
            {
                "render": function ( data, type, row ) {
                    if(row.role === "AGT_ADMIN"){
                        return data;
                    }

                    return [
                        '<a href="/agent/users/' + row.userID +'/edit" title="Edit">',
                        data,
                        '</a>'
                    ].join('');
                },
                "targets": 0
            },
            {
                "render": function ( data, type, row ) {
                    return convertStatus(data);
                },
                "targets": 1
            },
            {
                "render": function ( data, type, row ) {
                    var date = new Date(data);
                    return date.toLocaleString();
                },
                "targets": 2

            },{
                "render": function ( data, type, row ) {
                    return '<a href="/agent/users/' + row.userID +'/account-balance.html" title="Account balance">Account balance</a>';
                },
                "targets": 4
            }
        ],
        'sDom': 'lTfr<"clearfix">tip',
        'oTableTools': {
            'aButtons': [

            ]
        }
    } );

    $('#userFilter').on('click', function(){
        users_table.ajax.reload();
    });
});
