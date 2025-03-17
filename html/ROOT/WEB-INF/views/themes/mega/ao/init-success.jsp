<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="pageName"><fmt:message key="ao.init"/></c:set>
<c:set var="pageContent"><fmt:message key="ao.init.content"/></c:set>
<c:if test="${page != null}">
    <c:set var="pageName">${page.name}</c:set>
    <c:set var="pageContent">${page.content}</c:set>
</c:if>
<div class="vh-100">
    <div class="container">
        <div class="row">
            <div class="col-md-10 col-lg-8 mx-auto text-center">
                <i class="fa fa-paper-plane fa-2x mb-2 text-white"></i>
                <h1 class="mg-sec-title">${pageName}</h1>
                <div class="content">
                    ${pageContent}
                </div>
            </div>
        </div>
    </div>
</div>

