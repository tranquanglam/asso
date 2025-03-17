<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="container-fluid">
    <h2 class="pt-3 pb-3">Headers</h2>
    <div class="row">
        <div class="col-md-12">
            <div id="header-layouts-container">
                <c:forEach var="layout" items="${headers}">
                    <div class="header-layout-item-container border border-primary mt-4">
                            ${layout.template}
                        <div class="header-layout-item" data-layout="${layout.layout}">
                            <div class="text-center pt-5">${layout.layout}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <h2 class="pt-3 pb-3">Product items</h2>
    <div class="row">
        <c:forEach var="layout" items="${productItemLayouts}">
            <div class="col-md-3 border border-primary mt-4" data-layout="${layout.layout}">
                    ${layout.template}
            </div>
        </c:forEach>
    </div>
    <h2 class="pt-3 pb-3">Page contents</h2>
    <div class="row">
        <div class="col-md-12">
            <div id="layouts-container">
                <c:forEach var="layout" items="${layouts}">
                    <div class="layout-item border border-primary mt-4" data-layout="${layout.layout}">
                            ${layout.template}
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <h2 class="pt-3 pb-3">Footers</h2>
    <div class="row">
        <div class="col-md-12">
            <div id="footer-layouts-container">
                <c:forEach var="layout" items="${footers}">
                    <div class="footer-layout-item border border-primary mt-4" data-layout="${layout.layout}">
                            ${layout.template}
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<c:if test="${canRefresh}">
    <div class="mt-4 text-center">
        <form method="post">
            <button class="btn btn-primary" type="submit">Refresh</button>
        </form>
    </div>
</c:if>
