<%@ include file="/common/taglibs.jsp" %>
<c:set var="lang" value="en"/>
<c:if test="${not empty sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}">
    <c:set var="lang" value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}"/>
    <c:set var="lang" value="${fn:substring(lang, 0, 2)}"/>
</c:if>
<c:set var="ggfont" value="Montserrat"/>
<c:if test="${not empty site.googlefont}">
    <c:set var="ggfont" value="${site.googlefont}"/>
</c:if>
<c:set var="siteColor" value="#0ba4ff"/>
<c:if test="${not empty site.color}">
    <c:set var="siteColor" value="${site.color}"/>
</c:if>
<c:set var="siteHeaderColor" value="${siteColor}"/>
<c:if test="${not empty site.hcolor}">
    <c:set var="siteHeaderColor" value="${site.hcolor}"/>
</c:if>
<c:set var="siteFooterColor" value="${siteColor}"/>
<c:if test="${not empty site.fcolor}">
    <c:set var="siteFooterColor" value="${site.fcolor}"/>
</c:if>
<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
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
<!doctype html>
<html lang="${lang}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="${page.name} - ${site.title}">
    <meta name="author" content="Le Hung Ban">
    <title>${page.name}</title>
    <link href="https://fonts.googleapis.com/css2?family=${ggfont}:wght@200;300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/themes/agent/bs-icons/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet-ext.min.css" />
    <style>
        :root {
            --main-header-bg-color: ${headerBgColor};
            --main-header-bg-gradient-color: ${headerBgGradientColor};
            --main-header-txt-color: ${headerTxtColor};
            --main-header-font-family:${headerGfont};
            --primary-color: ${siteColor};
            --primary-gradient-color: ${siteHeaderColor};
            --secondary-color: #ff901f;
            --secondary-gradient-color: #ff4704;
            --main-bg-color: ${siteColor};
            --main-footer-bg-color: ${siteFooterColor};
            --main-footer-txt-color: ${siteFooterTextColor};
            --main-body-txt-color: ${siteBodyTextColor};
            --main-font-family:${ggfont};
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="container">
    <div class="col-12 pt-8">
        <div class="sform-container" data-code="${code}"></div>
    </div>
</div>
<script src="/themes/agent/js/bootstrap.bundle.min.js"></script>
<script src="/themes/grayscale/js/lp.js"></script>
</body>
</html>
