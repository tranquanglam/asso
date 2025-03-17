<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<style>
    hr{
        margin-top: 50px;
        margin-bottom: 50px;
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/agent/sites/B2B/settings">Site config</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${siteForm.site.name}</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1>SEO for Site ${siteForm.site.name}</h1>
        </div>
    </div>

<div class="row">
    <div class="col-lg-12">
        <form:form method="post" id="siteForm" commandName="siteForm" class="form-horizontal" role="form"
                   action="/agent/sites/${siteForm.site.siteid}" enctype="multipart/form-data">

            <input type="hidden" name="siteid">
            <div class="row">
                <div class="form-group col-md">
                    <label for="site.title">Title:</label>
                    <form:input type="text" class="form-control" path="site.title" maxlength="255"/>
                </div>
                <div class="form-group col-md">
                    <label for="site.name">Name:</label>
                    <form:input type="text" class="form-control" path="site.name" maxlength="255"/>
                </div>
            </div>
            <div class="form-group">
                <label for="site.description">Description:</label>
                <form:textarea class="form-control" path="site.description"/>
            </div>
            <div class="row">
                <div class="form-group col-md">
                    <label for="site.email">Email:</label>
                    <form:input type="text" class="form-control" path="site.email" maxlength="100"/>
                </div>
                <div class="form-group col-md">
                    <label for="site.phone">Phone:</label>
                    <form:input type="text" class="form-control" path="site.phone" maxlength="99"/>
                </div>
                <div class="form-group col-md">
                    <label for="site.address">Address:</label>
                    <form:input type="text" class="form-control" path="site.address" maxlength="255"/>
                </div>
            </div>
            <hr>
            <div class="row mt-3">

                <div class="form-group col-md">
                    <label for="site.domain" class="col-md control-label">Schema:</label>
                    <form:select cssClass="form-control" path="site.scheme">
                        <form:option value="http">http</form:option>
                        <form:option value="https">https</form:option>
                    </form:select>
                </div>
                <div class="form-group col-md">
                    <label for="site.domain" class="col-md control-label">Domain:</label>
                    <form:input type="text" cssClass="form-control" path="site.domain" maxlength="255"/>
                </div>
                <div class="form-group col-md">
                    <label for="site.domain" class="col-md control-label">is Change Domain</label> <br>
                    <form:checkbox cssClass="form-check-inline" path="changeDomain"/>
                </div>
            </div>
            <hr>
            <div class="row mt-3">
                <label class="col-auto">Select theme</label>
                <c:forEach var="th" items="${themes}">
                    <div class="col-auto">
                        <form:radiobutton path="theme" value="${th.themeid}" label="${th.name}"
                                          element="label"/>
                    </div>
                </c:forEach>
            </div>
            <hr>
            <div class="row">
                <div class="form-group col-md">
                    <label>Site bg color</label>
                    <form:input type="color" cssClass="form-control form-control-color" path="site.color"/>
                </div>
                <div class="form-group col-md">
                    <label>Header color</label>
                    <form:input type="color" class="form-control form-control-color" path="site.hcolor" maxlength="12"/>
                </div>
                <div class="form-group col-md">
                    <label>Footer color</label>
                    <form:input type="color" class="form-control form-control-color" path="site.fcolor" maxlength="12"/>
                </div>
                <div class="form-group col-md-3">
                    <label for="site.googlefont" >Google font family</label>
                    <form:input type="text" class="form-control" path="site.googlefont" maxlength="100" placeholder="Roboto Slab"/>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="form-group col-md-3">
                    <label >Site Favicon:</label>

                    <div>
                        <img src="${siteForm.site.favicon}" height="70px">
                        <br/>
                        <br/>
                        <form:input type="file" path="favicon"/>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label for="site.name" >Logo:</label>

                    <div>
                        <img src="${siteForm.site.desktopLogo}" height="70px">
                        <br/>
                        <br/>
                        <form:input type="file" path="desktopLogo"/>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label >Mobile Logo:</label>

                    <div>
                        <img src="${siteForm.site.mobileLogo}" height="70px">
                        <br/>
                        <br/>
                        <form:input type="file" path="mobileLogo"/>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="form-group col-md-3">
                    <label for="site.facebook" >Facebook</label>
                    <form:input type="text" class="form-control" path="site.facebook" maxlength="100"/>
                </div>
                <div class="form-group col-md-3">
                    <label for="site.twitter" >Twitter</label>
                    <form:input type="text" class="form-control" path="site.twitter" maxlength="100"/>
                </div>
                <div class="form-group col-md-3">
                    <label for="site.youtube" >Youtube</label>
                    <form:input type="text" class="form-control" path="site.youtube" maxlength="100"/>
                </div>
                <div class="form-group col-md-3">
                    <label for="site.instagram" >Instagram</label>
                    <form:input type="text" class="form-control" path="site.instagram" maxlength="100"/>
                </div>
                <div class="form-group col-md-3">
                    <label for="site.googletagmanager">Google Tag Manager</label>
                    <form:input type="text" class="form-control" path="site.googletagmanager" maxlength="32"/>
                </div>
                <div class="form-group col-md-3">
                    <label for="site.googleanalytics" >Google Analytics</label>
                    <form:input type="text" class="form-control" path="site.googleanalytics" maxlength="32"/>
                </div>
                <div class="form-group col-md-3">
                    <label for="site.zendesk">Enet Chat</label>
                    <form:input type="text" class="form-control" path="site.zendesk" maxlength="64"/>
                </div>

            </div>
            <hr>

            <div class="row mt-3">
                <div class="form-group col-md-3">
                    <label>Custom css 1:</label>
                    <div>
                        <img src="${siteForm.site.banner1}">
                        <br/>
                        <form:input type="file" path="banner1"/>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label>Custom css 2:</label>
                    <div>
                        <img src="${siteForm.site.banner2}" width="200px">
                        <br/>
                        <form:input type="file" path="banner2"/>
                    </div>
                </div>
            </div>
            <div class="row my-4">
                <div class="col">
                    <button type="submit" class="btn btn-primary">&nbsp;Save</button>
                    &nbsp;&nbsp;
                    <a href="/agent/settings" class="btn btn-link">Cancel</a>
                </div>
            </div>

        </form:form>
    </div>
</div>
</div>
