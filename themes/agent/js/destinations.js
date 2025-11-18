$(document).ready(function() {
    var destinations_table = $('#destinations_table').DataTable( {
        pageLength: 25,
        processing: true,
        serverSide: true,
        searching: false,
        lengthChange: false,
        ajax: {
            url: '/agent/destinations.json',
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: function ( d ) {
                var filterMap = $("#destinationFilterForm").serializeFormJSON();
                d.filterMap=filterMap;
                return JSON.stringify(d);
            }
        },
        columns: [
            { data: 'name' },
            { data: 'countryName' },
            { data: 'cityName' },
            { data: 'nameurl' }
        ],
        columnDefs: [
            {
                "render": function ( data, type, row ) {
                    if (data != row.countryName) {
                        return [
                            '<a href="/agent/destinations/' + row.destinationID +'/" title="Edit">',
                            data,
                            '</a>'
                        ].join('');
                    } else {
                        return data;
                    }
                },
                "targets": 0
            }
        ],
        'sDom': 'lTfr<"clearfix">tip',
        'oTableTools': {
            'aButtons': [

            ]
        }
    } );
    function changeState() {
        $('.cus-city').find('option').not(':first').remove();
        var statecode = $('.cus-state').val();
        if (statecode != '') {
            var countryid = $('#countryid').val();
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

    $('#destinationFilter').on('click', function(){
        destinations_table.ajax.reload();
    });
});
