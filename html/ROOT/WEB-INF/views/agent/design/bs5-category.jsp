<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<link href="/themes/mega/css/layout.css?v=1.00" rel="stylesheet">
<style>
    .js-enet-design{
        font-size: 0.8em;
    }

    /* Bars */

    #toolbars{
        flex-shrink: 0;
        position: relative;
        z-index: 2;
    }

    .bar{
    }

    /* Bar buttons */

    .bar .button{
        font-size: 11px;
        height: 22px;
        vertical-align: middle;
        line-height: 15px;
        margin-top: 5px;
        margin-left: 3px;
        padding: 3px 10px;
    }

    .bar .button i{
        font-size:14px;
    }

    #inline-editing-bar .button i,
    #column-control-bar .button i {
        font-size: 14px;
        width: 14px;
        height: 14px;
        line-height: 14px;
        color: #fff;
    }

    .bar .button.active{
        background: linear-gradient(#ABB2B3, #70797D);
    }

    .bar .spacer{
        display: inline-block;
        width: 10px;
    }

    .bar .label{
        display: inline-block;
        font-size: 11px;
        line-height: 1;
        padding-right: 5px;
        margin-top: 6px;
        vertical-align: middle;
        font-weight: bold;
        color: var(--text-color);
    }

    .bar .button {
        text-transform: none;
    }

    /* Component Toolbars */

    #component-tool-bar{
        position: absolute;
        width: 100%;
        display: block;
        z-index: 9;
        text-align: center;
        margin-top: 8px;
        pointer-events: none;
    }

    .component-bar-content {
        display: inline-block;
        text-align: center;
        height: 34px;
        padding: 0 10px;
        background: var(--component-bar-background);
        box-shadow: 0 1px 5px rgb(0 0 0 / 15%);
        white-space: nowrap;
        border-radius: 3px;
        pointer-events: all;
    }

    .component-bar-content .close {
        border-radius: 50%;
        width: 16px;
        height: 16px;
        position: relative;
        display: inline-block;
        top: 2px;
        color: var(--close-button-active-color);
        background: var(--close-button-active-bg-color);
        font-size: 13px;
        font-weight: bold;
        line-height: 16px;
        font-family: monospace;
        margin-left: 3px;
    }

    .component-bar-content .close:hover {
        background-color: var(--close-button-hover-bg-color);
        color: var(--close-button-hover-color);
    }

    #tool-bar .component-bar {
        flex: 1;
        height: 100%;
        min-width: 100px;
        overflow: hidden;
        text-align: center;
        color: white;
    }

    #tool-bar .component-bar-content {
        background: transparent;
        border: none;
        box-shadow: none;
    }

    #toolbars .button.darkgray {
        background: var(--button-dark);
        border-radius: 2px;
        margin-top:6px;
    }

    #toolbars .button.darkgray.active {
        background: var(--button-dark-active);
        box-shadow: 0 0 0 1px var(--button-dark-active);
    }

    #component-tool-bar:empty{
        display: none;
    }

    #component-tool-bar span.icon{
        padding: 4px;
        margin-left:0;
    }

    #inline-editing-bar .button,
    #column-control-bar .widen,
    #column-control-bar .narrow {
        padding: 3px 5px;
    }

    #inline-editing-bar .button{
        margin-left:0;
    }

    #inline-editing-bar .button.save,
    #inline-editing-bar .button.discard{
        padding:3px 10px;
    }

    #inline-editing-bar .button.character-input{
        padding: 3px 10px;
    }

    #column-control-bar .widen i:first-child,
    #column-control-bar .narrow i:first-child{
        margin-right: -4px;
    }

    #column-control-bar span i{
        font-weight: bold;
    }

    #dropdown-control-bar .expand-contract{
        width: 56px;
    }

</style>
<div class="d-none" id="lang">${lang}</div>


<section class="header-content bg-dark">
    <div class="text-center pt-5 pb-5 text-white">Header here</div>
    <div class="d-none" id="caturl">${category.nameurl}</div>
