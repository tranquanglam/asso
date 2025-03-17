
$(document).ready(function() {

    $('#formBean').validate({
        rules: {
            host: {
                required: true
            },
            port: {
                required: true,
                number: true
            },
            username: {
                required: true
            },
            password: {
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


    $(".btn-cancel").on('click', function (e) {
        window.history.back();
    });
});