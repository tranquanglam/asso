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
    <title>Admin <tiles:insertAttribute name="title" ignore="true"/></title>
    <link href="https://fonts.googleapis.com/css2?family=${ggfont}:wght@200;300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />
    <link href="/themes/mega/css/bootstrap.min.css" rel="stylesheet">
    <link href="/themes/mega/css/admin.css?v=1.00" rel="stylesheet">
    <link href="/themes/mega/css/select2.min.css" rel="stylesheet">
    <link href="/themes/mega/css/select2-bootstrap.css" rel="stylesheet">
    <c:forEach var="css" items="${stylesheets}">
        <link rel="stylesheet" type="text/css" href="<c:url value="${css}"/>">
    </c:forEach>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<header class="mb-4">
    <nav class="navbar navbar-expand-sm bg-dark navbar-dark pt-2 pb-2">
        <a class="navbar-brand" href="/admin/user/list.html">Users</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="/admin/sites">Sites</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/destination/countries.html">Countries</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/currencies">Currencies</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/units">Units</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/migration/migrationForm.html">Migration</a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0" action="/admin/sites">
                <input class="form-control mr-sm-2 top-form-search-q"  name="q" type="search" placeholder="Search" aria-label="Search" value="${param.q}">
                <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </nav>
</header>
<main role="main">
    <tiles:insertAttribute name="content"/>
</main>

<footer class="template-footer text-center">
    <p>&copy; 2020 travelenet.com. All rights reserved.</p>
</footer>
<script src="/themes/mega/js/bootstrap.min.js"></script>
<script src="/themes/mega/js/bootbox.min.js"></script>
<script src="/themes/mega/js/popper.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/select2.min.js"></script>
<!-- this page specific inline scripts -->
<c:forEach var="script" items="${javascripts}">
    <script src="<c:url value="${script}"/>"></script>
</c:forEach>
</body>
</html>