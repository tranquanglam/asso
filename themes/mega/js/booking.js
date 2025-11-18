(function ($) {
    $.fn.serializeFormJSON = function () {

        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };
    Number.prototype.toVND = function() {
        var n = this;
        if(isNaN(n)){
            return '';
        }
        var maxFraction = 0;
        var nStr = n.toLocaleString('de-DE', {
            maximumFractionDigits: maxFraction
        });
        return nStr;
    };
})(jQuery);

'use strict';
var rate = 1,numfix = 2;
function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}
function applyCoupon() {
    var code = $("#couponCode").val();
    var customerorderid = $("#customerorderid").val();
    if (code != null && code != '' && customerorderid != null) {
        code = code.toUpperCase();
        $("#couponCode").val(code);
        var url = '/share/'+customerorderid+'/'+encodeURIComponent(code)+'/applyCoupon.json';
        $.getJSON(url, function( data ) {
            if (data.discount > 0) {
                var discount = rate * data.discount;
                $("#couponValue").text(discount.toVND());
                $("#couponLabel").removeClass('text-danger');
                $("#couponLabel").addClass('text-success');
                $("#couponLabel").html('<i class="fa fa-check" aria-hidden="true"></i> ' + data.promotionDescription);
                $('#widget-coupon').removeClass('d-none');
                var booking_total = parseFloat($("#totalproductprice").html());
                booking_total = booking_total - discount;
                $('.price.booking_total').html(booking_total.toVND());
            } else {
                $('#widget-coupon').addClass('d-none');
                $("#couponLabel").removeClass('text-success');
                $("#couponLabel").addClass('text-danger');
                $("#couponLabel").html('<i class="fa fa-times" aria-hidden="true"></i>');
                var booking_total = parseFloat($("#totalproductprice").html());
                $('.price.booking_total').html(booking_total.toVND());
            }
        });
    } else {
        alert("Invalid promotion code");
    }
}
function changePaymentMethod($elm){
    $('.paymentMethodATM').addClass('d-none');
    var pm = $("input[name=paymentMethod]:checked").val();
    if(pm == 'PG') {
        var id = $("input[name=paymentMethod]:checked").attr('id');
        if (id == 'paymentMethod_PG_global') {
            $("#isLocal").val('false');
        } else if (id == 'paymentMethod_PG_local') {
            $('.paymentMethodATM').removeClass('d-none');
            $("#isLocal").val('true');
        }
    }
}
function submitContactForm(){
    var lang = $('html').attr('lang');
    var msg_fullname = (lang == 'en') ? "Fullname is required" : 'Bạn chưa điền tên';
    var msg_email = (lang == 'en') ? "Email is required" : 'Bạn chưa điền email';
    var msg_phone = (lang == 'en') ? "Phone is required" : 'Bạn chưa điền số điện thoại';
    var msg_address = (lang == 'en') ? "Address is required" : 'Bạn chưa điền địa chỉ';
    var msg_zip = (lang == 'en') ? "Please select one" : 'Bạn chưa chọn phường xã';
    jQuery.validator.addMethod("validEmail", function (value, element) {
        if (value == '') return true;
        return validateEmail(value);
    }, "Please enter valid email.");
    jQuery.validator.addMethod("valueNotEquals", function(value, element, arg){
        return arg != value;
    }, "Value must not equal arg.");
    $('#contact-form').validate({
        rules: {
            'customer.fullname': {
                minlength: 3,
                maxlength: 255,
                required: true
            },
            'customer.email': {
                required: true,
                validEmail: true
            },
            'customer.phone': {
                required: true,
                maxlength: 15
            },
            'customer.address': {
                required: true,
                maxlength: 255
            },
            'customer.zip': {
                valueNotEquals: "0"
            }
        },
        messages: {
            'customer.fullname': {
                required: msg_fullname
            },
            'customer.email': {
                required: msg_email
            },
            'customer.phone': {
                required: msg_phone
            },
            'customer.address': {
                required: msg_address
            },
            'customer.zip': {
                valueNotEquals: msg_zip
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
    $("#contact-form").submit();
}

function removePriceitem(code) {
    $.ajax({
        url: '/ajax/remove-cart-item.json?code='+encodeURIComponent(code),
        type: "GET",
        contentType: "application/json",
        success: function (result) {
            var totalAmount = result.amount;
            $('.product-items-totalamount').html(totalAmount.toVND() + " " + getCurrency());
            $('#item-' + code).remove();
        }
    });
}

function getCurrency() {
    return $('#currency').html();
}
function addToCart(productcode,productid, quantity) {
    var mOrderItem = {};
    mOrderItem.productcode = productcode;
    mOrderItem.productid = productid;
    mOrderItem.quantity = quantity;
    $.ajax({
        url: '/ajax/add-to-cart.json',
        type: "POST",
        data: JSON.stringify(mOrderItem),
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            var totalAmount = result.amount;
            $('.product-items-totalamount').html(totalAmount.toVND() + " " + getCurrency());
        }
    });
}

$(document).ready(function() {
    $('#paymentBookingBtn').click(function(event){
        event.preventDefault();
        if ($("#agreeid").is(":checked")) {
            $("#payNowForm").submit();
        } else {
            $("#agreeid").focus();
            $('.agree-text').addClass('text-danger');
        }
    });
    if ($('#currencyrate').html() != '') {
        rate = parseFloat($('#currencyrate').html());
    }
    if ($('#currency').html() == 'VND') {
        numfix = 0;
    }
    if ($('#paymentPolicy').length) {
        $.ajax({
            url: '/ajax/page/payment-policy.json',
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                $("#paymentPolicy").html(result.content);
            }
        });
    }
    if ($('#couponCode').length && $('#couponCode').val() != '') {
        applyCoupon();
    }
    $('.cus-zip').on('change',function(){
        // TODO updateTotalAmount();
    });
    function changeCity() {
        var citycode = $('.cus-city').val();
        var countryid = $('.d-none.countryid').html();
        $.ajax({
            url: '/ajax/findWardsByCity.html?countryid='+countryid+'&citycode='+citycode,
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                $('.cus-zip').find('option').not(':first').remove();
                if (result.array.length > 0) {
                    var wardArray = result.array;
                    for (var i=0;i<wardArray.length;i++) {
                        var $option = '<option value="'+wardArray[i].zip+'">'+wardArray[i].name+'</option>';
                        $('.cus-zip').append($option);
                        //shippingfeeMap[wardArray[i].zip] = wardArray[i].fee;
                    }
                }
                //updateTotalAmount();
            }
        });
    }
    $('.cus-city').on('change',function(){
        changeCity();
    });
    function changeState() {
        var statecode = $('.cus-state').val();
        var countryid = $('.d-none.countryid').html();
        $.ajax({
            url: '/ajax/findCitiesByCountry.html?countryid='+countryid+'&statecode='+statecode,
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                $('.cus-city').html('');
                if (result.array.length > 0) {
                    var ctArray = result.array;
                    for (var i=0;i<ctArray.length;i++) {
                        var $option = '<option value="'+ctArray[i].code+'">'+ctArray[i].name+'</option>';
                        $('.cus-city').append($option);
                    }
                    changeCity();
                }
            }
        });
    }
    $('.cus-state').on('change',function(){
        changeState();
    });
    $('.cus-country').on('change',function(){
        var cid = $(this).val();
        $.ajax({
            url: '/ajax/findStatesByCountry.html?cid='+cid,
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                $('.d-none.countryid').html(result.countryid);
                $('.cus-state').html('');
                if (result.array.length > 0) {
                    var stArray = result.array;
                    for (var i=0;i<stArray.length;i++) {
                        var $option = '<option value="'+stArray[i].code+'">'+stArray[i].name+'</option>';
                        $('.cus-state').append($option);
                    }
                }
                changeState();
            }
        });
    });
    if ( $('.cus-city').length &&  $('.cus-zip').length) {
        var zip = $('.cus-zip').val();
        if (zip == '0') {
            changeCity();
        }
    }


    function calProductPrice(data) {
        var productCode = data.rateid;
        var qty = data.quantity;
        var price = $('#item-'+productCode+'-price').val();
        var amount = price * qty;
        $('.product-items-'+productCode+'-amount').html(amount.toVND());
    }


    $('.plus-btn').click(function () {
        var rateid = $(this).attr('id').split('_')[1];
        var max = parseInt($('.quantity-' + rateid).attr('max'));
        var qty = parseInt($('.quantity-' + rateid).val());
        var productid =$('#item-'+rateid+'-productid').val();
        if (qty < max) {
            qty++;
            $('.quantity-' + rateid).val(qty);
            calProductPrice({
                rateid: rateid,
                quantity: qty
            })
            addToCart(rateid,productid, 1);
        }
    });
    $('.minus-btn').click(function () {
        var rateid = $(this).attr('id').split('_')[1];
        var min = parseInt($('.quantity-' + rateid).attr('min'));
        var qty = parseInt($('.quantity-' + rateid).val());
        var productid =$('#item-'+rateid+'-productid').val();
        if (qty > min) {
            qty--;
            if (qty <= 0) {
                bootbox.confirm("Bạn muốn xóa sản phẩm này không?", function(result) {
                    if (result) {
                        removePriceitem(rateid);
                    }
                });
            } else {
                $('.quantity-' + rateid).val(qty);
                calProductPrice({
                    rateid: rateid,
                    quantity: qty
                });
                addToCart(rateid,productid, -1);
            }
        }
    });

    $('input[name="quantity"]').on('change', function () {
        var max = $(this).attr('max');
        var min = $(this).attr('min');
        var qty = $(this).val();
        if (isNaN(qty)) {
            qty = 0;
        }
        if (qty > max) {
            qty = max;
            $(this).val(qty);
        }
        if (qty < min) {
            qty = min;
            $(this).val(qty);
        }
    });

    if ($(".page_loader").length) {
        setTimeout(function () {
            $(".page_loader").fadeOut("fast");
        }, 100)
    }
});
