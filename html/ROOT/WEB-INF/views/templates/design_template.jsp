<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/common/taglibs.jsp" %>
<tiles:importAttribute name="stylesheets"/>
<tiles:importAttribute name="javascripts"/>
<c:set var="ggfont" value="Montserrat"/>
<c:if test="${not empty site.googlefont}">
    <c:set var="ggfont" value="${site.googlefont}"/>
</c:if>
<c:set var="ggfont" value="Montserrat"/>
<c:if test="${not empty site.googlefont}">
    <c:set var="ggfont" value="${site.googlefont}"/>
</c:if>
<c:set var="siteColor" value="#0ba4ff"/>
<c:if test="${not empty site.color}">
    <c:set var="siteColor" value="${site.color}"/>
</c:if>
<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
</c:if>
<c:set var="sitePrimaryColor" value="${siteColor}"/>
<c:if test="${not empty siteStyle.primaryColor}">
    <c:set var="sitePrimaryColor" value="${siteStyle.primaryColor}"/>
</c:if>
<c:set var="sitePrimaryGradientColor" value="${siteColor}"/>
<c:if test="${not empty siteStyle.primaryGradientColor}">
    <c:set var="sitePrimaryGradientColor" value="${siteStyle.primaryGradientColor}"/>
</c:if>
<c:set var="siteHeaderColor" value="${siteColor}"/>
<c:if test="${not empty site.hcolor}">
    <c:set var="siteHeaderColor" value="${site.hcolor}"/>
</c:if>
<c:set var="siteFooterColor" value="${siteColor}"/>
<c:if test="${not empty site.fcolor}">
    <c:set var="siteFooterColor" value="${site.fcolor}"/>
</c:if>
<c:set var="siteHeaderTextColor" value="#000"/>
<c:if test="${not empty siteStyle.headerTextColor}">
    <c:set var="siteHeaderTextColor" value="${siteStyle.headerTextColor}"/>
</c:if>
<c:set var="siteFooterTextColor" value="#000"/>
<c:if test="${not empty siteStyle.footerTextColor}">
    <c:set var="siteFooterTextColor" value="${siteStyle.footerTextColor}"/>
</c:if>
<c:set var="siteBodyTextColor" value="#000"/>
<c:if test="${not empty siteStyle.bodyTextColor}">
    <c:set var="siteBodyTextColor" value="${siteStyle.bodyTextColor}"/>
</c:if>
<c:set var="headerid" value="header_jcontent_${site.siteid}"/>
<c:set var="headerGfont" value="${ggfont}"/>
<c:set var="headerTxtColor" value="#ffffff"/>
<c:set var="headerBgColor" value="${siteColor}"/>
<c:set var="headerBgGradientColor" value="${siteColor}"/>
<c:set var="topHeaderTxtColor" value="#ffffff"/>
<c:set var="topHeaderBgColor" value="${siteColor}"/>
<c:if test="${applicationScope[headerid] != null}">
    <c:set var="bmenu" value="${applicationScope[headerid].localmenu}"/>
    <c:if test="${lang eq 'en'}">
        <c:set var="bmenu" value="${applicationScope[headerid].menu}"/>
    </c:if>
    <c:set var="headerGfont" value="${bmenu.fontFamily}"/>
    <c:set var="headerBgColor" value="${bmenu.bgColor}"/>
    <c:set var="headerBgGradientColor" value="${bmenu.bgGradientColor}"/>
    <c:set var="headerTxtColor" value="${bmenu.txtColor}"/>
    <c:set var="topHeaderBgColor" value="${bmenu.bgColorTop}"/>
    <c:set var="topHeaderTxtColor" value="${bmenu.txtColorTop}"/>
</c:if>
<c:set var="version" value="1.0.23"/>
<!doctype html>
<html style="--main-bg-color: ${siteColor};--main-font-family:${ggfont}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Travel Enet set up travel eco system by integrating multi marketplaces, connect supplier, hotel, activities operator, transportation, cruise liner, dmc, travel agency, tour operator in a single platform (eco system) where roles are different, aim to help travel agency to maintain their loyal clients and grow revenue">
    <meta name="author" content="Le Hung Ban">
    <title>Travel Enet Technologies</title>
    <link href="https://fonts.googleapis.com/css?family=${headerGfont}:400,600,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=${ggfont}:wght@200;300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/themes/agent/bs-icons/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet.min.css?v=${version}" />
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet-ext.min.css?v=${version}" />
    <link href="/themes/mega/css/admin.css?v=${version}" rel="stylesheet">
    <c:forEach var="css" items="${stylesheets}">
        <link rel="stylesheet" type="text/css" href="<c:url value="${css}?v=${version}"/>">
    </c:forEach>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <style>
        :root {
            --main-header-bg-color: ${headerBgColor};
            --main-header-bg-gradient-color: ${headerBgGradientColor};
            --main-header-txt-color: ${headerTxtColor};
            --main-header-font-family:${headerGfont};
            --main-top-header-bg-color: ${topHeaderBgColor};
            --main-top-header-txt-color: ${topHeaderTxtColor};
            --primary-color: ${sitePrimaryColor};
            --primary-gradient-color: ${sitePrimaryGradientColor};
            --secondary-color: #ff901f;
            --secondary-gradient-color: #ff4704;
            --main-bg-color: ${siteColor};
            --main-footer-bg-color: ${siteFooterColor};
            --main-footer-txt-color: ${siteFooterTextColor};
            --main-body-txt-color: ${siteBodyTextColor};
            --main-font-family:${ggfont};
            --x-body-font-family:${ggfont};
            --x-primary-rgb:${sitePrimaryColor};
            --x-body-color:${siteBodyTextColor};
        }
    </style>

    <c:if test="${not empty site.banner1 && fn:endsWith(site.banner1, 'css')}">
        <link rel="stylesheet" type="text/css" href="${site.banner1}?v=${version}">
    </c:if>
</head>
<body>
<tiles:insertAttribute name="content"/>
<script src="/themes/mega/js/bootstrap.min.js"></script>
<!-- this page specific inline scripts -->
<c:forEach var="script" items="${javascripts}">
    <script src="<c:url value="${script}?v=${version}"/>"></script>
</c:forEach>

<script src="/themes/agent/js/bootstrap.bundle.min.js"></script>
<script src="/themes/mega/js/design/design.js?v=${version}"></script>
<script src="/themes/grayscale/js/lp.js?v=${version}"></script>

</body>
</html>
