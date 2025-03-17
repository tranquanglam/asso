<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active"><a href="/agent/users">Users</a></li>
                    <li class="breadcrumb-item"><a href="/agent/usercategories">Categories belong to Super User</a></li>
                    <li class="breadcrumb-item"><a href="/agent/usercities">Cities belong to User</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-10">
            <h1><fmt:message key="admin.agent.user.title" /></h1>
        </div>
        <div class="col-2">
            <div class="text-end">
                <a href="/agent/users/add" class="btn btn-success pull-right"><i class="bi bi-plus" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Add</a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="card bg-dark text-white my-3">
                <div class="card-body">
                    <form id="userFilterForm"  role="form" action="/agent/users">
                        <div class="row">
                            <div class="col-auto">
                                <select name="role" id="role" class="form-control">
                                    <option value="">All roles</option>
                                    <c:forEach items="${roles}" var="role">
                                        <option value="${role}">${role}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-auto">
                                <input type="text" class="form-control" name="q" placeholder="search..." id="q">
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-success" id="userFilter">Search</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <table id="users_table" class="table table-hover">
                <thead>
                <tr>
                    <th><fmt:message key="admin.agent.user.email"/></th>
                    <th><fmt:message key="admin.agent.user.status"/></th>
                    <th><fmt:message key="admin.agent.user.last_login"/></th>
                    <th><fmt:message key="admin.agent.user.role"/></th>
                    <th></th>
                </tr>
                </thead>

            </table>
        </div>
    </div>
</div>