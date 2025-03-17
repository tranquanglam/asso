<%@ include file="/common/taglibs.jsp"%>
<c:set var="url" value="/admin/user/list.html"/>
<c:set var="editUrl" value="/admin/user/edit.html"/>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
                <c:if test="${not empty messageResponse}">
                    <div class="alert alert-${alertType}">
                        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                            ${messageResponse}
                    </div>
                </c:if>
                <form:form action="${url}" method="post" id="userSearchForm" commandName="items" class="form-inline" role="form">
                        <div class="form-group">
                            <label>Email</label>
                            <form:input path="q" cssClass="form-control" />
                        </div>
                        <div class="form-group ml-2">
                            <label>Role</label>
                            <form:select path="pojo.role" cssClass="form-control">
                                <form:option value="">All</form:option>
                                <form:option value="ADMIN">Admin</form:option>
                                <form:option value="AGT_ADMIN">Agent Admin</form:option>
                                <form:option value="AGT_USER">Agent staff</form:option>
                                <form:option value="CUSTOMER">CUSTOMER</form:option>
                                <form:option value="PM">PM</form:option>
                            </form:select>

                        </div>
                        <div class="form-group ml-2">
                            <label>Status</label>
                            <form:select path="pojo.status" cssClass="form-control">
                                <form:option value="-1">All</form:option>
                                <form:option value="1">Active</form:option>
                                <form:option value="0">Disabled</form:option>
                            </form:select>
                        </div>
                        <div class="form-group ml-2">
                            <a onclick="submitForm();" class="btn btn-primary">&nbsp;Search</a>
                        </div>
                    <form:hidden path="crudaction" />
                </form:form>
                <div id="searchResult" class="mt-3 mb-3">
                    <table class="table table-borderless table-striped">
                        <thead class="blue">
                        <tr>
                            <th>Email</th>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Company</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${items.listResult}" var="tableList">
                            <tr id="item_${tableList.userID}">
                                <td class="item_name">
                                    <a href="${editUrl}?pojo.userID=${tableList.userID}">${tableList.email}</a>
                                </td>
                                <td class="item_name">
                                    <a href="${editUrl}?pojo.userID=${tableList.userID}">${tableList.firstName}</a>
                                </td>
                                <td class="item_address">${tableList.role}</td>
                                <td class="item_address">${tableList.company.name}</td>
                                <td class="item_country">
                                        ${tableList.status == 1 ? "ACTIVE" : "DISABLED"}
                                </td>
                                <td>
                                    <a href="/admin/user/${tableList.userID}/device-token.html">FCM TOKEN</a>
                                    <c:if test="${ownerID != tableList.userID}">
                                        <a class="btn btn-danger" title="Disable" onclick="deleteUser(${tableList.userID})">
                                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Delete
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
        </div>
        </div>
    </div>
<script type="text/javascript">
    $(document).ready(function(){

    });
    function deleteUser(userID){
        bootbox.confirm('Are you sure you want to delete this item ?', function(r){
            if(r){
                window.location.href = '/admin/user/delete.html?checkList=' + userID + '&crudaction=delete';
            }
        });

    }
    function enableUser(userID) {
        window.location.href = '/admin/user/enable.html?userID=' + userID;
    }
    function submitForm(){
        $("#crudaction").val("search");
        $("#userSearchForm").submit();
    }
</script>
