<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<c:set var="siteStyleId" value="siteStyle_${site.siteid}"/>
<c:if test="${applicationScope[siteStyleId] != null}">
    <c:set var="siteStyle" value="${applicationScope[siteStyleId]}"/>
</c:if>

<style>
    .form-step,.supplier-info {
        display: none;
    }
    .form-step.show,.supplier-info.show {
        display: block;
    }
    .form-step .card{
        margin-bottom: 0.5rem;
    }
    .btn-back,.btn-next {
        display: none;
    }
    .btn-back.show,.btn-next.show {
        display: inline;
        margin-left: 0.55rem;
        padding-left: 2rem;
        padding-right: 2rem;
    }
</style>

<section class="slice slice-lg min-vh-100 d-flex align-items-center bg-gradient-primary" data-offset-top="#header-main">
    <div class="container py-1 px-md-0 d-flex align-items-center">
        <div class="w-100">
            <div class="row row-grid justify-content-center justify-content-lg-between align-items-center">
                <div class="col-sm-4 col-lg-6 col-xl-5 order-lg-2">
                    <form method="post" id="supplierProductForm">
                        <div class="row">
                            <div class="col-md-12 form-step step-one" nextstep="two">
                                <div class="card rounded-3 mt-3">
                                    <div class="card-body pb-4">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="mb-4">
                                                    <label class="card-title mb-2">Title</label>
                                                    <input name="site.title" class="form-control required" value="${site.title}" maxlength="255" placeholder="Your site title">
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="mb-4">
                                                    <label class="card-title mb-2">Phone</label>
                                                    <input name="site.phone" class="form-control required" value="${site.phone}" placeholder="Your site phone">
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="mb-4">
                                                    <label class="card-title mb-2">Address</label>
                                                    <input name="site.address" class="form-control required" value="${site.address}" maxlength="255" placeholder="Your site address">
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="mb-4">
                                                    <label class="card-title mb-2">Description</label>
                                                    <textarea name="site.description" class="form-control required"  maxlength="255" placeholder="Your site name" rows="3">${site.description}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 form-step step-two" nextstep="three"prevstep="one">
                                <div class="card rounded-3 mt-3">
                                    <div class="card-body pb-4">
                                        <div class="mb-4">
                                            <label class="card-title mb-2">Font</label>
                                            <input class="form-control" list="datalistOptions" name="site.googlefont" value="${site.googlefont}">
                                            <datalist id="datalistOptions">
                                                <option value="Montserrat">
                                                <option value="Roboto">
                                                <option value="Open Sans">
                                                <option value="Philosopher">
                                                <option value="Chicago">
                                            </datalist>
                                        </div>
                                        <div class="row mb-4">
                                            <div class="col-6">
                                                <div class="">
                                                    <label class="card-title mb-2">Primary Color</label>
                                                    <input type="color" class="form-control form-control-color js-site-color" name="siteStyle.primaryColor" data-root-css="--primary-color" value="${siteStyle.primaryColor}" title="Choose your color">
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="">
                                                    <label class="card-title mb-2">Primary Gradient Color</label>
                                                    <input type="color" class="form-control form-control-color js-site-color" name="siteStyle.primaryGradientColor" data-root-css="--primary-gradient-color" value="${siteStyle.primaryGradientColor}" title="Choose your color">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row mb-4">
                                            <div class="col-6">
                                                <div class="">
                                                    <label class="card-title mb-2">Header Bg Color</label>
                                                    <input type="color" class="form-control form-control-color js-site-color" name="siteStyle.headerBgColor" value="${siteStyle.headerBgColor}" title="Choose your color">
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="">
                                                    <label class="card-title mb-2">Header Text Color</label>
                                                    <input type="color" class="form-control form-control-color js-site-color" name="siteStyle.headerTextColor" value="${siteStyle.headerTextColor}" title="Choose your color">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row mb-4">
                                            <div class="col-6">
                                                <div class="">
                                                    <label class="card-title mb-2">Background Color</label>
                                                    <input type="color" class="form-control form-control-color js-site-color" name="siteStyle.mainBgColor" value="${siteStyle.mainBgColor}" title="Choose your color">
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="">
                                                    <label class="card-title mb-2">Body Text Color</label>
                                                    <input type="color" class="form-control form-control-color js-site-color" name="siteStyle.mainBodyTextColor" value="${siteStyle.mainBodyTextColor}" title="Choose your color">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row mb-4">
                                            <div class="col-6">
                                                <div class="">
                                                    <label class="card-title mb-2">Footer Bg Color</label>
                                                    <input type="color" class="form-control form-control-color js-site-color" name="siteStyle.footerTextColor" value="${siteStyle.footerTextColor}" title="Choose your color">
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="">
                                                    <label class="card-title mb-2">Footer Text Color</label>
                                                    <input type="color" class="form-control form-control-color js-site-color" name="siteStyle.footerBgColor" value="${siteStyle.footerBgColor}" title="Choose your color">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 form-step step-three" nextstep="four" prevstep="two">
                                <div class="card rounded-3 mt-3">
                                    <div class="card-body pb-4">
                                        <div class="row">
                                            <div class="col-12 mb-4">
                                                <h5 class="card-title mb-2">Logo</h5>
                                                <c:choose>
                                                    <c:when test="${empty site.desktopLogo}">
                                                        <div class="">
                                                            <div class="dropzone border-dashed rounded-3" id="uploadDesktopLogo" name="site.desktopLogo" style="text-align: center"></div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${site.desktopLogo}" alt="" width="30%"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="col-12 mb-4">
                                                <h5 class="card-title mb-2">Logo mobile</h5>
                                                <c:choose>
                                                    <c:when test="${empty site.mobileLogo}">
                                                        <div class="">
                                                            <div class="dropzone border-dashed rounded-3" id="uploadMobileLogo" name="site.mobileLogo" style="text-align: center"></div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${site.mobileLogo}" alt="" width="30%"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="col-12 mb-4">
                                                <h5 class="card-title mb-2">Favicon</h5>
                                                <c:choose>
                                                    <c:when test="${empty site.favicon}">
                                                        <div class="">
                                                            <div class="dropzone border-dashed rounded-3" id="uploadFavicon" name="site.favicon" style="text-align: center"></div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${site.favicon}" alt="" width="20%"/>
                                                    </c:otherwise>
                                                </c:choose>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 form-step step-four" nextstep="submit" prevstep="three">

                                <div class="card rounded-3 mt-3">
                                    <div class="card-body pb-4">
                                        <h5 class="card-title mb-2">Phương thức thanh toán</h5>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="paymentMethods" value="BT" checked="${not empty mapPaymentMethod['BT'] ? 'checked' : ''}"  id="paymentMethod_BT">
                                            <label class="form-check-label" for="paymentMethod_BT">
                                                Thanh toán sau
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="paymentMethods" value="OP" checked="${not empty mapPaymentMethod['OP'] ? 'checked' : ''}" id="paymentMethod_OP">
                                            <label class="form-check-label" for="paymentMethod_OP">
                                                One pay (cấu hình sau)
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="paymentMethods" value="PP" checked="${not empty mapPaymentMethod['PP'] ? 'checked' : ''}" id="paymentMethod_PP">
                                            <label class="form-check-label" for="paymentMethod_PP">
                                                Paypal (cấu hình sau)
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="card rounded-3 mt-3">
                                    <div class="card-body pb-4">
                                        <h5 class="card-title mb-2">Social Network</h5>
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="mb-4">
                                                    <label class="card-title mb-2">Facebook</label>
                                                    <input name="site.facebook" class="form-control required" maxlength="255" placeholder="Your site facebook">
                                                </div>
                                            </div>

                                            <div class="col-12">
                                                <div class="mb-4">
                                                    <label class="card-title mb-2">Youtube</label>
                                                    <input name="site.youtube" class="form-control required" maxlength="255" placeholder="Your site youtube">
                                                </div>
                                            </div>

                                            <div class="col-12">
                                                <div class="mb-4">
                                                    <label class="card-title mb-2">Instagram</label>
                                                    <input name="site.instagram" class="form-control required" maxlength="255" placeholder="Your site instagram">
                                                </div>
                                            </div>

                                            <div class="col-12">
                                                <div class="mb-4">
                                                    <label class="card-title mb-2">Twitter</label>
                                                    <input name="site.twitter" class="form-control required" maxlength="255" placeholder="Your site twitter">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 form-step step-thankyou">
                                <div class="card rounded-3 mt-3">
                                    <div class="card-body pb-4">
                                        <h5 class="card-title mb-2">Thank you for joining ${site.name}</h5>
                                        <c:choose>
                                            <c:when test="${page != null}">
                                                ${page.content}
                                            </c:when>
                                            <c:otherwise>
                                                You have been registered successfully!
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 my-4">
                                <div class="d-flex justify-content-start">
                                    <a class="btn btn-secondary btn-back me-3" href="javascript:void(0)">Back</a>
                                    <a class="btn btn-primary btn-next" href="javascript:void(0)">Next</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-lg-5 order-lg-1 d-none d-lg-block zindex-100">
                    <blockquote>
                        <c:choose>
                            <c:when test="${not empty page}">
                                <h3 class="h2 mb-4">${page.content}</h3>
                                <footer>— <cite class="text-lg">${page.name}</cite></footer>
                            </c:when>
                            <c:otherwise>
                                <h3 class="h2 mb-4">Bổ sung dữ liệu để tiếp tục</h3>
                                <footer>— <cite class="text-lg">Tiếp tục</cite></footer>
                            </c:otherwise>
                        </c:choose>


                    </blockquote>
                </div>
            </div>
        </div>
    </div>
</section>



