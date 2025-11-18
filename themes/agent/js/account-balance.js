var transactions_table;
$(document).ready(function() {
    var accountTransactionUrl = $('#transactionFilterForm').attr('action');
    transactions_table = $('#transactions_table').DataTable( {
        pageLength: 25,
        processing: true,
        serverSide: true,
        searching: false,
        lengthChange: false,
        ajax: {
            url: accountTransactionUrl,
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: function ( d ) {
                var filterMap = $("#transactionFilterForm").serializeFormJSON();
                d.filterMap=filterMap;
                return JSON.stringify(d);
            }
        },
        columns: [
            { data: 'transactiontime' },
            { data: 'credit' },
            { data: 'ordernumber' },
            { data: 'paymentid' },
            { data: 'note' }
        ],
        columnDefs: [
            {
                "render": function (data, type, row ) {
                    var date = new Date(data);
                    return date.toLocaleString();
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

    $('#transactionFilter').on('click', function(){
        transactions_table.ajax.reload();
    });

    $('.btn-add-credit').on('click',function(){
        $('#transactionModal').modal('show');
    });

    $('.btn-add-credit-submit').on('click',function(){
        $('#transactionModal').modal('hide');
        var requestForm = {};
        requestForm.credit = $('#addTransactionForm').find('input[name="credit"]').val();
        if (requestForm.credit == '') {
            $('#addTransactionForm').find('input[name="credit"]').focus();
            return;
        }
        requestForm.paymentid = $('#addTransactionForm').find('input[name="paymentid"]').val();
        if (requestForm.paymentid == '') {
            $('#addTransactionForm').find('input[name="paymentid"]').focus();
            return;
        }
        requestForm.note = $('#addTransactionForm').find('input[name="note"]').val();
        var addTransactionUrl = $('#addTransactionForm').attr('action');
        $.ajax({
            url: addTransactionUrl,
            type: 'POST',
            contentType: "application/json",
            data: JSON.stringify(requestForm),
            dataType: "json",
            success: function(result) {
                transactions_table.ajax.reload();
            }
        });
    });
});
