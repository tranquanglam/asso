function validateEmail2(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}
function formatTextByLine(elm, line){
    var maxHeight = parseInt(elm.css('line-Height'))*line;

    while(elm.height() > maxHeight){
        var text = elm.text();
        elm.text(text.substring(0,text.length-10)).text(elm.text()+'...');
    }
}
function formatNumber(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}
function changeLang(lang) {
    $.ajax({
        url: '/ajax/change.json?lang='+lang,
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            document.location.reload();
        }
    });
}
function changeCurrency(key) {
    $.ajax({
        url: '/ajax/change.json?currency='+key,
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            document.location.reload();
        }
    });
}
function refreshCaptcha() {
    document.getElementById('captchaCodeImg').src = "/jcaptcha?dc=" + new Date().getTime();
}
function log(msg){
    if(debug){
        console.log(msg);
    }
}
function invertFormatDate(s,delim,newdelim) {
    var dd = s.split(delim);
    if (dd.length == 3) {
        return dd[2] + newdelim + dd[1] + newdelim + dd[0];
    }
    return '';
}
function removePriceitem(code) {
    $.ajax({
        url: '/ajax/remove-cart-item.json?code='+encodeURIComponent(code),
        type: "GET",
        contentType: "application/json",
        success: function (result) {
            updateCartWithResutl(result);
        }
    });
}
var eleTemplate = '<li id="rate_{productcode}">' +
    '<div class="row">' +
    '<div class="col-4"><span class=""><img src="{image}" alt="" width="100%"></span></div>' +
    '<div class="col-7 pl-0">{productname} \n <div class="quantity">{quantiy}</div> \n <div class="amount">{amount}</div></div>' +
    '<div class="col-1 pl-0"><a href="javascript:void(0);" onclick="removePriceitem(\'{productcode}\')"><i class="fa fa-trash"></i></a></div>'+
    '</div>' +
    '</li>';
function updateCartWithResutl(result) {
    $("#cart-products").html('');
    var quantity = 0;
    if (result.products != null && result.products.length > 0) {
        for (var i=0;i<result.products.length;i++) {
            var pi = result.products[i];
            quantity += pi.quantity;
            var ele = eleTemplate.replace('{productcode}',pi.productcode).replace('{productcode}',pi.productcode).replace('{productname}',pi.productname).replace('{amount}',pi.amount).replace('{quantiy}',pi.quantity);
            ele = ele.replace('{image}',pi.image);
            $("#cart-products").append(ele);
        }
    }
    $("#cart-badge").attr('data-count',quantity);
}
function updateCart() {
    $.ajax({
        url: '/ajax/cart.json',
        type: "GET",
        contentType: "application/json",
        success: function (result) {
            updateCartWithResutl(result);
        }
    });
}
function addToCart(productcode,productid) {
    var mOrderItem = {};
    mOrderItem.productcode = productcode;
    mOrderItem.productid = productid;
    mOrderItem.quantity = $('.quantity-'+productcode).val();
    if (mOrderItem.quantity > 0) {
        $.ajax({
            url: '/ajax/add-to-cart.json',
            type: "POST",
            data: JSON.stringify(mOrderItem),
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
                updateCartWithResutl(result);
            }
        });
    }
}
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
        var nStr = n.toLocaleString('en-US', {
            maximumFractionDigits: maxFraction
        });
        return nStr;
    };
})(jQuery);
function isIOS() {
    var userAgent = navigator.userAgent || navigator.vendor || window.opera;
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
        return true;
    }
    return false;
}
jQuery(document).ready(function ($) {
    if ($(window).width() >= 768) {
        $('.dropdown').hover(function() {
            $(this).addClass('show');
            $(this).find(' > .dropdown-menu').addClass('show');
        }, function() {
            $(this).removeClass('show');
            $(this).find(' > .dropdown-menu').removeClass('show');
        });
    }
    $(window).resize(function() {
        if ($(window).width() >= 768) {
            $('.dropdown').hover(function() {
                $(this).addClass('show');
                $(this).find(' > .dropdown-menu').addClass('show');
            }, function() {
                $(this).removeClass('show');
                $(this).find(' > .dropdown-menu').removeClass('show');
            });
        }
    });
    if (!$('#mega-slider').length) {
        $('.header.sticky').removeClass('transp');
    }
    if ($('#mega-product-slider').length) {
        $('.header.sticky').removeClass('transp').removeClass('sticky').addClass('sticky-on');
        var  mheight = $('#mainNav').height() + 10;
        $('.phead').height(mheight);
    }
    if ($('.transp').length && $('.phead').length) {
        var  mheight = $('#mainNav').height() + 10;
        $('.phead').height(mheight);
    }
    // Sticky Header
    $(window).ready(function() {
        sticky_check(this);
    });
    $(window).scroll(function() {
        sticky_check(this);
    });

    $(window).resize(function() {
        sticky_check(this);
    });

    function sticky_check($this) {
        if ($('#mega-slider').length) {
            if ($(window).width() >= 767) {
                if ($($this).scrollTop() > 150) {
                    $('.header.sticky').addClass("sticky-on");
                } else {
                    $('.header.sticky').removeClass("sticky-on");
                }
            } else {
                $('.header.sticky').removeClass("sticky-on");
            }
        }
    }
    $('[data-toggle="popover"]').popover();
    $('.banner-link').on('click',function(){
        var link = $(this).data('link');
        if (link != '' && link.length > 0) {
            window.location=link;
        }
    });
    $('#config-tool-cog').on('click', function(){
        $('#config-tool').toggleClass('closed');
    });
    $('#config-tool-close').on('click', function(){
        $('#config-tool').toggleClass('closed');
    });
    $('.btn-book-now').click(function(event){
        event.preventDefault();
        if ( $("#cart-products").length && $("#cart-products").html().length > 10) {
            $('#product-booking-form input[name="req"]').val('book');
            $('#product-booking-form').submit();
        }
    });
    updateCart();
    if ($('.section-page').length) {
        $('.section-page').each(function(){
            var bgcolor = $(this).data('bgcolor');
            if (bgcolor != '') {
                $(this).css("background-color", bgcolor);
            }
            var bgimage = $(this).data('bgimage');
            if (bgimage != '') {
                $(this).css('background-image', 'url(' + bgimage + ')');
                $(this).css('background-repeat', 'no-repeat');
                if (isIOS()) {
                    $(this).css('background-attachment','scroll');
                } else {
                    $(this).css('background-attachment','fixed');
                }
                $(this).css('background-size', 'cover');
            }
        });
    }
    if ($('.section-products').length) {
        $('.section-products').each(function(){
            var bgcolor = $(this).data('bgcolor');
            if (bgcolor != '') {
                $(this).css("background-color", bgcolor);
            }
        });
    }
    var sitelogo = $('#site-logo-img').html();
    $('img.logo').attr('src',sitelogo);
    if ($('.my-account-real-content').length) {
        var myaccountcontent = $('.my-account-real-content').html();
        $('.header .my-account').html(myaccountcontent);
        $('.my-account-real-content').html('');
        var langcontent = $('.lang-real-content').html();
        $('.header .li-language').html(langcontent);
        $('.lang-real-content').html('')
    }
});
