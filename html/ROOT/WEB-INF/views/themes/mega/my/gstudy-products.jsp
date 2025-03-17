<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    .book-thumbnails {
        width: 256px;
        height: 256px;
        display: inline-flex;
        justify-content: center;
        align-items: center;
        position: relative;
        overflow: hidden;
        border-radius: .75rem;
    }
    .product-name {
        width: 256px;
        justify-content: center;
        align-items: center;
        padding-top: 1rem;
    }
</style>
<div class="container-fluid">
    <div class="row">
        <c:choose>
            <c:when test="${responseProduct.totalRecords gt 0}">
                <div class="col-12 mb-3">
                    <h1>My books</h1>
                </div>
                <c:forEach var="product" items="${responseProduct.products}" varStatus="theCount">
                    <div class="one-product-content col-md-3 col-6">
                        <div class="book-thumbnails card border-0 shadow hover-translate-y-n10 hover-shadow-lg"><a href="/my/gstudy/${product.code}/view-product.html"><img alt="${product.name}" class="card-img-top product-image" src="${product.image}"></a>
                            <div class="card-body text-center py-3 px-1">

                            </div>
                        </div>
                        <div class="product-name">
                            <h5 class="text-center"><a href="/my/gstudy/${product.code}/view-product.html">${product.name}</a></h5>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12">
                    You have no any product
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>