function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}
function addContent() {
    $('#itemForm').find('input[name="manufacturerid"]').val(0);
    $('#itemForm').find('input[name="name"]').val('');
    $('#itemForm').find('input[name="address"]').val('');
    $('#itemForm').find('select[name="country"]').val('');
    $('#itemForm').find('select[name="state.stateid"]').val('');
    $('#itemForm').find('select[name="city.cityid"]').val('');
    $('#itemForm').find('select[name="city.wardid"]').val('');
    $("#formContentModal").modal('show');
}
function editContent(id) {
    $('#itemForm').find('input[name="manufacturerid"]').val(id);
    var name = $('#item_'+id).find('.item_name').html();
    $('#itemForm').find('input[name="name"]').val(name);
    var address = $('#item_'+id).find('.item_address').html();
    $('#itemForm').find('input[name="address"]').val(address);
    var country = $('#item_'+id).find('.item_country').html();
    $('#itemForm').find('select[name="country"]').val(country);


    $('.cus-state').find('option').not(':first').remove();
    $('.cus-city').find('option').not(':first').remove();
    $('.cus-ward').find('option').not(':first').remove();

    if ($('#item_'+id).find('.item_stateid').length) {
        var stateid = $('#item_'+id).find('.item_stateid').html();
        var statename = $('#item_'+id).find('.item_statename').html();
        $('.cus-state').append('<option value="'+stateid+'" >'+statename+'</option>');
        $('#itemForm').find('select[name="state.stateid"]').val(stateid);
    }
    if ($('#item_'+id).find('.item_cityid').length) {
        var cityid = $('#item_'+id).find('.item_cityid').html();
        var cityname = $('#item_'+id).find('.item_cityname').html();
        $('.cus-city').append('<option value="'+cityid+'">'+cityname+'</option>');
        $('#itemForm').find('select[name="city.cityid"]').val(cityid);
    }
    if ($('#item_'+id).find('.item_wardid').length) {
        var wardid = $('#item_'+id).find('.item_wardid').html();
        var wardname = $('#item_'+id).find('.item_wardname').html();
        $('.cus-ward').append('<option value="'+wardid+'">'+wardname+'</option>');
        $('#itemForm').find('select[name="ward.wardid"]').val(wardid);
    }

    $("#formContentModal").modal('show');
}
function itemFormSubmit(){
    $('#itemForm').validate({
        rules: {
            name: {
                minlength: 1,
                maxlength: 255,
                required: true
            },
            address: {
                minlength: 3,
                maxlength: 255,
                required: true
            },
            country: {
                required: true
            }
        },
        highlight: function (element) {
            $(element).closest('.control-group').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.control-group').removeClass('has-error');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function (error, element) {
            if (element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });
    $('#itemForm').submit();
}

function changeCountry() {
    $('.cus-state').find('option').not(':first').remove();
    $('.cus-city').find('option').not(':first').remove();
    var countryId =  $('.cus-country').find(":selected").attr('data-countryid');
    $.ajax({
        url: '/ajax/findStatesByCountry.html?cid='+countryId,
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            if (result.array.length > 0) {
                var ctArray = result.array;
                for (var i=0;i<ctArray.length;i++) {
                    var $option = '<option value="'+ctArray[i].stateid+'" data-code="'+ctArray[i].code+'">'+ctArray[i].name+'</option>';
                    $('.cus-state').append($option);
                }
            }
        }
    });

}

function changeState() {
    $('.cus-city').find('option').not(':first').remove();
    var statecode = $('.cus-state').find(":selected").attr('data-code');
    if (statecode != '') {
        var countryid =  $('.cus-country').find(":selected").attr('data-countryid');
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

function changeCity() {
    var citycode = $('.cus-city').val();
    var countryid =  $('.cus-country').find(":selected").attr('data-countryid');
    $.ajax({
        url: '/ajax/findWardsByCity.html?countryid='+countryid+'&citycode='+citycode,
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            $('.cus-ward').find('option').not(':first').remove();
            if (result.array.length > 0) {
                var wardArray = result.array;
                for (var i=0;i<wardArray.length;i++) {
                    var $option = '<option value="'+wardArray[i].wardid+'">'+wardArray[i].name+'</option>';
                    $('.cus-ward').append($option);
                }
            }
        }
    });
}

$(document).ready(function () {
    $('.cus-city').on('change',function(){
        changeCity();
    });

    $('.cus-state').on('change',function(){
        changeState();
    });

    $('.cus-country').on('change',function(){
        changeCountry();
    });

});
