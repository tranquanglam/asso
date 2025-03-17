<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="currency" value="${site.agent.currency}"/>
<c:set var="currencyrate" value="1"/>
<c:set var="scurrency" value="đ"/>
<c:set var="maxF" value="0"/>
<c:if test="${currency eq 'USD'}">
    <c:set var="maxF" value="2"/>
    <c:set var="scurrency" value="USD"/>
</c:if>
<c:set var="layoutitem" value="blog-box-1"/>
<c:if test="${param.layoutitem != null}">
    <c:set var="layoutitem" value="${param.layoutitem}"/>
</c:if>
<c:set var="colmdNumber" value="4"/>
<c:if test="${param.colmd != null}">
    <c:choose>
        <c:when test="${param.colmd eq 2}">
            <c:set var="colmdclass" value="row-cols-md-2"/>
            <c:set var="colmdNumber" value="2"/>
        </c:when>
        <c:when test="${param.colmd eq 3}">
            <c:set var="colmdclass" value="row-cols-md-3"/>
            <c:set var="colmdNumber" value="3"/>
        </c:when>
        <c:when test="${param.colmd eq 4}">
            <c:set var="colmdclass" value="row-cols-md-4"/>
            <c:set var="colmdNumber" value="4"/>
        </c:when>
        <c:otherwise>
            <c:set var="colmdclass" value="row-cols-md-4"/>
            <c:set var="colmdNumber" value="4"/>
        </c:otherwise>
    </c:choose>
</c:if>
<div class="container">
    <c:if test="${not empty title}">
        <div class="row section-title-box ${not empty titleCssClass ? titleCssClass : ''}">
            <div class="col">
                <div class="section-title">
                    <h2>${title}</h2>
                </div>
            </div>
        </div>
    </c:if>
</div>
<div class="container justify-content-center pb-5 px-0">
    <ul class="nav nav-tabs d-none d-sm-flex justify-content-center" id="tabs-${flag}" role="tablist">
        <c:forEach items="${categories}" var="cat" varStatus="theCount">
            <li class="nav-item">
                <a aria-selected="true"
                   class="nav-link ${theCount.index eq 0 ? '' : ''} catalogue-blog cat-link"
                   data-bs-toggle="tab" href="#pane-${flag}-${cat.categoryid}" id="tab-${flag}-${cat.categoryid}" role="tab" style="color:#f68121;"
                   data-cat="${cat.nameurl}"
                   data-targetid="collapse-${flag}-${cat.categoryid}"
                ><strong>${cat.name}</strong></a></li>
        </c:forEach>
    </ul>

    <div class="tab-content" id="content-${flag}" role="tablist" style="width: 100%;">
        <c:forEach items="${categories}" var="cat" varStatus="theCount">
            <div aria-labelledby="tab-${flag}-${cat.categoryid}" class=" tab-pane fade ${theCount.index eq 0 ? 'active show' : ''}" id="pane-${flag}-${cat.categoryid}" role="tabpanel">

                <div class="card-header d-block d-sm-none ps-0" id="heading-${flag}-${cat.categoryid}" role="tab" >
                    <h5 class="mb-0">
                        <a aria-controls="collapse-${flag}-${cat.categoryid}"
                           aria-expanded="true"
                           data-bs-toggle="collapse"
                           data-cat="${cat.nameurl}"
                           data-targetid="collapse-${flag}-${cat.categoryid}"
                           class="catalogue-blog cat-link-mobile"
                           href="#collapse-${flag}-${cat.categoryid}">${cat.name}</a>
                    </h5>
                </div>

                <div aria-labelledby="heading-${flag}-${cat.categoryid}" class="collapse ${theCount.index eq 0 ? 'show' : ''}" data-parent="#content-${flag}" id="collapse-${flag}-${cat.categoryid}" role="tabpanel">
                    <div class="px-0 py-3">
                        <c:choose>
                            <c:when test="${not empty mapNewsByCatId[cat.categoryid]}">
                                <c:set var="blogs" value="${mapNewsByCatId[cat.categoryid]}"/>
                                <%@ include file="blogs-for-view-2.jsp" %>
                            </c:when>
                            <c:otherwise>

                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

</div>
