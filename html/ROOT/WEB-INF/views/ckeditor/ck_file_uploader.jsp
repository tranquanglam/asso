<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
    window.parent.CKEDITOR.tools.callFunction('${editor}', '${pageContext.request.contextPath}/${url}', '');
</script>