<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="bg-gradient-primary" data-offset-top="#header-main">
</div>
<c:choose>
    <c:when test="${page.type eq 4}">
        ${page.content}
    </c:when>
    <c:otherwise>
        <section class="slice bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-9">
                        <header>
                            <h1 class="lh-150 mb-3 mg-post-title"><span>${page.name}</span></h1>
                        </header>
                        <article class="mg-post">

                            <div class="blog-content">
                                    ${page.content}
                            </div>
                        </article>
                    </div>
                </div>
            </div>
        </section>
    </c:otherwise>
</c:choose>
