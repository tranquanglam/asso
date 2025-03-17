<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html>
<head>
    <title><fmt:message key="404.title"/></title>
    <style>
        body {
            background: #282828;
        }
        .content {
            max-width: 600px;
            margin-top: 20%;
            margin-left: auto;
            margin-right: auto;
            background: white;
            padding: 40px;
            border: solid 2px #ff901f;
            border-radius: 40px;
        }
    </style>
</head>
<body>
<div class="content">
    <h1><fmt:message key="404.title"/></h1>
    <div>
        <fmt:message key="404.message">
            <fmt:param>#</fmt:param>
        </fmt:message>
    </div>
</div>
</body>
</html>