function joinMeeting(saleid,ldealid) {
    if (typeof BuyerDeals != 'undefined') {
        showMainContent('buyer-deals-container');
        var buyerdealsContainer = document.getElementById('buyer-deals-container');
        var accessToken = $('#loyalty-container').data('accesstoken');
        var serverPath = $('#loyalty-container').data('serverpath');
        BUYER_DEALS.joinRoom(buyerdealsContainer,serverPath,accessToken,saleid,ldealid,function(){
            console.log('Buyer joinRoom');
            $('.dragable-section').each(function(){
                var id = $(this).attr('id');
                if (id != undefined) {
                    dragElement(document.getElementById(id));
                }
            });
        });
    }
}
$(document).ready(function() {
    setTimeout(function(){
        var saleid =  $('#remoteproviderid').val();
        var ldealid =  $('#remoteappointmentid').val();
        joinMeeting(saleid,ldealid);
    },3000);
});