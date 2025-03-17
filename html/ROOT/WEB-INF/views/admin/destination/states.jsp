<%@ include file="/common/taglibs.jsp"%>
<c:url var="url" value="/admin/destination/states.html"/>
<h1>States of country ${country.name}</h1>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered" id="roomsTable">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Code</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${states}" var="ct">
                    <tr>
                        <td>
                            <span id="name_${ct.stateid}">${ct.name}</span>
                        </td>
                        <td>
                            <span id="code_${ct.stateid}">${ct.code}</span>
                        </td>
                        <td>
                            <a class="popup-with-form" data-mfp-src="#stateForm" onclick="editState('${ct.stateid}')">
                                <span class="fa fa-edit"></span></a>
                            |
                            <a href="/admin/destination/cities.html?countryID=${country.countryid}&statecode=${ct.code}">Cities</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <a class="btn btn-primary" onclick="addNew()">Add new State</a> | <a class="btn btn-secondary" onclick="syncState()">Sync one State</a>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">State form</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form:form action="${url}" method="post" commandName="item" id="stateForm" cssClass="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-8">
                            <form:input path="name" cssClass="form-control" id="stateName"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Code</label>
                        <div class="col-sm-8">
                            <form:input path="code" cssClass="form-control" id="stateCode"/>
                        </div>
                    </div>
                    <form:hidden path="stateid" id="stateid"/>
                    <input type="hidden" name="country.countryid" value="${country.countryid}">
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <a onclick="submitForm();" class="btn btn-primary">&nbsp;Save State</a>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="syncStateModal" tabindex="-1" role="dialog" aria-labelledby="syncStateLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="syncStateLabel">Sync State Data</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="syncStateForm" action="/admin/destination/sync-state-data.html" method="post" class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Site URL</label>
                        <div class="col-sm-8">
                            <input name="siteurl" class="form-control" value="http://admin.initwebs.com"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Country Code</label>
                        <div class="col-sm-8">
                            <input name="countrycode" class="form-control" value="${country.code}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">State Code</label>
                        <div class="col-sm-8">
                            <input name="statecode" class="form-control" value=""/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <a onclick="submitSyncStateForm();" class="btn btn-primary">&nbsp;Sync State</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    function submitForm(){
        $("#stateForm").submit();
    }
    function addNew() {
        $("#stateid").val('');
        $("#stateName").val('');
        $("#stateCode").val('');
        $('#myModal').modal('show');
    }
    function editState(id) {
        $("#stateid").val(id);
        var name = $("#name_"+id).html();
        $("#stateName").val(name);
        var code =  $("#code_"+id).html();
        $("#stateCode").val(code);
        $('#myModal').modal('show');
    }
    function syncState() {
        $('#syncStateModal').modal('show');
    }
    function submitSyncStateForm(){
        $("#syncStateForm").submit();
    }
</script>

