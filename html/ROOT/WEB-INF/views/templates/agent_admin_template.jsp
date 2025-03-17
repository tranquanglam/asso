<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/common/taglibs.jsp" %>
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
<!doctype html>
<html style="--main-bg-color: ${siteColor};--main-font-family:${ggfont}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="LMS and CMS platform">
    <meta name="author" content="Le Hung Ban">
    <title>Admin <tiles:insertAttribute name="title" ignore="true"/></title>
    <link href="https://fonts.googleapis.com/css2?family=${ggfont}:wght@200;300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/themes/agent/bs-icons/bootstrap-icons.css">
    <link href="/themes/agent/css/bootstrap.min.css" rel="stylesheet" type="text/css" >
    <link href="/themes/agent/css/datatables.min.css" rel="stylesheet" type="text/css" >
    <link href="/themes/agent/css/admin.css" rel="stylesheet" type="text/css" >
    <c:forEach var="css" items="${stylesheets}">
        <link rel="stylesheet" type="text/css" href="<c:url value="${css}"/>">
    </c:forEach>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<header class="mb-4">
    <nav class="navbar navbar-expand-sm bg-dark navbar-dark pt-2 pb-2 px-4">
        <a class="navbar-brand" href="/"><i class="bi bi-house"></i></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarSiteConfigDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Site UI
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarSiteConfigDropdown">
                        <li><a class="dropdown-item" href="/agent/sites/B2B/settings">Site Settings</a></li>
                        <li><a class="dropdown-item" href="/agent/sites/pages">Pages</a></li>
                        <c:if test="${not empty site}">
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="/agent/sites/${site.siteid}/custom-banner/album.html"><i class="bi bi-image"></i><span class="px-2">Custom Banners</span></a></li>
                            <li><a class="dropdown-item" href="/agent/sites/${site.siteid}/custom-subbanner/album.html"><i class="bi bi-image"></i><span class="px-2">Custom Subbanners</span></a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="/agent/sites/${site.siteid}/banner/album.html"><i class="bi bi-image"></i><span class="px-2">Banners</span></a></li>
                            <li><a class="dropdown-item" href="/agent/sites/${site.siteid}/gallery/album.html"><i class="bi bi-image"></i><span class="px-2">Gallery</span></a></li>
                            <li><a class="dropdown-item" href="/agent/sites/${site.siteid}/partner/album.html"><i class="bi bi-image"></i><span class="px-2">Partners</span></a></li>
                        </c:if>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="/agent/destinations"><i class="bi bi-map"></i> Destinations</a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="/agent/design/header.html">Design  header</a></li>
                        <li><a class="dropdown-item" href="/agent/design/home.html">Design  home</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/dashboard.html">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/agent/settings">Settings</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/agent/categories">Category</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/agent/currency/lastestrates">Currency rates</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/agent/news">News</a>
                </li>
                <c:if test="${fn:contains(site.agent.supplierproducts,'VIEW3D')}">
                <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="catFilesDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            3D files
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="apiDropdown">
                            <li><a class="dropdown-item" href="/view3d/agent/ifc/files.html">IFC files</a></li>
                            <li><a class="dropdown-item" href="/view3d/agent/gltf/files.html">GLTF files</a></li>
                            <li><a class="dropdown-item" href="/view3d/agent/3ds/files.html">3DS files</a></li>
                            <li><a class="dropdown-item" href="/view3d/agent/mtl/files.html">MTL files</a></li>
                        </ul>
                    </li>
                </security:authorize>
                </c:if>
                <c:if test="${fn:contains(site.agent.supplierproducts,'MARKETPLACE')}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="apiDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            API
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="apiDropdown">
                            <li><a class="dropdown-item" href="/agent/apisites">Api sites</a></li>
                            <li><a class="dropdown-item" href="/agent/apiproducts">Api products</a></li>
                        </ul>
                    </li>
                </c:if>
                <security:authorize access="hasAnyAuthority('AGT_ADMIN')">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="usersDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Users management
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="usersDropdown">
                            <li><a class="dropdown-item" href="/agent/users">Users</a></li>
                            <li><a class="dropdown-item" href="/agent/usercategories">Categories # S-Users</a></li>
                            <li><a class="dropdown-item" href="/agent/usercities">Cities # Users</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="customersDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            CRM
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="customersDropdown">
                            <li><a class="dropdown-item" href="/bo/data/leads.html">Leads</a></li>
                            <li><a class="dropdown-item" href="/bo/data/roughdatas.html">Rough data</a></li>
                            <%--<li><a class="dropdown-item" href="/bo/data/materials.html">Materials</a></li>
                            <li><a class="dropdown-item" href="/bo/data/materialinput.html">Materials input</a></li>--%>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/agent/enetstore/products.html">Enet Store</a>
                    </li>
                </security:authorize>
            </ul>

            <form class="d-flex px-3" action="/agent/users">
                <input class="form-control me-2"  name="q" type="search" placeholder="Search" aria-label="Search" value="${param.q}">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
            <div class="d-flex">
                <form id="logout" class="d-none" method="post" action="/j_spring_security_logout">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <a href="#" onclick="document.getElementById('logout').submit();" class="btn btn-outline-secondary"><i class="bi bi-power"></i></a>
            </div>
        </div>
    </nav>
</header>
<main role="main">
    <tiles:insertAttribute name="content"/>
</main>
</body>
<script src="/themes/agent/js/bootstrap.bundle.min.js"></script>
<script src="/themes/agent/js/datatables.min.js"></script>
<script src="/themes/agent/js/bootbox.min.js"></script>
<script src="/themes/agent/js/admin.min.js"></script>
<c:forEach var="script" items="${javascripts}">
    <script src="<c:url value="${script}"/>"></script>
</c:forEach>
</html>
