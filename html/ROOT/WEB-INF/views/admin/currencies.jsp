<%@ include file="/common/taglibs.jsp"%>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped table-dark">
                <thead>
                <tr>
                    <th>Currency Code</th>
                    <th>Name</th>
                    <th>Updated date</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cur" items="${currencies}">
                    <tr>
                        <td>${cur.currencycode}</td>
                        <td>${cur.name}</td>
                        <td>${cur.updateddate}</td>
                        <td><a href="#" onclick="editCurrency('${cur.currencyid}','${cur.currencycode}','${cur.name}')">Edit</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <br/>
            <button type="button" class="btn btn-success" id="addButton">Add</button>
        </div>
    </div>
</div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">Currency form</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <form id="currencyForm" method="post" action="/admin/currencies/form.html">
                        <input type="hidden" name="currencyid" value="0">
                        <div class="form-group">
                            <label>Currency Code:</label>
                            <input type="text" class="form-control" name="currencycode">
                        </div>
                        <div class="form-group">
                            <label>Name:</label>
                            <input type="text" class="form-control" name="name">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="saveButton">Save changes</button>
                </div>
            </div>
        </div>
    </div>

<script>
    $('#saveButton').on('click', function () {
        var $btn = $(this).button('loading');
        $("#currencyForm").submit();
    });
    $('#addButton').on('click', function () {
        $('#currencyForm')[0].reset(0);
        //reset hidden fields
        $('#currencyForm').find('input[name="currencyid"]').val('0');
        $('#myModal').modal('show');
    });
    function editCurrency(id,code,name) {
        $('#currencyForm').find('input[name="currencyid"]').val(id);
        $('#currencyForm').find('input[name="currencycode"]').val(code);
        $('#currencyForm').find('input[name="name"]').val(name);
        $('#myModal').modal('show');
    }
</script>