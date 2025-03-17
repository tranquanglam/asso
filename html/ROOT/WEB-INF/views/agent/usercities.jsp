<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/users">Users</a></li>
                    <li class="breadcrumb-item"><a href="/agent/usercategories">Categories belong to Super User</a></li>
                    <li class="breadcrumb-item active"><a href="/agent/usercities">Cities belong to User</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1>Cities belong to User</h1>
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
                            <div class="text-left pt-4">Users</div>
                            <div class="text-end pb-4 mb-4">Cities</div>
                        </div>
                    </th>
                    <c:forEach items="${cities}" var="city">
                        <th>${city.name}</th>
                    </c:forEach>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>
                            ${user.firstName} ${user.lastName} [${user.email}]
                        </td>
                        <c:forEach items="${cities}" var="city">
                            <c:set var="key" value="${user.userID},${city.cityid}"/>
                            <td>
                                <input type="checkbox" name="usercity" value="${user.userID},${city.cityid}" ${not empty rolesMap[key] ? 'checked' : ''}>
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