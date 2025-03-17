<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-9">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page"><fmt:message key="admin.agent.destination.title"/></li>
                </ol>
            </nav>
        </div>
        <div class="col-3 text-end">
            <a href="/agent/destinations/add" class="btn btn-outline-primary"><i class="bi bi-plus-circle"></i> Add</a>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="card bg-dark text-white my-3">
                <div class="card-body">
                    <form id="destinationFilterForm" class="form-inline" role="form" action="/agent/destinations">
                        <input type="hidden" name="countryid" id="countryid" value="${country.countryid}"/>
                        <div class="row">
                        <div class="form-group col-auto">
                            <select name="destype" class="form-control">
                                <option value="">--<fmt:message key="label.destype"/>--</option>
                                <c:forEach items="${destypes}" var="destype">
                                    <option value="${destype}">${destype}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <c:if test="${not empty states}">
                            <div class="form-group col-auto">
                                <select name="statecode" class="form-control cus-state">
                                    <option value="">--<fmt:message key="label.state"/>--</option>
                                    <c:forEach items="${states}" var="state">
                                        <option value="${state.code}">${state.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:if>
                        <div class="form-group col-auto">
                            <select name="citycode" class="form-control cus-city">
                                <option value="">--<fmt:message key="label.city"/>--</option>
                                <c:forEach items="${cities}" var="ct">
                                    <option value="${ct.code}">${ct.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col-auto">
                            <input type="text" class="form-control" name="q" placeholder="Search...">
                        </div>
                        <div class="form-group col-auto">
                            <label for="destinationFilter">&nbsp;</label>
                            <button type="button" class="btn btn-success" id="destinationFilter">Apply Filter</button>
                        </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
                <table id="destinations_table" class="table table-hover">
                    <thead>
                    <tr>
                        <th><fmt:message key="admin.agent.destination.name"/></th>
                        <th><fmt:message key="admin.agent.destination.country"/></th>
                        <th><fmt:message key="label.city"/></th>
                        <th>Page Url</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

</div>

