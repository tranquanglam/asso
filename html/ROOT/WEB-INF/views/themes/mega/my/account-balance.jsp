<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="account-balance-container">
    <div class="row">
        <div class="col-md-10">
            <h3>${user.firstName} ${user.lastName}'s balance: ${accountbalance.credit} / Last time: <fmt:formatDate type="both" value="${accountbalance.lasttime}"/></h3>
        </div>
        <div class="col-md-2">
            <div class="text-right">
                <a href="#" class="btn btn-success btn-buy-credit"><i class="bi bi-plus" aria-hidden="true"></i>&nbsp;&nbsp;<fmt:message key="label.buy-credit"/></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="card bg-dark text-white my-3">
                <div class="card-body">
                    <form id="transactionFilterForm" role="form" action="/loyalty/account-transaction.json">
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
                <h5 class="modal-title" id="transactionModalLabel"><fmt:message key="label.buy-credit"/></h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form role="form" action="/loyalty/OG/buy-credit.html" id="buyCreditForm" method="post">
                    <div class="form-group">
                        <select name="credit" class="form-control">
                            <option value="50000">50,000</option>
                            <option value="100000">100,000</option>
                            <option value="200000">200,000</option>
                            <option value="500000">500,000</option>
                            <option value="1000000">1,000,000</option>
                            <option value="2000000">2,000,000</option>
                            <option value="5000000">5,000,000</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-buy-credit-submit"><fmt:message key="label.buy-credit"/></button>
            </div>
        </div>
    </div>
</div>