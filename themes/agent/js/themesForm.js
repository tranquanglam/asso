
$(document).ready(function() {


    $(".js-product-one").on('click', function (e) {
        $(".js-product-one").removeClass('active');
        $(e.currentTarget).removeClass('active').addClass('active');
    });

    $(".js-product-one-box").on('click', function (e) {
        $(".js-product-one-box").removeClass('active');
        $(e.currentTarget).removeClass('active').addClass('active');
    });

    $(".js-submit").on('click', function (e) {
        debugger;
        var data = $('#formBean').serializeFormJSON();
        data.layoutOne = $(".js-product-one.active").data('layout');
        data.layoutOneBox = $(".js-product-one-box.active").data('layout');
        $.ajax({
            url: '/ajax/updateSiteStyle.json',
            type: "POST",
            data: JSON.stringify(data),
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
                console.log(result);
                alert("Success");
            }
        });
    });
});
