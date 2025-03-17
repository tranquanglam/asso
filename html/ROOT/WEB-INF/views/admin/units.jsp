<%@ include file="/common/taglibs.jsp"%>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped table-dark">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Namevi</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cur" items="${units}">
                    <tr>
                        <td>${cur.unitid}</td>
                        <td>${cur.name}</td>
                        <td>${cur.namevi}</td>
                        <td><a href="#" data-unitid="${cur.unitid}" data-name="${cur.name}" data-namevi="${cur.namevi}" onclick="editUnit(this)">Edit</a></td>
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
                <h4 class="modal-title" id="myModalLabel">Unit form</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="unitForm" method="post" action="/admin/units/form.html">
                    <input type="hidden" name="unitid" value="0">
                    <div class="form-group">
                        <label>Name:</label>
                        <input type="text" class="form-control" name="name">
                    </div>
                    <div class="form-group">
                        <label>Name VI:</label>
                        <input type="text" class="form-control" name="namevi">
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
        $("#unitForm").submit();
    });
    $('#addButton').on('click', function () {
        $('#unitForm')[0].reset(0);
        //reset hidden fields
        $('#unitForm').find('input[name="unitid"]').val('0');
        $('#myModal').modal('show');
    });
    function editUnit(ele) {
        var id = $(ele).data('unitid');
        var name = $(ele).data('name');
        var namevi = $(ele).data('namevi');
        $('#unitForm').find('input[name="unitid"]').val(id);
        $('#unitForm').find('input[name="name"]').val(name);
        $('#unitForm').find('input[name="namevi"]').val(namevi);
        $('#myModal').modal('show');
    }
</script>