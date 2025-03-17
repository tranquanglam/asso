$('#categoryForm').validate({
    rules: {
        'pojo.nameurl': {
            required: true
        },
        'pojo.name': {
            required: true
        },
        'pojo.namevn': {
            required: true
        },
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

function buildSelectGoogleProduct(text) {
    var data = [];
    var array = text.split("\n");
    array.forEach(function (item) {
        data.push({
            id: item.split(" - ")[0],
            text: item.split(" - ")[1] + " - " + item.split(" - ")[0]
        })
    });
    $('#googleCategoryProduct').select2({
        theme: "bootstrap-5",
        data: data
    });
    $('#googleCategoryProduct').val($('#namevi').val()).trigger('change')
}

fetch('/themes/agent/taxonomy-with-ids.vi-VN.txt')
    .then(response => response.text())
    .then(text => buildSelectGoogleProduct(text));
