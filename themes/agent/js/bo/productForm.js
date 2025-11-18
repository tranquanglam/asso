function deleteAlbumItem(itemID){
    bootbox.confirm('Are you sure you want to delete this item ?', function(r){
        if(r){
            var productid = $('#productid').val();
            var deleteAlbumItemUrl = '/bo/data/'+productid+'/deleteAlbumItem.html?itemID=' + itemID;
            $.ajax({
                cache: false,
                type: "GET",
                dataType: 'json',
                url:  deleteAlbumItemUrl,
                success: function(res){
                    $('.albumItem-'+itemID).remove();
                }
            });
        }
    });
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

function itemFormDelete() {
    bootbox.confirm('Are you sure you want to delete this item?', function(r){
        if(r){
            var productid = $('#productid').val();
            var deleteAlbumItemUrl = '/bo/data/'+productid+'/delete.html';
            $.ajax({
                cache: false,
                type: "POST",
                dataType: 'json',
                url:  deleteAlbumItemUrl,
                success: function(res){
                    bootbox.alert('This product was deleted.', function(r){
                        window.location.href = '/bo/data/products.html'
                    });
                }
            });
        }
    });
}
function setProductImage(ele) {
    var itemurl = $(ele).data('imageurl');
    $('#image').val(itemurl);
}
$(document).ready(function() {
    var base64_encoded_path = $('#base64_encoded_path').html();
    CKEDITOR.replace( 'description', {
        filebrowserBrowseUrl: '/ckeditor/browse/'+base64_encoded_path,
        filebrowserUploadUrl: '/ckeditor/upload/'+base64_encoded_path,
        height: 300,
        allowedContent: true
    });
    CKEDITOR.replace( 'descriptionvi', {
        filebrowserBrowseUrl: '/ckeditor/browse/'+base64_encoded_path,
        filebrowserUploadUrl: '/ckeditor/upload/'+base64_encoded_path,
        height: 300,
        allowedContent: true
    });
    Dropzone.options.myAwesomeDropzone = {
        paramName: "file", // The name that will be used to transfer the file
        maxFilesize: 60, // MB
        acceptedFiles:"image/*,application/pdf,.psd,.mp3,.mp4"
    };

    $("#keyword").select2({
        tags: true,
        tokenSeparators: [',', ' ']
    })
});
