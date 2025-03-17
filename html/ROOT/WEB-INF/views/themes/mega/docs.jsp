<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="container-fluid">
    <div class="row flex-xl-nowrap">
        <div class="col-12 col-md-2 bd-sidebar pl-0 pr-0">
            <c:forEach var="page" items="${pages}" varStatus="theCount">
                <div class="border-bottom pt-3 pb-3 pl-3 pr-3 font-weight-bold text-primary">
                    <a href="#" data-nameurl="${page.nameurl}" class="page-nameurl">
                        <c:if test="${not empty page.image}">
                            <img src="${page.image}" alt="${page.name}" height="100">
                        </c:if>
                        ${page.name}
                    </a>
                </div>
            </c:forEach>
        </div>
        <main class="col-12 col-md-10 main-container" role="main">
            <div class="main-content">

            </div>
        </main>
    </div>
</div>
