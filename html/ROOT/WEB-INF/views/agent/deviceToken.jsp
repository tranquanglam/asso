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
            ${topicAgentUser}
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
