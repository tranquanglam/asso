$(document).ready(function() {
    $('#products_table').DataTable( {
        pageLength: 25,
        paging: true,
        processing: true,
        serverSide: true,
        ajax: {
            url: '/agent/apiproducts.json' + window.location.search,
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: function ( d ) {
                return JSON.stringify(d);
            }
        },
        columns: [
            { data: 'name' },
            { data: 'productid' },
            { data: 'brandid' },
            { data: 'apiproductid' },
            { data: 'apiproductid' },
            { data: 'visible' },
            { data: 'categoryurl' },
            { data: 'apiproductid' }
        ],
        columnDefs: [
            {
                "render": function ( data, type, row ) {
                    return row.apisite.siteurl;
                },
                "targets": 3
            },
            {
                "render": function ( data, type, row ) {
                    return row.apisite.clientid;
                },
                "targets": 4
            },
            {
                "render": function ( data, type, row ) {
                    return '<a href="#" onclick="javascript:updateCategory('+row.apiproductid+',\''+data+'\')" title="Category">'+data+'</a>';
                },
                "targets": 6
            },
            {
                "render": function ( data, type, row ) {
                    sss = '';
                    if (!row.visible) {
                        sss +=  '&nbsp; <a href="#" onclick="javascript:updateStatus('+row.apiproductid+',1)" title="Enable"><i class="fa fa-check" aria-hidden="true"></i></a>';
                    } else {
                        sss += '&nbsp; <a href="#" onclick="javascript:updateStatus('+row.apiproductid+',0)" title="Disable"><i class="fa fa-trash" aria-hidden="true"></i></a>';
                    }
                    return sss;
                },
                "targets": 7
            }
        ],
        'sDom': 'lTfr<"clearfix">tip',
        'oTableTools': {
            'aButtons': [

            ]
        }
    });

    $('.saveCategoryBtn').on('click',function(){
        $('#categoryForm').submit();
    })

});
function updateStatus(productID,status) {
    var updateVisibleUrl = '/agent/apiproducts/'+productID+'/ajax/updateVisible.html?status=' + status;
    $.ajax({
        cache: false,
        type: "GET",
        dataType: 'json',
        url: updateVisibleUrl,
        success: function (res) {
            window.location.href = '/agent/apiproducts';
        }
    });
}
function updateCategory(productID,categoryurl) {
    $('#apiproductid').val(productID);
    $('#categoryurl').val(categoryurl);
    $("#categoryModal").modal("show");
}
