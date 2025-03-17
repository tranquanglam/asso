function addFormFeatureValue(event) {
    event.preventDefault();
    var index = $('#tableProductFeature tbody tr').length;
    $('#tableProductFeature tbody').append('<tr>\n' +
        '        <td>'+(index+1)+'</td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].code" class="form-control" type="text"></td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].name" class="form-control" type="text"></td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].iconCss" class="form-control" type="text"></td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].content" class="form-control" type="text"></td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].orderNumber" value="'+(index+1)+'" type="hidden"><button class="btn btn-danger" onclick="deleteFeatureValue(this)">Delete</button></td>\n' +
        '    </tr>');
}

function deleteFeatureValue(ele) {
    $(ele).closest('tr').remove();
}
function addContent() {
    $('#itemForm').find('input[name="productfeatureid"]').val(0);
    $('#itemForm').find('input[name="name"]').val('');
    $('#itemForm').find('input[name="code"]').val('');
    $('#itemForm').find('input[name="orderNumber"]').val($('.productfeature-item').length + 1);
    $('#tableProductFeature tbody').html('');
    var index = 0;
    $('#tableProductFeature tbody').append('<tr>\n' +
        '        <td>'+(index+1)+'</td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].code" class="form-control" type="text"></td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].name" class="form-control" type="text"></td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].iconCss" class="form-control" type="text"></td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].content" class="form-control" type="text"></td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].orderNumber" value="'+(index+1)+'" type="hidden"><button class="btn btn-danger" onclick="deleteFeatureValue(this)">Delete</button></td>\n' +
        '    </tr>');
    $("#formContentModal").modal('show');
}

function getProductFeatureApi(productid, productfeatureid, callback) {
    $.ajax({
        url: `/bo/data/${productid}/productfeatures/${productfeatureid}/detail.json`,
        type: 'GET',
        dataType: "json",
        contentType: "application/json",
        success: function(result){
            console.log(result);
            callback(result);
        },
        error: function (e){
            console.log('...................', e)
        }
    });
}
function editContent(id) {
    let productid = $('#load-productid').html();
    getProductFeatureApi(productid, id, function (obj) {
        $('#itemForm').find('input[name="productfeatureid"]').val(id);
        $('#itemForm').find('select[name="lang"]').val(obj.lang);
        $('#itemForm').find('input[name="name"]').val(obj.name);
        $('#itemForm').find('input[name="code"]').val(obj.code);
        $('#itemForm').find('input[name="orderNumber"]').val(obj.orderNumber);
        if (obj.jvalueDTO && obj.jvalueDTO.items) {
            $('#tableProductFeature tbody').html('');
            for (let i = 0; i < obj.jvalueDTO.items.length; i++) {
                let item = obj.jvalueDTO.items[i];
                let checked = (item.visible == null || item.visible == false) ? '' : 'checked';
                $('#tableProductFeature tbody').append('<tr>\n' +
                    '        <td>'+(i+1)+'</td>\n' +
                    '        <td><input value="'+item.code+'" readonly name="jvalueDTO.items['+i+'].code" class="form-control" type="text"></td>\n' +
                    '        <td><input value="'+item.name+'" name="jvalueDTO.items['+i+'].name" class="form-control" type="text"></td>\n' +
                    '        <td><input value="'+item.iconCss+'" name="jvalueDTO.items['+i+'].iconCss" class="form-control" type="text"></td>\n' +
                    '        <td><input value="'+item.content+'" name="jvalueDTO.items['+i+'].content" class="form-control" type="text"></td>\n' +
                    '        <td><input value="'+item.orderNumber+'" name="jvalueDTO.items['+i+'].orderNumber" type="hidden"><button class="btn btn-danger" onclick="deleteFeatureValue(this)">Delete</button></td>\n' +
                    '    </tr>');
            }
        }
        $("#formContentModal").modal('show');
    });

}
function deleteItem(id) {
    bootbox.confirm("Are you sure you want to delete this item!", function(result) {
        if (result) {
            $('#itemForm').find('input[name="productfeatureid"]').val(id);
            $('#itemForm').find('input[name="action"]').val('delete');
            $('#itemForm').submit();
        }
    });
}
function itemFormSubmit(){
    $('#itemForm').validate({
        rules: {
            name: {
                required: true
            },
            ciode: {
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
    $('#itemForm').submit();
}
