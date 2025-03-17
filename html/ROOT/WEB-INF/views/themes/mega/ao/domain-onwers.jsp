<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-2 mb-5">
    <div class="customers-container">
        <div class="row mt-4">
            <div class="col-md-4">
                <h1>Site Owners </h1>
            </div>
            <div class="col-md-8">
                <form:form id="myForm" cssClass="form-inline pull-right" action="/ao/payment/domain-onwers.html" method="post" modelAttribute="items">
                    <div class="form-group">
                        <form:input  path="q" placeholder="search..." maxlength="64" cssClass="form-control"/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-info"><span><i class="fa fa-search" aria-hidden="true"></i></span></button>
                    </div>
                    <form:hidden path="page" id="formPage"/>
                </form:form>
            </div>
        </div>
        <div class="box-table">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped" id="customer_table">
                    <thead class="blue">
                    <tr>
                        <th>UserID</th>
                        <th>Domain</th>
                        <th><fmt:message key="membership.register.firstname"/> </th>
                        <th><fmt:message key="membership.register.lastname"/></th>
                        <th><fmt:message key="label.phone"/></th>
                        <th>Email</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${items.listResult}" var="user">
                        <tr id="user_${user.userID}">
                            <td>${user.userID}</td>
                            <td>${user.domainowner}</td>
                            <td class="firstName">${user.firstName}</td>
                            <td class="lastName">${user.lastName}</td>
                            <td class="phone">${user.phone}</td>
                            <td class="email"><a href="#" class="btn continue btn-licenses">${user.email}</a></td>
                            <td><a href="#" class="btn continue btn-payment-request" data-email="${user.email}"><fmt:message key="payment.request"/></a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!--  -->
        <ul class="pagination pull-right">
            <c:if test="${items.hasPrevious}">
                <li><a href="#"><i class="fa fa-play arrow-left"></i></a></li>
            </c:if>
            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                <li><a ${items.page eq loop.count?'class="current"':''} href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
            </c:forEach>
            <c:if test="${items.hasNext}">
                <li><a href="#"><i class="fa fa-play arrow-right"></i></a></li>
            </c:if>
        </ul>
    </div>
</div>
