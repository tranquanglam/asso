$(document).ready(function() {
    console.log('ready');
    $('#sites_table').DataTable( {
        ajax: {
            url: '/agent/sites.json',
            dataSrc: ''
        },
        columns: [
            { data: 'siteid' },
            { data: 'name' },
            { data: 'domain'},
            { data: 'type'},
            { data: 'siteid' }
        ],
        columnDefs: [
            {
                // The `data` parameter refers to the data for the cell (defined by the
                // `data` option, which defaults to the column being worked with, in
                // this case `data: 0`.
                "render": function ( data, type, row ) {
                    return [
                        '<a href="/agent/sites/' + row.siteid +'/pages" title="All Pages">All Pages</a>',
                        '|',
                        '<a href="/agent/sites/' + row.siteid +'/pages/comments" title="Comments">Comments</a>',
                        '|',
                        '<a href="/agent/sites/' + row.siteid +'/album.html" title="Album">Gallery</a>'
                    ].join('');
                },
                "targets": 4
            },
            {
                // The `data` parameter refers to the data for the cell (defined by the
                // `data` option, which defaults to the column being worked with, in
                // this case `data: 0`.
                "render": function ( data, type, row ) {
                    return [
                        '<a href="/agent/sites/' + row.siteid +'/" title="Edit">',
                        'Edit',
                        '</a>'
                    ].join('');
                },
                "targets": 0
            }
        ],
        'sDom': 'lTfr<"clearfix">tip',
        'oTableTools': {
            'aButtons': [

            ]
        }
    } );

    var tt = new $.fn.dataTable.TableTools( table );
    $( tt.fnContainer() ).insertBefore('div.dataTables_wrapper');

});
