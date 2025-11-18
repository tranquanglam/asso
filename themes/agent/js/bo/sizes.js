function addContent() {
    $('#itemForm').find('input[name="sizeid"]').val(0);
    $('#itemForm').find('input[name="name"]').val('');
    $("#formContentModal").modal('show');
}
function editContent(id) {
    $('#itemForm').find('input[name="sizeid"]').val(id);
    var name = $('#item_'+id).find('.item_name').html();
    $('#itemForm').find('input[name="name"]').val(name);
    var unitname = $('#item_'+id).find('.item_unitname').html();
    $('#itemForm').find('input[name="unitname"]').val(unitname);
    var unitvalue = $('#item_'+id).find('.item_unitvalue').html();
    $('#itemForm').find('input[name="unitvalue"]').val(unitvalue);

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
            name: {
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
