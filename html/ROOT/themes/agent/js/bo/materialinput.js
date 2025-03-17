function ApiCallback(func, dynamic) {
    if (func !== null && func !== undefined && func !== "" && typeof func === 'function') {
        var args = [];
        for (var i = 1; i < arguments.length; i++)
            args.push(arguments[i]);
        func.apply(this, args)
    }
}

function MaterialAPIData() {
    var me = this;

    this.executeAjaxPost = function (url, data, optionCallback) {
        $.ajax({
            type: 'POST',
            url: url,
            dataType: "json",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function (data) {
                ApiCallback(optionCallback.success, data);
            },
            error: function (data) {
                ApiCallback(optionCallback.error, data);
            }
        });
    };

    this.addMaterialInput = function ( data, optionCallback) {
        var url = "/api/v0/supplier/material/addMaterialInput.json";
        me.executeAjaxPost(url, data, {
            success: optionCallback
        });
    };


}
var MaterialAPIData = new MaterialAPIData();

function addMaterialInput() {
    $('#itemMaterialInputForm').find('input[name="materialid"]').val(0);
    $('#itemMaterialInputForm').find('input[name="code"]').val('');
    $('#itemMaterialInputForm').find('input[name="name"]').val('');
    $('#itemMaterialInputForm').find('input[name="quantity"]').val('1');
    $('#itemMaterialInputForm').find('input[name="namevi"]').val('');
    $('#itemMaterialInputForm').find('input[name="visible"]').prop('checked', true);
    $("#formMaterialInputModal").modal('show');
}
function itemMaterialInputSubmit(signed) {
    $('#itemMaterialInputForm').validate({
        rules: {
            materialid: {
                required: true
            },
            quantity: {
                required: true
            },
            price: {
                required: true
            },
            manufacturerid: {
                required: true
            },
            mfgdate: {
                required: true
            },
            expdate: {
                required: true
            },
            slotno: {
                required: true
            },
            providercode: {
                required: true
            }
        },
        highlight: function (element) {
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function (error, element) {
            if (element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });

    if($("#itemMaterialInputForm").valid()){
        var formData = $('#itemMaterialInputForm').serializeFormJSON();
        formData.signed = signed;
        MaterialAPIData.addMaterialInput(formData, function (res) {
            if (materialinput_table) {
                materialinput_table.ajax.reload();
            }
            $("#formMaterialInputModal").modal('hide');
        });
    }
}

function editContent(data) {
    $('#itemMaterialInputForm').find('input[name="materialinputid"]').val(data.materialinputid);

    var $materialSelect = $($("#itemMaterialInputForm").find('select[name="materialid"]')[0]);
    if($materialSelect.find('option[value="'+data.material.materialid+'"]').length == 0){
        $materialSelect.append(`<option value="${data.material.materialid}">${data.material.name}</option>`);
    }
    $materialSelect.val(data.material.materialid);

    $('#itemMaterialInputForm').find('input[name="slotno"]').val(data.slotno);
    $('#itemMaterialInputForm').find('input[name="inputtime"]').val(data.inputtime);
    $('#itemMaterialInputForm').find('input[name="expdate"]').val(data.expdate);
    $('#itemMaterialInputForm').find('input[name="price"]').val(data.price);
    $('#itemMaterialInputForm').find('input[name="tax"]').val(data.tax);
    $('#itemMaterialInputForm').find('input[name="quantity"]').val(data.quantity);
    $('#itemMaterialInputForm').find('input[name="purchasenumber"]').val(data.purchasenumber);

    $('#itemMaterialInputForm').find('select[name="branchid"]').val(data.branchid);

    $('#itemMaterialInputForm').find('select[name="providercode"]').val(data.providercode);

    $('#itemMaterialInputForm').find('select[name="manufacturerid"]').val(data.manufacturer.manufacturerid);


    $("#formMaterialInputModal").modal('show');
}

function getBranchNameById(id) {
    return $('.select-branchid option[value="'+id+'"]').text();
}

var materialinput_table;
$(document).ready(function () {
    $('.datepicker').flatpickr({
        enableTime: false,
        dateFormat: "d/m/Y"
    });
    if ($('#materialinput_table').length) {
        materialinput_table = $('#materialinput_table').DataTable({
            pageLength: 25,
            paging: true,
            processing: true,
            serverSide: true,
            bPaginate: false,
            bLengthChange: false,
            bFilter: false,
            bInfo: false,
            bAutoWidth: false,
            language: {
                url: '/themes/agent/js/datatables.vi.json',
            },
            ajax: {
                url: '/api/v0/supplier/material/dataMaterialInput.json',
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: function (d) {
                    var filterMap = $("#materialInputFilterForm").serializeFormJSON();
                    d.filterMap=filterMap;
                    return JSON.stringify(d);
                }
            },
            columns: [
                {data: 'branchid'},
                {data: 'purchasenumber'},
                {data: 'materialinputid'},
                {data: 'providername'},
                {data: 'materialinputid'},
                {data: 'slotno'},
                {data: 'inputtime'},
                {data: 'expdate'},
                {data: 'price'},
                {data: 'quantity'},
                {data: 'tax'},
                {data: 'totalamount'},
                {data: 'totalamount'}
            ],
            columnDefs: [
                {
                    "render": function ( data, type, row ) {
                        return getBranchNameById(data);
                    },
                    "targets": 0
                },
                {
                    "render": function ( data, type, row ) {
                        return '<a href="javascript:void(0)" class="btn-filter-purchasenumber">'+data+'</a>';
                    },
                    "targets": 1
                },
                {
                    "render": function ( data, type, row ) {
                        if (row.material != null) {
                            return row.material.name;
                        } else {
                            return '';
                        }

                    },
                    "targets": 2
                },
                {
                    "render": function ( data, type, row ) {
                        if (row.manufacturer != null) {
                            return row.manufacturer.name;
                        } else {
                            return '';
                        }
                    },
                    "targets": 4
                },
                {
                    "render": function ( data, type, row ) {
                        return row.qtyinstock + ' / ' + row.quantity;
                    },
                    "targets": 9
                },
                {
                    "render": function ( data, type, row ) {
                        if (data != null) {
                            return data.toVND() || '';
                        }
                        return data;
                    },
                    "className": 'text-end',
                    "targets": [8,11]
                },
                {
                    "render": function ( data, type, row ) {
                        let html = [];
                        html.push('<button type="button" class="btn btn-sm btn-square btn-neutral text-danger-hover btn-edit">\n' +
                            '          <i class="bi bi-pencil"></i>\n' +
                            '      </button>')
                        return html.join('');
                    },
                    "targets": 12
                },
            ],
            'sDom': 'lTfr<"clearfix">tip',
            'oTableTools': {
                'aButtons': []
            },
            "fnDrawCallback": function( oSettings ) {
                var list = oSettings.json.data;
                var amount = 0;
                for(var i = 0; i < list.length ; i++) {
                    if (list[i].totalamount) {
                        amount += list[i].totalamount;
                    }
                }
                $('#totalAmount').html(amount.toVND());
            }
        });
        materialinput_table.on( '.btn-edit', function ( e, buttonApi, dataTable, node, config ) {
            console.log( 'Button '+buttonApi.text()+' was activated' );
        } );


        $('#materialinput_table tbody').on( 'click', 'button.btn-edit', function () {
            var tr = $(this).parent('td');
            var data = materialinput_table.row($(tr)).data();
            editContent(data);
        } );
        $('#materialinput_table tbody').on( 'click', '.btn-filter-purchasenumber', function () {
            var tr = $(this).parent('td');
            var data = materialinput_table.row($(tr)).data();
            var purchasenumber = data.purchasenumber;
            $('#materialInputFilterForm input[name="fromDate"]').val('');
            $('#materialInputFilterForm input[name="toDate"]').val('');
            $('#materialInputFilterForm input[name="purchasenumber"]').val(purchasenumber);
            materialinput_table.ajax.reload();
        } );
    }


    if ($('#selectMaterialid').length) {
        var placeholder = $("#selectMaterialid").attr('placeholder')
        $("#selectMaterialid").select2({
            dropdownParent: $('#formMaterialInputModal'),
            theme: "bootstrap-5",
            allowClear: true,
            placeholder: placeholder || '',
            ajax: {
                url: '/api/v0/supplier/material/select.json',
                dataType: 'json',
                quietMillis: 50,
                data: function (params) {
                    var d = {
                        searchTerm: params.term,
                        page: params.page ? params.page : 1,
                        maxPageItems: 10
                    };
                    return d;
                },
                processResults: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.name,
                                id: item.materialid
                            }
                        })
                    };
                },
                dropdownCssClass: "bigdrop",
                containerCssClass: "form-select",
                containerCss: "form-select",
            }
        });

    }

    $( "#materialInputFilterForm" ).submit(function( event ) {
        event.preventDefault();
        materialinput_table.ajax.reload();
    });
});
