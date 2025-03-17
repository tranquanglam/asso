<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="row">
    <div class="col-lg-6">
        <ol class="breadcrumb">
            <li><a href="#">Home</a></li>
            <li class="active"><span>Customers</span></li>
        </ol>

        <h1>Customers</h1>
    </div>
    <div class="col-lg-6">
        <c:if test="${not empty error}">
            <div class="alert alert-warning alert-dismissible">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <strong>${error}</strong>
            </div>
        </c:if>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="main-box clearfix">
            <header class="main-box-header clearfix">
                <form:form id="myForm" class="form-inline pull-right" action="/agent/customers" method="post" commandName="mineBean">
                    <div class="input-group mb-3">
                        <form:input  path="searchTerm" placeholder="id or email" maxlength="64" cssClass="input-search form-control"/>
                        <div class="input-group-btn">
                            <button type="submit" class="btn btn-info btn-sm"><span><i class="fa fa-search"></i></span></button>
                        </div>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-default membershipFormBtn" type="button">Add new membership <i class="fa fa-plus"></i></button>
                    </div>
                    <input type="hidden" name="page" id="formPage" value="1">
                    <input type="hidden" name="customerId" id="customerId">
                </form:form>
            </header>
            <div class="main-box-body clearfix">
                <div class="table-responsive table-responsive-last">
                    <table class="table">
                        <thead class="green">
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>MemberID</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${items.listResult}" var="cus">
                            <tr>
                                <td>
                                        ${cus.fullname}
                                </td>
                                <td>${cus.email}</td>
                                <td>${cus.phone}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cus.ismember}">
                                            <i class="fa fa-check fa-lg" aria-hidden="true"></i>
                                            <a href="/agent/customers/${cus.customerid}/membership">${cus.memberid}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#" onclick="convertToCustomer('${cus.customerid}')">Convert to membership</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><a href="/agent/bookings?q=${cus.email}"><i class="fa fa-shopping-cart fa-lg" aria-hidden="true"></i></a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <ul class="pagination pull-right">
                    <c:if test="${items.hasPrevious}">
                        <li><a href="javascript:gotoPage(${items.page - 1})"><i class="fa fa-angle-left"></i></a></li>
                    </c:if>
                    <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                        <li class="${items.page eq loop.count?'page-item active':'page-item'}"><a href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
                    </c:forEach>
                    <c:if test="${items.hasNext}">
                        <li><a href="javascript:gotoPage(${items.page + 1})"><i class="fa fa-angle-right"></i></a></li>
                    </c:if>
                </ul>
            </div>

        </div>
    </div>
</div>
<div class="modal" id="membershipModal" tabindex="-1" role="dialog" aria-labelledby="membershipModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="membershipModalLabel">Add new membership</h4>
            </div>
            <div class="modal-body">
                <form id="addMembershipForm" action="/agent/customers/addMembership" class="form-horizontal" method="post">
                    <div class="row form-group">
                        <label class="col-lg-2 control-label">First Name:</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" name="firstName"/>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-lg-2 control-label">Last Name:</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" name="lastName"/>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-lg-2 control-label">Email:</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" name="email"/>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-lg-2 control-label">Phone:</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" name="phone"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Country:</label>
                        <div class="col-lg-10">
                            <select name="countryCode" class="form-control">
                                <option value=""></option>
                                <c:forEach var="country" items="${countryList}">
                                    <option value="${country.code}">${country.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary addMemmbershipBtn">&nbsp;Add</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
