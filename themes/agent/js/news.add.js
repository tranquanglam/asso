$(document).ready(function() {

    $('#newsForm').validate({
        rules: {
            'title': {
                required: true
            },
            'keyword': {
                required: true
            },
            'urlname': {
                required: true
            },
            'content': {
                required: true
            }
        },
        highlight: function(element) {
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight: function(element) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function(error, element) {
            if(element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });

    if (l == 'vi') {
        CKEDITOR.replace( 'contentvn', {
            filebrowserBrowseUrl: '/ckeditor/browse/'+base64_encoded_path,
            filebrowserUploadUrl: '/ckeditor/upload/'+base64_encoded_path,
            height: 700,
            allowedContent: true
        });
    } else if(l == 'it'){
        CKEDITOR.replace( 'contentit', {
            filebrowserBrowseUrl: '/ckeditor/browse/'+base64_encoded_path,
            filebrowserUploadUrl: '/ckeditor/upload/'+base64_encoded_path,
            height: 700,
            allowedContent: true
        });
    } else {
        CKEDITOR.replace( 'content', {
            filebrowserBrowseUrl: '/ckeditor/browse/'+base64_encoded_path,
            filebrowserUploadUrl: '/ckeditor/upload/'+base64_encoded_path,
            height: 700,
            allowedContent: true
        });
    }

});

