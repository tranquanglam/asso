var productArray = [],maxN = 3, cusArray = [];
function selectCus(cus) {
    $('#customerOrderForm').find('input[name="customerid"]').val(cus.customerid);
    $("#customerOrderForm").find('input[name="fullname"]').val(cus.fullname);
    $("#customerOrderForm").find('input[name="email"]').val(cus.email);
    $("#customerOrderForm").find('input[name="phone"]').val(cus.phone);
    if (cus.city != null) {
        $("#customerOrderForm").find('select[name="city"]').val(cus.city);
    }
    if (cus.zip != null) {
        $("#customerOrderForm").find('select[name="zip"]').val(cus.zip);
    }
    $("#customerOrderForm").find('input[name="address"]').val(cus.address);
}
function autocompleteCus() {
    var currentFocus;
    var inp = document.getElementById('cfullname');
    inp.addEventListener("input", function (e) {
        var a, b, i, val = this.value;
        closeAllLists();
        if (!val) {
            return false;
        }
        currentFocus = -1;
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        this.parentNode.appendChild(a);
        $.ajax({
            url: '/bo/data/customers.json?max=10&q=' + encodeURIComponent(val),
            type: 'GET',
            contentType: "application/json",
            success: function (result) {
                cusArray = result;
                for (i = 0; i < cusArray.length; i++) {
                    if (cusArray[i].fullname.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                        b = document.createElement("DIV");
                        b.innerHTML = "<strong>" + cusArray[i].fullname.substr(0, val.length) + "</strong>";
                        b.innerHTML += cusArray[i].fullname.substr(val.length) + " - " + cusArray[i].phone;
                        b.innerHTML += "<input type='hidden' value='" + i + "'>";
                        b.addEventListener("click", function (e) {
                            var index = this.getElementsByTagName("input")[0].value;
                            selectCus(cusArray[parseInt(index)]);
                            closeAllLists();
                        });
                        a.appendChild(b);
                    }
                }
            }
        });
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
function submitCustomerOrderForm(status) {
    var requestOrder = {};
    requestOrder.status = status;
    var customer = {};
    customer.email = $("#customerOrderForm").find('input[name="email"]').val();
    if (customer.email == '') {
        $("#customerOrderForm").find('input[name="email"]').focus();
        return;
    }
    customer.phone = $("#customerOrderForm").find('input[name="phone"]').val();
    if (customer.phone == '') {
        $("#customerOrderForm").find('input[name="phone"]').focus();
        return;
    }
    customer.fullname = $("#customerOrderForm").find('input[name="fullname"]').val();
    if (customer.fullname == '') {
        $("#customerOrderForm").find('input[name="fullname"]').focus();
        return;
    }
    customer.city = $("#customerOrderForm").find('select[name="city"]').val();
    customer.zip = $("#customerOrderForm").find('select[name="zip"]').val();
    customer.address = $("#customerOrderForm").find('input[name="address"]').val();
    requestOrder.customer = customer;
    requestOrder.specialrequest = $("#customerOrderForm").find('input[name="specialrequest"]').val();
    var products = [];
    $('#item-list').find('.item-container').each(function(){
        var mOrderItem = {};
        mOrderItem.productpriceid = $(this).find('select[name="productpriceid"]').val();
        mOrderItem.productid = $(this).find('input[name="productid"]').val();
        mOrderItem.quantity = $(this).find('input[name="quantity"]').val();
        products.push(mOrderItem);
    });
    requestOrder.products = products;
    requestOrder.shippingdate = $("#customerOrderForm").find('input[name="shippingdate"]').val();
    requestOrder.shippingfee = $("#customerOrderForm").find('input[name="shippingfee"]').val();
    requestOrder.discount = $("#customerOrderForm").find('input[name="discount"]').val();
    var ACCESSS_TOKEN = $('#access_token').html();
    var customerorderid = $("#customerOrderForm").find('input[name="customerorderid"]').val();
    $.ajax({
        url: '/api/v0/supplier/'+customerorderid+'/save-order.json',
        type: 'POST',
        data: JSON.stringify(requestOrder),
        dataType: "json",
        contentType: "application/json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
        },
        success: function(result){
            if (result.errorMessage == null) {
                window.location = '/my/booking.html';
            } else {
                alert(result.errorMessage);
            }
        },
        error: function (e){
            console.log('...................', e)
        }
    });
}
function updateProductprice(inputid) {
    var pid = $('#'+inputid+'container').find('input[name="productid"]').val();
    if (pid != '') {
        var productpriceid = $('#'+inputid+'container').find('select[name="productpriceid"]').val();
        for (var i=0;i<productArray.length;i++) {
            if (productArray[i].productid == pid) {
                if (productArray[i].productprices != null) {
                    var productprices =  productArray[i].productprices;
                    for (var j=0;j<productprices.length;j++) {
                        if (productprices[j].productpriceid == productpriceid) {
                            var quantity = $('#'+inputid+'container').find('input[name="quantity"]').val();
                            var amount = productprices[j].price * quantity;
                            $('#'+inputid+'container').find('input[name="amount"]').val(Math.round(amount));
                            break;
                        }
                    }
                } else {
                    loadProductprices( productArray[i],productpriceid,inputid)
                }
                break;
            }
        }
        updateTotalAmount();
    }
}
function updateTotalAmount() {
    var finalamount = 0;
    for (var n=1;n<=maxN;n++) {
        if ($('#product'+n+'container').length) {
            var amount = $('#product'+n+'container').find('input[name="amount"]').val();
            if (amount != '') {
                finalamount += parseFloat(amount);
            }
        }
    }
    var shippingfee = $("#customerOrderForm").find('input[name="shippingfee"]').val();
    if (shippingfee != '') {
        finalamount = finalamount + parseFloat(shippingfee);
    }
    var discount = $("#customerOrderForm").find('input[name="discount"]').val();
    if (discount != '') {
        finalamount = finalamount - parseFloat(discount);
    }
    $("#customerOrderForm").find('input[name="finalamount"]').val(finalamount);
}
function updateAll() {
    for (var n=1;n<=maxN;n++) {
        updateProductprice('product'+n);
    }
}
function loadProductprices(med,productpriceid,inputid) {
    $.ajax({
        url: '/bo/data/'+med.productid+'/productprices.json',
        type: 'GET',
        contentType: "application/json",
        success: function(productprices) {
            if (productprices.length > 0) {
                med.productprices = productprices;
                for (var j=0;j<productprices.length;j++) {
                    if (productprices[j].productpriceid == productpriceid) {
                        var quantity = $('#'+inputid+'container').find('input[name="quantity"]').val();
                        var amount = productprices[j].price * quantity;
                        $('#'+inputid+'container').find('input[name="amount"]').val(Math.round(amount));
                        break;
                    }
                }
            }
        }
    });
}
function selectMed(i,inputid) {
    var med =  productArray[i];
    $('#'+inputid).val(med.name);
    $('#'+inputid+'container').find('input[name="productid"]').val(med.productid);
    $.ajax({
        url: '/bo/data/'+med.productid+'/productprices.json',
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            var options = '';
            if (result.length > 0) {
                med.productprices = result;
                options += '<option value="'+result[0].productpriceid+'" selected>'+result[0].description+': ' + result[0].price +'</option>';
                if (result.length > 1) {
                    for (var j=0;j<result.length;j++) {
                        options += '<option value="'+result[j].productpriceid+'">'+result[j].description+': ' + result[j].price +'</option>';
                    }
                }
                $('#'+inputid+'container').find('select[name="productpriceid"]')
                    .find('option')
                    .remove()
                    .end()
                    .append(options);
                updateProductprice(inputid);
            }
        }
    });
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
        for (i = 0; i < productArray.length; i++) {
            if (productArray[i].name.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                b = document.createElement("DIV");
                b.innerHTML = "<strong>" + productArray[i].name.substr(0, val.length) + "</strong>";
                b.innerHTML += productArray[i].name.substr(val.length);
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
function removeItem(n) {
    if ($('#product'+n+'container').length) {
        $('#product'+n+'container').remove();
        updateTotalAmount();
    }
}
function addItem() {
    maxN =  maxN + 1;
    var itemEle = $('#item-template').html();
    itemEle = itemEle.replace(/\{n\}/g,maxN);
    $('#item-list').append(itemEle);
    autocomplete('product'+maxN);
}
$(document).ready(function() {
    maxN = parseInt($('#customerOrderForm').find('input[name="maxN"]').val());
    $.ajax({
        url: '/bo/data/products.json?max=500',
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            productArray = result;
            for (var n=1;n<=maxN;n++) {
                autocomplete('product'+n);
            }
        }
    });
    autocompleteCus();
    $('.cus-state').on('change',function(){
        var statecode = $(this).val();
        var countryid = $('#countryid').html();
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
            }
        });
    });
    function changeCity() {
        $('.cus-zip').find('option').not(':first').remove();
        var citycode = $('.cus-city').val();
        var countryid = $('#countryid').html();
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
    $('.shipping-datetime').flatpickr({
        enableTime: true,
        dateFormat: "d/m/Y H:i"
    });
});
function deleteBooking() {
    bootbox.confirm('Are you sure you want to delete this item ?', function(r){
        if(r){
            var ACCESSS_TOKEN = $('#access_token').html();
            var customerorderid = $("#customerOrderForm").find('input[name="customerorderid"]').val();
            $.ajax({
                url: '/api/v0/supplier/'+customerorderid+'/delete-booking.json',
                type: 'POST',
                contentType: "application/json",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("Authorization", "Bearer " + ACCESSS_TOKEN);
                },
                success: function(result){
                    window.location = '/my/booking.html';
                },
                error: function (e){
                    console.log('...................', e)
                }
            });
        }
    });
}