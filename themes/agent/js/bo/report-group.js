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
$('.edit-shipping-date-link').on('click',function(){
    var groupid = $(this).data('groupid');
    $('#formContentModal').find('input[name="groupid"]').val(groupid);
    var nextevent = $(this).data('nextevent');
    $('#formContentModal').find('input[name="nextevent"]').val(nextevent);
    var groupname = $(this).parent().parent().find('.groupname').html();
    $('#formContentModal .groupname').html(groupname);
    $('#formContentModal').modal('show');
});
function nexteventFormSubmit() {
    $('#nexteventForm').submit();
}
$(document).ready(function() {
    $('#formContentModal .nextevent').flatpickr({
        enableTime: true,
        dateFormat: "d/m/Y H:i",
        minTime: "06:00",
        maxTime: "22:00"
    });
    $('.btn-export-group').click(function (e) {
        window.location = '/bo/report/group-export?' + $("#reportForm").serialize();
    });
});