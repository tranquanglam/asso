<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<style>
    .order-sidebar  .order-sidebar-item .cat-link {
        color: #01c4ff;
    }
    .order-sidebar  .order-sidebar-item .cat-link.active {
        color: var(--primary-color);
    }
    @media (max-width: 767px) {
        .order-sidebar{
            display: inline-flex;
            justify-content: space-between;
            max-width: 767px;
            overflow-x: scroll;
        }
        .order-sidebar::-webkit-scrollbar {
            display: none;
        }
        /* Hide scrollbar for IE, Edge and Firefox */
        .order-sidebar {
            -ms-overflow-style: none;  /* IE and Edge */
            scrollbar-width: none;  /* Firefox */
        }
        .order-sidebar .order-sidebar-item {
            white-space: nowrap;
        }
        .order-sidebar  .order-sidebar-item .cat-link.active {
            color: #0913ff;
        }
        .order-main-content {
            padding: 0.5rem;
        }
    }

</style>
<div class="bg-gradient-primary" data-offset-top="#header-main">
</div>
<section class="slice bg-white">
    <div class="text-center">
        <h1>${page.name}</h1>
        ${page.content}
    </div>
    <div class="container-fluid">
        <div class="row flex-xl-nowrap">
            <div class="col-12 col-md-2 order-sidebar pl-0 pr-0">
                <c:forEach items="${categories}" var="cat" varStatus="theCount">
                    <div class="order-sidebar-item border-bottom p-3">
                        <span class="badge badge-pill badge-info mr-3">${theCount.count}</span>  <a href="javascript:void(0)" class="catalogue cat-link" data-cat="${cat.nameurl}" data-targetid="ajax-products-by-cat"> ${cat.name}</a>
                    </div>
                </c:forEach>
            </div>
            <main class="col-12 col-md-10 py-md-3 pl-md-3" role="main">
                <div class="order-main-content" id="ajax-products-by-cat" maxN="36" query="${q}">

                </div>
            </main>
        </div>
    </div>
</section>
