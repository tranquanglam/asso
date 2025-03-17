function submitForm(){
    $("#apisiteForm").submit();
}
$(document).ready(function() {
    $('#apisiteForm').validate({
        rules: {
            'siteurl': {
                required: true
            },
            'resourceid': {
                required: true
            },
            'clientid': {
                required: true
            },
            'clientsecrect': {
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
});