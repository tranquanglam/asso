$(document).ready(function() {
    if($('#config-tool').length) {
        $('#config-tool').addClass('d-none');
    }
    function updateGroupCount(city) {
        $.ajax({
            url: '/api/v0/guest/count-pending-order-by-group.json?city='+city,
            type: 'GET',
            contentType: "application/json",
            success: function(map) {
                $('.destination-list').find('.group-count').each(function(){
                    var groupid = $(this).data('groupid');
                    var scount = (map[groupid] != null) ? '(' + map[groupid] +')' : '';
                    $(this).html(scount);
                });
            }
        });
    }
    function changeCity() {
        var citycode = $('.cus-city').val();
        var countryid = $('.d-none.countryid').html();
        $.ajax({
            url: '/ajax/findDestinationsByCity.html?countryid='+countryid+'&citycode='+citycode+'&destype=Residentialarea',
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                $('.destination-list').html('');
                var desEle = $('#des-template').html();
                if (result.array.length > 0) {
                    var desArray = result.array;
                    for (var i=0;i<desArray.length;i++) {
                        var des = desEle.replace('{code}',desArray[i].code).replace('{name}',desArray[i].name);
                        des = des.replace('{groupid}',desArray[i].destinationid);
                        $('.destination-list').append(des);
                    }
                    updateGroupCount(citycode);
                }
            }
        });
    }
    $('.cus-city').on('change',function(){
        changeCity();
    });
    $('.cus-state').on('change',function(){
        var statecode = $(this).val();
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
                }
                changeCity();
            }
        });
    });
    changeCity();
});