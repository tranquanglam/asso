$(document).ready(function() {
    $('.btn-get-enet-product').on('click',function(){
        var categoryurl =  $(this).data('categoryurl');
        var code =  $(this).data('code');
        $.ajax({
            type: "GET",
            url: '/agent/enetstore/'+categoryurl+'/'+code+'/get-one-product.json',
            contentType: "application/json",
            success: function (res) {
                $('#pageModalLabel').html(res.name);
                $('#pageModalContent').html(res.content);
                $('#pageModal').modal('show');
            }
        });
    });
    $('.btn-enetstore-search').on('click',function(){
        $('#enetStoreFilterForm').submit();
    });
});
