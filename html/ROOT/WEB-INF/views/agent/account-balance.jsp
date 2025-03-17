<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-md-10">
            <h3>${user.firstName} ${user.lastName}'s balance: ${accountbalance.credit} / Last time: <fmt:formatDate type="both" value="${accountbalance.lasttime}"/></h3>
        </div>
        <div class="col-md-2">
            <div class="text-end">
                <a href="#" class="btn btn-success btn-add-credit"><i class="bi bi-plus" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Add</a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="card bg-dark text-white my-3">
                <div class="card-body">
                    <form id="transactionFilterForm" role="form" action="/agent/users/${accountbalance.userid}/account-transaction.json">
                        <div class="row">
                            <div class="col-auto">
                                <input type="text" class="form-control" name="fromDate" placeholder="from date" id="fromDate">
                            </div>
                            <div class="col-auto">
                                <input type="text" class="form-control" name="toDate" placeholder="to date" id="toDate">
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-success" id="transactionFilter">Search</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <table id="transactions_table" class="table table-hover">
                <thead>
                <tr>
                    <th>Transaction time</th>
                    <th>Credit</th>
                    <th>Ordernumber</th>
                    <th>Paymentid</th>
                    <th>Note</th>
                </tr>
                </thead>

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