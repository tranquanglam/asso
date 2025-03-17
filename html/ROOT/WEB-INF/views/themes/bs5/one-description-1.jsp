<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<ul class="nav nav-pills" id="myTab" role="tablist">
    <c:if test="${pageOneProduct.sitepageid gt 0}">
        <li class="nav-item text-dark" role="presentation">
            <button class="nav-link active" id="product-description-tab" data-bs-toggle="tab"
                    data-bs-target="#product-description" type="button" role="tab"
                    aria-controls="product-description" aria-selected="true">
                <fmt:message key="label.product.description"/></button>
        </li>
    </c:if>
    <c:if test="${not empty productfeatures || (not empty productDescriptionDTO.feature.content && productDescriptionDTO.feature.visible eq true)}">
        <li class="nav-item text-dark" role="presentation">
            <button class="nav-link" id="product-feature-tab" data-bs-toggle="tab" data-bs-target="#product-feature" type="button"
                    <c:set var="labelProductFeature" value="label.product.feature${labelProductFeature}"/>
                    role="tab" aria-controls="product-feature" aria-selected="false"> <fmt:message key="${labelProductFeature}" />
            </button>
        </li>
    </c:if>
    <c:if test="${not empty productDescriptionDTO.video.content && productDescriptionDTO.video.visible eq true}">
        <li class="nav-item text-dark" role="presentation">
            <button class="nav-link" id="product-video-tab" data-bs-toggle="tab" data-bs-target="#product-video" type="button"
                    role="tab" aria-controls="product-video" aria-selected="false"> Video
            </button>
        </li>
    </c:if>
    <c:if test="${not empty productDescriptionDTO.faq.content && productDescriptionDTO.faq.visible eq true}">
        <li class="nav-item text-dark" role="presentation">
            <button class="nav-link" id="product-faq-tab" data-bs-toggle="tab" data-bs-target="#product-faq" type="button"
                    role="tab" aria-controls="product-faq" aria-selected="false"> FAQ
            </button>
        </li>
    </c:if>
</ul>
<div class="tab-content mt-4" id="myTabContent">
    <c:if test="${pageOneProduct.sitepageid gt 0}">
        <div class="tab-pane fade show active" id="product-description" role="tabpanel"
             aria-labelledby="home-tab">
            <div class="row mt-2">
                <div class="col-12">
                        ${pageOneProduct.content}
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${not empty productfeatures || (not empty productDescriptionDTO.feature.content && productDescriptionDTO.feature.visible eq true)}">
        <div class="tab-pane fade" id="product-feature" role="tabpanel" aria-labelledby="profile-tab">
            <div class="row">
                <div class="col-12">
                    <c:if test="${not empty productfeatures}">
                        <div class="table-responsive">
                            <table class="table table-feature">
                                <tbody>
                                <c:forEach items="${productfeatures}" var="feature">
                                    <c:choose>
                                        <c:when test="${empty feature.jvalueDTO}"></c:when>
                                        <c:when test="${empty feature.jvalueDTO.items}"></c:when>
                                        <c:when test="${feature.jvalueDTO.items.size() > 1}">
                                            <c:forEach items="${feature.jvalueDTO.items}" var="item" begin="0">
                                                <tr>
                                                    <td class="feature__name">${item.name}</td>
                                                    <td class="feature__content">${item.content}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td>${feature.name}</td>
                                                <td>${feature.firstValue}</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${productDescriptionDTO.feature.visible eq true}">
                        ${productDescriptionDTO.feature.content}
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty productDescriptionDTO.video.content}">
        <div class="tab-pane fade" id="product-video" role="tabpanel"
             aria-labelledby="home-tab">
            <div class="row mt-2">
                <div class="col-12">
                        ${productDescriptionDTO.video.content}
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty productDescriptionDTO.faq.content}">
        <div class="tab-pane fade" id="product-faq" role="tabpanel"
             aria-labelledby="home-tab">
            <div class="row mt-2">
                <div class="col-12">
                        ${productDescriptionDTO.faq.content}
                </div>
            </div>
        </div>
    </c:if>

</div>
