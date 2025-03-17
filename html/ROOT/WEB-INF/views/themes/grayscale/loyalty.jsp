<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="container-fluid" id="loyalty-container" data-accesstoken="${access_token}" data-serverpath="https://membooking.com" data-userscope="${user_scope}">
    ${page.content}
</div>
