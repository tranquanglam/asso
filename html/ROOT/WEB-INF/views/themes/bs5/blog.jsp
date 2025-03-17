<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<link rel="stylesheet" type="text/css" href="/themes/grayscale/css/blog.css"/>
<div class="slice slice-sm" data-offset-top="#header-main">
    <div class="container">
        <h1 class="">${h1}</h1>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/"> <ftm:message key="title.home_page"/> </a></li>
                <li class="breadcrumb-item active" aria-current="page">${h1} </li>
            </ol>
        </nav>
    </div>
</div>
<section class=" bg-light">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <main id="mainBlogs">
                    <c:forEach var="blog" items="${blogs}" varStatus="loop">
                        <div class="row mb-3">
                            <c:set var="classBlogRight" value="col-md-12"/>
                            <c:if test="${not empty blog.image1}">
                                <div class="col-md-4 d-flex align-items-start">
                                    <img src="${blog.image1}" alt="${blog.title}" width="100%" height="auto"/>
                                </div>
                                <c:set var="classBlogRight" value="col-md-8"/>
                            </c:if>

                            <div class="${classBlogRight}">
                                <article class="mg-post pt-0">
                                    <header>
                                        <div class="mg-post-title h2"><a href="/blog/${blog.urlname}"
                                                                     rel="bookmark">${blog.title}</a></div>
                                        <div class="mg-post-meta">
                                            <span><a href="#"><ftm:formatDate value="${blog.modifiedDate}"
                                                                              type="both"/></a></span>
                                            <%--<span>by <a href="#">Admin</a></span>--%>
                                            <c:if test="${not empty blog.numOfComment}">
                                                <span><a href="#">${blog.numOfComment} <ftm:message
                                                        key="title.comments"/></a></span>
                                            </c:if>
                                        </div>
                                    </header>
                                    <div>
                                        <p>${blog.shortDescription300}</p>
                                    </div>
                                    <footer class="clearfix">
                                        <a href="/blog/${blog.urlname}" class="mg-read-more"><ftm:message key="title.readmore"/> <i class="fa fa-long-arrow-right"></i></a>
                                    </footer>
                                </article>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${blogs.size() < count}">
                        <button id="show-more-btn" class="btn btn-primary" onclick="loadMore()"><ftm:message key="home.see-more"/></button>
                    </c:if>
                </main>
            </div>
            <div class="col-md-4">
                <div class="mg-widget-area">
                    <aside class="mg-widget">
                        <h3 class="mg-widget-title"><ftm:message key="label.current.promo"/></h3>
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

<script language="JavaScript">
    var count = ${count};
    var searchFilter = {};
    searchFilter.start = ${fn:length(blogs)};
    searchFilter.length = 20;
    searchFilter.end = 2;

    function getBlogTemplate(blog) {
        var html = [];
        html.push('<div class="row mb-3">')
        if (blog.image1 != undefined && blog.image1 != null) {
            html.push('   <div class="col-md-4 d-flex align-items-start">  ');
            html.push('         <img src="'+blog.image1+'" alt="'+blog.title+'" width="100%" height="auto">')
            html.push('   </div>  ')
            html.push('   <div class="col-md-8">  ')
        } else {
            html.push('   <div class="col-md-12">  ')
        }
        html.push('         <article class="mg-post pt-0">  ')
        html.push('             <header>')
        html.push('                 <h2 class="mg-post-title"><a href="/blog/'+blog.urlname+'" rel="bookmark">'+blog.title+'</a></h2>')
        html.push('                 <div class="mg-post-meta">')
        html.push('                     <span><a href="#">'+blog.createddateStr+'</a></span>')
        html.push('                     <span>by <a href="#">'+blog.createdByStr+'</a></span>')
        html.push('                     <span><a href="#"> Comments</a></span>')
        html.push('                  </div>')
        html.push('             </header>')
        html.push('              <div><p>'+blog.shortDescription300+'</p></div>');
        html.push('             <footer class="clearfix"> <a href="/blog/'+blog.urlname+'" class="mg-read-more"><ftm:message key="title.readmore"/> <i class="fa fa-long-arrow-right"></i></a> </footer>');
        html.push('</article></div> </div>');
        return html.join('');
    }
    function loadMore() {
        if (searchFilter.start < count) {
            $.ajax({
                url: '/ajax/getBlogs.json?start=' + searchFilter.start,
                type: 'GET',
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {
                        var blog = result[i];
                        blog.createddateStr = new Date(blog.createdDate).toLocaleDateString();
                        blog.createdByStr = 'Admin';
                       $('#mainBlogs').append(getBlogTemplate(blog))
                    }
                }
            });
            searchFilter.start = searchFilter.start + searchFilter.length;
            if (searchFilter.start >= count) {
                $("#show-more-btn").addClass('d-none');
            }
        }
    }
</script>
