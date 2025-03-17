function fcmPushMessage(objJson){
    $.ajax({
        url: window.location.origin + '/agent/news/push-notification.html?newsid=' + objJson.newsid,
        contentType: 'application/json',
        cache: false,    //This will force requested pages not to be cached by the browser
        processData:false, //To avoid making query String instead of JSON
        success: function(res) {
            console.log(res);
            dialog.modal('hide');
        },
        error:function(data,status,er) {
            dialog.modal('hide');
        }
    });
}

var dialog;
$(document).ready(function () {
    $('.push-notification').click(function () {
        var newsid = $(this).attr('newsid');
        dialog = bootbox.dialog({
            message: '<p class="text-center">Please wait</p>',
            closeButton: false
        });
        fcmPushMessage(
            {
                "newsid" : newsid
            })
    });
});