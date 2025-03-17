var cusArray = [];
function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}
function addContent() {
    var sdate = $('#date').val();
    $('#itemForm').find('input[name="sdate"]').val(sdate);
    var doctorname = $('#doctorid').text();
    $('#formContentModalLabel').find('.doctor-name').html(doctorname);
    var doctorid = $('#doctorid').val();
    $('#itemForm').find('input[name="doctor.userID"]').val(doctorid);
    $("#formContentModal").modal('show');
}
function editContent(id) {
    $('#itemForm').find('input[name="clinicid"]').val(id);
    var name = $('#item_'+id).find('.item_name').html();
    $('#itemForm').find('input[name="name"]').val(name);
    var urlname = $('#item_'+id).find('.item_urlname').html();
    $('#itemForm').find('input[name="urlname"]').val(urlname);
    var address = $('#item_'+id).find('.item_address').html();
    $('#itemForm').find('input[name="address"]').val(address);
    var shortdescription = $('#item_'+id).find('.item_shortdescription').html();
    $('#itemForm').find('textarea[name="shortdescription"]').val(shortdescription);
    var keyword = $('#item_'+id).find('.item-others').data('keyword');
    $('#itemForm').find('input[name="keyword"]').val(keyword);
    var image1 = $('#item_'+id).find('.item-others').data('image1');
    $('#itemForm').find('input[name="image1"]').val(image1);
    var visible = $('#item_'+id).attr('class').split('-')[1];
    if (visible == 'true') {
        $('#itemForm').find('input[name="visible"]').prop('checked', true);
    }
    $("#formContentModal").modal('show');
}
function itemFormSubmit(){
    $('#itemForm').validate({
        rules: {
            timerange: {
                minlength: 3,
                maxlength: 255,
                required: true
            },
            startnumber: {
                required: true
            },
            endnumber: {
                required: true
            },
            sessionduration: {
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
function deleteItem(id) {
    bootbox.confirm("Are you sure you want to delete this item!", function(result) {
        if (result) {
            $('#deleteForm').find('input[name="id"]').val(id);
            $('#deleteForm').submit();
        }
    });
}
function sessionFormSubmit(){
    $('#sessionForm').validate({
        rules: {
            'customer.fullname': {
                minlength: 3,
                maxlength: 255,
                required: true
            },
            'customer.address': {
                minlength: 3,
                maxlength: 255,
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
    var cdateofbirth = $('#sessionForm').find('input[name="cdateofbirth"]').val();
    if (cdateofbirth != '') {
        var dd = invertFormatDate(cdateofbirth,'/','-');
        $('#sessionForm').find('input[name="customer.dateofbirth"]').val(dd);
    } else {
        $('#sessionForm').find('input[name="customer.dateofbirth"]').val('');
    }
    $('#sessionForm').submit();
}
function selectCus(i) {
    var cus =  cusArray[i];
    $('#sessionForm').find('input[name="customer.customerid"]').val(cus.customerid);
    $('#cfullname').val(cus.fullname);
    if (cus.dateofbirth != null) {
        $('#sessionForm').find('input[name="cdateofbirth"]').val(invertFormatDate(cus.dateofbirth,'-','/'));
    }
    $('#sessionForm').find('input[name="customer.address"]').val(cus.address);
    $('#sessionForm').find('input[name="customer.email"]').val(cus.email);
    $('#sessionForm').find('input[name="customer.relativename"]').val(cus.relativename);
    $('#sessionForm').find('input[name="customer.phone"]').val(cus.phone);
    if (cus.cusNote != null) {
        $('#sessionForm').find('input[name="customer.cusNote.height"]').val(cus.cusNote.height);
        $('#sessionForm').find('input[name="customer.cusNote.weight"]').val(cus.cusNote.weight);
    }
}
function autocomplete(inp) {
    var currentFocus;
    inp.addEventListener("input", function(e) {
        var a, b, i, val = this.value;
        /*close any already open lists of autocompleted values*/
        closeAllLists();
        if (!val) { return false;}
        currentFocus = -1;
        /*create a DIV element that will contain the items (values):*/
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        /*append the DIV element as a child of the autocomplete container:*/
        this.parentNode.appendChild(a);
        $.ajax({
            url: '/clinic/data/customers.json?max=10&q='+encodeURIComponent(val),
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                cusArray = result;
                for (i = 0; i < cusArray.length; i++) {
                    /*check if the item starts with the same letters as the text field value:*/
                    if (cusArray[i].fullname.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                        /*create a DIV element for each matching element:*/
                        b = document.createElement("DIV");
                        /*make the matching letters bold:*/
                        b.innerHTML = "<strong>" + cusArray[i].fullname.substr(0, val.length) + "</strong>";
                        b.innerHTML += cusArray[i].fullname.substr(val.length);
                        /*insert a input field that will hold the current array item's value:*/
                        b.innerHTML += "<input type='hidden' value='" + i + "'>";
                        /*execute a function when someone clicks on the item value (DIV element):*/
                        b.addEventListener("click", function(e) {
                            /*insert the value for the autocomplete text field:*/
                            var index = this.getElementsByTagName("input")[0].value;
                            selectCus(parseInt(index));
                            closeAllLists();
                        });
                        a.appendChild(b);
                    }
                }
            }
        });
    });
    /*execute a function presses a key on the keyboard:*/
    inp.addEventListener("keydown", function(e) {
        var x = document.getElementById(this.id + "autocomplete-list");
        if (x) x = x.getElementsByTagName("div");
        if (e.keyCode == 40) {
            /*If the arrow DOWN key is pressed,
             increase the currentFocus variable:*/
            currentFocus++;
            /*and and make the current item more visible:*/
            addActive(x);
        } else if (e.keyCode == 38) { //up
            /*If the arrow UP key is pressed,
             decrease the currentFocus variable:*/
            currentFocus--;
            /*and and make the current item more visible:*/
            addActive(x);
        } else if (e.keyCode == 13) {
            /*If the ENTER key is pressed, prevent the form from being submitted,*/
            e.preventDefault();
            if (currentFocus > -1) {
                /*and simulate a click on the "active" item:*/
                if (x) x[currentFocus].click();
            }
        }
    });
    function addActive(x) {
        /*a function to classify an item as "active":*/
        if (!x) return false;
        /*start by removing the "active" class on all items:*/
        removeActive(x);
        if (currentFocus >= x.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = (x.length - 1);
        /*add class "autocomplete-active":*/
        x[currentFocus].classList.add("autocomplete-active");
    }
    function removeActive(x) {
        /*a function to remove the "active" class from all autocomplete items:*/
        for (var i = 0; i < x.length; i++) {
            x[i].classList.remove("autocomplete-active");
        }
    }
    function closeAllLists(elmnt) {
        /*close all autocomplete lists in the document,
         except the one passed as an argument:*/
        var x = document.getElementsByClassName("autocomplete-items");
        for (var i = 0; i < x.length; i++) {
            if (elmnt != x[i] && elmnt != inp) {
                x[i].parentNode.removeChild(x[i]);
            }
        }
    }
    /*execute a function when someone clicks in the document:*/
    document.addEventListener("click", function (e) {
        closeAllLists(e.target);
    });
}
function cancelSession() {
    $('#sessionForm').find('input[name="action"]').val('cancel');
    $('#sessionForm').submit();
}
function attendSession() {
    $('#sessionForm').find('input[name="action"]').val('attend');
    $('#sessionForm').submit();
}
function prescribeSession() {
    $('#sessionForm').find('input[name="action"]').val('prescribe');
    $('#sessionForm').submit();
}
$(document).ready(function() {
    $('.input-group.mg-check-in').datepicker({
        format : 'dd/mm/yyyy',
        startDate: "dateToday",
        autoclose: true
    });

    $('.input-group.mg-check-in').on('hide', function(e) {
        $(e.currentTarget).removeClass('focus');
    });

    $('.input-group.mg-check-in').on('show', function(e) {
        $(e.currentTarget).addClass('focus');
    });
    $('.dateofbirth').datepicker({
        format : 'dd/mm/yyyy',
        autoclose: true
    });
    $('.doctorsession').on('click',function(){
        var cliniccode = $('#cliniccode').html();
        var doctorsessionid = $(this).data('doctorsessionid');
        $.ajax({
            url: '/clinic/data/'+cliniccode+'/'+doctorsessionid+'/doctor-session.json',
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                if (result.doctorsessionid != null) {
                    $('#sessionForm').find('input[name="doctorsessionid"]').val(result.doctorsessionid);
                    $('#sessionModalLabel').find('.slotnumber').html(result.slotnumber);
                    $('#sessionModalLabel').find('.starttime').html(result.starttime.split(" ")[1]);
                    var statusLabel = $('.sessionStatuses').find('.'+result.status).html();
                    $('#sessionStatus').attr('class','bg-'+result.status);
                    $('#sessionStatus').html(statusLabel);
                    if (result.customer != null) {
                        $('#sessionForm').find('input[name="customer.customerid"]').val(result.customer.customerid);
                        $('#cfullname').val(result.customer.fullname);
                        if (result.customer.dateofbirth != null) {
                            $('#sessionForm').find('input[name="cdateofbirth"]').val(invertFormatDate(result.customer.dateofbirth,'-','/'));
                        }
                        $('#sessionForm').find('input[name="customer.address"]').val(result.customer.address);
                        $('#sessionForm').find('input[name="customer.email"]').val(result.customer.email);
                        $('#sessionForm').find('input[name="customer.relativename"]').val(result.customer.relativename);
                        $('#sessionForm').find('input[name="customer.phone"]').val(result.customer.phone);
                        if (result.customer.cusNote != null) {
                            $('#sessionForm').find('input[name="customer.cusNote.height"]').val(result.customer.cusNote.height);
                            $('#sessionForm').find('input[name="customer.cusNote.weight"]').val(result.customer.cusNote.weight);
                        }
                    } else {
                        $('#sessionForm').find('input[name="customer.customerid"]').val(0);
                        $("#cfullname").val('')
                        $('#sessionForm').find('input[name="cdateofbirth"]').val('');
                        $('#sessionForm').find('input[name="customer.address"]').val('');
                        $('#sessionForm').find('input[name="customer.email"]').val('');
                        $('#sessionForm').find('input[name="customer.relativename"]').val('');
                        $('#sessionForm').find('input[name="customer.phone"]').val('');
                        autocomplete(document.getElementById("cfullname"));
                    }
                    $('#sessionForm').find('input[name="status"]').val(result.status);
                    if (result.status == 'BOOKABLE' || result.status == 'BOOKABLE_ON') {
                        $('#btn-book').removeClass('d-none');
                        $('#btn-cancel').addClass('d-none');
                        $('#btn-attend').addClass('d-none');
                        $('#btn-prescribe').addClass('d-none');
                    } else if (result.status == 'BOOKED') {
                        $('#btn-book').addClass('d-none');
                        $('#btn-prescribe').addClass('d-none');
                        $('#btn-cancel').removeClass('d-none');
                        $('#btn-attend').removeClass('d-none');
                    } else if (result.status == 'ATTENDING') {
                        $('#btn-book').addClass('d-none');
                        $('#btn-attend').addClass('d-none');
                        $('#btn-prescribe').removeClass('d-none');
                        $('#btn-cancel').removeClass('d-none');
                    } else {
                        $('#btn-book').addClass('d-none');
                        $('#btn-attend').addClass('d-none');
                        $('#btn-prescribe').addClass('d-none');
                        $('#btn-cancel').addClass('d-none');
                    }
                    $("#sessionModal").modal('show');
                }
            }
        })
    });
});