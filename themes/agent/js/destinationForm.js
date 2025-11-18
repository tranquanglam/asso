function editAvatar() {
    document.getElementById('avatar').innerHTML = "<input type='file' name='avatarFile' size='40' />";
}
function changeState() {
    $('.cus-city').find('option').not(':first').remove();
    var statecode = $('.cus-state').val();
    if (statecode != '') {
        var countryid = $('.countryid').val();
        $.ajax({
            url: '/ajax/findCitiesByCountry.html?countryid='+countryid+'&statecode='+statecode,
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                if (result.array.length > 0) {
                    var ctArray = result.array;
                    for (var i=0;i<ctArray.length;i++) {
                        var $option = '<option value="'+ctArray[i].cityid+'">'+ctArray[i].name+'</option>';
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
