function cancelEditShippingfee(ele) {
    $(this).parent().parent().remove();
    $('.edit-shipping-fee-form').removeClass('active');
}
function formatMoney(m) {
    return parseFloat(m).toLocaleString('en-US', {
        maximumFractionDigits: 0
    });
}
function confirmShipping(ele) {
    if ($('.btn-export-booking').length) {
        var bookingid = $(ele).data('bookingid');
        var access_token = $('.access_token').html();
        var shippingfee  = $('.edit-shipping-fee-form.active').find('input[name="shippingfee"]').val();
        if (shippingfee == '') {
            $('.edit-shipping-fee-form.active').find('input[name="shippingfee"]').focus();
            return;
        }
        var shippingdate  = $('.edit-shipping-fee-form.active').find('input[name="shippingdate"]').val();
        if (shippingdate == '') {
            $('.edit-shipping-fee-form.active').find('input[name="shippingdate"]').focus();
            return;
        }
        var requestOrder = {};
        requestOrder.status = 'SHIPPING';
        requestOrder.shippingfee = shippingfee;
        requestOrder.shippingdate = shippingdate;
        $.ajax({
            url: '/api/v0/supplier/'+bookingid+'/update-fees.json',
            type: 'POST',
            data: JSON.stringify(requestOrder),
            dataType: "json",
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + access_token);
            },
            success: function(result){
                if (result.errorMessage == null) {
                    $('.edit-shipping-fee-form').removeClass('active');
                    var tdstatus = '<div class="status {status}"><span>{status}</span></div>';
                    tdstatus = tdstatus.replace(/\{status\}/g,result.status);
                    $('.tr-booking-id-'+bookingid).find('.td-status').html(tdstatus);
                    var sfee = formatMoney(result.shippingfee);
                    $('.tr-booking-id-'+bookingid).find('.td-shipping-fee').html(sfee);
                    $('.tr-booking-id-'+bookingid).find('.td-shipping-date').html(shippingdate);
                    var finalamount = formatMoney(result.finalamount);
                    $('.tr-booking-id-'+bookingid).find('.finalamount').html(finalamount);
                } else {
                    alert(result.errorMessage);
                }
            },
            error: function (e){
                console.log('...................', e)
            }
        });
    }
}
$(document).ready(function() {
    $('.datepicker').flatpickr({
        enableTime: false,
        dateFormat: "d/m/Y",
    });
    function gotoPage(page) {
        $("#formPage").val(page);
        $("#myBookingForm").submit();
    }
    if ($('.btn-export-booking').length) {
        $('.btn-export-booking').click(function (e) {
            window.location = '/my/booking/export?' + $("#myBookingForm").serialize();
        });
        var editTemp = $('#edit-shipping-fee-template').html();
        $('.edit-shipping-fee.REQUEST').click(function (e) {
            $('.edit-shipping-fee-form').removeClass('active');
            $(this).parent().find('.edit-shipping-fee-form').addClass('active');
            var bookingid = $(this).data('bookingid');
            var access_token = $('.access_token').html();
            $.ajax({
                url: '/api/v0/supplier/'+bookingid+'/mybooking.json',
                type: 'GET',
                contentType: "application/json",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("Authorization", "Bearer " + access_token);
                },
                success: function(result){
                    if (result.status == 'REQUEST') {
                        var content = editTemp.replace(/\{bookingid\}/g,bookingid).replace('{shippingfee}',result.shippingfee);
                        var lis = '';
                        for (var i=0;i<result.products.length;i++) {
                            var item = result.products[i];
                            lis += '<li class="list-group-item">'+item.productname+ ' x ' + item.quantity +'</li>';
                        }
                        content = content.replace('{lis}',lis).replace('{city}',result.city);
                        $('.edit-shipping-fee-form.active').html(content);
                        $('.edit-shipping-fee-form.active .shipping-datetime').flatpickr({
                            enableTime: true,
                            dateFormat: "d/m/Y H:i",
                            minTime: "06:00",
                            maxTime: "22:00"
                        });
                    } else {
                        $('.edit-shipping-fee-form').removeClass('active');
                    }
                },
                error: function (e){
                    $('.edit-shipping-fee-form').removeClass('active');
                    console.log('...................', e)
                }
            });
        });
    }
    $('.bd-sidebar').find('.bd-sidebar-booking').addClass('active');
});