</section>
<section class="category body-content">
    <div class="row">
        <div class="col-9 body-content-left">

            <div class="sticky-top d-none">
                <div id="toolbars">

                    <div id="tab-bar" class="bar">
                        <div class="tab-scroll">
                            <div class="tab-holder" style=""><div class="tab active unsaved"><span class="title" title="Unsaved">Untitled</span><span class="close"></span></div></div>
                        </div>
                    </div>

                    <div id="tool-bar" class="bar">
                        <span class="button-zoom zoom-in active" data-id="zoom-in" title="Zoom In"><i class="material-icons">zoom_in</i></span>
                        <span class="button-zoom zoom-out active" data-id="zoom-out" title="Zoom Out"><i class="material-icons">zoom_out</i></span>

                        <span class="rotate-canvas active" data-id="rotate-canvas" title="Flip Canvas"><i class="material-icons">screen_rotation</i></span>

                        <span class="fit-to-canvas active" data-id="fit-to-canvas" title="Fit to Canvas"><i class="material-icons">aspect_ratio</i></span>

                        <span class="canvas-settings active" data-id="canvas-settings" title="View Options"><i class="material-icons">layers</i></span>

                        <span class="info-container">
						<span class="info device-selection">576px × 600px @ 100%</span>
					</span>

                        <span class="bar component-bar"></span>

                        <div class="page-selection">index.html</div>

                        <div class="devices"><span class="button-size xs" data-id="xs" title="XS"><i class="material-icons">phone_iphone</i></span><span class="button-size sm active" data-id="sm" title="SM"><i class="material-icons">tablet_mac</i></span><span class="button-size md" data-id="md" title="MD"><i class="material-icons">tablet</i></span><span class="button-size lg" data-id="lg" title="LG"><i class="material-icons">laptop_mac</i></span><span class="button-size xl" data-id="xl" title="XL"><i class="material-icons">desktop_windows</i></span><span class="button-size xxl" data-id="xxl" title="XXL"><i class="material-icons">tv</i></span></div>

                    </div>

                    <div id="component-tool-bar" class="bar component-bar"><div class="component-bar-content" id="column-control-bar"><span class="label">Column Position</span> <span class="button darkgray icon" title="Move Left"><i class="material-icons">arrow_back</i></span> <span class="button darkgray icon" title="Move Right"><i class="material-icons">arrow_forward</i></span> <span class="spacer"></span> <span class="label">Column Size</span> <span class="button darkgray widen icon" title="Make Wider"><i class="material-icons">keyboard_arrow_left</i><i class="material-icons">keyboard_arrow_right</i></span> <span class="button darkgray narrow icon" title="Make Narrower"><i class="material-icons">keyboard_arrow_right</i><i class="material-icons">keyboard_arrow_left</i></span> <span class="spacer"></span> <span class="label">Add Column</span> <span class="button darkgray">Before</span> <span class="button darkgray">After</span> <span class="button darkgray">End</span> <div class="close">×</div></div></div>

                </div>
            </div>


            <div class="page-layout">
                <div class="pt-4 pb-4 text-center">
                    <a href="/agent/sites/${site.siteid}/banner/album.html">Banners here</a>
                </div>
            </div>
            <c:if test="${not empty sections}">
                <c:forEach var="sitepage" items="${sections}" varStatus="theCount">
                    <div class="mt-4 page-layout sitepageid-${sitepage.sitepageid}" data-sitepageid="${sitepage.sitepageid}" data-bgcolor="${sitepage.bgcolor}" data-bgimage="${sitepage.image}" data-ordernumber="${sitepage.ordernumber}">
                        <c:choose>
                            <c:when test="${sitepage.type eq 0}">
                                <div class="layout-config" id="layout-config-${sitepage.sitepageid}">
                                    <c:if test="${theCount.count gt 1}">
                                        <a href="/agent/design/${sitepage.sitepageid}/move-up.html" class="pr-2 border-right"><i class="bi bi-arrow-up" aria-hidden="false"></i></a>
                                    </c:if>
                                    <c:if test="${theCount.count lt fn:length(sections)}">
                                        <a href="/agent/design/${sitepage.sitepageid}/move-down.html" class="pr-2 border-right"><i class="bi bi-arrow-down" aria-hidden="false"></i></a>
                                    </c:if>
                                    <a href="javascript:void(0);" onclick="changePageLayout(this)" class="layout-config-change pr-2 border-right" data-sitepageid="${sitepage.sitepageid}" data-layout="${sitepage.layout}" data-nameurl="${sitepage.nameurl}"><i class="bi bi-gear-fill" aria-hidden="false"></i></a>
                                    <a href="javascript:void(0);" onclick="deletePageLayout(this)" class="layout-config-delete pr-2 border-right text-danger" data-sitepageid="${sitepage.sitepageid}"><i class="bi bi-trash" aria-hidden="false"></i></a>
                                    <a href="javascript:void(0);" onclick="editablePageLayout(this)" class="layout-config-contenteditable" data-sitepageid="${sitepage.sitepageid}"><i class="bi bi-pencil-square" aria-hidden="false"></i></a>
                                    <a href="javascript:void(0);" onclick="saveContentPageLayout(this)" class="layout-config-content-save d-none" data-sitepageid="${sitepage.sitepageid}"><i class="bi bi-save" aria-hidden="false"></i></a>
                                </div>
                                <div class="content1 content-to-be-editable" id="page-content-${sitepage.sitepageid}" data-sitepageid="${sitepage.sitepageid}" data-nameurl="${sitepage.nameurl}">
                                        ${sitepage.content}
                                </div>
                            </c:when>
                            <c:when test="${sitepage.type eq 2000}">
                                <div class="layout-config">
                                    <c:if test="${theCount.count gt 1}">
                                        <a href="/agent/design/${sitepage.sitepageid}/move-up.html" class="pr-2 border-right"><i class="bi bi-arrow-up" aria-hidden="false"></i></a>
                                    </c:if>
                                    <c:if test="${theCount.count lt fn:length(sections)}">
                                        <a href="/agent/design/${sitepage.sitepageid}/move-down.html" class="pr-2 border-right"><i class="bi bi-arrow-down" aria-hidden="false"></i></a>
                                    </c:if>
                                    <a href="javascript:void(0);" class="config-products-layout pr-2 border-right"><i class="bi bi-gear-fill" aria-hidden="false"></i></a>
                                    <a href="javascript:void(0);" onclick="deletePageLayout(this)" class="layout-config-delete text-danger" data-sitepageid="${sitepage.sitepageid}"><i class="bi bi-trash" aria-hidden="false"></i></a>
                                </div>
                                ${sitepage.content}
                            </c:when>
                            <c:otherwise>
                                <header>
                                    <h2 class="mt-5"><span>${sitepage.name}</span></h2>
                                </header>
                                <div class="text-center">
                                        ${sitepage.content}
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </c:if>
            <div class="page-layout" id="next-page-layout">
                <div class="pt-4 pb-4 text-center">
                    <a href="javascript:void(0);" class="add-pape-layout" data-nameurl="${category.nameurl}/${nextpagenum}" data-nextpagenum="${nextpagenum}"><i class="bi bi-plus-circle
