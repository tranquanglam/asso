<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="emptybanner hidden-xs">

</div>

<div class="mg-blog-list">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <main>
                    <c:forEach var="blog" items="${blogs}" varStatus="loop">
                    <article class="mg-post">
                        <header>
                            <h2 class="mg-post-title"><a href="/blog/${blog.urlname}" rel="bookmark">${blog.title}</a></h2>
                            <div class="mg-post-meta">
                                <span><a href="#"><ftm:formatDate value="${blog.modifiedDate}" type="both"/></a></span>
                                <span>by <a href="#">Admin</a></span>
                                <span><a href="#">${blog.numOfComment} <ftm:message key="title.comments"/></a></span>
                            </div>
                        </header>
                        <div>
                            <p>${blog.shortDescription300}</p>
                        </div>
                        <footer class="clearfix">
                            <a href="/blog/${blog.urlname}" class="mg-read-more"><ftm:message key="title.readmore"/> <i class="fa fa-long-arrow-right"></i></a>
                        </footer>
                    </article>
                    </c:forEach>
                </main>
            </div>
            <div class="col-md-4">
                <div class="mg-widget-area">
                    <aside class="mg-widget">
                        <h2 class="mg-widget-title">CURRENT PROMO</h2>
                        <ul>
                            <c:if test="${not empty tevents}">
                                <c:forEach var="tevent" items="${tevents}">
                                    <li><a href="/${tevent.urlname}/tevent/detail.html">${tevent.name}</a></li>
                                </c:forEach>
                            </c:if>
                            <c:if test="${not empty hotels}">
                                <c:forEach var="h" items="${hotels}">
                                    <li><a href="/${h.urlname}/hotel/detail.html">${h.name}</a></li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </aside>
                    <aside class="mg-widget">
                        <h2 class="mg-widget-title">Recent Posts</h2>
                        <ul class="mg-recnt-posts">
                            <c:forEach var="blog" items="${topBlogs}" varStatus="loop">
                            <li>
                                <div class="mg-recnt-post">
                                    <div class="mg-rp-date"><ftm:formatDate pattern="dd" value="${blog.modifiedDate}"/><div class="mg-rp-month"><ftm:formatDate pattern="MMM" value="${blog.modifiedDate}"/></div></div>
                                    <h3><a class="line-2" href="/blog/${blog.urlname}" title="${blog.title}">${blog.title}</a></h3>
                                    <p>${blog.shortDescription60}...</p>
                                </div>
                            </li>
                            </c:forEach>
                        </ul>
                    </aside>
                    <aside class="mg-widget">
                        <h2 class="mg-widget-title"><ftm:message key="label.tags"/></h2>
                        <div class="tagcloud">
                            <c:forEach items="${keywords}" var="keyword">
                                <a href="#" onclick="blogSearch('${keyword}')">${keyword}</a>
                            </c:forEach>
                        </div>
                    </aside>
                </div>
            </div>
        </div>
    </div>
</div>
