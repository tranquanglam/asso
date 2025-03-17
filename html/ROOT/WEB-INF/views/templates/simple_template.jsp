<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/common/taglibs.jsp" %>
<tiles:importAttribute name="stylesheets"/>
<tiles:importAttribute name="javascripts"/>
<c:set var="ggfont" value="Montserrat"/>
<c:if test="${not empty site.googlefont}">
    <c:set var="ggfont" value="${site.googlefont}"/>
</c:if>
<c:set var="siteColor" value="#0ba4ff"/>
<c:if test="${not empty site.color}">
    <c:set var="siteColor" value="${site.color}"/>
</c:if>
<!doctype html>
<html style="--main-bg-color: ${siteColor};--main-font-family:${ggfont}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Travel Enet set up travel eco system by integrating multi marketplaces, connect supplier, hotel, activities operator, transportation, cruise liner, dmc, travel agency, tour operator in a single platform (eco system) where roles are different, aim to help travel agency to maintain their loyal clients and grow revenue">
    <meta name="author" content="Le Hung Ban">
    <title>Travel Enet Technologies</title>
    <link href="https://fonts.googleapis.com/css2?family=${ggfont}:wght@200;300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css" integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/purpose.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/mem.css" />
    <link href="/themes/mega/css/admin.css?v=1.06" rel="stylesheet">
    <c:forEach var="css" items="${stylesheets}">
        <link rel="stylesheet" type="text/css" href="<c:url value="${css}"/>">
    </c:forEach>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<tiles:insertAttribute name="content"/>
<script src="/themes/mega/js/bootstrap.min.js"></script>
<!-- this page specific inline scripts -->
<c:forEach var="script" items="${javascripts}">
    <script src="<c:url value="${script}"/>"></script>
</c:forEach>
</body>
</html>