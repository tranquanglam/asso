<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="pageName">Bạn đã đăng ký thành công</c:set>
<c:if test="${page.name != null}">
    <c:set var="pageName">${page.name}</c:set>
</c:if>
<div class="slice bg-gradient-primary" data-offset-top="#header-main">
</div>
<section class="slice bg-light">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <article class="mg-post">
                    <header>
                        <h1 class="mg-post-title"><span>${pageName}</span></h1>
                    </header>
                    <div class="blog-content">
                        ${page.content}
                    </div>
                </article>
            </div>
        </div>
    </div>
</section>