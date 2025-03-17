function changeState() {
    $('.cus-city').find('option').not(':first').remove();
    var statecode = $('.cus-state').val();
    if (statecode != '') {
        var countryid = $('.d-none.countryid').html();
        $.ajax({
            url: '/ajax/findCitiesByCountry.html?countryid='+countryid+'&statecode='+statecode,
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                if (result.array.length > 0) {
                    var ctArray = result.array;
                    for (var i=0;i<ctArray.length;i++) {
                        var $option = '<option value="'+ctArray[i].code+'">'+ctArray[i].name+'</option>';
                        $('.cus-city').append($option);
                    }
                }
            }
        });
    }
}
$('.cus-state').on('change',function(){
    changeState();
});
function nexteventFormSubmit() {
    $('#nexteventForm').submit();
}
$(document).ready(function() {
    function changeCity() {
        $('.cus-zip').find('option').not(':first').remove();
        var citycode = $('.cus-city').val();
        var countryid = $('.d-none.countryid').html();
        $.ajax({
            url: '/ajax/findWardsByCity.html?countryid='+countryid+'&citycode='+citycode,
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                if (result.array.length > 0) {
                    var wardArray = result.array;
                    for (var i=0;i<wardArray.length;i++) {
                        var $option = '<option value="'+wardArray[i].zip+'">'+wardArray[i].name+'</option>';
                        $('.cus-zip').append($option);
                    }
                }
            }
        });
    }
    $('.cus-city').on('change',function(){
        changeCity();
    });
    $('.btn-export-zip').click(function (e) {
        window.location = '/bo/report/zip-export?' + $("#reportForm").serialize();
    });


    $('.custom-select').select2({
        theme: "bootstrap-5",
        allowClear: false
    });
});
