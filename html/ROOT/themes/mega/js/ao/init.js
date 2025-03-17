function validateEmail2(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}
function selectTemplate(id) {
    $('.template').each(function() {
        $(this).removeClass('active');
    });
    $('.template').each(function() {
        if ($(this).data('tempid') == id) {
            $(this).addClass('active');
            var domain = $(this).data('cdomain');
            $('#cdomain').val(domain);
            var sitetype = $(this).data('sitetype');
            $('#sitetype').val(sitetype);
        }
    });
}
function createSiteFormSubmit(){
    jQuery.validator.addMethod("validEmail", function (value, element) {
        if (value == '') return true;
        return validateEmail2(value);
    }, "Please enter valid email.");
    $('#createSiteForm').validate({
        rules: {
            'inputEmail': {
                required: true,
                validEmail: true
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
    $("#createSiteForm").submit();
}
function filterStype(stype) {
    if (stype > 0) {
        $('.template').each(function() {
            if ($(this).data('sitetype') == stype) {
                $(this).removeClass('d-none');
            } else {
                $(this).addClass('d-none');
            }
        });
    } else {
        $('.template').each(function() {
            $(this).removeClass('d-none');
        });
    }
    $('.sidebar-stype').each(function(){
        var stypeitem = $(this).data('stype');
        if (stypeitem == stype) {
            $(this).addClass('active');
        } else {
            $(this).removeClass('active');
        }
    })
}
$(document).ready(function() {
    $('header .navbar').addClass('navbar-ao-sticky');
    $('.template-link').on('click',function(){
        var domain = 'https://' + $(this).data('cdomain');
        $('#messageContentModalLabel').html(domain);
        $('#modal-iframe-content').attr('src',domain);
        $("#messageContentModal").modal('show');
    });
    if ($('#creating-site').length) {
        var userid = $('#userid').html();
        var token = $('#token').html();
        $.ajax({
            url: '/ao/init-done/'+userid+'/'+token+'.json',
            type: 'POST',
            contentType: "application/json",
            success: function(result) {
                if (result.success == 'true') {
                    var siteinfo = $('#site-information').html();
                    siteinfo = siteinfo.replace('{domain}','http://'+result.domain).replace('{domain}','http://'+result.domain);
                    siteinfo = siteinfo.replace('{username}',result.username);
                    siteinfo = siteinfo.replace('{password}',result.subdomain);
                    $("#creating-site").html(siteinfo);
                } else {
                    if (result.errorMessage) {
                        $("#creating-site").html(result.errorMessage);
                    } else {
                        $("#creating-site").html("Something has wrong! we'll get back to you ASAP...");
                    }

                }
            }
        });
    }
    $('#select-site-type').on('change',function(){
        var stype = parseInt($(this).val());
        filterStype(stype);
    });
    if ($('#stype').length) {
        var ss = $('#stype').html();
        if (ss != '') {
            var stype = parseInt(ss);
            filterStype(stype);
        }
    }
});
