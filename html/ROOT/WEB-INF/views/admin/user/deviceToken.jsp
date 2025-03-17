<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container-fluid">
    <div class="row mb-5">
        <div class="col-md-10">
            <h3>${user.firstName} ${user.lastName}</h3>
        </div>
        <div class="col-md-2">
        </div>
        <div class="col-md-2">
            Agent UserAdmin Topic: ${topicAgentUser}
        </div>
    </div>

    <div class="row mb-5">
        <div class="col-12">
            <h5>User token</h5>
            <table  class="table table-hover">
                <thead>
                <tr>
                    <th>#</th>
                    <th></th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${deviceTokenList}" var="deviceToken" varStatus="loop">
                    <tr >
                        <td>${loop.index + 1}</td>
                        <td class="item_name" style="font-size: 0.8em;">${deviceToken}</td>
                        <td><a href="javascript:void(0);" data-token="${deviceToken}" onclick="getUserByToken(this)">GetUsers</a></td>
                        <td><a href="javascript:void(0);" data-token="${deviceToken}" onclick="removeToken(this)">RemoveToken</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row mb-5">
        <div class="col-12">
            <h5>User Subscribes</h5>
            <table  class="table table-hover">
                <thead>
                <tr>
                    <th>#</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${userSubscribes}" var="userSubscribe" varStatus="loop">
                    <tr >
                        <td>${loop.index + 1}</td>
                        <td class="item_name">${userSubscribe.name}</td>
                        <td class="item_topic">${userSubscribe.topic}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row mb-5">
        <div class="col-8">
            <h5>Test push noti</h5>
            <form action="/admin/user/${user.userID}/pushNotification.html" method="post">
                <div class="form-group row">
                    <label for="topic" class="col-2">Topic</label>
                    <input type="text" class="form-control col-10" name="topic" value="${topicAgentUser}">
                </div>
                <div class="form-group row">
                    <label for="title" class="col-2">Title</label>
                    <input type="text" class="form-control col-10" name="title" placeholder="Title" value="Title test message">
                </div>
                <div class="form-group row">
                    <label for="body" class="col-2">Body</label>
                    <input type="text" class="form-control col-10" name="body" placeholder="Title" value="Body test message">
                </div>
                <div class="row">
                    <div class="col-12 text-right">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </div>

            </form>
        </div>
    </div>

    <div class="row mb-5">
        <div class="col-8">
            <h5>Unsubscribe this topic</h5>
            <form action="/admin/user/${user.userID}/unsubscribeTopic.html" method="post">
                <div class="form-group row">
                    <label class="col-2">Topic</label>
                    <input type="text" class="form-control col-10" name="topic" value="">
                </div>
                <div class="row">
                    <div class="col-12 text-right">
                        <button type="submit" class="btn btn-primary">Unsubscribe and Delete Topic</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="row mb-5">
        <div class="col-8">
            <h5>Subscribe this topic</h5>
            <form action="/admin/user/${user.userID}/subscribeTopic.html" method="post">
                <div class="form-group row">
                    <label class="col-2">Topic</label>
                    <input type="text" class="form-control col-10" name="topic" value="">
                </div>
                <div class="row">
                    <div class="col-12 text-right">
                        <button type="submit" class="btn btn-primary">Create and Subscribe Topic</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="transactionModal" tabindex="-1" aria-labelledby="transactionModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="transactionModalLabel">Add credit to account balance</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form role="form" action="/agent/users/${accountbalance.userid}/add-transaction.json" id="addTransactionForm">
                    <div class="form-group">
                        <input name="credit" type="number" class="form-control" placeholder="credit"/>
                    </div>
                    <div class="form-group mt-3">
                        <input name="paymentid" type="text" class="form-control" placeholder="payment receipt"/>
                    </div>
                    <div class="form-group mt-3">
                        <input name="note" type="text" class="form-control" placeholder="note"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-add-credit-submit">Add credit</button>
            </div>
        </div>
    </div>
</div>

<div class="d-none" id="load-userid">${user.userID}</div>

<script>
    function getUserByToken(ele) {
        var deviceToken = $(ele).data('token');
        deviceToken = deviceToken.replace('#', '');
        deviceToken = deviceToken.replace('#', '');
        var url = '/ajax/getUserByToken.json?token=' + deviceToken;
        $.ajax({
            url: url,
            type: 'GET',
            contentType: "application/json",
            success: function(result) {
                for (var i = 0; i < result.length; i++) {
                    console.log(result[i].memberID, result[i].email)
                }
                console.log("")
            }
        });
    }

    function removeToken(ele) {
        var deviceToken = $(ele).data('token');
        deviceToken = deviceToken.replace('#', '');
        deviceToken = deviceToken.replace('#', '');
        var url = '/admin/user/'+$('#load-userid').html()+'/deleteToken.json?token=' + deviceToken;
        $.ajax({
            url: url,
            type: 'POST',
            contentType: "application/json",
            success: function(result) {
                window.location.reload();
                console.log("")
            }
        });
    }
</script>
