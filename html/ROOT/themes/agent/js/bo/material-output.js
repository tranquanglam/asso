function getBranchNameById(id) {
    return $('.select-branchid option[value="'+id+'"]').html();
}

var materialoutput_table;
$(document).ready(function () {
    $('.datepicker').flatpickr({
        enableTime: false,
        dateFormat: "d/m/Y"
    });
    if ($('#materialoutput_table').length) {
        materialoutput_table = $('#materialoutput_table').DataTable({
            pageLength: 25,
            paging: true,
            processing: true,
            serverSide: true,
            bLengthChange: false,
            bFilter: false,
            bInfo: false,
            bSort: false,
            language: {
                url: '/themes/agent/js/datatables.vi.json',
            },
            ajax: {
                url: '/api/v0/supplier/material/data-output.json',
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: function (d) {
                    return JSON.stringify(d);
                }
            },
            columns: [
                {data: 'materialoutputid'},
                {data: 'materialoutputid'},
                {data: 'materialoutputid'},
                {data: 'materialoutputid'},
                {data: 'materialoutputid'},
                {data: 'materialoutputid'},
                {data: 'quantity'},
                {data: 'outputtime'},
                {data: 'ordernumber'}
            ],
            columnDefs: [
                {
                    "render": function ( data, type, row ) {
                        return getBranchNameById(row.materialinput.branchid);
                    },
                    "targets": 0
                },
                {
                    "render": function ( data, type, row ) {
                        if (row.materialinput != null) {
                            return row.materialinput.material.name;
                        } else {
                            return '';
                        }

                    },
                    "targets": 1
                },
                {
                    "render": function ( data, type, row ) {
                        if (row.materialinput.manufacturer != null) {
                            return row.materialinput.manufacturer.name;
                        } else {
                            return '';
                        }
                    },
                    "targets": 2
                },
                {
                    "render": function ( data, type, row ) {
                        if (row.materialinput != null) {
                            return row.materialinput.slotno;
                        } else {
                            return '';
                        }

                    },
                    "targets": 3
                },
                {
                    "render": function ( data, type, row ) {
                        if (row.materialinput != null) {
                            return row.materialinput.mfgdate;
                        } else {
                            return '';
                        }

                    },
                    "targets": 4
                },{
                    "render": function ( data, type, row ) {
                        if (row.materialinput != null) {
                            return row.materialinput.expdate;
                        } else {
                            return '';
                        }

                    },
                    "targets": 5
                }
            ],
            'sDom': 'lTfr<"clearfix">tip',
            'oTableTools': {
                'aButtons': []
            }
        });
    }

    if ($('#selectMaterialid').length) {
        $("#selectMaterialid").select2({
            dropdownParent: $('#formMaterialInputModal'),
            theme: "bootstrap-5",
            allowClear: true,
            placeholder: "Materials",
            ajax: {
                url: '/api/v0/supplier/material/select.json',
                dataType: 'json',
                quietMillis: 50,
                data: function (params) {
                    var d = {
                        searchTerm: params.term,
                        page: params.page ? params.page : 1,
                        maxPageItems: 10
                    };
                    return d;
                },
                processResults: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.code + " - " + item.name,
                                id: item.materialid
                            }
                        })
                    };
                },
                dropdownCssClass: "bigdrop",
                containerCssClass: "form-select",
                containerCss: "form-select",
            }
        });

    }

});
