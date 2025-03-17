<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<section class="slice slice-lg min-vh-100 d-flex align-items-center bg-gradient-primary">
    <div class="container py-5 px-md-0 d-flex align-items-center">
        <div class="w-100">
            <c:if test="${content != null}">
                <div class="card shadow zindex-100 mb-0 mt-3">
                    <div class="card-body px-md-5 py-5">
                            ${content}
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</section>