" aria-hidden="false"></i>Add new content</a>

                    <a href="javascript:void(0);" class="config-products-layout" data-nameurl="${category.nameurl}/${nextpagenum}" data-nextpagenum="${nextpagenum}"><i class="bi bi-plus-circle
" aria-hidden="false"></i>Add products section</a>
                </div>
            </div>
        </div>
        <div class="col-3 body-content-right">
            <div class="sticky-top mt-5">
                <div class="row">
                    <div class="col-lg-12 mx-auto">
                        <div>
                            <h4 class="font-semibold mb-1">Profile</h4>
                            <p class="text-sm text-muted">By filling your data you get a much better experience using
                                our website.</p>
                        </div>
                        <hr class="my-6"/>
                        <div class="row align-items-center">
                            <div class="col-md-2">
                                <h6 class="mb-0 font-semibold">Tag</h6>
                            </div>
                            <div class="col-md-10">
                                <input type="text" readonly id="js-enet-element-tagname" class="form-control form-control-sm js-enet-design">
                            </div>
                        </div>
                        <div class="row align-items-center mt-2">
                            <div class="col-md-2">
                                <h6 class="mb-0 font-semibold">Class</h6>
                            </div>
                            <div class="col-md-10">
                                <textarea type="text" class="form-control form-control-sm js-enet-design" id="js-enet-element-class-other"></textarea>
                            </div>
                        </div>
                        <div class="row align-items-center mt-2">
                            <div class="col-md-2">
                                <h6 class="mb-0 font-semibold">Html</h6>
                            </div>
                            <div class="col-md-10">
                                <textarea type="text" class="form-control form-control-sm js-enet-design" id="js-enet-element-paragraph"></textarea>
                            </div>
                        </div>
                        <div class="row align-items-center mt-2 js-enet-design-src">
                            <div class="col-md-2">
                                <h6 class="mb-0 font-semibold">Src</h6>
                            </div>
                            <div class="col-md-10">
                                <textarea type="text" class="form-control form-control-sm js-enet-design" id="js-enet-element-src"></textarea>
                            </div>
                        </div>
                        <div class="row align-items-center mt-2">
                            <div class="col-md-2">
                                <h6 class="mb-0 font-semibold">AnimationType</h6>
                            </div>
                            <div class="col-md-10">
                                <select name="animation" id="js-enet-element-animationtype" class="form-control form-control-sm">

                                </select>
                            </div>
                        </div>


                        <%--<div class="row align-items-center">
                            <div class="col-md-4">
                                <h6 class="mb-0 font-semibold">Font size</h6>
                            </div>
                            <div class="col-md-6">
                                <select class="form-select" id="js-enet-element-class-fontSize" placeholder="Your fontSize" aria-label="Default select example">

                                </select>

                            </div>
                        </div>--%>
                        <hr class="my-6"/>

                        <div class="align-items-center">
                            <button type="button" class="btn btn-neutral me-2">Cancel</button>
                            <button type="button" class="btn btn-primary js-enet-btn-duplicateElement">Duplicate</button>
                            <button type="button" class="btn btn-primary js-enet-btn-removeElement">Remove</button>
                            <%--<button type="button" class="btn btn-primary js-enet-btn-applyElement">Apply</button>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</section>
