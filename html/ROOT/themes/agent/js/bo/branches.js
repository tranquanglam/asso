function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}
function addContent() {
    $('#itemForm').find('input[name="branchid"]').val(0);
    $('#itemForm').find('input[name="urlname"]').val('');
    $('#itemForm').find('input[name="name"]').val('');
    $('#itemForm').find('input[name="address"]').val('');
    $('#itemForm').find('input[name="phone"]').val('');
    $('#itemForm').find('area[name="description"]').val('');
    $("#formContentModal").modal('show');
}
function editContent(id) {
    $('#itemForm').find('input[name="branchid"]').val(id);
    var name = $('#item_'+id).find('.item_name').html();
    $('#itemForm').find('input[name="name"]').val(name);
    var urlname = $('#item_'+id).find('.item_urlname').html();
    $('#itemForm').find('input[name="urlname"]').val(urlname);
    var address = $('#item_'+id).find('.item_address').html();
    $('#itemForm').find('input[name="address"]').val(address);
    var phone = $('#item_'+id).find('.item_phone').html();
    $('#itemForm').find('input[name="phone"]').val(phone);
    var shortdescription = $('#item_'+id).find('.item_shortdescription').html();
    $('#itemForm').find('textarea[name="shortdescription"]').val(shortdescription);
    var keyword = $('#item_'+id).find('.item-others').data('keyword');
    $('#itemForm').find('input[name="keyword"]').val(keyword);
    var image1 = $('#item_'+id).find('.item-others').data('image1');
    $('#itemForm').find('input[name="image1"]').val(image1);
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