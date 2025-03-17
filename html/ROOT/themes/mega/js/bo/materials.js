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

    this.addMaterial = function ( data, optionCallback) {
        var url = "/api/v0/supplier/material/add.json";
        me.executeAjaxPost(url, data, {
            success: optionCallback
        });
    };

    this.addMaterialProduct = function ( data, optionCallback) {
        var url = "/api/v0/supplier/material/addMaterialProduct.json";
        me.executeAjaxPost(url, data, {
            success: optionCallback
        });
    };

    this.addMaterialInput = function ( data, optionCallback) {
        var url = "/api/v0/supplier/material/addMaterialInput.json";
        me.executeAjaxPost(url, data, {
            success: optionCallback
        });
    };

    this.deleteMaterialProduct = function ( data, optionCallback) {
        var url = "/api/v0/supplier/material/deleteMaterialProduct.json";
        me.executeAjaxPost(url, data, {
            success: optionCallback
        });
    };


}
var MaterialAPIData = new MaterialAPIData();

function addContent() {
    $('#itemForm').find('input[name="materialid"]').val(0);
    $('#itemForm').find('input[name="code"]').val('');
    $('#itemForm').find('input[name="name"]').val('');
    $('#itemForm').find('input[name="quantity"]').val('1');
    $('#itemForm').find('input[name="namevi"]').val('');
    $('#itemForm').find('input[name="visible"]').prop('checked', true);
    $("#formContentModal").modal('show');
}

function editContent(id) {
    $('#itemForm').find('input[name="materialid"]').val(id);
    var name = $('#item_' + id).find('.item_name').html();
    $('#itemForm').find('input[name="name"]').val(name);
    var code = $('#item_' + id).find('.item_code').html();
    $('#itemForm').find('input[name="code"]').val(code);
    var quantity = $('#item_' + id).find('.item_quantity').html();
    $('#itemForm').find('input[name="quantity"]').val(quantity);
    var price = $('#item_' + id).find('.item_price').html();
    $('#itemForm').find('input[name="price"]').val(price);
    var namevi = $('#item_' + id).find('.item_namevi').html();
    $('#itemForm').find('input[name="namevi"]').val(namevi);
    var categoryurl = $('#item_' + id).find('.item_categoryurl').html();
    $('#itemForm').find('select[name="categoryurl"]').val(categoryurl);
    var manufacturerid = $('#item_' + id).find('.item_manufacturer').data('manufacturerid');
    $('#itemForm').find('select[name="manufacturerid"]').val(manufacturerid);
    var unit = $('#item_' + id).find('.item_unit').html();
    $('#itemForm').find('select[name="unit"]').val(unit);
    var visible = $('#item_' + id).attr('class').split('-')[1];
    if (visible == 'true') {
        $('#itemForm').find('input[name="visible"]').prop('checked', true);
    }
    $("#formContentModal").modal('show');
}

function editContentMaterial(ele) {
    var obj = {
        materialid: $(ele).data('material-id'),
        name: $(ele).data('material-name'),
        namevi: $(ele).data('material-namevi'),
        code: $(ele).data('material-code'),
        quantity: $(ele).data('material-quantity'),
        price: $(ele).data('material-price'),
        unit: $(ele).data('material-unit'),
    }
    $('#itemForm').find('input[name="materialid"]').val(obj.materialid);
    $('#itemForm').find('input[name="name"]').val(obj.name);
    $('#itemForm').find('input[name="code"]').val(obj.code);
    $('#itemForm').find('input[name="quantity"]').val(obj.quantity);
    $('#itemForm').find('input[name="price"]').val(obj.price);
    $('#itemForm').find('input[name="namevi"]').val(obj.namevi);
    $('#itemForm').find('select[name="unit"]').val(obj.unit);
    if (obj.visible == 'true') {
        $('#itemForm').find('input[name="visible"]').prop('checked', true);
    }
    $("#formContentModal").modal('show');
}

