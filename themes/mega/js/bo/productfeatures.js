function addFormFeatureValue(event) {
    event.preventDefault();
    var index = $('#tableProductFeature tbody tr').length;
    $('#tableProductFeature tbody').append('<tr>\n' +
        '        <td>'+(index+1)+'</td>\n' +
        '        <td>Auto generate</td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].name" class="form-control" type="text"></td>\n' +
        '        <td><input name="jvalueDTO.items['+index+'].visible" class="form-control" type="checkbox"></td>\n' +
        '        <td><button class="btn btn-danger" onclick="deleteFeatureValue(event)">Delete</button></td>\n' +
        '    </tr>');
}

function deleteFeatureValue(event) {
    event.preventDefault();
    alert("This function is not available!");
}
function addContent() {
    $('#itemForm').find('input[name="productfeatureid"]').val(0);
    $('#itemForm').find('input[name="code"]').val('');
    $('#itemForm').find('input[name="price"]').val('');
    $('#itemForm').find('input[name="unitquantity"]').val('');
    $('#itemForm').find('input[name="numofavailable"]').val('');
    $('#itemForm').find('input[name="description"]').val('');
    $('#itemForm').find('input[name="descriptionvi"]').val('');
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
        if (obj.jvalueDTO && obj.jvalueDTO.items) {
            $('#tableProductFeature tbody').html('');
            for (let i = 0; i < obj.jvalueDTO.items.length; i++) {
                let item = obj.jvalueDTO.items[i];
                let checked = (item.visible == null || item.visible == false) ? '' : 'checked';
                $('#tableProductFeature tbody').append('<tr>\n' +
                    '        <td>'+(i+1)+'</td>\n' +
                    '        <td><input value="'+item.code+'" disabled name="jvalueDTO.items['+i+'].code" class="form-control" type="text"></td>\n' +
                    '        <td><input value="'+item.name+'" name="jvalueDTO.items['+i+'].name" class="form-control" type="text"></td>\n' +
                    '        <td><input '+ checked +' name="jvalueDTO.items['+i+'].visible" class="form-control" type="checkbox"></td>\n' +
                    '        <td><button class="btn btn-danger" onclick="deleteFeatureValue(event)">Delete</button></td>\n' +
                    '    </tr>');
            }
        }
        $("#formContentModal").modal('show');
    });

}
function deleteItem(id) {
    bootbox.confirm("Are you sure you want to delete this item!", function(result) {
        if (result) {
            $('#itemForm').find('input[name="productpriceid"]').val(id);
            $('#itemForm').find('input[name="action"]').val('delete');
            $('#itemForm').submit();
        }
    });
}
function itemFormSubmit(){
    $('#itemForm').validate({
        rules: {
            price: {
                required: true
            },
            unitquantity: {
                required: true
            },
            numofavailable: {
                required: true
            },
            description: {
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
