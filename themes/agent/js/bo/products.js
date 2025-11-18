function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}
function addContent() {
    $('#itemForm').find('input[name="productid"]').val(0);
    $('#itemForm').find('input[name="code"]').val('');
    $('#itemForm').find('input[name="name"]').val('');
    $('#itemForm').find('input[name="quantity"]').val('1');
    $('#itemForm').find('input[name="namevi"]').val('');
    $('#itemForm').find('input[name="visible"]').prop('checked', true);
    $("#formContentModal").modal('show');
}
function editContent(id) {
    $('#itemForm').find('input[name="productid"]').val(id);
    var name = $('#item_'+id).find('.item_name').html();
    $('#itemForm').find('input[name="name"]').val(name);
    var code = $('#item_'+id).find('.item_code').html();
    $('#itemForm').find('input[name="code"]').val(code);
    var quantity = $('#item_'+id).find('.item_quantity').html();
    $('#itemForm').find('input[name="quantity"]').val(quantity);
    var price = $('#item_'+id).find('.item_price').html();
    $('#itemForm').find('input[name="price"]').val(price);
    var namevi = $('#item_'+id).find('.item_namevi').html();
    $('#itemForm').find('input[name="namevi"]').val(namevi);
    var categoryurl = $('#item_'+id).find('.item_categoryurl').html();
    $('#itemForm').find('select[name="categoryurl"]').val(categoryurl);
    var manufacturerid = $('#item_'+id).find('.item_manufacturer').data('manufacturerid');
    $('#itemForm').find('select[name="manufacturerid"]').val(manufacturerid);
    var unit = $('#item_'+id).find('.item_unit').html();
    $('#itemForm').find('select[name="unit"]').val(unit);
    var visible = $('#item_'+id).attr('class').split('-')[1];
    if (visible == 'true') {
        $('#itemForm').find('input[name="visible"]').prop('checked', true);
    }
    $("#formContentModal").modal('show');
}
function itemFormSubmit(){
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
    $('#itemForm').submit();
}

$(document).ready(function() {
    $('.bd-sidebar').find('.bd-sidebar-product').addClass('active');

/*    $('#table_products').dataTable({
        "bPaginate": false,
        "bLengthChange": false,
        "bFilter": false,
        "bInfo": false,
        "bAutoWidth": false
    });*/
});
