<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/news">News</a></li>
                    <li class="breadcrumb-item active" aria-current="page"><fmt:message key="menu.title.news_comments"/></li>
                </ol>
            </nav>
        </div>
    </div>

<div class="row">
    <div class="col-lg-12">
        <h1><fmt:message key="menu.title.news_comments"/></h1>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <table id="news_comments_table" class="table table-hover">
            <thead>
            <tr>
                <th class="col-sm-2">News ID</th>
                <th class="col-sm-3">content</th>
                <th class="col-sm-2">review by</th>
                <th class="col-sm-1">score</th>
                <th class="col-sm-1"># likes</th>
                <th class="col-sm-1"># dislikes</th>
                <th class="col-sm-1">visible</th>
                <th class="col-sm-1"></th>
            </tr>
            </thead>
        </table>
        <form class="d-none" id="commentFilterForm">
            <c:if test="${not empty param.newsid}">
                <input type="hidden" name="newsid" value="${param.newsid}">
            </c:if>
        </form>
    </div>
</div>
</div>