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

    this.addMaterialInputList = function ( data, optionCallback) {
        var url = "/api/v0/supplier/material/addMaterialInputList.json";
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
    $('.btn-material-update').removeClass('d-none').addClass('d-none');
    $('.btn-material-save').removeClass('d-none');
    $("#formMaterialInputModal").modal('show');
}
function itemMaterialInputSubmit(signed, action) {
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
        formData.providername = $('#itemMaterialInputForm').find('select[name="providercode"] option:selected').text();
        formData.materialinputname = $('#itemMaterialInputForm').find('select[name="materialid"] option:selected').text();
        formData.branchname = $('#itemMaterialInputForm').find('select[name="branchid"] option:selected').text();
        formData.manufacturername = $('#itemMaterialInputForm').find('select[name="manufacturerid"] option:selected').text();

        if (action == 'save') {
            materialinput_table.row.add(formData);
        } else if (action == 'update') {
            materialinput_table.row(currentRow).data(formData);
        }
        materialinput_table.draw();
        $("#formMaterialInputModal").modal('hide');

    }
}

function materialInputSubmit() {
    var purchasenumber = $('#materialinputForm').find('input[name="purchasenumber"]').val();
    var inputtime = $('#materialinputForm').find('input[name="inputtime"]').val();
    var data = {};
    data.items = [];
    if (materialinput_table.rows().data().length) {
        for (var i = 0; i < materialinput_table.rows().data().length; i++) {
            data.items[i] = materialinput_table.rows().data()[i];
            data.items[i].purchasenumber = purchasenumber;
            data.items[i].inputtime = inputtime;
        }
    }

    MaterialAPIData.addMaterialInputList(data, function (res) {
        window.location.href="/bo/data/materialinput.html"
    });
}

function editContent(data) {
    $('.btn-material-update').removeClass('d-none');
    $('.btn-material-save').removeClass('d-none').addClass('d-none');

    $('#itemMaterialInputForm').find('input[name="materialinputid"]').val(data.materialinputid);

    var $materialSelect = $($("#itemMaterialInputForm").find('select[name="materialid"]')[0]);
    if($materialSelect.find('option[value="'+data.materialid+'"]').length == 0){
        $materialSelect.append(`<option value="${data.materialid}">${data.materialinputname}</option>`);
    }
    $materialSelect.val(data.materialid).trigger('change');

    $('#itemMaterialInputForm').find('input[name="slotno"]').val(data.slotno);
    $('#itemMaterialInputForm').find('input[name="inputtime"]').val(data.inputtime);
    $('#itemMaterialInputForm').find('input[name="expdate"]').val(data.expdate);
    $('#itemMaterialInputForm').find('input[name="price"]').val(data.price);
    $('#itemMaterialInputForm').find('input[name="tax"]').val(data.tax);
    $('#itemMaterialInputForm').find('input[name="quantity"]').val(data.quantity);
    $('#itemMaterialInputForm').find('input[name="purchasenumber"]').val(data.purchasenumber);

    $('#itemMaterialInputForm').find('select[name="branchid"]').val(data.branchid);

    $('#itemMaterialInputForm').find('select[name="providercode"]').val(data.providercode);

    $('#itemMaterialInputForm').find('select[name="manufacturerid"]').val(data.manufacturerid);

    $("#formMaterialInputModal").modal('show');
}

function getBranchNameById(id) {
    return $('.select-branchid option[value="'+id+'"]').text();
}

var currentRow = 0;
var materialinput_table;
$(document).ready(function () {
    $('.datepicker').flatpickr({
        enableTime: false,
        dateFormat: "d/m/Y"
    });
    if ($('#materialinput_table').length) {
        materialinput_table = $('#materialinput_table').DataTable({

            bPaginate: false,
            bLengthChange: false,
            bFilter: false,
            bInfo: false,
            bAutoWidth: false,
            language: {
                url: '/themes/agent/js/datatables.vi.json',
            },
            columns: [
                {data: 'branchname'},
                {data: 'materialinputname'},
                {data: 'providername'},
                {data: 'materialinputid'},
                {data: 'slotno'},
                {data: 'expdate'},
                {data: 'price'},
                {data: 'quantity'},
                {data: 'tax'},
                {data: 'price'}
            ],
            columnDefs: [
                {
                    "render": function ( data, type, row ) {
                        let html = [];
                        html.push('<button type="button" class="btn btn-sm btn-square btn-neutral text-danger-hover btn-edit">\n' +
                            '          <i class="bi bi-pencil"></i>\n' +
                            '      </button>')
                        return html.join('');
                    },
                    "targets": 10
                },
            ],
            'sDom': 'lTfr<"clearfix">tip',
            'oTableTools': {
                'aButtons': []
            }
        });
        materialinput_table.on( '.btn-edit', function ( e, buttonApi, dataTable, node, config ) {
            console.log( 'Button '+buttonApi.text()+' was activated' );
        } );

        $('#materialinput_table tbody').on( 'click', 'button.btn-edit', function () {
            var tr = $(this).parent('td');
            var data = materialinput_table.row($(tr)).data();
            currentRow = materialinput_table.row($(tr)).index();
            editContent(data);
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

});
