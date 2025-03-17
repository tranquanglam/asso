<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/common/taglibs.jsp"%>
<tiles:importAttribute name="stylesheets"/>
<tiles:importAttribute name="javascripts"/>
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
<c:if test="${applicationScope[headerid] != null}">
    <c:set var="bmenu" value="${applicationScope[headerid].localmenu}"/>
    <c:if test="${lang eq 'en'}">
        <c:set var="bmenu" value="${applicationScope[headerid].menu}"/>
    </c:if>
    <c:set var="headerGfont" value="${bmenu.fontFamily}"/>
    <c:set var="headerBgColor" value="${bmenu.bgColor}"/>
    <c:set var="headerBgGradientColor" value="${bmenu.bgGradientColor}"/>
    <c:set var="headerTxtColor" value="${bmenu.txtColor}"/>
</c:if>

<!DOCTYPE html>
<html lang="${lang}">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta property="og:url"           content="https://${site.domain}${requestScope['javax.servlet.forward.request_uri']}" />
    <meta property="og:type"          content="website" />
    <meta property="og:title"         content="<tiles:insertAttribute name="title" ignore="true"/>" />
    <meta property="og:description"   content="<tiles:insertAttribute name="description" ignore="true"/>" />
    <c:choose>
        <c:when test="${not empty blog}">
            <meta property="og:image"         content="${applicationScope['hostmedia']}${blog.image1}" />
        </c:when>
        <c:otherwise>
            <meta property="og:image" content="${applicationScope['hostmedia']}${site.desktopLogo}"/>
        </c:otherwise>
    </c:choose>
    <meta name="description" content="<tiles:insertAttribute name="description" ignore="true"/>">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="theme-color" content="#ffffff">
    <title><tiles:insertAttribute name="title" ignore="true"/></title>
    <link type="image/x-icon" href="${applicationScope['hostmedia']}${site.favicon}" rel="shortcut icon"/>
    <link href="https://fonts.googleapis.com/css?family=${headerGfont}:400,600,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=${ggfont}:wght@200;300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css" integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/purpose.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/mem.css" />
    <c:if test="${not empty stylesheets}">
        <c:forEach var="css" items="${stylesheets}">
            <link rel="stylesheet" type="text/css" href="${css}">
        </c:forEach>
    </c:if>
    <c:if test="${not empty site.banner1 && fn:endsWith(site.banner1, 'css')}">
        <link rel="stylesheet" href="${site.banner1}">
    </c:if>
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
    <script type="application/ld+json">
    {
      "@context" : "http://schema.org",
      "@type" : "Organization",
      "name" : "${site.name}",
      "url" : "https://${site.domain}",
      "sameAs" : [
        "${site.twitter}",
        "${site.facebook}"
        ]
    }
    </script>
    <c:if test="${not empty site.googletagmanager}">
        <!-- Google Tag Manager -->
        <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','${site.googletagmanager}');</script>
        <!-- End Google Tag Manager -->
    </c:if>
</head>
<body class="bg-dark bg-noise">
<c:if test="${not empty site.googletagmanager}">
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=${site.googletagmanager}"
                      height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->
</c:if>
<tiles:insertAttribute name="header"/>
<div class="main-content">
    <tiles:insertAttribute name="content"/>
</div>
<tiles:insertAttribute name="footer"/>
<div class="d-none" id="site-logo-img">${site.desktopLogo}</div>
<c:if test="${not empty site.zendesk}">
    <c:set var="widget" value="widget"/>
    <c:set var="access_token" value="${site.zendesk}"/>
    <security:authorize access="isAuthenticated()">
        <c:set var="access_token" value="${userInfo.access_token}"/>
    </security:authorize>
    <div class="d-none">
        <div class="access_token">${access_token}</div>
        <div class="serverpath"></div>
    </div>

</c:if>
</body>
<script type="text/javascript" src="/themes/grayscale/js/purpose.core.js"></script>
<script type="text/javascript" src="/themes/grayscale/js/layout.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/order-1.0.min.js"></script>
<c:if test="${not empty javascripts}">
    <c:forEach var="script" items="${javascripts}">
        <script type="text/javascript" src="<c:url value="${script}"/>"></script>
    </c:forEach>
</c:if>
<c:if test="${not empty site.googleanalytics}">
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

        ga('create', '${site.googleanalytics}', 'auto');
        ga('send', 'pageview');
    </script>
</c:if>
<c:if test="${not empty site.phone}">
    <div class="hotline-phone-ring-wrap">
        <div class="hotline-phone-ring">
            <div class="hotline-phone-ring-circle"></div>
            <div class="hotline-phone-ring-circle-fill"></div>
            <div class="hotline-phone-ring-img-circle"> <a href="tel:${site.phone}" class="pps-btn-img"> <img src="/themes/mega/images/ic_phone.png" alt="so dien thoai" width="50"> </a></div>
        </div>
        <div class="hotline-bar">
            <a href="tel:${site.phone}"> <span class="text-hotline">${site.phone}</span> </a>
        </div>

    </div>
</c:if>
<c:choose>
    <c:when test="${empty sessionScope['AUTHENTICATION_METHOD']}">
        <script>
            function logout() {
                document.getElementById('logout').submit();
            }
        </script>
    </c:when>
    <c:when test="${sessionScope['AUTHENTICATION_METHOD'] eq 'GG'}">
        <c:set var="googleConfig" value="googleConfig_${site.siteid}"/>
        <meta name="google-signin-client_id" content="${applicationScope[googleConfig].oauth.appId}">
        <script src="https://apis.google.com/js/platform.js?onload=initGG" async defer></script>
        <script>
            function initGG() {
                gapi.load('auth2', function() {
                    gapi.auth2.init({
                        clientId: "${applicationScope[googleConfig].oauth.appId}"
                    });
                });
            }
            function logout() {
                var auth2 = gapi.auth2.getAuthInstance();
                auth2.signOut().then(function () {
                    document.getElementById('logout').submit();
                });
            }
        </script>
    </c:when>
    <c:when test="${sessionScope['AUTHENTICATION_METHOD'] eq 'FB'}">
        <script>
            function logout() {
                document.getElementById('logout').submit();
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            function logout() {
                document.getElementById('logout').submit();
            }
        </script>
    </c:otherwise>
</c:choose>
</html>