<section class="footer-content">
    <div class="footer-config">
        <a href="javascript:void(0);" class="footer-config-change pr-2 border-right"><i class="bi bi-gear-fill" aria-hidden="false"></i></a>
        <c:if test="${footer.sitepageid gt 0}">
            <a href="javascript:void(0);" class="footer-config-content-edit" onclick="editFooterContent()"><i class="bi bi-pencil-square" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" class="footer-config-content-save d-none" onclick="saveFooterContent()"><i class="bi bi-save" aria-hidden="false"></i></a>
        </c:if>
    </div>
    <div id="footer-layout-content-container" data-footerpageid="${footer.sitepageid}" data-bgcolor="${footer.bgcolor}" >
        ${footer.content}
    </div>
</section>
<div class="d-none" id="page-layout-template">
    <div class="mt-4 page-layout sitepageid-{sitepageid}">
        <div class="layout-config">
            <a href="javascript:void(0);" onclick="changePageLayout(this)" class="layout-config-change pr-2 border-right" data-sitepageid="{sitepageid}" data-layout="{layout}" data-nameurl="{nameurl}"><i class="bi bi-gear-fill" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" onclick="deletePageLayout(this)" class="layout-config-delete pr-2 border-right text-danger" data-sitepageid="{sitepageid}"><i class="bi bi-trash" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" onclick="editablePageLayout(this)" class="layout-config-contenteditable" data-sitepageid="{sitepageid}"><i class="bi bi-pencil-square" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" onclick="saveContentPageLayout(this)" class="layout-config-content-save d-none" data-sitepageid="{sitepageid}"><i class="bi bi-save" aria-hidden="false"></i></a>
        </div>
        {content}
    </div>
