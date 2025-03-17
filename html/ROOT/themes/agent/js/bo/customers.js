$(document).ready(function() {
    function changeCity(callback) {
        $('.cus-zip-one').find('option').not(':first').remove();
        var citycode = $('.cus-city-one').val();
        var countryid = $('.d-none.countryid').html();
        $.ajax({
            url: '/ajax/findWardsByCity.html?countryid='+countryid+'&citycode='+citycode,
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                if (result.array.length > 0) {
                    var wardArray = result.array;
                    for (var i=0;i<wardArray.length;i++) {
                        var $option = '<option value="'+wardArray[i].zip+'">'+wardArray[i].name+'</option>';
                        $('.cus-zip-one').append($option);
                    }
                }
                callback();
            }
        });
    }
    function changeState(classstate, classcity, callback) {
        $('.'+classcity).find('option').not(':first').remove();
        var statecode = $('.'+classstate).val();
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
                            $('.'+classcity).append($option);
                        }
                        if (callback != undefined) {
                            callback();
                        }
                    }
                }
            });
        }
    }
    $('.cus-state').on('change',function(){
        changeState('cus-state','cus-city');
    });
    $('.cus-state-one').on('change',function(){
        changeState('cus-state-one','cus-city-one');
    });
    $('.cus-city-one').on('change',function(){
        changeCity(function(){

        });
    });
    $('.btn-link-customer').on('click',function(){
        var customerid = $(this).data('customerid');
        $.ajax({
            url: '/bo/data/'+customerid+'/customer.json',
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                debugger;
                $('#customerForm').find('input[name="customerid"]').val(result.customerid);
                $('#customerForm').find('input[name="fullname"]').val(result.fullname);
                if (result.dateofbirth != null) {
                    $('#customerForm').find('input[name="cdateofbirth"]').val(invertFormatDate(result.dateofbirth,'-','/'));
                }
                if (result.cusNote != null) {
                    $('#customerForm').find('input[name="cusNote.note"]').val(result.cusNote.note);
                }
                $('#customerForm').find('select[name="statecode"]').val(result.statecode);
                changeState('cus-state-one','cus-city-one',function(){
                    $('#customerForm').find('select[name="city"]').val(result.city);
                    changeCity(function(){
                        $('#customerForm').find('select[name="zip"]').val(result.zip);
                    });
                });


                $('#customerForm').find('input[name="address"]').val(result.address);
                $('#customerForm').find('input[name="email"]').val(result.email);
                $('#customerForm').find('input[name="relativename"]').val(result.relativename);
                $('#customerForm').find('input[name="phone"]').val(result.phone);
                $("#customerContentModal").modal('show');
            }
        });
    });
    $('.btn-update').on('click',function(){
        $("#customerContentModal").modal('hide');
        var customer = {};
        customer.customerid= $('#customerForm').find('input[name="customerid"]').val();
        customer.fullname= $('#customerForm').find('input[name="fullname"]').val();
        customer.city = $('#customerForm').find('select[name="city"]').val();
        customer.zip = $('#customerForm').find('select[name="zip"]').val();
        customer.address= $('#customerForm').find('input[name="address"]').val();
        customer.email= $('#customerForm').find('input[name="email"]').val();
        customer.relativename= $('#customerForm').find('input[name="relativename"]').val();
        customer.phone= $('#customerForm').find('input[name="phone"]').val();
        var cdateofbirth = $('#customerForm').find('input[name="cdateofbirth"]').val();
        if (cdateofbirth != '') {
            var dd = invertFormatDate(cdateofbirth,'/','-');
            customer.dateofbirth = dd;
        }
        var cusNote = {};
        cusNote.note= $('#customerForm').find('input[name="cusNote.note"]').val();
        customer.cusNote = cusNote;
        $.ajax({
            url: '/bo/data/customer.json',
            type: 'PUT',
            contentType: "application/json",
            data: JSON.stringify(customer),
            dataType: "json",
            success: function(result) {
                window.location.reload();
                $('#customer_'+customer.customerid).find('.fullname').html(customer.fullname);
                $('#customer_'+customer.customerid).find('.address').html(customer.address);
                $('#customer_'+customer.customerid).find('.relativename').html(customer.relativename);
                $('#customer_'+customer.customerid).find('.phone').html(customer.phone);
                $('#customer_'+customer.customerid).find('.email').html(customer.email);
            }
        });
    });
    $('.btn-booking-history').on('click',function(){
        var customerid = $(this).data('customerid');
        window.location = '/my/booking.html?customerId='+customerid;
    });

    $('.bd-sidebar').find('.bd-sidebar-customer').addClass('active');
});
function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}
function invertFormatDate(s,delim,newdelim) {
    var dd = s.split(delim);
    if (dd.length == 3) {
        return dd[2] + newdelim + dd[1] + newdelim + dd[0];
    }
    return '';
}
