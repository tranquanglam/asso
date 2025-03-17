function addContent() {
    $('#itemForm').find('input[name="productpriceid"]').val(0);
    $('#itemForm').find('input[name="strikeprice"]').val('');
    $('#itemForm').find('input[name="price"]').val('');
    $('#itemForm').find('input[name="unitquantity"]').val('');
    $('#itemForm').find('input[name="numofavailable"]').val('');
    $('#itemForm').find('input[name="description"]').val('');
    $('#itemForm').find('input[name="descriptionvi"]').val('');
    $("#formContentModal").modal('show');
}
function editContent(id) {
    $('#itemForm').find('input[name="productpriceid"]').val(id);
    var strikeprice = $('#item_'+id).find('.item_strikeprice').html();
    $('#itemForm').find('input[name="strikeprice"]').val(strikeprice);
    var price = $('#item_'+id).find('.item_price').html();
    $('#itemForm').find('input[name="price"]').val(price);
    var unitquantity = $('#item_'+id).find('.item_unitquantity').html();
    $('#itemForm').find('input[name="unitquantity"]').val(unitquantity);
    var numofavailable = $('#item_'+id).find('.item_numofavailable').html();
    $('#itemForm').find('input[name="numofavailable"]').val(numofavailable);
    var description = $('#item_'+id).find('.item_description').html();
    $('#itemForm').find('input[name="description"]').val(description);
    var descriptionvi = $('#item_'+id).find('.item_descriptionvi').html();
    $('#itemForm').find('input[name="descriptionvi"]').val(descriptionvi);
    $("#formContentModal").modal('show');
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