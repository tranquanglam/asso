function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}
function addContent() {
    $('#itemForm').find('input[name="manufacturerid"]').val(0);
    $('#itemForm').find('input[name="name"]').val('');
    $('#itemForm').find('input[name="address"]').val('');
    $('#itemForm').find('select[name="country"]').val('');
    $("#formContentModal").modal('show');
}
function editContent(id) {
    $('#itemForm').find('input[name="manufacturerid"]').val(id);
    var name = $('#item_'+id).find('.item_name').html();
    $('#itemForm').find('input[name="name"]').val(name);
    var address = $('#item_'+id).find('.item_address').html();
    $('#itemForm').find('input[name="address"]').val(address);
    var country = $('#item_'+id).find('.item_country').html();
    $('#itemForm').find('select[name="country"]').val(country);
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
            address: {
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