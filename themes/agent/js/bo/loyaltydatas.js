function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}

$(document).ready(function () {
    $('.js-convert-to-lead').on('click', function (e) {
        let $ele = $(e.currentTarget);
        let loyaltydataid = $ele.data('loyaltydataid');
        $('#lead_loyaltyDataId').val(loyaltydataid);
        let arrayFields = $(`.js-fieldnames-${loyaltydataid}`);
        let html = [];
        arrayFields.each(function (i) {
            let name = $(this).data('fieldname');
            if (name == 'phoneNumber') {
                name = 'phone';
            }
            let value = $(this).data('fieldvalue');
            html.push(`<div class="row mb-3">
                            <label for="inputEmail3" class="col-sm-2 col-form-label">${name}</label>
                            <div class="col-sm-10">
                                <input type="text" name="${name}" readonly class="form-control" value="${value}">
                            </div>
                        </div>    `)
        });

        $('#loyaltyDataInfo').html('')
        $('#loyaltyDataInfo').append(html.join(''));
        $('#convertToLeadModal').modal('show');
    });

    $('.js-convertToLeadSubmit').on('click', function (e) {

        let jdata = $('#convertToLeadForm').serializeFormJSON();
        $.ajax({
            url: "/bo/data/loyaltydatas/convertToLead.json",
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(jdata),
            success: function(response) {
                $('#convertToLeadModal').modal('hide');
                setTimeout(function () {
                    alert("success");
                }, 200);
            }
        });
    });
});
