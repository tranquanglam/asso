<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<c:forEach items="${names}" var="name">
    <div style="float: left; margin: 0 10px 10px 0">
        <a href="javascript:window.opener.CKEDITOR.tools.callFunction(${editor},'${pageContext.request.contextPath}/${path}/${name}');window.close();">
            <img src="${pageContext.request.contextPath}/${path}/${name}" style="height: 100px; width: auto" />
        </a>
    </div>
</c:forEach>