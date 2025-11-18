$(document).ready(function() {
    $('.btn-payment-request').on('click',function(){
        var email = $(this).data('email');
        $.ajax({
            url: '/ao/payment/make-request.json?email='+encodeURIComponent(email),
            type: 'POST',
            contentType: "application/json",
            success: function(result) {

            }
        });
        $(this).addClass('d-none');
    });
    $('.btn-licenses').on('click',function(){
        var email = $(this).html();
        window.location = '/ao/payment/licenses.html?email='+encodeURIComponent(email);
    });
});
function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}
