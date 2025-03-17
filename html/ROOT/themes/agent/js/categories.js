$(document).ready(function() {
    var siteid = $('#siteid').html();
    var categories_table = $('#categories_table').DataTable( {
        pageLength: 25,
        processing: true,
        serverSide: true,
        searching: false,
        lengthChange: false,
        ajax: {
            url: '/agent/categories.json'+ window.location.search,
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: function ( d ) {
                var filterMap = $("#categoryFilterForm").serializeFormJSON();
                d.filterMap=filterMap;
                return JSON.stringify(d);
            }
        },
        columns: [
            { data: 'ordernumber'},
            { data: 'nameurl' },
            { data: 'name' },
            { data: 'lang' },
            { data: 'link' },
            { data: 'type' }
        ],
        columnDefs: [
            {
                "render": function ( data, type, row ) {
                        return [
                            '<a href="/agent/categories/' + row.categoryid +'/" title="Edit">',
                            data,
                            '</a>'
                        ].join('');
                },
                "targets": 1
            },
            {
                "render": function ( data, type, row ) {
                    var designurl = '<a href="/agent/design/'+ row.nameurl +'/category.html" title="Manage Content">Content</a>';
                    var album = '<a href="/agent/sites/'+siteid+'/' + row.nameurl +'/album.html" title="Manage album">Album</a>';
                    switch(data) {
                        case 1:
                            return 'News';
                            break;
                        case 2:
                            return designurl + ' | <a href="/agent/sites/'+siteid+'/pages?catid=' + row.categoryid +'" title="pages in the category">Pages</a> | ' +album;
                            break;
                        case 3:
                            return 'Menu ' + designurl + ' | <a href="/agent/sites/'+siteid+'/pages?catid=' + row.categoryid +'" title="pages in the category">Pages</a> | ' +album;
                            break;
                        case 8:
                            return 'Product';
                            break;
                        case 12:
                            return 'Lead';
                            break;
                        default:
                            return data;
                    }
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
    $('#categoryFilter').on('click', function(){
        categories_table.ajax.reload();
    });
});
