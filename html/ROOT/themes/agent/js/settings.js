$(document).ready(function() {
    $('.btn-send-test-email').on('click',function(){
        $('#emailFormModal').modal('show');
    });
    $('.btn-refresh-enet-chat-key').on('click',function(){
        $.ajax({
            type: "GET",
            url: '/agent/refresh-enet-chat-key.json',
            contentType: "application/json",
            success: function (res) {
                $('.enet-chat-key').html(res.errorMessage);
            }
        });
    });
    $('.btn-disable-enet-chat').on('click',function(){
        $.ajax({
            type: "GET",
            url: '/agent/refresh-enet-chat-key.json?remove=true',
            contentType: "application/json",
            success: function (res) {
                $('.enet-chat-key').html(res.errorMessage);
            }
        });
    });
});
