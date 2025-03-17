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
function showLoadingMessage(messge,spinner,second) {
    if (spinner) {
        messge = messge + ' <div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div>';
    }
    $('.sending-loader-content').html(messge);
    $('.sending-loader').addClass('show');
    if (second > 0) {
        setTimeout(function() {
            hideLoadingMessage();
        }, second);
    }
}
function hideLoadingMessage() {
    $('.sending-loader-content').html('');
    $('.sending-loader').removeClass('show');
}
$(document).ready(function() {

});