</div>
<div class="modal fade" id="menuItemFormModal" tabindex="-1" role="dialog" aria-labelledby="menuItemFormModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="menuItemFormModalLabel">Item</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/agent/design/category-form.html" method="post" id="menuItemForm" class="form-horizontal" role="form">
                    <input type="hidden" name="categoryid" value="0">
                    <input type="hidden" name="visible" value="true">
                    <input type="hidden" name="type" value="3">
                    <input type="hidden" name="ordernumber" value="1"/>
                    <input type="hidden" name="code"/>
                    <div class="form-group">
                        <input type="text" class="form-control" name="name" placeholder="name"/>
                    </div>
                    <div class="form-group" id="dropdownmenulink-col">
                        <div class="form-check pl-0">
                            <input type="checkbox" class="form-check-input mt-1" id="dropdownmenulink" name="dropdownmenulink" value="dropdown"/>
                            <label class="form-check-label pl-2" for="dropdownmenulink"> Is dropdown menu</label>
                        </div>
                    </div>
                    <div class="form-group" id="link-col">
                        <input type="text" class="form-control" name="link" placeholder="hyperlink"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="menuItemFormSave()"><fmt:message key="label.save"/></button>
                <button class="btn btn-delete btn-more" type="button" onclick="menuItemFormDelete()"><fmt:message key="label.remove"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="layoutsModal" tabindex="-1" role="dialog" aria-labelledby="layoutsModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="layoutsModalLabel">Select layout</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div id="layouts-container">
                    <div class="d-none" id="currentsitepageid"></div>
                    <div class="d-none" id="currentnameurl"></div>
                    <c:forEach var="layout" items="${layouts}">
                        <div class="layout-item border border-primary mt-4" data-layout="${layout.layout}">
                            <c:choose>
                                <c:when test="${not empty layout.avatar}">
                                    <img src="${layout.avatar}" height="100px">
                                </c:when>
                                <c:otherwise>
                                    ${layout.layout}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
                <div id="background-container" class="d-none">
                    <div class="row title mt-3">
                        <div class="col-md-12 pt-2 pb-2">
                            Background color & background image
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-inline mt-3">
                                <div class="form-group">
                                    <input type='text' id="layout-bg-color" />
                                </div>
                                <a href="#" class="ml-3 btn btn-more btn-change-bgcolor">Change color</a>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <form id="uploadImageForm" class="form-inline mt-3 float-right" method="post" action="/agent/design/0/upload-image.html" enctype="multipart/form-data">
                                <div class="form-group">
                                    <input type="file" name="imageFile"/>
                                </div>
                                <a href="#" class="btn btn-more btn-change-bgimage">Change image</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="uploadLogoModal" tabindex="-1" role="dialog" aria-labelledby="uploadLogoModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="uploadLogoModalLabel">Upload Logo</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="uploadLogoForm" method="post" action="/agent/design/upload-logo.html" enctype="multipart/form-data">
                    <div class="form-group">
                        <c:if test="${not empty site.desktopLogo}">
                            <img src="${site.desktopLogo}" height="100px">
                        </c:if>
                        <input type="file" name="file"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="uploadLogoSubmit()"><fmt:message key="label.upload"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="headerLayoutsModal" tabindex="-1" role="dialog" aria-labelledby="headerLayoutsLabel">
    <div class="modal-dialog" role="document" style="width:98%;max-width: 1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="headerLayoutsLabel">Change Header: click one to replace the current header</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/agent/design/header-layout-form.html" method="post" id="headerLayoutForm" class="form-horizontal" role="form">
                    <input type="hidden" name="layout" value="${headerSitePage.layout}">
                    <input type="hidden" name="bgcolor" value="${headerSitePage.bgcolor}">
                </form>
                <div id="header-layouts-container">
                    <c:forEach var="layout" items="${headers}">
                        <div class="header-layout-item-container border border-primary mt-4">
                                ${layout.layout}
                            <div class="header-layout-item ${headerSitePage.layout eq layout.layout ? 'active' : ''}" data-layout="${layout.layout}">
                                <div class="text-center">Select this</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div id="header-background-container" class="${headerSitePage.sitepageid == 0 ? 'd-none' : ''}">
                    <div class="row title mt-3">
                        <div class="col-md-12 pt-2 pb-2">
                            Background color
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-inline mt-3">
                                <div class="form-group">
                                    <input type='text' id="header-bg-color" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="saveLayoutHeader()"><fmt:message key="label.save"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="aheaderModal" tabindex="-1" role="dialog" aria-labelledby="aheaderModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="aheaderModalLabel">Link</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="aheaderForm"  method="post">
                    <input type="hidden" name="atextold" value=""/>
                    <input type="hidden" name="alinkold" value=""/>
                    <div class="form-group">
                        <label>Text</label>
                        <input type="text" class="form-control" name="atext" placeholder="name"/>
                    </div>
                    <div class="form-group">
                        <label>Hyperlink</label>
                        <input type="text" class="form-control" name="alink" placeholder="hyperlink"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="saveAheader()"><fmt:message key="label.save"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="footerLayoutsModal" tabindex="-1" role="dialog" aria-labelledby="footerLayoutsLabel">
    <div class="modal-dialog" role="document" style="max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="footerLayoutsLabel">Change Footer: click one to replace the current footer</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div id="footer-layouts-container">
                    <c:forEach var="layout" items="${footers}">
                        <div class="footer-layout-item border border-primary mt-4 ${footer.layout eq layout.layout ? 'active' : ''}" data-layout="${layout.layout}">
                                ${layout.layout}
                        </div>
                    </c:forEach>
                </div>
                <div id="footer-background-container" class="${footer.sitepageid == 0 ? 'd-none' : ''}">
                    <div class="row title mt-3">
                        <div class="col-md-12 pt-2 pb-2">
                            Background color
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-inline mt-3">
                                <div class="form-group">
                                    <input type='text' id="footer-bg-color" />
                                </div>
                                <a href="#" class="ml-3 btn btn-more btn-footer-change-bgcolor">Change color</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="afooterModal" tabindex="-1" role="dialog" aria-labelledby="afooterModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="afooterModalLabel">Link</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="afooterForm"  method="post">
                    <input type="hidden" name="atextold" value=""/>
                    <input type="hidden" name="alinkold" value=""/>
                    <div class="form-group">
                        <label>Text</label>
                        <input type="text" class="form-control" name="atext" placeholder="name"/>
                    </div>
                    <div class="form-group">
                        <label>Hyperlink</label>
                        <input type="text" class="form-control" name="alink" placeholder="hyperlink"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="saveAfooter()"><fmt:message key="label.save"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="productsLayoutModal" tabindex="-1" role="dialog" aria-labelledby="productsLayoutLabel">
    <div class="modal-dialog" role="document" style="max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="productsLayoutLabel">Change layout of products</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/agent/design/products-layout-form.html" method="post" id="productsLayoutForm" class="form-horizontal" role="form">
                    <div class="row">
                        <div class="form-group col">
                            <div class="form-check pl-0">
                                <input type="checkbox" name="isFluid" class="form-check-input mt-1" value="true" ${layoutProducts.isFluid ? 'checked' :''}/>
                                <label class="form-check-label pl-2"> Is fluid</label>
                            </div>
                        </div>
                        <div class="form-group col">
                            <label>Background color</label>
                            <input type='text' id="products-bg-color" class="form-control"/>
                            <input type="hidden" name="bgcolor" value="${layoutProducts.bgcolor}">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Title</label>
                            <input type="text" name="title" value="${layoutProducts.title}" class="form-control">
                        </div>
                        <div class="form-group col">
                            <label>Alignment</label>
                            <input type="text" name="alignTitle" value="${layoutProducts.alignTitle}" class="form-control">
                        </div>
                    </div>
                    <div id="product-item-layouts-container" class="row">
                        <c:forEach var="layout" items="${productItemLayouts}">
                            <div class="product-item-layout border border-primary mt-4 col-md-4 ${layoutProducts.layoutProductItem.layout eq layout.layout ? 'active' : ''}" data-layout="${layout.layout}">
                                    ${layout.template}
                            </div>
                        </c:forEach>
                        <input type="hidden" name="layoutProductItem.layout" value="${layoutProducts.layoutProductItem.layout}">
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Max number of products</label>
                            <input type='number' name="maxSize" class="form-control" value="${layoutProducts.maxSize}"/>
                        </div>
                        <div class="form-group col">
                            <label># item per row</label>
                            <input type='number' name="itemPerRow" class="form-control" value="${layoutProducts.itemPerRow}"/>
                        </div>
                        <div class="form-group col">
                            <label># item per row on mobile</label>
                            <input type='number' name="mobileItemPerRow" class="form-control" value="${layoutProducts.mobileItemPerRow}"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="saveLayoutProducts()"><fmt:message key="label.save"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="ajaxProductsLayoutModal" tabindex="-1" role="dialog" aria-labelledby="ajaxProductsLayoutModal">
    <div class="modal-dialog" role="document" style="max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="ajaxProductsLayoutLabel">Change layout of products</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/agent/design/ajax-products-layout-form.html" method="post" id="ajaxProductsLayoutForm" class="form-horizontal" role="form">
                    <input type='hidden' id="sitepageid" name="sitepageid" class="form-control" value=""/>
                    <input type='hidden' name="nameurl" class="form-control" value=""/>
                    <div class="row">
                        <div class="form-group col">
                            <label>Background color</label>
                            <input type='text' id="ajax-products-bg-color" class="form-control"/>
                            <input type="hidden" name="bgcolor" value="">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Layout: products-for-view | products-for-view-2 | products-for-view-3</label>
                            <input type='text' name="layout" class="form-control"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Max number of products</label>
                            <input type='number' name="maxn" class="form-control" value=""/>
                        </div>
                        <div class="form-group col">
                            <label># item per row</label>
                            <input type='number' name="colmd" class="form-control" value=""/>
                        </div>
                        <div class="form-group col">
                            <label># item per row on mobile</label>
                            <input type='number' name="col" class="form-control" value=""/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="saveLayoutAjaxProducts()"><fmt:message key="label.save"/></button>
                <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="content1 content-to-be-editable d-none" id="page-content-">
    <section class="">
        <div class="container ajax-products-for-view py-5" col="2" colmd="4" colsm="2" maxn="8" query="" bgcolor="#e91212" colxs="2">Products here</div>
    </section>
