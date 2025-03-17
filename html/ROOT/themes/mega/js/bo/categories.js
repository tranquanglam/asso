function addContent() {
    $('#itemForm').find('input[name="categoryid"]').val(0);
    $('#itemForm').find('input[name="nameurl"]').val('');
    $('#itemForm').find('input[name="name"]').val('');
    $('#itemForm').find('input[name="ordernumber"]').val('1');
    $('#itemForm').find('input[name="namevi"]').val('');
    $('#itemForm').find('input[name="visible"]').prop('checked', true);
    $("#formContentModal").modal('show');
}
function editContent(id) {
    $('#itemForm').find('input[name="categoryid"]').val(id);
    var name = $('#item_'+id).find('.item_name').html();
    $('#itemForm').find('input[name="name"]').val(name);
    var nameurl = $('#item_'+id).find('.item_nameurl').html();
    $('#itemForm').find('input[name="nameurl"]').val(nameurl);
    var ordernumber = $('#item_'+id).find('.item_ordernumber').html();
    $('#itemForm').find('input[name="ordernumber"]').val(ordernumber);
    var namevi = $('#item_'+id).find('.item_namevi').html();
    $('#itemForm').find('input[name="namevi"]').val(namevi);
    var ctype = $('#item_'+id).find('.item_type').html();
    var ltype = (ctype == 'MAIN') ? 8 : 11;
    $('#itemForm').find('select[name="type"]').val(ltype);
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
            nameurl: {
                minlength: 3,
                maxlength: 255,
                required: true
            },
            namevi: {
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
