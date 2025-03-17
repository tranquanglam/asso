<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<link href="/themes/mega/css/layout.css?v=1.00" rel="stylesheet">
<div class="d-none" id="lang">${lang}</div>
<section class="header-content bg-dark">
    <div class="text-center pt-5 pb-5 text-white">Header here</div>
    <div class="d-none" id="caturl">${category.nameurl}</div>
</section>
<section class="category body-content">
    <div class="page-layout">
        <div class="pt-4 pb-4 text-center">
            <a href="/agent/sites/${site.siteid}/${album_cat}/album.html">Banners here</a>
        </div>
    </div>
    <c:if test="${not empty sections}">
        <c:forEach var="sitepage" items="${sections}" varStatus="theCount">
            <div class="mt-4 page-layout sitepageid-${sitepage.sitepageid}" data-bgcolor="${sitepage.bgcolor}" data-bgimage="${sitepage.image}">
                <c:choose>
                    <c:when test="${sitepage.type eq 0}">
                        <div class="layout-config">
                            <c:if test="${theCount.count gt 1}">
                                <a href="/agent/design/${sitepage.sitepageid}/move-up.html" class="pr-2 border-right"><i class="fa fa-long-arrow-up" aria-hidden="false"></i></a>
                            </c:if>
                            <c:if test="${theCount.count lt fn:length(sections)}">
                                <a href="/agent/design/${sitepage.sitepageid}/move-down.html" class="pr-2 border-right"><i class="fa fa-long-arrow-down" aria-hidden="false"></i></a>
                            </c:if>
                            <a href="javascript:void(0);" onclick="changePageLayout(this)" class="layout-config-change pr-2 border-right" data-sitepageid="${sitepage.sitepageid}" data-layout="${sitepage.layout}" data-nameurl="${sitepage.nameurl}"><i class="fa fa-gear" aria-hidden="false"></i></a>
                            <a href="javascript:void(0);" onclick="deletePageLayout(this)" class="layout-config-delete pr-2 border-right text-danger" data-sitepageid="${sitepage.sitepageid}"><i class="fa fa-trash" aria-hidden="false"></i></a>
                            <a href="javascript:void(0);" onclick="editablePageLayout(this)" class="layout-config-contenteditable" data-sitepageid="${sitepage.sitepageid}"><i class="fa fa-pencil" aria-hidden="false"></i></a>
                            <a href="javascript:void(0);" onclick="saveContentPageLayout(this)" class="layout-config-content-save d-none" data-sitepageid="${sitepage.sitepageid}"><i class="fa fa-save" aria-hidden="false"></i></a>
                        </div>
                        <div class="content1 content-to-be-editable">
                            ${sitepage.content}
                        </div>
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
            <a href="javascript:void(0);" class="add-pape-layout" data-nameurl="${category.nameurl}/${nextpagenum}" data-nextpagenum="${nextpagenum}"><i class="fa fa-plus-circle" aria-hidden="false"></i> click here to add new content</a>
        </div>
    </div>
</section>
<section class="footer-content bg-dark">
    <div class="text-center pt-5 pb-5">Footer here</div>
</section>
<div class="d-none" id="page-layout-template">
    <div class="mt-4 page-layout sitepageid-{sitepageid}">
        <div class="layout-config">
            <a href="javascript:void(0);" onclick="changePageLayout(this)" class="layout-config-change pr-2 border-right" data-sitepageid="{sitepageid}" data-layout="{layout}" data-nameurl="{nameurl}"><i class="fa fa-gear" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" onclick="deletePageLayout(this)" class="layout-config-delete pr-2 border-right text-danger" data-sitepageid="{sitepageid}"><i class="fa fa-trash" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" onclick="editablePageLayout(this)" class="layout-config-contenteditable" data-sitepageid="{sitepageid}"><i class="fa fa-pencil" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" onclick="saveContentPageLayout(this)" class="layout-config-content-save d-none" data-sitepageid="{sitepageid}"><i class="fa fa-save" aria-hidden="false"></i></a>
        </div>
        {content}
    </div>
</div>
<div class="modal fade" id="layoutsModal" tabindex="-1" role="dialog" aria-labelledby="layoutsModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="layoutsModalLabel">Select layout</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div id="layouts-container">
                    <div class="d-none" id="currentsitepageid"></div>
                    <div class="d-none" id="currentnameurl"></div>
                    <c:forEach var="layout" items="${layouts}">
                        <div class="layout-item border border-primary mt-4" data-layout="${layout.layout}">
                                ${layout.template}
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="d-none" id="base64_encoded_path">${base64_encoded_path}</div>
