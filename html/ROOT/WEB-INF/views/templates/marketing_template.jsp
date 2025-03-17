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
<c:set var="siteConfigId" value="siteConfig_${site.siteid}"/>
<c:if test="${not empty applicationScope[siteConfigId] && not empty applicationScope[siteConfigId]['google']}">
    <c:set var="siteGoogleConfig" value="${applicationScope[siteConfigId]['google']}"/>
</c:if>
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
    <link rel="stylesheet" href="/themes/agent/bs-icons/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/enet-ext.min.css" />
    <c:if test="${not empty stylesheets}">
        <c:forEach var="css" items="${stylesheets}">
            <link rel="stylesheet" type="text/css" href="${css}">
        </c:forEach>
    </c:if>
    <c:if test="${not empty site.banner1 && fn:endsWith(site.banner1, 'css')}">
        <link rel="stylesheet" href="${site.banner1}">
    </c:if>

    <c:if test="${not empty siteGoogleConfig && not empty siteGoogleConfig.merchantCenterConfig}">
        <c:if test="${not empty siteGoogleConfig.merchantCenterConfig.siteVerificationContent}">
            <meta name="google-site-verification" content="${siteGoogleConfig.merchantCenterConfig.siteVerificationContent}" />
        </c:if>
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

    <!-- Meta Pixel Code -->
    <script>
        !function(f,b,e,v,n,t,s)
        {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
            n.callMethod.apply(n,arguments):n.queue.push(arguments)};
            if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
            n.queue=[];t=b.createElement(e);t.async=!0;
            t.src=v;s=b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t,s)}(window, document,'script',
            'https://connect.facebook.net/en_US/fbevents.js');
        fbq('init', '5122189291161802');
        fbq('track', 'PageView');
    </script>
    <noscript><img height="1" width="1" style="display:none"
                   src="https://www.facebook.com/tr?id=5122189291161802&ev=PageView&noscript=1"
    /></noscript>
    <!-- End Meta Pixel Code -->
