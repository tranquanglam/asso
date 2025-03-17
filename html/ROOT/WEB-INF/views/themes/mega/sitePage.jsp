<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="w-100 pt-4">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <article class="mg-post">
                    <header>
                        <h1 class="mg-post-title"><span>${page.name}</span></h1>
                    </header>
                    <div class="blog-content">
                        ${page.content}
                    </div>
                </article>
            </div>
        </div>
    </div>
</div>