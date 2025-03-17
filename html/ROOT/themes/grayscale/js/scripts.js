/*!
    * Start Bootstrap - Grayscale v6.0.1 (https://startbootstrap.com/themes/grayscale)
    * Copyright 2013-2020 Start Bootstrap
    * Licensed under MIT (https://github.com/BlackrockDigital/startbootstrap-grayscale/blob/master/LICENSE)
    */
    (function ($) {
    "use strict"; // Start of use strict

    // Smooth scrolling using jQuery easing
    $('a.js-scroll-trigger[href*="#"]:not([href="#"])').click(function () {
        if (
            location.pathname.replace(/^\//, "") ==
                this.pathname.replace(/^\//, "") &&
            location.hostname == this.hostname
        ) {
            var target = $(this.hash);
            target = target.length
                ? target
                : $("[name=" + this.hash.slice(1) + "]");
            if (target.length) {
                $("html, body").animate(
                    {
                        scrollTop: target.offset().top - 70,
                    },
                    1000,
                    "easeInOutExpo"
                );
                return false;
            }
        }
    });

    // Closes responsive menu when a scroll trigger link is clicked
    $(".js-scroll-trigger").click(function () {
        $(".navbar-collapse").collapse("hide");
    });

    // Activate scrollspy to add active class to navbar items on scroll
    $("body").scrollspy({
        target: "#mainNav",
        offset: 100,
    });

    // Collapse Navbar
    var navbarCollapse = function () {
        if ($("#mainNav").offset().top > 100) {
            $("#mainNav").addClass("navbar-shrink");
        } else {
            $("#mainNav").removeClass("navbar-shrink");
        }
    };
    // Collapse now if page is not at top
    navbarCollapse();
    // Collapse the navbar when page is scrolled
    $(window).scroll(navbarCollapse);
})(jQuery); // End of use strict

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
    if (lang == 'id') {
        lang = 'in';
    }
    var currentURL = window.location.href;
    if (currentURL.indexOf('#') > 0) {
        currentURL = currentURL.substring(0, currentURL.indexOf('#'));
    }
    document.location = "/change?lang="+lang+"&url="+encodeURIComponent(currentURL);
}
function changeCurrency(key) {
    var currentURL = window.location.href;
    if (currentURL.indexOf('#') > 0) {
        currentURL = currentURL.substring(0, currentURL.indexOf('#'));
    }
    document.location = "/change?currency="+key+"&url="+encodeURIComponent(currentURL);
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

jQuery(document).ready(function ($) {
    if ($(window).width() >= 768) {
        $('.nav-item.dropdown').hover(function() {
            $(this).addClass('show');
            $(this).find(' > .dropdown-menu').addClass('show');
        }, function() {
            $(this).removeClass('show');
            $(this).find(' > .dropdown-menu').removeClass('show');
        });
    }
    $(window).resize(function() {
        if ($(window).width() >= 768) {
            $('.nav-item.dropdown').hover(function() {
                $(this).addClass('show');
                $(this).find(' > .dropdown-menu').addClass('show');
            }, function() {
                $(this).removeClass('show');
                $(this).find(' > .dropdown-menu').removeClass('show');
            });
        }
    });
    if ($('.masthead').length) {
        var bgimage = $('#masthead-bg-image').html();
        var bgcss = 'linear-gradient(to bottom, rgba(0, 0, 0, 0.3) 0%, rgba(0, 0, 0, 0.7) 75%, #000000 100%), url("'+bgimage+'")';
        $('.masthead').css('background',bgcss);
    }
    if ($('.phead').length) {
        var  mheight = $('#mainNav').height() + 10;
        $('.phead').height(mheight);
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
    $('.subcribe').click(function(event){
        if ($("#inputEmail").length && $("#inputEmail").val().length > 6) {
            var subscribeReq = {};
            subscribeReq.inputEmail = $("#inputEmail").val();
            subscribeReq.comment = 'subcribe';
            if (validateEmail2(subscribeReq.inputEmail)) {
                $('.subcribe').addClass('d-none');
                $.ajax({
                    url: '/ajax/subscribe.json',
                    type: "POST",
                    data: JSON.stringify(subscribeReq),
                    dataType: "json",
                    contentType: "application/json",
                    success: function (result) {
                        if (result.errorCode == null) {
                            $('.subcribe-container').html('Thank you for your subcribe');
                        }
                    }
                });
            } else {
                console.log("invalid email");
            }
        }
    });
    updateCart();
});
