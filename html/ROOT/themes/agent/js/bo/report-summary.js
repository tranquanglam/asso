var chartDaily = null,chartProduct = null;
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
function loadDailyData(status, callback) {
    var dataurl = '/bo/report/by-date-range.json?status='+status;
    var statecode = $('.cus-state').length > 0 ? $('.cus-state').val() : '';
    if (statecode != '') {
        dataurl += '&statecode='+encodeURIComponent(statecode);
    }
    var citycode = $('.cus-city').val();
    if (citycode != '') {
        dataurl += '&citycode='+encodeURIComponent(citycode);
    }
    var zip = $('.cus-zip').val();
    if (zip != '') {
        dataurl += '&zip='+encodeURIComponent(zip);
    }
    var fromDate = $('.from-date').val();
    if (fromDate != '') {
        dataurl += '&fromDate='+encodeURIComponent(fromDate);
    }
    var toDate = $('.to-date').val();
    if (toDate != '') {
        dataurl += '&toDate='+encodeURIComponent(toDate);
    }
    $.ajax({
        url: dataurl,
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            callback(result);
        }
    });
}
function loadProductData(status, callback) {
    var dataurl = '/bo/report/by-product.json?status='+status;
    var statecode = $('.cus-state').length > 0 ? $('.cus-state').val() : '';
    if (statecode != '') {
        dataurl += '&statecode='+encodeURIComponent(statecode);
    }
    var citycode = $('.cus-city').val();
    if (citycode != '') {
        dataurl += '&citycode='+encodeURIComponent(citycode);
    }
    var zip = $('.cus-zip').val();
    if (zip != '') {
        dataurl += '&zip='+encodeURIComponent(zip);
    }
    var fromDate = $('.from-date').val();
    if (fromDate != '') {
        dataurl += '&fromDate='+encodeURIComponent(fromDate);
    }
    var toDate = $('.to-date').val();
    if (toDate != '') {
        dataurl += '&toDate='+encodeURIComponent(toDate);
    }
    $.ajax({
        url: dataurl,
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            callback(result);
        }
    });
}
function addEleToArray(ele,array) {
    if (array.length > 0) {
        var index = 0;
        var afterArray = [];
        for (var j = 0; j<array.length;j++) {
            if (array[j].id == ele.id) {
                return array;
            } else if (array[j].id < ele.id) {
                index++;
            } else {
                afterArray.push(array[j]);
            }
        }
        array[index] = ele;
        if (afterArray.length > 0) {
            for (var k=0;k<afterArray.length;k++) {
                index++;
                array[index] = afterArray[k];
            }
        }
    } else {
        array[0] = ele;
    }
    return array;
}
function addArrayToArray(arrsrc,eleArray) {
    if (arrsrc.length > 0) {
        for (var i=0;i<arrsrc.length;i++) {
            eleArray = addEleToArray(arrsrc[i],eleArray);
        }
    }
    return eleArray;
}
function getArrayValue(array,id) {
    if (array.length > 0) {
        for (var i=0;i<array.length;i++) {
            if (array[i].id == id) {
                return array[i].y;
            }
        }
    }
    return 0;
}
function drawChartDaily() {
    var ajaxLoadCount = 0;
    var retriedCount = 0;
    var labelArray = [];
    var dataDONE = [];
    var dataPENDING = [];
    var dataCANCELLED = [];
    loadDailyData('DONE',function(result){
        if (result.length > 0) {
            for (var i=0;i<result.length;i++) {
                var ele = {};
                ele.id = result[i].datelong;
                ele.x = result[i].shortdate;
                ele.y = result[i].totalamount;
                dataDONE.push(ele);
            }
        }
        ajaxLoadCount++;
    });
    loadDailyData('CANCELLED',function(result){
        if (result.length > 0) {
            for (var i=0;i<result.length;i++) {
                var ele = {};
                ele.id = result[i].datelong;
                ele.x = result[i].shortdate;
                ele.y = result[i].totalamount;
                dataCANCELLED.push(ele);
            }
        }
        ajaxLoadCount++;
    });
    loadDailyData('PENDING',function(result){
        if (result.length > 0) {
            for (var i=0;i<result.length;i++) {
                var ele = {};
                ele.id = result[i].datelong;
                ele.x = result[i].shortdate;
                ele.y = result[i].totalamount;
                dataPENDING.push(ele);
            }
        }
        ajaxLoadCount++;
    });
    function drawChartIfReady() {
        retriedCount++;
        if(retriedCount > 10) {
            clearInterval(timerId);
        }
        if (ajaxLoadCount == 3) {
            clearInterval(timerId);
            var eleArray = [];
            eleArray = addArrayToArray(dataDONE, eleArray);
            eleArray = addArrayToArray(dataPENDING, eleArray);
            eleArray = addArrayToArray(dataCANCELLED, eleArray);
            for (var i = 0; i < eleArray.length; i++) {
                labelArray[i] = eleArray[i].x;
            }
            if (chartDaily == null) {
                var ctx = document.getElementById('daily-chart');
                chartDaily = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            label: 'DONE',
                            data: dataDONE,
                            fill: false,
                            borderColor: 'rgb(0, 0, 192)',
                            tension: 0.1
                        }, {
                            label: 'PENDING',
                            data: dataPENDING,
                            fill: false,
                            borderColor: 'rgb(75, 192, 192)',
                            tension: 0.1
                        }, {
                            label: 'CANCELLED',
                            data: dataCANCELLED,
                            fill: false,
                            borderColor: 'rgb(255, 192, 192)',
                            borderDash: [5, 5],
                            tension: 0.1
                        }]
                    }
                });
            } else {
                chartDaily.data.labels = labelArray;
                chartDaily.data.datasets[0].data = dataDONE;
                chartDaily.data.datasets[1].data = dataPENDING;
                chartDaily.data.datasets[2].data = dataCANCELLED;
                chartDaily.update();
            }
        }
    }
    var timerId = setInterval(drawChartIfReady, 1000);
}
function drawChartProuct() {
    var pajaxLoadCount = 0;
    var pretriedCount = 0;
    var pdataDONE = [];
    var pdataInputPriceDONE = [];
    var pdataPENDING = [];
    var pdataInputPricePENDING = [];
    var pdataCANCELLED = [];
    var pdataInputPriceCANCELLED = [];
    loadProductData('DONE',function(result){
        if (result.length > 0) {
            for (var i=0;i<result.length;i++) {
                var ele = {};
                ele.id = result[i].id;
                ele.x = result[i].name;
                ele.y = result[i].amount;
                pdataDONE.push(ele);

                pdataInputPriceDONE.push({
                    id: result[i].id,
                    x: result[i].name,
                    y: result[i].inputprice
                })
            }
        }
        pajaxLoadCount++;
    });
    loadProductData('CANCELLED',function(result){
        if (result.length > 0) {
            for (var i=0;i<result.length;i++) {
                var ele = {};
                ele.id = result[i].id;
                ele.x = result[i].name;
                ele.y = result[i].amount;
                pdataCANCELLED.push(ele);
                pdataInputPriceCANCELLED.push({
                    id: result[i].id,
                    x: result[i].name,
                    y: result[i].inputprice
                })
            }
        }
        pajaxLoadCount++;
    });
    loadProductData('PENDING',function(result){
        if (result.length > 0) {
            for (var i=0;i<result.length;i++) {
                var ele = {};
                ele.id = result[i].id;
                ele.x = result[i].name;
                ele.y = result[i].amount;
                pdataPENDING.push(ele);
                pdataInputPricePENDING.push({
                    id: result[i].id,
                    x: result[i].name,
                    y: result[i].inputprice
                })
            }
        }
        pajaxLoadCount++;
    });
    function drawPChartIfReady() {
        pretriedCount++;
        if(pretriedCount > 10) {
            clearInterval(ptimerId);
        }
        if (pajaxLoadCount == 3) {
            clearInterval(ptimerId);
            if (chartProduct == null) {
                var pctx = document.getElementById('product-chart');
                chartProduct = new Chart(pctx, {
                    type: 'bar',
                    data: {
                        datasets: [{
                            label: '',
                            data: pdataInputPriceDONE,
                            backgroundColor: 'rgba(0,0,192,0.5)',
                            backgroundColor: 'rgba(0,0,192,0.5)',
                            stack: 'Stack DONE',
                        },{
                            label: 'DONE',
                            data: pdataDONE,
                            borderColor: 'rgb(0, 0, 192)',
                            backgroundColor: 'rgb(0, 0, 192)',
                            stack: 'Stack DONE',
                        },{
                            label: '',
                            data: pdataInputPricePENDING,
                            borderColor: 'rgb(75, 192, 192, 0.5)',
                            backgroundColor: 'rgb(75, 192, 192, 0.5)',
                            stack: 'Stack PENDING',
                        },{
                            label: 'PENDING',
                            data: pdataPENDING,
                            borderColor: 'rgb(75, 192, 192)',
                            backgroundColor: 'rgb(75, 192, 192)',
                            stack: 'Stack PENDING',
                        },{
                            label: '',
                            data: pdataInputPriceCANCELLED,
                            borderColor: 'rgb(255, 192, 192, 0.5)',
                            backgroundColor: 'rgb(255, 192, 192, 0.5)',
                            stack: 'Stack CANCELLED',
                        },{
                            label: 'CANCELLED',
                            data: pdataCANCELLED,
                            borderColor: 'rgb(255, 192, 192)',
                            backgroundColor: 'rgb(255, 192, 192)',
                            stack: 'Stack CANCELLED',
                        }]
                    },
                    options: {
                        responsive: true,
                        interaction: {
                            intersect: true,
                        },
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: false,
                                text: 'Product Chart'
                            }
                        },
                        scales: {
                            x: {
                                stacked: false
                            },
                            y: {
                                stacked: true
                            }
                        }
                    }
                });
            } else {
                chartProduct.data.datasets[0].data = pdataDONE;
                chartProduct.data.datasets[1].data = pdataPENDING;
                chartProduct.data.datasets[2].data = pdataCANCELLED;
                chartProduct.update();
            }
        }
    }
    var ptimerId = setInterval(drawPChartIfReady, 500);
}
$(document).ready(function() {
    $('.datepicker').flatpickr({
        enableTime: false,
        dateFormat: "d/m/Y"
    });
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
    $('.show-hide-filter').on('click',function(){
        if($('.summary-report-filter.d-none').length) {
            $('#summary-report-filter').removeClass('d-none');
        } else {
            $('#summary-report-filter').addClass('d-none');
        }
    });
    $('.btn-refresh-report').on('click',function(){
        drawChartDaily();
        drawChartProuct();
    });
    drawChartDaily();
    drawChartProuct();

    $('.custom-select').select2({
        theme: "bootstrap-5",
        allowClear: false
    });
});
