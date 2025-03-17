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

<div class="container justify-content-center pb-5 px-0">
    <ul class="nav nav-tabs d-flex justify-content-between justify-content-md-center " id="tabs-${flag}" role="tablist">
        <c:forEach items="${sitepages}" var="sitepage" varStatus="theCount">
            <li class="nav-item mb-2 mx-2">
                <a aria-selected="true"
                   class="nav-link ${theCount.index eq 0 ? 'active' : ''} catalogue-blog cat-link"
                   data-bs-toggle="tab" href="#pane-${flag}-${sitepage.sitepageid}" id="tab-${flag}-${sitepage.sitepageid}" role="tab"
                   data-cat="${sitepage.nameurl}"
                   data-targetid="collapse-${flag}-${sitepage.sitepageid}"
                ><strong>${sitepage.name}</strong></a></li>
        </c:forEach>
    </ul>

    <div class="tab-content" id="content-${flag}" role="tablist" style="width: 100%;">
        <c:forEach items="${sitepages}" var="sitepage"  varStatus="theCount">
            <div aria-labelledby="tab-${flag}-${sitepage.sitepageid}" class=" tab-pane fade ${theCount.index eq 0 ? 'active show' : ''}" id="pane-${flag}-${sitepage.sitepageid}" role="tabpanel">
                <div aria-labelledby="heading-${flag}-${sitepage.sitepageid}" class="collapse ${theCount.index eq 0 ? 'show' : ''}" data-parent="#content-${flag}" id="collapse-${flag}-${sitepage.sitepageid}" role="tabpanel">
                    <div class="px-0 py-3">
                        <c:set var="item" value="${sitepage}"/>
                        <%@ include file="sitepage-box.jsp" %>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
