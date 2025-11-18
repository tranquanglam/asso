function changeState() {
    $('.cus-city').find('option').remove();
    var statecode = $('.cus-state').val();
    if (statecode != '') {
        var countryid = $('.d-none.countryid').html();
        $.ajax({
            url: '/ajax/findCitiesByCountry.html?countryid='+countryid+'&statecode='+statecode,
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                if (result.array.length > 0) {
                    var ctArray = result.array;
                    for (var i=0;i<ctArray.length;i++) {
                        var $option = '<option value="'+ctArray[i].code+'">'+ctArray[i].name+'</option>';
                        $('.cus-city').append($option);
                    }
                }
            }
        });
    }
}
$('.cus-state').on('change',function(){
    changeState();
});
$(document).ready(function() {
    $('.btn-edit-shipping-fees').on('click',function(){
        $('.btn-edit-shipping-fees').addClass('d-none');
        $('.btn-edit-shipping-fees-save').removeClass('d-none');
        $('.item-shippingfee').each(function() {
            $(this).attr('contenteditable','true');
        });
        $('.item-shippinginitfee').each(function() {
            $(this).attr('contenteditable','true');
        });
    });
    $('.btn-edit-shipping-fees-save').on('click',function(){
        $('.btn-edit-shipping-fees').removeClass('d-none');
        $('.btn-edit-shipping-fees-save').addClass('d-none');
        $('.item-shippingfee').each(function() {
            $(this).attr('contenteditable','false');
            var wardid = $(this).data('wardid');
            var fee = $(this).data('fee');
            var sfee = $(this).html();
            $('.item-shippinginitfee.ward-'+wardid).attr('contenteditable','false');
            var initfee = $('.item-shippinginitfee.ward-'+wardid).data('initfee');
            var sinitfee = $('.item-shippinginitfee.ward-'+wardid).html();
            if (sfee == '0' || fee != sfee || initfee != sinitfee) {
                $(this).data('fee',sfee);
                $('.item-shippinginitfee.ward-'+wardid).data('initfee',sinitfee);
                $.ajax({
                    url: '/bo/data/'+wardid+'/save-fee.json?fee='+sfee+'&initfee='+sinitfee,
                    type: 'GET',
                    contentType: "application/json",
                    success: function(result) {
                        if (result.shippingfeeid != null) {

                        }
                    }
                });
            }
        });
    });
});