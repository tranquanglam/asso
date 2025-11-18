(function($) {
    "use strict";
    $('.parallax').parallax("50%", 0.2);
    $('.beactive').addClass('active');
    $('.beactive').removeClass('beactive');
    $('.mg-search-box-trigger').click(function () {
        var sbox = $(this).next();
        // $(this).toggleClass('mg-sb-active');
        $(this).find('i').toggleClass('fa-times');
        sbox.toggleClass('mg-sb-active');
        return false;
    });
    /*
     * Main Menu dropdown at Hover
     */
    if ($(window).width() >= 768) {
        $('.dropdown').hover(
            function () {
                $(this).addClass('open');
            },
            function() {
                $(this).removeClass('open');
            }
        );
    }
    $(window).resize(function () {
        if ($(window).width() >= 768) {
            $('.dropdown').hover(
                function () {
                    $(this).addClass('open');
                },
                function() {
                    $(this).removeClass('open');
                }
            );
        }
    });
    // Sticky Header
    $(window).ready(function () {
        sticky_check(this);
    });
    $(window).scroll(function() {
        sticky_check(this);
    });

    $(window).resize(function() {
        sticky_check(this);
    });

    function sticky_check ($this) {
        if ($(window).width() >= 767) {
            if ($($this).scrollTop() > 150){
                if (!$('.sticky-on-fixed').length && !$('.header.sticky').hasClass('transp') ) {
                    $('body').prepend('<div class="sticky-on-fixed" style="height:'+$('.header.sticky').height()+'px"></div>');
                };

                $('.header.sticky').addClass("sticky-on");
            }
            else{
                $('.header.sticky').removeClass("sticky-on");

                $('.sticky-on-fixed').remove();
            }
        } else {
            $('.header.sticky').removeClass("sticky-on");
            $('.sticky-on-fixed').remove();
        }
    }
})(jQuery);

$(window).load(function () {
});

/*
 * Preloader
 */
$(window).load(function () {
    $('.preloader').fadeOut("slow");
});