</div>
<div class="d-none" id="base64_encoded_path">${base64_encoded_path}</div>

<div class="ui-overlay d-none" style="width: 569px; height: 593px;">
    <div class="ui-temp">
        <div class="highlights history"></div>
    </div>
    <div class="ui-persistent">
        <div class="grid"><div class="grid-rect" style="width: 538px; height: 155.195px; top: -152px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 155.195px; top: -152px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 785.641px; top: 5.19531px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 260.547px; top: 5.19531px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 260.547px; top: 267.742px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 260.547px; top: 530.289px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 155.195px; top: 992.836px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 155.195px; top: 992.836px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 910.141px; top: 1150.03px; left: 14.5px;"></div><div class="grid-rect" style="width: 268px; height: 287.047px; top: 1150.03px; left: 14.5px;"></div><div class="grid-rect" style="width: 268px; height: 287.047px; top: 1150.03px; left: 284.5px;"></div><div class="grid-rect" style="width: 268px; height: 287.047px; top: 1454.08px; left: 14.5px;"></div><div class="grid-rect" style="width: 268px; height: 287.047px; top: 1454.08px; left: 284.5px;"></div><div class="grid-rect" style="width: 268px; height: 287.047px; top: 1758.12px; left: 14.5px;"></div><div class="grid-rect" style="width: 268px; height: 287.047px; top: 1758.12px; left: 284.5px;"></div><div class="grid-rect" style="width: 538px; height: 131.852px; top: 2262.17px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 131.852px; top: 2262.17px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 1260.38px; top: 2396.02px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 1260.38px; top: 2396.02px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 435.094px; top: 3858.4px; left: 14.5px;"></div><div class="grid-rect" style="width: 178px; height: 435.094px; top: 3858.4px; left: 14.5px;"></div><div class="grid-rect" style="width: 178px; height: 435.094px; top: 3858.4px; left: 194.5px;"></div><div class="grid-rect" style="width: 178px; height: 435.094px; top: 3858.4px; left: 374.5px;"></div><div class="grid-rect" style="width: 538px; height: 98px; top: 4443.49px; left: 14.5px;"></div><div class="grid-rect" style="width: 268px; height: 48px; top: 4443.49px; left: 14.5px;"></div><div class="grid-rect" style="width: 268px; height: 48px; top: 4443.49px; left: 284.5px;"></div><div class="grid-rect" style="width: 268px; height: 48px; top: 4493.49px; left: 14.5px;"></div><div class="grid-rect" style="width: 268px; height: 48px; top: 4493.49px; left: 284.5px;"></div><div class="grid-rect" style="width: 538px; height: 155.195px; top: 4691.49px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 155.195px; top: 4691.49px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 577px; top: 4848.69px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 577px; top: 4848.69px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 577px; top: 4848.69px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 244px; top: 4848.69px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 262px; top: 5094.69px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 67px; top: 5358.69px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 118px; top: 5552.69px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 38px; top: 5552.69px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 38px; top: 5592.69px; left: 14.5px;"></div><div class="grid-rect" style="width: 538px; height: 38px; top: 5632.69px; left: 14.5px;"></div></div>
        <div class="focus-bar-container"><div class="focus-bar" style="top: 167.742px; left: 26.5px; position: absolute; visibility: visible;"><div class="focus-bar-options"><span title="Move" class="move-handle"><i class="material-icons">open_with</i></span><span title="Select Parent"><i class="material-icons">arrow_upward</i></span><span title="Edit"><i class="material-icons">edit</i></span><span title="Duplicate"><i class="material-icons">content_copy</i></span><span title="Hide"><i class="material-icons">visibility_off</i></span><span title="Delete"><i class="material-icons">delete</i></span></div></div></div>
        <div class="highlights focus"><div class="focus" style="width: 516px; height: 84px; top: 167.742px; left: 26.5px; border-width: 1px;"></div></div>
        <div class="addons"></div>
        <div class="line-container">
            <div class="line" style="display: none;"></div>
        </div>
    </div>
    <%--<div class="ui-addons">
        <div class="comments-list"></div>
        <div id="custom-options-panel" class="panel-container floating-panel" style="position: absolute; display: none;"><div class="panel options-panel"><div class="content"><div class="search" style="display: none;">
            <input type="search" required="" placeholder="Search options" spellcheck="false">
            <i class="material-icons search-icon">search</i>
        </div>
            <div class="addon"></div><div class="spinner">
                <div class="bounce1"></div>
                <div class="bounce2"></div>
                <div class="bounce3"></div>
            </div>
            <div class="list"><div><div class="option-group custom-options" tabindex="0"><div class="option-group-label"><div class="title"><span class="title-text">Custom Options</span><span class="collapse" style="display: none;"></span></div><div class="addons"><div class="buttongroup copy-paste"><span class="button icon copy disabled" data-tooltip="Copy Options"><i class="copy-icon"></i></span><span class="button icon paste disabled" data-tooltip="Paste Options"><i class="paste-icon"></i></span><span class="button icon reset disabled" data-tooltip="Reset the options in this group to their default state."><i class="reset-icon"></i></span></div></div></div><div class="content"><div class="item-list-option">
                <p class="message" style="display: block;">Add custom options to this component. They will appear in the component options, and allow you to easily switch class names and attributes on or off.</p>
                <ul></ul><button class="add-button button darkgray" data-type="toggle">Add Toggle</button><button class="add-button button darkgray" data-type="dropdown">Add Dropdown</button>
            </div></div></div></div></div></div></div><div class="handle resize-panel-group visible vertical"></div><div class="handle resize-panel-group visible horizontal"></div><div class="handle resize-panel-group visible both"></div></div></div>--%>
</div>