</head>
<body>
<div class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
    <!-- Vertical Navbar -->
    <nav class="navbar show navbar-vertical h-lg-screen navbar-expand-lg px-0 py-3 navbar-light bg-white border-bottom border-bottom-lg-0 border-end-lg" id="navbarVertical">
        <div class="container-fluid">
            <!-- Toggler -->
            <button class="navbar-toggler ms-n2" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarCollapse" aria-controls="sidebarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- Brand -->
            <a class="navbar-brand py-lg-2 mb-lg-5 px-lg-6 me-0" href="#">
                <img src="https://preview.webpixels.io/web/img/logos/clever-primary.svg" alt="...">
            </a>
            <!-- User menu (mobile) -->
            <div class="navbar-user d-lg-none">
                <!-- Dropdown -->
                <div class="dropdown">
                    <!-- Toggle -->
                    <a href="#" id="sidebarAvatar" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <div class="avatar-parent-child">
                            <img alt="Image Placeholder" src="https://images.unsplash.com/photo-1548142813-c348350df52b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=3&w=256&h=256&q=80" class="avatar avatar- rounded-circle">
                            <span class="avatar-child avatar-badge bg-success"></span>
                        </div>
                    </a>
                    <!-- Menu -->
                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="sidebarAvatar">
                        <a href="#" class="dropdown-item">Profile</a>
                        <a href="#" class="dropdown-item">Settings</a>
                        <a href="#" class="dropdown-item">Billing</a>
                        <hr class="dropdown-divider">
                        <a href="#" class="dropdown-item">Logout</a>
                    </div>
                </div>
            </div>
            <!-- Collapse -->
            <div class="collapse navbar-collapse" id="sidebarCollapse">
                <!-- Navigation -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-house"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-bar-chart"></i> Analitycs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-chat"></i> Messages
                            <span class="badge bg-soft-primary text-primary rounded-pill d-inline-flex align-items-center ms-auto">6</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-bookmarks"></i> Collections
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-people"></i> Users
                        </a>
                    </li>
                </ul>
                <!-- Divider -->
                <hr class="navbar-divider my-5 opacity-20">
                <!-- Navigation -->
                <ul class="navbar-nav mb-md-4">
                    <li>
                        <div class="nav-link text-xs font-semibold text-uppercase text-muted ls-wide" href="#">
                            Contacts
                            <span class="badge bg-soft-primary text-primary rounded-pill d-inline-flex align-items-center ms-4">13</span>
                        </div>
                    </li>
                    <li>
                        <a href="#" class="nav-link d-flex align-items-center">
                            <div class="me-4">
                                <div class="position-relative d-inline-block text-white">
                                    <img alt="Image Placeholder" src="https://images.unsplash.com/photo-1548142813-c348350df52b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=3&w=256&h=256&q=80" class="avatar rounded-circle">
                                    <span class="position-absolute bottom-2 end-2 transform translate-x-1/2 translate-y-1/2 border-2 border-solid border-current w-3 h-3 bg-success rounded-circle"></span>
                                </div>
                            </div>
                            <div>
                                <span class="d-block text-sm font-semibold">
                                    Marie Claire
                                </span>
                                <span class="d-block text-xs text-muted font-regular">
                                    Paris, FR
                                </span>
                            </div>
                            <div class="ms-auto">
                                <i class="bi bi-chat"></i>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="nav-link d-flex align-items-center">
                            <div class="me-4">
                                <div class="position-relative d-inline-block text-white">
                                    <span class="avatar bg-soft-warning text-warning rounded-circle">JW</span>
                                    <span class="position-absolute bottom-2 end-2 transform translate-x-1/2 translate-y-1/2 border-2 border-solid border-current w-3 h-3 bg-success rounded-circle"></span>
                                </div>
                            </div>
                            <div>
                                <span class="d-block text-sm font-semibold">
                                    Michael Jordan
                                </span>
                                <span class="d-block text-xs text-muted font-regular">
                                    Bucharest, RO
                                </span>
                            </div>
                            <div class="ms-auto">
                                <i class="bi bi-chat"></i>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="nav-link d-flex align-items-center">
                            <div class="me-4">
                                <div class="position-relative d-inline-block text-white">
                                    <img alt="..." src="https://images.unsplash.com/photo-1610899922902-c471ae684eff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=3&w=256&h=256&q=80" class="avatar rounded-circle">
                                    <span class="position-absolute bottom-2 end-2 transform translate-x-1/2 translate-y-1/2 border-2 border-solid border-current w-3 h-3 bg-danger rounded-circle"></span>
                                </div>
                            </div>
                            <div>
                                <span class="d-block text-sm font-semibold">
                                    Heather Wright
                                </span>
                                <span class="d-block text-xs text-muted font-regular">
                                    London, UK
                                </span>
                            </div>
                            <div class="ms-auto">
                                <i class="bi bi-chat"></i>
                            </div>
                        </a>
                    </li>
                </ul>
                <!-- Push content down -->
                <div class="mt-auto"></div>
                <!-- User (md) -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-person-square"></i> Account
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-box-arrow-left"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="h-screen flex-grow-1 overflow-y-lg-auto">
        <tiles:insertAttribute name="content"/>
    </div>


</div>
</body>

<script src="/themes/agent/js/bootstrap.bundle.min.js"></script>
<script src="/themes/grayscale/js/lp.js"></script>
<script type="text/javascript" src="/themes/mega/js/order-1.1.min.js"></script>

<c:if test="${not empty javascripts}">
    <c:forEach var="script" items="${javascripts}">
        <script type="text/javascript" src="<c:url value="${script}"/>"></script>
    </c:forEach>
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


<script>
    window.fbAsyncInit = function() {
        FB.init({
            appId      : '412738923996515',
            cookie     : true,
            xfbml      : true,
            version    : 'v13.0'
        });
        FB.AppEvents.logPageView();
    };
    (function(d, s, id){
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s); js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
</script>
</html>
