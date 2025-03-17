<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<!-- Main content -->
<div class="h-screen flex-grow-1 overflow-y-lg-auto">
    <!-- Header -->
    <h1 class="h2 mb-0 ls-tight px-3 mt-4">Colors</h1>
    <!-- Main -->
    <div class="py-6 bg-surface-secondary">
        <div class="container-fluid">
            <div class="mt-2 mb-4">
                <div class="product-container">

                    <div class="box-table mt-3">
                        <div class="table-responsive table-responsive-last">
                            <table class="table table-borderless table-striped">
                                <thead class="table-light">
                                <tr>
                                    <th></th>
                                    <th>Code</th>
                                    <th>Name</th>
                                    <th>Tiếng Việt</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${items}" var="em" varStatus="loop">
                                    <tr id="item_${em.colorid}" class="">
                                        <td class="">${loop.index + 1}</td>
                                        <td class="item_code">${em.code}</td>
                                        <td class="item_name ">${em.name}</td>
                                        <td class="item_namevi">${em.namevi}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
