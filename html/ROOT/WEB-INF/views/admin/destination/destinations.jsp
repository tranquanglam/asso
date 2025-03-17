<%@ include file="/common/taglibs.jsp"%>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <form:form action="/admin/destination/destinations.html" method="post" id="destinationSearchForm" commandName="items" class="form-inline" role="form">
                <div class="pane_report">
                    <div class="form-group">
                        <label>Name</label>
                        <form:input path="searchTerm" class="form-control search-destination"/>
                    </div>
                    <div class="form-group">
                        <label class="checkbox-inline">
                            <form:checkbox path="hasHotel" /> Hotel
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="checkbox-inline">
                            <form:checkbox path="hasTour" /> Tour
                        </label>
                    </div>
                    <div class="form-group">
                        <a onclick="submitForm();" class="btn btn-primary">&nbsp;Search</a>
                    </div>
                    <div class="form-group float_right">
                        <a href="/admin/destination/countries.html" class="btn btn-success">&nbsp;Manage Countries</a>     &nbsp;&nbsp;
                        <a href="#" onclick="submitDestinationListForm();" class="btn btn-success">&nbsp;Update Destinations</a>
                    </div>
                </div>
                <form:hidden path="crudaction" />
            </form:form>

<!-- Modal -->
<div class="modal fade" id="destinationNameFormModal" tabindex="-1" role="dialog" aria-labelledby="destinationNameFormModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Edit Name</h4>
            </div>
            <div class="modal-body">
                <form id="destinationNameForm" action="/admin/destination/updateDestinations.html" method="post" >
                    <input type="hidden" name="destinationid">
                    <div class="form-group">
                        <label for="name" class="control-label">Name:</label>
                        <input class="form-control" id="name" name="name"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="saveButton">Save changes</button>
            </div>
        </div>
    </div>
</div><!--end modal-->

            <div id="searchResult" style="margin-bottom:10px;">
                <form id="destinationListForm" action="/admin/destination/updateDestinations.html" method="post" enctype="multipart/form-data">
                    <table class="table table-borderless table-striped">
                        <thead class="blue">
                        <tr>
                            <th>Name</th>
                            <th>Country</th>
                            <th>Avatar</th>
                            <th># Order</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${items.listResult}" var="tableList">
                            <tr id="item_${tableList.destinationID}">
                                <td class="item_name">
                                    <a href="javascript:void(0)" onclick="editName(${tableList.destinationID}, '${tableList.name}');" title="Edit Name">
                                        ${tableList.name}
                                    </a>
                                </td>
                                <td class="item_country">
                                    <c:choose>
                                        <c:when test="${!(tableList.countryName eq tableList.name)}">
                                            ${tableList.countryName}
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/admin/destination/cities.html?countryID=${tableList.countryID}">Manage Cities</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="item_avatar">
                                    <div id="avatar_${tableList.destinationID}">
                                        <img src="${tableList.avatar}"/>
                                        <c:choose>
                                            <c:when test="${not empty tableList.cityCode}">
                                                (70,70)
                                            </c:when>
                                            <c:otherwise>
                                                (120,88)
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="#" onclick="editAvatar('${tableList.destinationID}');" title="Edit Avatar">
                                            Edit
                                        </a>
                                    </div>
                                </td>
                                <td class="item_order">
                                    <div id="orderNumber_${tableList.destinationID}">
                                            ${tableList.orderNumber}
                                        <a href="#" onclick="editOrderNumber('${tableList.destinationID}','${tableList.orderNumber}');" title="Edit Order Number">
                                            Edit
                                        </a>
                                    </div>
                                </td>
                                <td>
                                    <a href="javascript:void(0)" onclick="editName(${tableList.destinationID}, '${tableList.name}');" title="Edit Name">
                                            ${tableList.name}
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <input type="hidden" name="avatarList" id="avatarList" value=""/>
                    <input type="hidden" name="orderNumberList" id="orderNumberList" value=""/>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function submitForm(){
        $("#crudaction").val("search");
        $("#destinationSearchForm").submit();
    }
    function submitDestinationListForm() {
        $("#destinationListForm").submit();
    }
    function editAvatar(desID) {
        var aList = $("#avatarList").val() + "," + desID;
        $("#avatarList").val(aList);
        document.getElementById('avatar_'+desID).innerHTML = "<input type='file' name='avatar_"+desID+"' size='40' />";
    }
    function editOrderNumber(desID,number) {
        var oList = $("#orderNumberList").val() + "," + desID;
        $("#orderNumberList").val(oList);
        document.getElementById('orderNumber_'+desID).innerHTML = "<input type='text' name='orderNumber_"+desID+"' value='"+number+"' size='5' />";
    }
    function editName(desID, name) {
        $('#destinationNameForm')[0].reset(0);
        //reset hidden fields
        $('#destinationNameForm').populate({destinationid: desID, name: name});
        $('#destinationNameFormModal').modal('show');
    }
    $('#saveButton').on('click', function () {
        var $btn = $(this).button('loading')
        var formData = $("#destinationNameForm").serializeFormJSON();
        postData(formData);
        //console.log(formData);



    });
    function postData(formData){

        //console.log(formData);
        var postUrl = "/admin/destinations.json";
        if(formData.destinationid){
            postUrl = "/admin/destinations/" + formData.destinationid + ".json";
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
                $('#destinationNameFormModal').modal('hide');
                $('#saveButton').button('reset');
                alert("Successfully update " + data.name);

                //reload page $('#currency_table').bootstrapTable('refresh');
                location.reload();
            },
            error:function(data,status,er) {
                $('#destinationNameFormModal').modal('hide');
                $('#saveButton').button('reset')
                alert("Error when update "+data+": "+er);
            }
        });
    }

</script>