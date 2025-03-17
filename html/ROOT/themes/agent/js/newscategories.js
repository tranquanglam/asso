var newscategory_table;
$(document).ready(function() {
    newscategory_table = $('#newscategory_table').DataTable( {
        pageLength: 25,
        processing: true,
        serverSide: true,
        searching: true,
        ajax: {
            url: '/agent/categories/newscategories.json'+ window.location.search,
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            "data": function (d) {
                var filterMap = $("#filterForm").serializeFormJSON();
                d.filterMap = filterMap;
                return JSON.stringify(d);
            }
        },
        columns: [
            { data: 'category' },
            { data: 'news' },
            { data: 'category' }
        ],
        columnDefs: [
            { targets: 'no-sort', orderable: false },
            {
                "render": function ( data, type, row ) {
                        return data.name;
                },
                "targets": 0
            },
            {
                "render": function ( data, type, row ) {
                    return data.title;
                },
                "targets": 1
            },
            {
                "render": function ( data, type, row ) {
                    switch(data.type) {
                        case 1:
                            return 'News';
                            break;
                        case 2:
                            return 'Page';
                            break;
                        default:
                            return data.type;
                    }
                },
                "targets": 2
            }

        ],
        'sDom': 'lTfr<"clearfix">tip',
        'oTableTools': {
            'aButtons': [
                {
                    'sExtends':    'collection',
                    'sButtonText': '<i class="bi bi-plus-circle"></i>&nbsp;&nbsp;&nbsp;Add',
                    "fnClick": function ( nButton, oConfig, oFlash ) {
                        window.location = '/agent/categories/add/';
                    },
                    'aButtons':    [ ]
                }
            ]
        }
    } );

});
$('#bookingFilter').on('click', function () {
    newscategory_table.ajax.reload();
});