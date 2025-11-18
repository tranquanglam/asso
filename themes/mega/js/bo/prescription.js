var medArray = [],maxN = 5, cusArray = [];
function submitPrescriptionForm() {
    $('#prescriptionForm').validate({
        rules: {
            'diagnose': {
                minlength: 2,
                maxlength: 255,
                required: true
            },
            'amount': {
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
    $("#prescriptionForm").submit();
}
function updateMedquantity(inputid) {
    var pid = $('#'+inputid+'container').find('input[name="productid"]').val();
    if (pid != '') {
        var doseid = $('#'+inputid+'container').find('select[name="productdoseid"]').val();
        for (var i=0;i<medArray.length;i++) {
            if (medArray[i].productid == pid) {
                var productdoses =  medArray[i].productdoses;
                for (var j=0;j<productdoses.length;j++) {
                    if (productdoses[j].productdoseid == doseid) {
                        var medquantity = productdoses[j].dose * productdoses[j].times;
                        medquantity = medquantity * $('#prescriptionForm').find('select[name="days"]').val();
                        $('#'+inputid+'container').find('input[name="medquantity"]').val(Math.round(medquantity));
                        break;
                    }
                }
                break;
            }
        }
    }
}
function updateAllMedquantity() {
    for (var n=1;n<=maxN;n++) {
        updateMedquantity('product'+n);
    }
    updateFollowup();
}
function selectMed(i,inputid) {
    var med =  medArray[i];
    $('#'+inputid).val(med.name);
    $('#'+inputid+'container').find('input[name="productid"]').val(med.productid);
    $.ajax({
        url: '/clinic/data/'+med.productid+'/productdoses.json',
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            var options = '';
            if (result.length > 0) {
                med.productdoses = result;
                options += '<option value="'+result[0].productdoseid+'" selected>'+result[0].description+'</option>';
                if (result.length > 1) {
                    for (var j=0;j<result.length;j++) {
                        options += '<option value="'+result[j].productdoseid+'">'+result[j].description+'</option>';
                    }
                }
                $('#'+inputid+'container').find('select[name="productdoseid"]')
                    .find('option')
                    .remove()
                    .end()
                    .append(options);
                updateMedquantity(inputid);
            }
        }
    });
}
function updateFollowup() {
    var days = $('#prescriptionForm').find('select[name="days"]').val();
    var today = new Date();
    var followDate = new Date(today.getTime() + days*1000*24*60*60);
    var followup = followDate.getDate() +'/' + (followDate.getMonth() + 1) + '/' + followDate.getFullYear();
    $('#prescriptionForm').find('input[name="followup"]').val(followup);
}
function autocomplete(inputid) {
    var currentFocus;
    var inp = document.getElementById(inputid);
    inp.addEventListener("input", function(e) {
        var a, b, i, val = this.value;
        closeAllLists();
        if (!val) { return false;}
        currentFocus = -1;
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        this.parentNode.appendChild(a);
        for (i = 0; i < medArray.length; i++) {
            if (medArray[i].name.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                b = document.createElement("DIV");
                b.innerHTML = "<strong>" + medArray[i].name.substr(0, val.length) + "</strong>";
                b.innerHTML += medArray[i].name.substr(val.length);
                b.innerHTML += "<input type='hidden' value='" + i + "'>";
                b.addEventListener("click", function(e) {
                    var index = this.getElementsByTagName("input")[0].value;
                    selectMed(parseInt(index),inputid);
                    closeAllLists();
                });
                a.appendChild(b);
            }
        }
    });
    inp.addEventListener("keydown", function(e) {
        var x = document.getElementById(this.id + "autocomplete-list");
        if (x) x = x.getElementsByTagName("div");
        if (e.keyCode == 40) {
            currentFocus++;
            addActive(x);
        } else if (e.keyCode == 38) { //up
            currentFocus--;
            addActive(x);
        } else if (e.keyCode == 13) {
            e.preventDefault();
            if (currentFocus > -1) {
                if (x) x[currentFocus].click();
            }
        }
    });
    function addActive(x) {
        if (!x) return false;
        removeActive(x);
        if (currentFocus >= x.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = (x.length - 1);
        x[currentFocus].classList.add("autocomplete-active");
    }
    function removeActive(x) {
        for (var i = 0; i < x.length; i++) {
            x[i].classList.remove("autocomplete-active");
        }
    }
    function closeAllLists(elmnt) {
        var x = document.getElementsByClassName("autocomplete-items");
        for (var i = 0; i < x.length; i++) {
            if (elmnt != x[i] && elmnt != inp) {
                x[i].parentNode.removeChild(x[i]);
            }
        }
    }
    document.addEventListener("click", function (e) {
        closeAllLists(e.target);
    });
}
$(document).ready(function() {
    maxN = parseInt($('#prescriptionForm').find('input[name="maxN"]').val());
    $.ajax({
        url: '/clinic/data/products.json?max=500',
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            medArray = result;
            for (var n=1;n<=maxN;n++) {
                autocomplete('product'+n);
            }
        }
    });
    $('.prev-prescription').on('click',function(){
       $('#prevPrescriptionModal').modal('show');
    });
});