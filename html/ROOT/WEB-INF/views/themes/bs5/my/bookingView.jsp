<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div id="content-prescription" style="margin-top: 20px;">
    ${mailContent}
</div>
<div class="mt-4 mb-2">
    <div style="margin-left: auto;margin-right: auto;max-width: 800px;">
        <div class="d-flex justify-content-center">
            <div class="one mx-2">
                <a class="btn btn-primary continue" href="javascript:void(0)" onclick="printElem('content-prescription')"><span class="text-white"><fmt:message key="label.print"/>
                    <i class="bi bi-printer"></i></span></a>
            </div>
        </div>
    </div>
</div>

