<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="desUrl" value="/blog/${blog.urlname}"/>
<div class="mg-blog-list">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <main>
                    <article class="mg-post">
                        <header>
                            <h1 class="mg-post-title"><a href="${desUrl}" rel="bookmark">${blog.title}</a></h1>
                            <div class="mg-post-meta">
                                <span><a href="#"><ftm:formatDate value="${blog.modifiedDate}" type="both"/></a></span>
                                <span>by <a href="#">Admin</a></span>
                                <span><a href="#">${blog.numOfComment} <ftm:message key="title.comments"/></a></span>
                                <span><a href="https://www.facebook.com/sharer/sharer.php?u=https://${site.domain}${desUrl}&title=${blog.title}" target="_blank"><i class="fa fa-2x fa-facebook-square" aria-hidden="true"></i></a></span>
                                <span><a href="https://twitter.com/intent/tweet?hashtags=${site.domain}&url=https://${site.domain}${desUrl}&text=${blog.title}" target="_blank"><i class="fa fa-2x fa-twitter-square" aria-hidden="true"></i></a></span>
                            </div>
                        </header>
                        <div class="blog-content">
                            <p>${blog.content}</p>
                        </div>
                        <footer class="clearfix">
                            <div class="mg-single-post-tags tagcloud">
                                <c:forEach items="${keywords}" var="keyword">
                                    <a href="#" onclick="blogSearch('${keyword}')">${keyword}</a>
                                </c:forEach>
                            </div>
                        </footer>
                    </article>
                </main>
                <div class="clearfix mg-post-nav">
                    <div class="pull-left">
                        <a href="#"><i class="fa fa-angle-left"></i> Previous</a>
                    </div>
                    <div class="pull-right">
                        <a href="#">Next <i class="fa fa-angle-right"></i></a>
                    </div>
                </div>
                <c:if test="${not empty comments}">
                    <div class="mg-single-comments-list">
                        <h2 class="mg-sec-left-title">${blog.numOfComment} Responses</h2>
                        <c:forEach items="${comments}" var="comment">
                            <div class="media">
                                <div class="media-left">
                                    <a href="#">
                                        <img class="media-object" src="/themes/mega/images/comment.png" alt="">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <div class="mg-comment-body">
                                        <h4 class="media-heading"><a href="#">${comment.reviewby}</a></h4>
                                        <span><a href="#">${comment.createddate}</a></span>
                                        <p>${comment.comment}</p>
                                        <a href="#" onclick="replyComment(${comment.blogcommentid});" class="btn btn-default btn-comment-reply">Reply</a>
                                    </div>
                                    <c:if test="${not empty subcommentMap[comment.blogcommentid]}">
                                        <c:forEach var="subcomment" items="${subcommentMap[comment.blogcommentid]}">
                                            <div class="media">
                                                <div class="media-left">
                                                    <a href="#">
                                                        <img class="media-object" src="/themes/mega/images/comment2.png" alt="">
                                                    </a>
                                                </div>
                                                <div class="media-body">
                                                    <div class="mg-comment-body">
                                                        <h4 class="media-heading"><a href="#">${subcomment.reviewby}</a></h4>
                                                        <span><a href="#">${subcomment.createddate}</a></span>
                                                        <p>${subcomment.comment}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <div id="replyForm">
                    <h2 class="mg-sec-left-title">Leave a Reply</h2>
                    <form action="/blog/${blog.urlname}" method="post">
                        <input type="hidden" name="parentid" id="parentid" value="0">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" class="form-control" maxlength="255">
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" class="form-control" maxlength="255">
                        </div>
                        <div class="form-group">
                            <label>Comment</label>
                            <textarea name="comment" class="form-control" rows="7"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Score</label>
                            <input name="score" type="number" value="5" min="0" max="5" class="form-control" value="5"/>
                        </div>
                        <input type="submit" value="Post Comment" class="btn btn-primary mt-3">
                    </form>
                </div>
            </div>
            <div class="col-md-4">
                <div class="mg-widget-area">
                    <aside class="mg-widget">
                        <h2 class="mg-widget-title">CURRENT PROMO</h2>
                        <ul>
                            <c:if test="${not empty products}">
                                <c:forEach var="h" items="${products}">
                                    <li><a href="/${h.code}.html">${h.name}</a></li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </aside>
                    <aside class="mg-widget">
                        <h2 class="mg-widget-title">Recent Posts</h2>
                        <ul class="mg-recnt-posts">
                            <c:forEach var="tb" items="${topBlogs}" varStatus="loop">
                                <li>
                                    <div class="mg-recnt-post">
                                        <div class="mg-rp-date"><ftm:formatDate pattern="dd" value="${tb.createdDate}"/><div class="mg-rp-month"><ftm:formatDate pattern="MMM" value="${tb.createdDate}"/></div></div>
                                        <h3><a class="line-2" href="/blog/${tb.urlname}" title="${tb.title}">${tb.title}</a></h3>
                                        <p>${tb.shortDescription60}...</p>
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
