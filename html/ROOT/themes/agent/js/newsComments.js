var news_comments_table;
$(document).ready(function() {
    news_comments_table = $('#news_comments_table').DataTable( {
        pageLength: 25,
        searching: true,
        paging: true,
        processing: true,
        serverSide: true,
        ajax: {
            url: '/agent/news/comments.json'  + window.location.search,
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: function ( d ) {
                var filterMap = $("#commentFilterForm").serializeFormJSON();
                d.filterMap=filterMap;
                return JSON.stringify(d);
            }
        },
        columns: [
            { data: 'newsid' },
            { data: 'comment'},
            { data: 'reviewby' },
            { data: 'score' },
            { data: 'numLikes' },
            { data: 'numDislikes' },
            { data: 'visible' },
            { data: 'blogcommentid' }

        ],
        columnDefs: [
            {
                "render": function ( data, type, row ) {
                    return '<a href="/agent/news/comments?newsid='+data+'">'+data+'</a>';
                },
                "targets": 0
            },
            {
                "render": function ( data, type, row ) {
                    if (row.visible) {
                        return '<a href="#" title="Disable" onclick="javascript:disableReview(' + row.blogcommentid +')">Disable</a>';
                    } else {
                        return '<a href="#" title="Enable" onclick="javascript:enableReview(' + row.blogcommentid +')">Enable</a>';
                    }

                },
                "targets": 7
            }
        ],
        'sDom': 'lTfr<"clearfix">tip',
        'oTableTools': {
            'aButtons': [

            ]
        }
    } );
});
function enableReview(id) {
    $.ajax({
        type: "GET",
        url: "/agent/news/comments/" + id + "/enable",
        success: function(data) {
            if (data == "true") {
                news_comments_table.ajax.reload();
            }
        }
    });
}
function disableReview(id) {
    $.ajax({
        type: "GET",
        url: "/agent/news/comments/" + id + "/disable",
        success: function(data) {
            if (data == "true") {
                news_comments_table.ajax.reload();
            }
        }
    });
}


