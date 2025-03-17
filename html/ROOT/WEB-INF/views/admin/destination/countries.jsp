<%@ include file="/common/taglibs.jsp"%>
    <script type="text/javascript">

        function submitForm(){
            $("#countryForm").submit();
        }
        function addNew() {
            $("#countryid").val('');
            $("#countryName").val('');
            $("#countryCode").val('');
            $("#countryGroup").val('');
            $("#currencycode").val('');
            $("#locale").val('');
            $('#myModal').modal('show');
        }
        function editCountry(id) {
            $("#countryid").val(id);
            var name = $("#name_"+id).html();
            $("#countryName").val(name);
            var code =  $("#code_"+id).html();
            $("#countryCode").val(code);
            var group =  $("#group_"+id).html();
            $("#countryGroup").val(group);
            var currencycode =  $("#currencycode_"+id).html();
            $("#currencycode").val(currencycode);
            var locale =  $("#locale_"+id).html();
            $("#locale").val(locale);
            $('#myModal').modal('show');
        }
    </script>
<c:url var="url" value="/admin/destination/countries.html"/>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered" id="roomsTable">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Code</th>
                    <th>Group</th>
                    <th>Currency Code</th>
                    <th>Locale</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${countries}" var="ct">
                    <tr>
                        <td>
                            <span id="name_${ct.countryid}">${ct.name}</span>
                        </td>
                        <td>
                            <span id="code_${ct.countryid}">${ct.code}</span>
                        </td>
                        <td>
                            <span id="group_${ct.countryid}">${ct.countrygroup}</span>
                        </td>
                        <td>
                            <span id="currencycode_${ct.countryid}">${ct.currencycode}</span>
                        </td>
                        <td>
                            <span id="locale_${ct.countryid}">${ct.locale}</span>
                        </td>
                        <td>
                            <a class="popup-with-form" data-mfp-src="#countryForm" onclick="editCountry('${ct.countryid}')">
                                <i class="fa fa-edit"></i></a>
                            |
                            <a href="/admin/destination/states.html?countryID=${ct.countryid}">States</a>
                            |
                            <a href="/admin/destination/cities.html?countryID=${ct.countryid}">Cities</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <!--
            <button type="button" class="btn btn-success" id="addButton">Add</button>-->
            <a class="btn btn-outline-primary" onclick="addNew()">Add new Country</a>

            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Add Country</h4>
                        </div>
                        <div class="modal-body">
                            <form:form action="${url}" method="post" commandName="item" id="countryForm"
                                       cssClass="form-horizontal" role="form" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label>Name</label>
                                        <form:input path="name" cssClass="form-control" id="countryName"/>
                                </div>
                                <div class="form-group">
                                    <label>Code</label>
                                    <form:input path="code" cssClass="form-control" id="countryCode"/>
                                </div>
                                <div class="form-group">
                                    <label>Group</label>
                                    <form:input path="countrygroup" cssClass="form-control" id="countryGroup"/>
                                </div>
                                <div class="form-group">
                                    <label>Currency Code</label>
                                    <form:input path="currencycode" cssClass="form-control" id="currencycode"/>
                                </div>
                                <div class="form-group">
                                    <label>Locale</label>
                                    <form:input path="locale" cssClass="form-control" id="locale"/>
                                </div>
                                <div class="form-group">
                                    <label>Image for Destination</label>
                                    <input type='file' name='imageFile' size='40' />
                                </div>
                                <form:hidden path="countryid" id="countryid"/>
                            </form:form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <a onclick="submitForm();" class="btn btn-primary">&nbsp;Save Country</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
