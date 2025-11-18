function loadPageContent(nameurl) {
    $.ajax({
        url: '/ajax/page/'+nameurl+'.json',
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            $(".main-content").html(result.content);
            $('.page-nameurl').each(function(){
                var nurl = $(this).data('nameurl');
                if (nurl == nameurl) {
                    $(this.parentNode).addClass('active');
                } else {
                    $(this.parentNode).removeClass('active');
                }
            })
        }
    });
}
$(document).ready(function() {
    $('.page-nameurl').on('click',function(){
        var nameurl = $(this).data('nameurl');
        if (nameurl.indexOf('/') == 0) {
            nameurl = nameurl.substring(1);
        }
        loadPageContent(nameurl);
    });
    if(window.location.hash) {
        var hash = window.location.hash;
        if (hash.length > 1) {
            var nameurl = hash.substring(1);
            loadPageContent(nameurl);
        }
    } else if ($('.page-nameurl').length) {
        var nameurl = $('.page-nameurl').first().data('nameurl');
        if (nameurl.indexOf('/') == 0) {
            nameurl = nameurl.substring(1);
        }
        loadPageContent(nameurl);
    }
});
