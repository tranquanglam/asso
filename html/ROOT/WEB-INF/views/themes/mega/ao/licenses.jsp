<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-2 mb-5">
    <div class="customers-container">
        <div class="row mt-4">
            <div class="col-md-4">
                <h1>Licenses</h1>
            </div>
            <div class="col-md-8">
                <form:form id="myForm" cssClass="form-inline pull-right" action="/ao/payment/licenses.html" method="post" modelAttribute="items">
                    <div class="form-group">
                        <form:input  path="email" placeholder="email" maxlength="255" cssClass="form-control"/>
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
                        <th>Email</th>
                        <th>Domain</th>
                        <th>Order number</th>
                        <th>Effective date</th>
                        <th>Expiration date</th>
                        <th>Description</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${items.listResult}" var="license">
                        <tr id="license_${license.licenseid}">
                            <td>${license.email}</td>
                            <td>${license.domain}</td>
                            <td>${license.ordernumber}</td>
                            <td>${license.effectivedate}</td>
                            <td>${license.expirationdate}</td>
                            <td>${license.description}</td>
                            <td>${license.status}</td>
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
