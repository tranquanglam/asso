<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<div class="h-screen flex-grow-1 overflow-y-lg-auto">
    <!-- Header -->
    <header class="bg-surface-primary border-bottom pt-6">
        <div class="container-fluid">
            <div class="mb-npx">
                <div class="row align-items-center">
                    <div class="col-sm-6 col-12 mb-4 mb-sm-0">
                        <!-- Title -->
                        <h1 class="h2 mb-0 ls-tight"> <fmt:message key="label.product.description"/></h1>
                    </div>
                    <!-- Actions -->
                    <div class="col-sm-6 col-12 text-sm-end">
                        <div class="mx-n1">
                            <a href="/${product.code}.html" class="btn d-inline-flex btn-sm btn-neutral border-base mx-1">
                                  <span class=" pe-2">
                                    <i class="bi bi-view"></i>
                                  </span>
                                <span> <fmt:message key="label.view-detail"/> </span>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- Nav -->
                <ul class="nav nav-tabs mt-4 overflow-x border-0">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="product-description-tab" data-bs-toggle="tab" data-bs-target="#product-description" type="button" role="tab" aria-controls="product-description" aria-selected="true">Description</button>
                    </li>

                    <li class="nav-item" role="presentation">
                        <button class="nav-link " id="product-feature-tab" data-bs-toggle="tab" data-bs-target="#product-feature" type="button" role="tab" aria-controls="product-feature" aria-selected="true">Feature</button>
                    </li>

                    <li class="nav-item" role="presentation">
                        <button class="nav-link " id="product-video-tab" data-bs-toggle="tab" data-bs-target="#product-video" type="button" role="tab" aria-controls="product-video" aria-selected="true">Video</button>
                    </li>

                    <li class="nav-item" role="presentation">
                        <button class="nav-link " id="product-faq-tab" data-bs-toggle="tab" data-bs-target="#product-faq" type="button" role="tab" aria-controls="product-faq" aria-selected="true">FAQ</button>
                    </li>

                    <li class="nav-item" role="presentation">
                        <button class="nav-link " id="product-location-tab" data-bs-toggle="tab" data-bs-target="#product-location" type="button" role="tab" aria-controls="product-location" aria-selected="true">Location</button>
                    </li>


                </ul>
            </div>
        </div>
    </header>
    <!-- Main -->
    <main class="py-6 bg-surface-secondary">
        <div class="container-fluid">
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                    <strong>Alert!</strong> ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form:form id="sitePageForm" commandName="formItem" method="post" class="form-horizontal" role="form"  enctype="multipart/form-data">
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="product-description" role="tabpanel" aria-labelledby="product-description-tab">

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="nameurl" value="${formItem.sitePage.nameurl}">
                        <form:input type="hidden" cssClass="form-control" path="sitePage.type"/>
                        <form:input type="hidden" cssClass="form-control" path="sitePage.ordernumber"/>
                        <form:input type="hidden" cssClass="form-control" path="sitePage.sitepageid"/>
                        <form:input type="hidden" cssClass="form-control" path="sitePage.nameurl"/>
                        <form:input type="hidden" cssClass="form-control" path="sitePage.name"/>
                        <form:input type="hidden" cssClass="form-control" path="sitePage.namevn"/>
                        <form:input type="hidden" cssClass="form-control" path="sitePage.link" id="sitePageLink"/>

                        <div class="row">
                            <div class="form-group col-md">
                                <label>Commentable</label>
                                <input type="checkbox" id="isComment" cssClass="form-control" ${formItem.sitePage.link eq 'commentable' ? 'checked' : ''} />
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${param.l == 'vi'}">
                                <div class="form-group">
                                    <label for="contentvn" class="control-label">Nội dung Tiếng Việt:</label>
                                    <form:textarea path="sitePage.contentvn" id="contentvn" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="form-group">
                                    <label for="content" class="control-label">Content:</label>
                                    <form:textarea path="sitePage.content" id="content" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <div class="tab-pane fade" id="product-feature" role="tabpanel" aria-labelledby="product-feature-tab">

                        <a href="/bo/data/${product.productid}/productfeatures.html">Open Table Feature</a>
                        <input type="hidden" name="feature.ordernumber" value="1" />

                        <div>
                            <input class="form-check-input" type="checkbox" name="feature.visible" ${formItem.feature.visible eq true ? 'checked' : ''}  />
                            <label class="form-check-label">
                                Visible
                            </label>
                        </div>

                        <c:choose>
                            <c:when test="${param.l == 'vi'}">
                                <div class="form-group">
                                    <label for="contentvn" class="control-label">Nội dung Tiếng Việt:</label>
                                    <form:textarea path="feature.contentvn" id="featureContentvn" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="form-group">
                                    <label for="content" class="control-label">Content feature:</label>
                                    <form:textarea path="feature.content" id="featureContent" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="tab-pane fade" id="product-video" role="tabpanel" aria-labelledby="product-description-tab">

                        <input type="hidden" name="video.ordernumber" value="1" />

                        <div>
                            <input class="form-check-input" type="checkbox" name="video.visible" ${formItem.video.visible eq true ? 'checked' : ''}  />
                            <label class="form-check-label">
                                Visible
                            </label>
                        </div>

                        <c:choose>
                            <c:when test="${param.l == 'vi'}">
                                <div class="form-group">
                                    <label for="contentvn" class="control-label">Nội dung Tiếng Việt:</label>
                                    <form:textarea path="video.contentvn" id="videoContentvn" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="form-group">
                                    <label for="content" class="control-label">Content:</label>
                                    <form:textarea path="video.content" id="videoContent" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="tab-pane fade" id="product-faq" role="tabpanel" aria-labelledby="product-faq-tab">
                        <input type="hidden" name="faq.ordernumber" value="2" />

                        <div>
                            <input class="form-check-input" type="checkbox" name="faq.visible"  ${formItem.faq.visible eq true ? 'checked' : ''}/>
                            <label class="form-check-label">
                                Visible
                            </label>
                        </div>


                        <c:choose>
                            <c:when test="${param.l == 'vi'}">
                                <div class="form-group">
                                    <label for="contentvn" class="control-label">Nội dung Tiếng Việt:</label>
                                    <form:textarea path="faq.contentvn" id="faqContentvn" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="form-group">
                                    <label for="content" class="control-label">Content:</label>
                                    <form:textarea path="faq.content" id="faqContent" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="tab-pane fade" id="product-location" role="tabpanel" aria-labelledby="product-location-tab">
                        <input type="hidden" name="location.ordernumber" value="2" />

                        <div>
                            <input class="form-check-input" type="checkbox" name="location.visible" ${formItem.location.visible eq true ? 'checked' : ''} />
                            <label class="form-check-label">
                                Visible
                            </label>
                        </div>


                        <c:choose>
                            <c:when test="${param.l == 'vi'}">
                                <div class="form-group">
                                    <label for="contentvn" class="control-label">Nội dung Tiếng Việt:</label>
                                    <form:textarea path="location.contentvn" id="locationContentvn" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="form-group">
                                    <label for="content" class="control-label">Content:</label>
                                    <form:textarea path="location.content" id="locationContent" cssClass="form-control richTextEditor" rows="10" />
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>


                <div class="row form-group my-3">
                    <div class="col-md-6">
                        <security:authorize access="hasAnyAuthority('AGT_ADMIN','PRODUCT_W')">
                            <button type="submit" class="btn btn-primary">&nbsp;Submit</button>
                        </security:authorize>
                    </div>
                </div>
            </form:form>
        </div>
    </main>
</div>
<div class="d-none" id="base64_encoded_path">${base64_encoded_path}</div>
<script language="JavaScript">
    var base64_encoded_path = '${base64_encoded_path}';
    var l='en';
    <c:if test="${param.l == 'vi'}">
    l='vi';
    </c:if>
</script>
