function addContent() {
    $('#itemForm').find('input[name="companyid"]').val(0);
    $('#itemForm').find('input[name="companycode"]').val('');
    $('#itemForm').find('input[name="name"]').val('');
    $("#formContentModal").modal('show');
}
function editContent(id) {
    $('#itemForm').find('input[name="companyid"]').val(id);
    var companycode = $('#item_'+id).find('.item_companycode').html();
    $('#itemForm').find('input[name="companycode"]').val(companycode);
    var name = $('#item_'+id).find('.item_name').html();
    $('#itemForm').find('input[name="name"]').val(name);
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
            companycode: {
                minlength: 3,
                maxlength: 255,
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
    $('.bd-sidebar').find('.bd-sidebar-category').addClass('active');
});
