<%@ include file="/common/taglibs.jsp"%>

<div class="row">
    <script>
        function postData(formData){

            //console.log(formData);
            var postUrl = "/admin/currencyrates.json";
            if(formData.currencyrateid){
                postUrl = "/admin/currencyrates/" + formData.currencyrateid + ".json";
            }

            //console.log(postUrl);
            var jsonString = JSON.stringify(formData);

            $.ajax({
                url: postUrl,
                type: 'POST',
                data: jsonString,
                contentType: 'application/json',
                cache: false,    //This will force requested pages not to be cached by the browser
                processData:false, //To avoid making query String instead of JSON
                success: function(data) {
                    $('#editFormModal').modal('hide');
                    $('#saveButton').button('reset');
                    alert("Update successfully.");

                    $('#model_table').bootstrapTable('refresh');

                },
                error:function(data,status,er) {
                    $('#editFormModal').modal('hide');
                    $('#saveButton').button('reset')
                    alert("Error when update "+data+": "+er);
                }
            });
        }

        function operateFormatter(value, row, index) {
            return [
                '<a class="edit ml10" href="javascript:void(0)" title="Edit">',
                '<i class="glyphicon glyphicon-edit"></i>',
            ].join('');
        }

        window.operateEvents = {
            'click .like': function (e, value, row, index) {
                alert('You click like icon, row: ' + JSON.stringify(row));
                console.log(value, row, index);
            },
            'click .edit': function (e, value, row, index) {
                $('#editForm').populate(row);
                $('#editFormModal').modal('show');
                console.log(value, obj, index);
            },
            'click .remove': function (e, value, row, index) {
                alert('You click remove icon, row: ' + JSON.stringify(row));
                console.log(value, row, index);
            }
        };
    </script>

    <!-- Modal -->
    <div class="modal fade" id="exrateTableModal" tabindex="-1" role="dialog" aria-labelledby="exrateTableModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exrateTableModalLabel">VCB Exrate</h4>
                </div>
                <div class="modal-body">
                    <div id="exrateTableContainer">

                    </div>
                    <div class="hide">
                        <div class="exrate_table_template">
                            <table class="exrate_table">
                                <thead>
                                <th data-field="currencyCode">currencyCode</th>
                                <th data-field="currencyName">currencyName</th>
                                <th data-field="buy">buy</th>
                                <th data-field="transfer">transfer</th>
                                <th data-field="sell">sell</th>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

                </div>

            </div>
        </div>
    </div><!--end Modal -->
    <button type="button" class="btn btn-primary" id="getExrateButton">Vietcombank Exchange Rates</button>

    <table data-toggle="table" id="model_table" data-url="/admin/currencyrates.json" data-search="true">
        <thead>
        <tr>
            <th data-field="state" data-checkbox="true"></th>

            <th data-field="fromcurrencycode" data-sortable="true">fromcurrencycode</th>
            <th data-field="tocurrencycode" data-sortable="true">tocurrencycode</th>
            <th data-field="averagerate" data-sortable="true">averagerate</th>
            <th data-field="operate" data-formatter="operateFormatter" data-events="operateEvents">Item Operate</th>
        </tr>
        </thead>
    </table>
    <br>
    <button type="button" class="btn btn-success" id="addButton">Add</button>
    <!-- Modal -->
    <div class="modal fade" id="editFormModal" tabindex="-1" role="dialog" aria-labelledby="editFormModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="editFormModalLabel">Add/Edit Currency Rate</h4>
                </div>
                <div class="modal-body">
                    <form id="editForm">
                        <input type="hidden" name="currencyrateid">
                        <div class="form-group">
                            <label for="fromcurrencycode" class="control-label">fromcurrencycode:</label>
                            <select class="form-control" id="fromcurrencycode" name="fromcurrencycode">
                                <c:forEach var="currency" items="${currencies}">
                                    <option value="${currency.currencycode}">${currency.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="tocurrencycode" class="control-label">tocurrencycode:</label>
                            <select class="form-control" id="tocurrencycode" name="tocurrencycode">
                                <c:forEach var="currency" items="${currencies}">
                                    <option value="${currency.currencycode}">${currency.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="averagerate" class="control-label">averagerate:</label>
                            <input type="text" class="form-control" id="averagerate" name="averagerate">
                        </div>


                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="saveButton">Save changes</button>
                </div>
            </div>
        </div>
    </div><!--end Modal -->
    <script>
        $('#saveButton').on('click', function () {
            var $btn = $(this).button('loading')
            var formData = $("#editForm").serializeFormJSON();
            postData(formData);
            //console.log(formData);



        });
        $('#addButton').on('click', function () {
            $('#editForm')[0].reset(0);
            $('#editFormModal').modal('show');
        });

        $('#getExrateButton').on('click', function () {
            $('#exrateTable').bootstrapTable({
                data: []
            })
            $('#exrateTableModal').modal('show');
        });

        $("#exrateTableModal").on("show.bs.modal", function(e) {

            $.get("/admin/currencyrates/vcbexrates.json", function( result ) {
                $( "#exrateTableContainer" ).html( 'Loading data...' );
                $('#exrateTableModalLabel').html('Loading VCB Exchange Rates');

                var $newPanel = $(".exrate_table_template").clone();
                $newPanel.find(".exrate_table").bootstrapTable({
                    classes: "table table-no-bordered",
                    pagination: true,
                    pageSize: 5,
                    pageList: [5, 10],
                    search: true,
                    cache: false,
                    striped: true,
                    columns: [{
                        field: 'currencyCode',
                        title: 'Code',
                        class: "col-xs-1"
                    }, {
                        field: 'currencyName',
                        title: 'Name'
                    }, {
                        field: 'buy',
                        title: 'Buy',
                        class: "col-xs-1",
                        align: "right"
                    }, {
                        field: 'transfer',
                        title: 'Transfer',
                        class: "col-xs-1",
                        align: "right"
                    }, {
                        field: 'sell',
                        title: 'Sell',
                        class: "col-xs-1",
                        align: "right"
                    }],
                    data: result.exrates
                });

                $('#exrateTableContainer').html($newPanel.fadeIn());
                $('#exrateTableModalLabel').html('VCB Exchange Rates: ' + result.exrateDate);
                //$('#exrateTable').bootstrapTable('refresh');
            });


            //$(this).find(".modal-body").load(link.attr("href"));
        });


    </script>
</div>

