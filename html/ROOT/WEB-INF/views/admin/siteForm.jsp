<%@ include file="/common/taglibs.jsp" %>
<div class="container">
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <header class="card-header">
                <h2>Site Form</h2>
            </header>

            <div class="card-body">
                <form:form method="post" id="siteForm" commandName="siteForm" class="form-horizontal" role="form"
                           action="/admin/sites/${siteForm.site.siteid}/siteForm" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="site.name" class="col-lg-2 control-label">Name:</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.name" maxlength="255"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.description" class="col-lg-2 control-label">Description:</label>

                        <div class="col-lg-10">
                            <form:textarea class="form-control" path="site.description"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label for="agentAdmin.email">Agent Email:</label>
                            <form:hidden path="agentAdmin.userID"/>
                            <form:input type="text" class="form-control" path="agentAdmin.email" maxlength="255"/>
                        </div>
                        <div class="form-group col">
                            <label for="agentName">Agent Name:</label>
                            <form:input type="text" class="form-control" path="agentName" maxlength="255"/>
                        </div>
                        <div class="form-group col">
                            <label for="supplierproducts">PRODUCT,MARKETPLACE,CLONESITE,APPOINTMENT,AFFILIATE,VIEW3D</label>
                            <form:input type="text" class="form-control" path="supplierproducts" maxlength="255"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="agentAdmin.password" class="col-lg-2 control-label">Password:</label>

                        <div class="col-lg-10">
                            <form:input type="password" class="form-control" path="agentAdmin.password" maxlength="255"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.phone" class="col-lg-2 control-label">Phone:</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.phone" maxlength="99"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.address" class="col-lg-2 control-label">Address:</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.address" maxlength="255"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.title" class="col-lg-2 control-label">Title:</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.title" maxlength="255"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.domain" class="col-lg-2 control-label">Domain:</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.domain" maxlength="255"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Select theme</label>

                        <div class="col-lg-10">
                            <c:forEach var="th" items="${themes}">
                                <div class="radio">
                                    <form:radiobutton path="theme" value="${th.themeid}" label="${th.name}"
                                                      element="label"/>
                                    <img src="${th.thumbnail}" height="100px">
                                </div>
                            </c:forEach>

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Main color</label>
                        <div class="col-lg-10">
                            <form:input class="form-control" path="site.color"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Header color</label>
                        <div class="col-lg-10">
                            <form:input class="form-control" path="site.hcolor" maxlength="12"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Footer color</label>
                        <div class="col-lg-10">
                            <form:input class="form-control" path="site.fcolor" maxlength="12"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Site Favicon:</label>

                        <div class="col-lg-10">
                            <img src="${siteForm.site.favicon}">
                            <br/>
                            <br/>
                            <form:input type="file" path="favicon"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.name" class="col-lg-2 control-label">Logo:</label>

                        <div class="col-lg-10">
                            <img src="${siteForm.site.desktopLogo}" height="100px">
                            <br/>
                            <br/>
                            <form:input type="file" path="desktopLogo"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Mobile Logo:</label>

                        <div class="col-lg-10">
                            <img src="${siteForm.site.mobileLogo}">
                            <br/>
                            <br/>
                            <form:input type="file" path="mobileLogo"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.facebook" class="col-lg-2 control-label">Facebook</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.facebook" maxlength="100"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.twitter" class="col-lg-2 control-label">Twitter</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.twitter" maxlength="100"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.youtube" class="col-lg-2 control-label">Youtube</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.youtube" maxlength="100"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.instagram" class="col-lg-2 control-label">Instagram</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.instagram" maxlength="100"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.googlefont" class="col-lg-2 control-label">Google Font</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.googlefont" maxlength="100"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.googletagmanager" class="col-lg-2 control-label">Google Tag Manager</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.googletagmanager" maxlength="32"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.googleanalytics" class="col-lg-2 control-label">Google Analytics</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.googleanalytics" maxlength="32"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="site.zendesk" class="col-lg-2 control-label">Zendesk</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="site.zendesk" maxlength="64"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Banner 1:</label>

                        <div class="col-lg-10">
                            <img src="${siteForm.site.banner1}">
                            <br/>
                            <form:input type="file" path="banner1"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Banner 2:</label>

                        <div class="col-lg-10">
                            <img src="${siteForm.site.banner2}">
                            <br/>
                            <form:input type="file" path="banner2"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-2 control-label">&nbsp;</label>
                        <div class="col-10">
                            <label class="radio-inline">
                                <form:radiobutton path="agentAdmin.status" value="1"/> ACTIVE &nbsp;&nbsp;&nbsp;&nbsp;
                            </label>
                            <label class="radio-inline">
                                <form:radiobutton path="agentAdmin.status" value="0"/> INACTIVE
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-2 col-lg-10">
                            <button type="submit" class="btn btn-primary">&nbsp;Save</button>
                            &nbsp;&nbsp;
                            <a href="/admin/sites" class="btn btn-link">Cancel</a>
                        </div>
                    </div>

                </form:form>
            </div>
        </div>
    </div>
</div>
    <c:if test="${canDelete}">
    <div class="mt-3">
        <div class="row">
            <div class="col-lg-12">
            <form id="deleteSiteForm" action="/admin/sites/${siteForm.site.siteid}/deleteSite" method="post">
                <div class="float-right">
                    <a href="#" class="btn btn-warning" onclick="document.getElementById('deleteSiteForm').submit();">Delete Site</a>
                </div>
            </form>
            </div>
        </div>
    </div>
    </c:if>
    <c:if test="${!canDelete}">
        <div class="mt-3">
            <div class="row">
                <div class="col-lg-12">
                    <form id="deleteCustomersForm" action="/admin/sites/${siteForm.site.siteid}/deleteAllCustomer" method="post">
                        <div class="float-right">
                            <a href="#" class="btn btn-warning" onclick="document.getElementById('deleteCustomersForm').submit();">Delete all customers</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>
<div class="mt-3 d-none">
    <form id="migrationForm" action="/admin/migration/pull-products.html" method="post">
        <input type="hidden" name="toAgentid" value="${siteForm.site.agent.agentid}">
        <div class="row">
            <div class="form-group col-3">
                <input name="siteurl" class="form-control" value="https://kiengiangpromotion.vn" placeholder="site url">
            </div>
            <div class="form-group col-3">
                <input name="resourceid" class="form-control" value="travelenet-rest-api" placeholder="reosurce id">
            </div>
            <div class="form-group col-3">
                <input name="clientid" class="form-control" value="" placeholder="client id">
            </div>
            <div class="form-group col-3">
                <input name="clientsecret" class="form-control" value="" placeholder="secret">
            </div>
            <div class="form-group col-3">
                <input name="brandid" class="form-control" value="" placeholder="brandid">
            </div>
            <div class="form-group col-3">
                <input name="categoryid" class="form-control" value="" placeholder="categoryid">
            </div>
            <div class="form-group">
                <a href="#" class="btn btn-success" onclick="document.getElementById('migrationForm').submit();">Submit</a>
            </div>
        </div>
    </form>
</div>
</div>
