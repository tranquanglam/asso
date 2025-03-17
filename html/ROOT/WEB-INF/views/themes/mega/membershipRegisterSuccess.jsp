<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="pageName">Bạn đã đăng ký thành công</c:set>
<c:if test="${page != null}">
    <c:set var="pageName">${page.name}</c:set>
</c:if>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="mg-sec-title mt-3">
                <h3>${pageName}</h3>
            </div>
            <div class="d-flex justify-content-center align-items-center">
                <div class="border border-light pt-3">
                    <c:if test="${page != null}">
                        ${page.content}
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

