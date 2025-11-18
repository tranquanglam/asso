$(document).ready(function() {
    $('#groupStartdate').flatpickr({
        enableTime: false,
        dateFormat: "m/d/Y"
    });
    $('#groupEnddate').flatpickr({
        enableTime: false,
        dateFormat: "m/d/Y"
    });
    $('#checkin').flatpickr({
        enableTime: false,
        dateFormat: "m/d/Y"
    });
    $('#checkout').flatpickr({
        enableTime: false,
        dateFormat: "m/d/Y"
    });

    $('#promotionFormBean').validate({
        rules: {
            'code': {
                required: true
            },
            'startdate': {
                required: true
            },
            'enddate': {
                required: true
            },
            'discount': {
                required: true
            },
            'minimum': {
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

