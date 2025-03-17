<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<div class="mg-gallery-page">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="mg-filter">
                    <form id="mg-filter">
                        <fieldset>
                            <label class="btn btn-dark btn-main"><input type="radio" name="filter" value="all" checked="checked">All</label>
                            <c:forEach var="key" items="${keys}">
                                <label class="btn btn-dark"><input type="radio" name="filter" value="${key}">${albumMap[key]}</label>
                            </c:forEach>
                        </fieldset>
                    </form>
                </div>

                <div class="row" id="mg-grid">
                    <c:forEach var="aitem" items="${albumitems}">
                    <figure class="col-md-3 mg-gallery-item" data-groups='["${aitem.album.name}"]'>
                        <a class="fancybox" data-fancybox-group="gallery" href="${applicationScope['hostmedia']}${aitem.url}" data-lightbox-gallery="rooms"><img src="${applicationScope['hostmedia']}${aitem.url}" class="img-responsive" alt="" /><span class="mg-gallery-overlayer"><i class="fa fa-search-plus"></i></span></a>
                    </figure>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>