<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="container-fluid">
<div class="row">
    <div class="col-md-6">
        <h1>
           Promotion Level ${level}  # Products
        </h1>
    </div>
    <div class="col-md-6 pt-3 text-right">
        <span><a href="/bo/data/promotions/0/products">Level 0</a> | </span>
        <span><a href="/bo/data/promotions/1/products">Level 1</a> | </span>
        <span><a href="/bo/data/promotions/2/products">Level 2</a></span>
    </div>
</div>
</div>
    <div class="container-fluid mt-3">
        <form method="post">
            <table class="table table-bordered table-striped" id="ratesTable">
                <thead>
                <tr>
                    <th style="background-image: linear-gradient(to top right,white 48%,black,white 52%);">
                        <span class="pull-left">Products</span>
                        <span class="pull-right">Promotions</span>
                    </th>
                    <c:forEach items="${promotions}" var="promotion">
                        <th>${promotion.code}</th>
                    </c:forEach>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${items}" var="item">
                    <tr>
                        <td>
                            <span>${item.name}</span>
                        </td>
                        <c:forEach items="${promotions}" var="promotion">
                            <c:set var="key" value="${promotion.promotionid},${item.productid}"/>
                            <td>
                                <input type="checkbox" name="promotionitem" value="${promotion.promotionid},${item.productid}" ${not empty promotionitemMap[key] ? 'checked' : ''}>
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <button class="btn btn-primary btn-submit" type="submit">Save</button>
        </form>
    </div>