function itemFormSubmit() {
    $('#itemForm').validate({
        rules: {
            name: {
                minlength: 3,
                maxlength: 255,
                required: true
            },
            code: {
                minlength: 3,
                maxlength: 255,
                required: true
            },
            country: {
                required: true
            }
        },
        highlight: function (element) {
            $(element).closest('.control-group').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.control-group').removeClass('has-error');
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
    var formData = $('#itemForm').serializeFormJSON();
    formData.visible = true ? formData.visible == 'on' : false;
    MaterialAPIData.addMaterial(formData, function (res) {
        if (materials_table) {
            materials_table.ajax.reload();
        }
        $("#formContentModal").modal('hide');
    });
}

function itemMaterialProductSubmit() {
    $('#itemMaterialProductForm').validate({
        rules: {
            materialid: {
                required: true
            }
        },
        highlight: function (element) {
            $(element).closest('.control-group').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.control-group').removeClass('has-error');
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
    var formData = $('#itemMaterialProductForm').serializeFormJSON();
    MaterialAPIData.addMaterialProduct(formData, function (res) {
        if (materialproducts_table) {
            materialproducts_table.ajax.reload();
        }
        $("#formMaterialProductModal").modal('hide');

    });
}

function addMaterialProduct() {
    $('#itemMaterialProductForm').find('input[name="materialid"]').val(0);
    $('#itemMaterialProductForm').find('input[name="code"]').val('');
    $('#itemMaterialProductForm').find('input[name="name"]').val('');
    $('#itemMaterialProductForm').find('input[name="quantity"]').val('1');
    $('#itemMaterialProductForm').find('input[name="namevi"]').val('');
    $('#itemMaterialProductForm').find('input[name="visible"]').prop('checked', true);
    $("#formMaterialProductModal").modal('show');
}

function addMaterialInput() {
    $('#itemMaterialInputForm').find('input[name="materialid"]').val(0);
    $('#itemMaterialInputForm').find('input[name="code"]').val('');
    $('#itemMaterialInputForm').find('input[name="name"]').val('');
    $('#itemMaterialInputForm').find('input[name="quantity"]').val('1');
    $('#itemMaterialInputForm').find('input[name="namevi"]').val('');
    $('#itemMaterialInputForm').find('input[name="visible"]').prop('checked', true);
    $("#formMaterialInputModal").modal('show');
}
function itemMaterialInputSubmit() {
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
        },
        highlight: function (element) {
            $(element).closest('.control-group').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.control-group').removeClass('has-error');
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
    var formData = $('#itemMaterialInputForm').serializeFormJSON();
    MaterialAPIData.addMaterialInput(formData, function (res) {
        if (materialinput_table) {
            materialinput_table.ajax.reload();
        }
        $("#formMaterialInputModal").modal('hide');

    });

    MaterialAPIData.deleteMaterialProduct(formData, function (res) {
        if (materialinput_table) {
            materialinput_table.ajax.reload();
        }
        $("#formMaterialInputModal").modal('hide');

    });
}


var materials_table;
var materialproducts_table;
var materialinput_table;
$(document).ready(function () {
    if ($('#materials_table').length) {
        materials_table = $('#materials_table').DataTable({
            pageLength: 100,
            paging: true,
            processing: true,
            serverSide: true,
            ajax: {
                url: '/api/v0/supplier/material/dataMaterials.json' + window.location.search,
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: function (d) {
                    return JSON.stringify(d);
                }
            },
            columns: [
                {data: 'code'},
                {data: 'name'},
                {data: 'namevi'},
                {data: 'price'},
                {data: 'unit'},
                {data: 'quantity'},
                {data: 'materialid'}
            ],
            columnDefs: [
                {
                    "render": function (data, type, row ) {
                        var html = [];
                        html.push(`<a href="javascript:void(0)" onclick="editContentMaterial(this)" 
                                        data-material-id="${row.materialid}"
                                        data-material-code="${row.code}"
                                        data-material-name="${row.name}"
                                        data-material-namevi="${row.namevi}"
                                        data-material-unit="${row.unit}"
                                        data-material-quantity="${row.quantity}"
                                        data-material-price="${row.price}"
                                        data-material-inputprice="${row.inputprice}"
                                        ><i class="bi bi-pencil-square"></i></a>`);
                        return html.join('');
                    },
                    "targets": 6
                }
            ],
            'sDom': 'lTfr<"clearfix">tip',
            'oTableTools': {
                'aButtons': []
            }
        });
    }

    if ($('#materialproducts_table').length) {
        var productid = $('#js_productid').html();
        materialproducts_table = $('#materialproducts_table').DataTable({
            pageLength: 100,
            paging: true,
            processing: true,
            serverSide: true,
            ajax: {
                url: '/api/v0/supplier/product/' + productid + '/dataMaterialProducts.json' + window.location.search,
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: function (d) {
                    return JSON.stringify(d);
                }
            },
            columns: [
                {data: 'materialproductid'},
                {data: 'materialproductid'},
                {data: 'materialproductid'},
                {data: 'quantity'},
                {data: 'materialproductid'},
                {data: 'materialproductid'}
            ],
            columnDefs: [
                {
                    "render": function ( data, type, row ) {
                        return row.material.code;
                    },
                    "targets": 1
                },
                {
                    "render": function ( data, type, row ) {
                        return row.material.name;
                    },
                    "targets": 2
                },{
                    "render": function ( data, type, row ) {
                        return row.material.inputprice || 'undefined';
                    },
                    "targets": 4
                },{
                    "render": function ( data, type, row ) {
                        return '<a href="javascript:void(0)" class="" onclick="deleteMaterialProduct(this)" data-materialproductid="'+data+'"><i class="bi bi-trash"></i></a>   ';
                    },
                    "targets": 5
                },
            ],
            'sDom': 'lTfr<"clearfix">tip',
            'oTableTools': {
                'aButtons': []
            }
        });
    }

    if ($('#materialinput_table').length) {

        materialinput_table = $('#materialinput_table').DataTable({
            pageLength: 100,
            paging: true,
            processing: true,
            serverSide: true,
            ajax: {
                url: '/api/v0/supplier/material/dataMaterialInput.json' + window.location.search,
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: function (d) {
                    return JSON.stringify(d);
                }
            },
            columns: [
                {data: 'materialinputid'},
                {data: 'materialinputid'},
                {data: 'materialinputid'},
                {data: 'price'},
                {data: 'quantity'},
                {data: 'amount'},
                {data: 'tax'},
                {data: 'totalamount'},
                {data: 'inputtime'},
            ],
            columnDefs: [
                {
                    "render": function ( data, type, row ) {
                        return row.material.name;
                    },
                    "targets": 1
                },
                {
                    "render": function ( data, type, row ) {
                        return row.manufacturer.name;
                    },
                    "targets": 2
                },
                {
                    "render": function ( data, type, row ) {
                        return row.tax + '%';
                    },
                    "targets": 6
                },
            ],
            'sDom': 'lTfr<"clearfix">tip',
            'oTableTools': {
                'aButtons': []
            }
        });
    }

    if ($('#selectMaterialid').length) {
        $("#selectMaterialid").select2({
            dropdownParent: $('#formMaterialInputModal').length > 0 ? $('#formMaterialInputModal') : $('#formMaterialProductModal'),
            theme: "bootstrap-5",
            allowClear: true,
            placeholder: "Materials",
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
                                text: item.code + " - " + item.name,
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

function deleteMaterialProduct(e) {
    var dataMaterialProductId = $(e).data('materialproductid') || '';
    if (dataMaterialProductId != '') {
        bootbox.confirm("Are you sure you want to delete this item!", function(result) {
            if (result) {
                MaterialAPIData.deleteMaterialProduct({
                    materialproductid: dataMaterialProductId
                }, function (res) {
                    if (materialproducts_table) {
                        materialproducts_table.ajax.reload();
                    }
                });
            }
        });
    }
}
function updateStatus(productID, status) {
    var updateVisibleUrl = '/agent/apiproducts/' + productID + '/ajax/updateVisible.html?status=' + status;
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

function updateCategory(productID, categoryurl) {
    $('#apiproductid').val(productID);
    $('#categoryurl').val(categoryurl);
    $("#categoryModal").modal("show");
}
