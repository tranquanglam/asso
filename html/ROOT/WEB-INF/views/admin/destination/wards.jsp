<%@ include file="/common/taglibs.jsp"%>
<c:url var="url" value="/admin/destination/wards.html"/>
<h1>Wards of ${city.name}</h1>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered" id="roomsTable">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Zip</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${wards}" var="ct">
                    <tr>
                        <td>
                            <span id="name_${ct.wardid}">${ct.name}</span>
                        </td>
                        <td>
                            <span id="code_${ct.wardid}">${ct.zip}</span>
                        </td>
                        <td>
                            <a class="popup-with-form" data-mfp-src="#wardForm" onclick="editWard('${ct.wardid}')">
                                <span class="fa fa-edit"></span></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <a class="btn btn-primary" onclick="addNew()">Add new Ward</a>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Ward form</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form:form action="${url}" method="post" commandName="item" id="wardForm" cssClass="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-8">
                            <form:input path="name" cssClass="form-control" id="wardName"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Code</label>
                        <div class="col-sm-8">
                            <form:input path="zip" cssClass="form-control" id="wardCode"/>
                        </div>
                    </div>
                    <form:hidden path="wardid" id="wardid"/>
                    <input type="hidden" name="city.cityid" value="${city.cityid}">
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <a onclick="submitForm();" class="btn btn-primary">&nbsp;Save Ward</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    function submitForm(){
        $("#wardForm").submit();
    }
    function addNew() {
        $("#wardid").val('');
        $("#wardName").val('');
        $("#wardCode").val('');
        $('#myModal').modal('show');
    }
    function editWard(id) {
        $("#wardid").val(id);
        var name = $("#name_"+id).html();
        $("#wardName").val(name);
        var code =  $("#code_"+id).html();
        $("#wardCode").val(code);
        $('#myModal').modal('show');
    }
</script>

