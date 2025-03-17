<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="/themes/grayscale/css/blog.css" />
<c:set var="desUrl" value="/blog/${blog.urlname}"/>
<div class="" data-offset-top="#header-main">

</div>
<section class="slice bg-light">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/"> <ftm:message key="title.home_page"/> </a></li>
                        <li class="breadcrumb-item"><a href="/blog"> <ftm:message key="title.blog"/> </a></li>
                        <li class="breadcrumb-item active" aria-current="page"> ${blog.title} </li>
                    </ol>
                </nav>
                <main>
                    <article class="mg-post">
                        <header>
                            <h1 class="mg-post-title"><a href="${desUrl}" rel="bookmark">${blog.title}</a></h1>
                            <div class="mg-post-meta">
                                <span><a href="javascript:void(0)"><ftm:formatDate value="${blog.modifiedDate}" type="both"/></a></span>
                                <%--<span>by <a href="#">Admin</a></span>--%>
                                <c:if test="${not empty comments}">
                                    <span><a href="#">${blog.numOfComment} <ftm:message key="title.comments"/></a></span>
                                </c:if>
                                <span class="blog-share-to-facebook"><a href="https://www.facebook.com/sharer/sharer.php?u=https://${site.domain}${desUrl}&title=${blog.title}" target="_blank"><i class="bi bi-facebook" aria-hidden="true"></i></a></span>
                                <span class="blog-share-to-twitter"><a href="https://twitter.com/intent/tweet?hashtags=${site.domain}&url=https://${site.domain}${desUrl}&text=${blog.title}" target="_blank"><i class="bi bi-twitter" aria-hidden="true"></i></a></span>
                                <span class="blog-share-to-whatapp"><a href="https://api.whatsapp.com/send?text=https://${site.domain}${desUrl}" target="_blank"><i class="bi bi-whatsapp" aria-hidden="true"></i></a></span>
                            </div>
                        </header>
                        <div id="blog-toc"></div>
                        <div class="blog-content">
                            <p>${blog.content}</p>
                        </div>
                        <footer class="clearfix">
                            <div class="mg-single-post-tags tagcloud">
                                <c:forEach items="${keywords}" var="keyword">
                                    <a href="javascript:void(0)" onclick="blogSearch('${keyword}')">${keyword}</a>
                                </c:forEach>
                            </div>
                        </footer>
                    </article>
                </main>
                <div class="mt-3">

                </div>
                <c:if test="${not empty comments}">
                    <div class="mg-single-comments-list">
                        <h2 class="mg-sec-left-title mb-4">${blog.numOfComment} Responses</h2>
                        <c:forEach items="${comments}" var="comment">

                            <div class="mb-3">
                                <div class="media media-comment">
                                    <img alt="Blog comment" class="rounded-circle shadow me-4" src="/themes/mega/images/comment.png" >
                                    <div class="media-body">
                                        <div class="media-comment-bubble left-top">
                                            <h6 class="mt-0">${comment.reviewby}</h6>
                                            <p class="mt-0">${comment.createddate}</p>
                                            <p class="text-sm lh-160">${comment.comment}</p>
                                            <div class="icon-actions">
                                                <a href="#" onclick="replyComment(${comment.blogcommentid});">
                                                    <i class="bi bi-reply"></i>
                                                    <span class="text-muted">Reply</span>
                                                </a>
                                            </div>
                                        </div>


                                        <c:if test="${not empty subcommentMap[comment.blogcommentid]}">
                                            <c:forEach var="subcomment" items="${subcommentMap[comment.blogcommentid]}">
                                                <div class="media media-comment">
                                                    <img alt="Blog comment reply" class="rounded-circle shadow me-4" src="/themes/mega/images/comment.png" >
                                                    <div class="media-body">
                                                        <div class="media-comment-bubble left-top">
                                                            <h6 class="mt-0">${subcomment.reviewby}</h6>
                                                            <p class="mt-0">${subcomment.createddate}</p>
                                                            <p class="text-sm lh-160">${subcomment.comment}</p>
                                                            <div class="icon-actions">
                                                                <a href="#" onclick="replyComment(${subcomment.blogcommentid});">
                                                                    <i class="bi bi-reply"></i>
                                                                    <span class="text-muted">Reply</span>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>



                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                    </div>
                </c:if>
                <div id="replyForm" class="d-none">
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
                        <h3 class="mg-widget-title"><ftm:message key="label.current.promo"/></h3>
                        <ul>
                            <c:if test="${not empty products}">
                                <c:forEach var="h" items="${products}">
                                    <li><a href="/${h.code}.html">${h.name}</a></li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </aside>
                    <aside class="mg-widget">
                        <h3 class="mg-widget-title"><ftm:message key="label.recent.posts"/></h3>
                        <ul class="mg-recnt-posts">
                            <c:forEach var="blog" items="${topBlogs}" varStatus="loop">
                                <li>
                                    <div class="mg-recnt-post d-inline-block w-100">
                                        <div class="mg-rp-date"><ftm:formatDate pattern="dd"
                                                                                value="${blog.modifiedDate}"/>
                                            <div class="mg-rp-month"><ftm:formatDate pattern="MMM"
                                                                                     value="${blog.modifiedDate}"/></div>
                                        </div>
                                        <p class="h3"><a class="line-2" href="/blog/${blog.urlname}"
                                                         title="${blog.title}">${blog.title}</a></p>
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
                                <a href="javascript:void(0)" onclick="blogSearch('${keyword}')">${keyword}</a>
                            </c:forEach>
                        </div>
                    </aside>
                </div>
            </div>
        </div>
    </div>
</section>

