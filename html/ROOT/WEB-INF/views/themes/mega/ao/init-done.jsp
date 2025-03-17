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
        <div class="d-none" id="userid">${userid}</div>
        <div class="d-none" id="token">${token}</div>
        <div class="d-flex justify-content-center" id="creating-site">
            <div class="spinner-border" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
    </div>
</div>
<div class="d-none" id="site-information">
    <div class="row">
        <div class="site-domain col-md-12 text-center"><a href="{domain}">{domain}</a></div>
        <div class="site-admin-info col-md-12 text-center">Your admin username is <strong>{username}</strong></div>
        <div class="site-admin-info col-md-12 text-center">Your admin password is <strong>{password}</strong></div>
    </div>
</div>

