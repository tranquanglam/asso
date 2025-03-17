<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    span[contenteditable="true"] {
        padding-top: 0.5rem;
        padding-bottom: 0.5rem;
        padding-left: 2rem;
        padding-right: 2rem;
        border: dashed 1px #06abff;
        color: #06abff;
    }
</style>
<section class="shippingfee-ward">
    <div class="container-fluid">
        <form id="reportForm" action="/bo/data/shippingfees.html" method="POST">
            <div class="row">
                <c:if test="${not empty states}">
                    <div class="form-ward form-ward-state col-md-3">
                        <select name="statecode" class="form-control custom-select cus-state">
                            <c:forEach items="${states}" var="state">
                                <option value="${state.code}" ${city.statecode eq state.code ? 'selected' : ''}>${state.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>
                <div class="form-ward form-ward-city col-md-3">
                    <select name="citycode" class="form-control custom-select cus-city">
                        <c:forEach items="${cities}" var="ct">
                            <option value="${ct.code}" ${city.code eq ct.code ? 'selected' : ''}>${ct.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-ward col-md-3">
                    <button type="submit" class="btn btn btn-outline-secondary">Filter</button>
                </div>
            </div>
        </form>

        <div class="row mt-4">
            <div class="col-12">
                <table class="table table-striped">
                    <thead class="blue">
                    <tr>
                        <th><fmt:message key="label.ward"/> </th>
                        <th><fmt:message key="label.zip"/></th>
                        <th class="text-right"><fmt:message key="shipping.initfee"/></th>
                        <th class="text-right"><fmt:message key="shipping.productfee"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${wards}" var="w">
                        <tr class="tr-ward">
                            <td>
                                    ${w.name}
                            </td>
                            <td>
                                    ${w.zip}
                            </td>
                            <c:set var="sfee" value="0"/>
                            <c:set var="sinitfee" value="0"/>
                            <c:if test="${not empty shippingfeeMap[w.wardid]}">
                                <c:set var="sinitfee"><fmt:formatNumber value="${shippingfeeMap[w.wardid].initfee}" groupingUsed="false" maxFractionDigits="0"/></c:set>
                                <c:set var="sfee"><fmt:formatNumber value="${shippingfeeMap[w.wardid].fee}" groupingUsed="false" maxFractionDigits="0"/></c:set>
                            </c:if>
                            <td class="text-right"><span class="item-shippinginitfee ward-${w.wardid}" data-wardid="${w.wardid}" contenteditable="false" data-initfee="${sinitfee}">${sinitfee}</span></td>
                            <td class="text-right"><span class="item-shippingfee" data-wardid="${w.wardid}" contenteditable="false" data-fee="${sfee}">${sfee}</span></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="my-3">
            <div class="text-right">
                <a href="#" class="btn btn-outline-secondary btn-edit-shipping-fees">Edit fees</a>
                <a href="#" class="btn btn-outline-primary d-none btn-edit-shipping-fees-save">Update fees</a>
            </div>
        </div>
    </div>
</section>
<div class="d-none countryid">${country.countryid}</div>

