function paymentFormSubmit(){
    jQuery.validator.addMethod("validEmail", function (value, element) {
        if (value == '') return true;
        return validateEmail2(value);
    }, "Please enter valid email.");
    $('#paymentForm').validate({
        rules: {
            'email': {
                required: true,
                validEmail: true
            },
            'domain': {
                required: true
            },
            'captchaCode': {
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
    $("#paymentForm").submit();
}