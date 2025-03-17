<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    .js-product-one.active,
    .js-product-one-box.active{
        border: 3px solid dodgerblue;
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/settings">Settings</a></li>
                    <li class="breadcrumb-item" aria-current="page"><a href="/agent/emailTemplates">Templates</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Email settings</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">

            <form method="post" id="formBean" class="" role="form">
                <div class="row">
                    <div class="col">
                        <label>primaryColor:</label>
                        <input type="color" class="form-control" name="primaryColor" value="${siteStyle.primaryColor}"/>
                    </div>
                    <div class="col">
                        <label>primaryGradientColor:</label>
                        <input type="color" class="form-control" name="primaryGradientColor" value="${siteStyle.primaryGradientColor}"/>
                    </div>

                    <div class="col">
                        <label>secondaryColor:</label>
                        <input type="color" class="form-control" name="secondaryColor" value="${siteStyle.secondaryColor}"/>
                    </div>
                    <div class="col">
                        <label>secondaryGradientColor:</label>
                        <input type="color" class="form-control" name="secondaryGradientColor" value="${siteStyle.secondaryGradientColor}"/>
                    </div>

                    <div class="col">
                        <label>bodyTextColor:</label>
                        <input type="color" class="form-control" name="bodyTextColor" value="${siteStyle.bodyTextColor}"/>
                    </div>
                </div>

                <div class="row mt-5">
                    <div class="col">
                        <label>Google Font 1:</label>
                        <input class="form-control" list="googleFontOptions" name="googleFont" value="${siteStyle.googleFont}">
                        <datalist id="googleFontOptions">
                            <option value="Montserrat">
                            <option value="Roboto">
                            <option value="Open Sans">
                            <option value="Philosopher">
                            <option value="Chicago">
                            <option value="Dancing Script">
                        </datalist>
                    </div>
                    <div class="col">
                        <label>Google Font 2:</label>
                        <input class="form-control" list="googleFont2Options" name="googleFont2" value="${siteStyle.googleFont2}">
                        <datalist id="googleFont2Options">
                            <option value="Montserrat">
                            <option value="Roboto">
                            <option value="Open Sans">
                            <option value="Philosopher">
                            <option value="Chicago">
                            <option value="Dancing Script">
                        </datalist>
                    </div>
                </div>

                <div class="row mt-5">
                    <div class="col">
                        <label>Products: products</label>
                        <input class="form-control" name="mappingProducts" list="mappingProductsOptions"  value="${siteStyle.mappingProducts}">
                        <datalist id="mappingProductsOptions">
                            <option value="products">
                            <option value="san-pham">
                            <option value="tram-huong">
                            <option value="tours">
                        </datalist>
                    </div>
                    <div class="col">
                        <label>mappingBlogs: blog</label>
                        <input class="form-control" name="mappingBlogs" list="mappingBlogsOptions"  value="${siteStyle.mappingBlogs}">
                        <datalist id="mappingBlogsOptions">
                            <option value="blog">
                        </datalist>
                    </div>

                    <div class="col">
                        <label>mappingBlogsTag: blog/tag</label>
                        <input class="form-control" name="mappingBlogsTag" list="mappingBlogsTagOptions"  value="${siteStyle.mappingBlogsTag}">
                        <datalist id="mappingBlogsTagOptions">
                            <option value="blog/tag">
                        </datalist>
                    </div>
                </div>

                <div class="row g-4 mt-5">
                    <div class="col-12">
                        <h3>Product layout</h3>
                    </div>
                    <c:forEach items="${layoutOnes}" var="layout">
                        <div class="col-2">
                            <div class="card js-product-one h-100 ${layout.layout eq siteStyle.layoutOne ? 'active' : ''}" style="" data-layout="${layout.layout}">
                                <img src="${layout.avatar}" class="card-img-top" alt="..." height="200px">
                                <div class="card-body">
                                    <p>${layout.layout}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="row g-4 mt-5">
                    <div class="col-12">
                        <h3>Product Box layout</h3>
                    </div>
                    <c:forEach items="${layoutOneBoxs}" var="layout">
                        <div class="col-2">
                            <div class="card js-product-one-box h-100 ${layout.layout eq siteStyle.layoutOneBox ? 'active' : ''}" style="" data-layout="${layout.layout}">
                                <img src="${layout.avatar}" class="card-img-top" alt="..." height="200px">
                                <div class="card-body">
                                    <p>${layout.layout}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="row g-4 mt-5">
                    <div class="col-12">
                        <h3>Dashboard Css</h3>
                    </div>
                    <div class="col-12">
                        <label>Dashboard Css</label>
                        <textarea class="form-control" name="dashboardCss" >${siteStyle.dashboardCss}</textarea>
                    </div>
                </div>

                <div class="form-group">
                    <div class="mt-3">
                        <button type="button" class="btn btn-success js-submit">&nbsp;Save</button>
                        <a href="/agent/settings" class="btn btn-default btn-cancel">&nbsp;Cancel</a>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
