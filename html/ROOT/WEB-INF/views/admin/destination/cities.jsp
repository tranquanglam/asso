<%@ include file="/common/taglibs.jsp"%>
<c:url var="url" value="/admin/destination/cities.html"/>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
        <table class="table table-bordered" id="roomsTable">
            <thead>
            <tr>
                <th>Name</th>
                <th>Code</th>
                <th>State</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${cities}" var="ct">
                <tr>
                    <td>
                        <span id="name_${ct.cityid}">${ct.name}</span>
                    </td>
                    <td>
                        <span id="code_${ct.cityid}">${ct.code}</span>
                    </td>
                    <td>
                        <span id="statecode_${ct.cityid}">${ct.statecode}</span>
                    </td>
                    <td>
                        <a class="popup-with-form" data-mfp-src="#cityForm" onclick="editCity('${ct.cityid}')">
                            <span class="fa fa-edit"></span></a>
                        |
                        <a href="/admin/destination/wards.html?cityid=${ct.cityid}">Wards</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <a href="#" class="btn btn-primary" onclick="addNew()">Add new City</a>

        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">City form</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form:form action="${url}" method="post" commandName="item" id="cityForm" cssClass="form-horizontal" role="form" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-8">
                            <form:input path="name" cssClass="form-control" id="cityName"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Code</label>
                        <div class="col-sm-8">
                            <form:input path="code" cssClass="form-control" id="cityCode"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">State Code</label>
                        <div class="col-sm-8">
                            <form:select path="statecode" cssClass="form-control" id="statecode">
                                <c:forEach var="state" items="${states}">
                                    <form:option value="${state.code}">${state.name}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Image for Destination</label>
                        <div class="col-sm-8">
                            <input type='file' name='imageFile' size='40' />
                        </div>
                    </div>
                    <form:hidden path="cityid" id="cityid"/>
                    <form:hidden path="countryid" id="countryid"/>
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <a onclick="submitForm();" class="btn btn-primary">&nbsp;Save City</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function submitForm(){
        $("#cityForm").submit();
    }
    function addNew() {
        $("#cityid").val('');
        $("#cityName").val('');
        $("#cityCode").val('');
        $('#myModal').modal('show');
    }
    function editCity(id) {
        $("#cityid").val(id);
        var name = $("#name_"+id).html();
        $("#cityName").val(name);
        var code =  $("#code_"+id).html();
        $("#cityCode").val(code);
        var statecode =  $("#statecode_"+id).html();
        $("#statecode").val(statecode);
        $('#myModal').modal('show');
    }
</script>

