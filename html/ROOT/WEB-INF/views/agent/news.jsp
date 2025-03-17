<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page">News</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-10">
            <h2>News</h2>
        </div>
        <div class="col-2 text-end">
            <a class="btn btn-primary" href="/agent/news/notification">Notification</a>
        </div>
    </div>
    <div class="row my-4">
        <div class="col-12">
            <div class="card bg-dark text-white my-3">
                <div class="card-body">
                    <form id="myForm" class="form-inline pull-right" action="/agent/news" method="get">
                        <div class="row">
                            <div class="form-group col-md">
                                <select name="lan"  class="form-control">
                                    <c:forEach items="${langs}" var="lang">
                                        <option value="${lang}" ${lang eq lan ? 'selected' : ''}>${lang}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group col-md">
                                <input  name="q" maxlength="64" class="form-control" value="${q}"/>
                            </div>
                            <div class="form-group col-md">
                                <button type="submit" class="btn btn-info"><span><i class="bi bi-search"></i> Search</span></button>
                            </div>
                            <div class="form-group col-md text-end">
                                <a href="${pageContext.request.contextPath}/agent/news/add?lan=${lan}" class="btn btn-primary"><i class="fa fa-plus" aria-hidden="true"></i>Add News</a>
                            </div>
                        </div>
                        <input type="hidden" name="page" id="formPage" value="${page}">
                    </form>
                </div>
            </div>
        </div>
        <div class="col-12">
            <div class="main-box">
                <div class="main-box-body clearfix">
                <c:if test="${not empty news}">
                <table class="table table-bordered table-hover">
                    <tr class="info">
                        <th>Title (English)</th>
                        <th>Url</th>
                        <th>Tên Tiếng Việt</th>
                        <th>Nome</th>
                        <th>Date</th>
                        <th></th>
                    </tr>
                    <c:forEach var="news" items="${news}">
                        <tr>
                            <td><a href="${pageContext.request.contextPath}/agent/news/update/${news.newsId}">${news.title}</a></td>
                            <td>${news.urlname}</td>
                            <td><a href="${pageContext.request.contextPath}/agent/news/update/${news.newsId}?l=vi">${news.titlevn}</a></td>
                            <td><a href="${pageContext.request.contextPath}/agent/news/update/${news.newsId}?l=it">${news.titleit}</a></td>
                            <td>${news.createdDate}</td>
                            <td class="text-center">
                                <a class="btn btn-danger btn-xs" href="javascript:deleteNews('${news.newsId}', '${news.title}');"><i class="fa fa-times" aria-hidden="true"></i> Delete</a>
                                | <a class="btn btn-secondary btn-xs" href="/agent/news/comments?newsid=${news.newsId}">Comments</a>
                                | <a class="btn btn-secondary btn-xs" href="/agent/sites/${site.siteid}/blog_${news.newsId}/album.html">Album</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                </c:if>


                <div>
                    <div class="after-loop text-center">
                        <div class="pagination pager pages">
                            <ul class="page-numbers">
                                <c:forEach begin="1" end="${endPage}" varStatus="loop">
                                    <li><a ${page eq loop.count?'class="active"':'class="page-numbers"'} href="/agent/news?page=${loop.count}">${loop.count}</a></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                </div>
            </div>
        </div>
    </div>
</div>
<form id="delete-form" action="${pageContext.request.contextPath}/agent/news/delete" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="newsid" id="delete-id"  />
</form>

<script>
    function deleteNews(newsid, title) {
        var rs = confirm('Delete blog "' + title + '"?');
        if (rs && rs == true) {
            $("#delete-id").val(newsid);
            $("#delete-form").submit();
        }
    }
</script>

