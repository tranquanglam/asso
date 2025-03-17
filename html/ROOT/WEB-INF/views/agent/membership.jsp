<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="row">
    <div class="col-lg-6">
        <ol class="breadcrumb">
            <li><a href="#">Home</a></li>
            <li class="active"><span>Membership information</span></li>
        </ol>

        <h1>${customer.fullname}</h1>
    </div>
    <div class="col-lg-6">
        <div class="d-none hide" id="customerid">${customer.customerid}</div>
        <div class="d-none hide" id="usd_vnd_rate">${sessionScope.USD_VND.rate}</div>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="main-box clearfix">
            <header class="main-box-header clearfix">
                <div class="row">
                    <div class="col-lg-6">
                        Total points <span class="label label-primary" id="totalPoints">${user.company.point}</span>  |
                        Level <span class="label label-info">${user.company.level}</span> &nbsp;
                        <span><i class="fa fa-long-arrow-right" aria-hidden="true"></i> <a href="#" onclick="changeLevelType()">change level & type</a></span>
                    </div>
                    <div class="col-lg-6">
                        <div class="pull-right">
                        API: &nbsp;
                        <span class="${apiable ? '' : 'hide'}" id="api-yes"><i class="fa fa-unlock fa-lg" aria-hidden="true"></i></span>
                        <span class="${apiable ? 'hide' : ''}" id="api-no"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                        <a href="#" class="btn btn-link apiable">${apiable ? 'Lock' : 'Unlock'}</a>
                        </div>
                    </div>
                </div>
            </header>

            <div class="main-box-body clearfix">
                <div class="table-responsive">
                    <table id="membership_points_table" class="table table-hover">
                        <thead>
                        <tr>
                            <th class="col-md-2">Date</th>
                            <th class="col-md-1 nosort">Name</th>
                            <th class="col-md-3 nosort">Booking No</th>
                            <th class="col-md-3 nosort">Reward</th>
                            <th class="col-md-1 nosort">Point</th>
                            <th class="col-md-2 nosort">Description</th>
                        </tr>
                        </thead>
                    </table>
                </div>
                <a href="#" class="btn btn-danger" onclick="redeem()">Redeem</a>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="levelTypeModal" tabindex="-1" role="dialog" aria-labelledby="levelTypeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="levelTypeModalLabel">Level & Customer Type</h4>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="col-md-12">
                        <form id="levelTypeForm" class="form-horizontal" method="post" role="form">
                            <div class="form-group">
                                <label>Level</label>
                                <select name="level" class="form-control">
                                    <c:forEach begin="0" end="2" var="i" step="1">
                                        <option value="${i}" ${i eq user.company.level ? 'selected' : ''}>Level ${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Customer Type</label>
                                <select name="type" class="form-control">
                                    <option value="UNKNOWN" ${'UNKNOWN' eq user.company.type ? 'selected' : ''}>Personal Customer</option>
                                    <option value="AGENCY" ${'AGENCY' eq user.company.type ? 'selected' : ''}>Agency</option>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary saveLevelTypeBtn">&nbsp;Save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="redeemModal" tabindex="-1" role="dialog" aria-labelledby="redeemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="redeemModalLabel">Redeem</h4>
            </div>
            <div class="modal-body">
                <table id="rewards_table" class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th class="col-md-6">Name</th>
                        <th class="col-md-3 nosort">Point</th>
                        <th class="col-md-3 nosort"></th>
                    </tr>
                    </thead>
                    <tbody id="rewardList">
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


