<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/users">Users</a></li>
                    <li class="breadcrumb-item active"><a href="/agent/usercategories">Categories belong to Super User</a></li>
                    <li class="breadcrumb-item"><a href="/agent/usercities">Cities belong to User</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1>Categories belong to  Super User</h1>
        </div>
    </div>
</div>
<div class="light-wrapper">
    <div class="container">
        <form method="post">
            <div class="w-100 overflow-scroll">
            <table class="table table-bordered table-striped" id="ratesTable">
                <thead>
                <tr>
                    <th style="background-image: linear-gradient(to top right,white 48%,black,white 52%);">
                        <div class="d-flex justify-content-between">
                            <div class="text-left pt-4">Categories</div>
                            <div class="text-end pb-4 mb-4">Super Users</div>
                        </div>
                    </th>
                    <c:forEach items="${susers}" var="user">
                        <c:set var="uname" value="${user.email}"/>
                        <c:if test="${not empty user.firstName}">
                            <c:set var="uname" value="${user.firstName}"/>
                        </c:if>
                        <c:if test="${not empty user.lastName}">
                            <c:set var="uname" value="${user.lastName}"/>
                        </c:if>
                        <th>${uname}</th>
                    </c:forEach>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${categories}" var="cat">
                    <tr>
                        <td>
                            <span>${cat.name}</span>
                        </td>
                        <c:forEach items="${susers}" var="user">
                            <c:set var="key" value="${user.userID},${cat.categoryid}"/>
                            <td>
                                <input type="checkbox" name="usercategory" value="${user.userID},${cat.categoryid}" ${not empty rolesMap[key] ? 'checked' : ''}>
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            </div>
            <button class="btn btn-submit btn-outline-primary my-4" type="submit">Save</button>
        </form>
    </div>
</div>