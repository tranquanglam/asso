<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/common/taglibs.jsp"%>
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
<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
</c:if>
<c:set var="sitePrimaryColor" value="${siteColor}"/>
<c:if test="${not empty siteStyle.primaryColor}">
    <c:set var="sitePrimaryColor" value="${siteStyle.primaryColor}"/>
</c:if>
<c:set var="siteSecondaryColor" value="#ff901f"/>
<c:if test="${not empty siteStyle.secondaryColor}">
    <c:set var="siteSecondaryColor" value="${siteStyle.secondaryColor}"/>
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
<c:if test="${not empty siteStyle.googleFont2}">
    <c:set var="googleFont2" value="${siteStyle.googleFont2}"/>
</c:if>
<c:set var="headerid" value="header_jcontent_${site.siteid}"/>
<c:set var="footerPluginId" value="footer_plugin_${site.siteid}"/>
<c:set var="siteSchemaId" value="schema_${site.siteid}"/>
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
<c:if test="${applicationScope[footerPluginId] != null}">
    <c:set var="footerPlugin" value="${applicationScope[footerPluginId]}"/>
</c:if>

<c:if test="${applicationScope[siteSchemaId] != null}">
    <c:set var="siteSchema" value="${applicationScope[siteSchemaId].content}"/>
</c:if>
<c:set var="version" value="1.0.31"/>
<c:set var="domainPath" value="http://${site.domain}"/>
<c:if test="${not empty site.scheme}">
    <c:set var="domainPath" value="${site.scheme}://${site.domain}"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><tiles:insertAttribute name="title" ignore="true"/></title>
    <link type="image/x-icon" href="${site.favicon}" rel="shortcut icon"/>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:300,400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/themes/agent/bs-icons/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet.min.css?v=${version}" />
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet-ext.min.css?v=${version}" />
    <link rel="stylesheet" type="text/css" href="/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap-datepicker3.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/booking.css" />
    <script src="/themes/mega/js/jquery-3.3.1.min.js"></script>

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
            --secondary-color: ${siteSecondaryColor};
            --secondary-gradient-color: #ff4704;
            --main-bg-color: ${siteColor};
            --main-footer-bg-color: ${siteFooterColor};
            --main-footer-txt-color: ${siteFooterTextColor};
            --main-body-txt-color: ${siteBodyTextColor};
            --main-font-family:${ggfont};
            --x-body-font-family:${ggfont};
            --x-body-color:${siteBodyTextColor};
            --secondary-font-family: ${googleFont2};
        }
    </style>

</head>
<body>
<tiles:insertAttribute name="header"/>

<div class="container-fluid">
    <div class="row flex-xl-nowrap">
        <main class="col-12 " role="main">
            <div class="main-content">
                <tiles:insertAttribute name="content"/>
            </div>
        </main>
    </div>
</div>
</body>

<script src="/themes/agent/js/bootbox.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/booking.js"></script>
</html>
