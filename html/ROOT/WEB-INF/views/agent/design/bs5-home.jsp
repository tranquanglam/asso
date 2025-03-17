<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="d-none" id="lang">${lang}</div>
<section class="top-header-content bg-primary">
    <div class="container">
        <div class="text-end">
            <button class="btn btn-neutral" onclick="window.location='/agent/design/header.html'"><i class="bi bi-gear-fill"></i></button>
            <button class="btn btn-neutral" onclick="window.location='/'"><i class="bi bi-house"></i></button>
        </div>
    </div>
    <div class="text-center pt-5 pb-5 text-white">Header here</div>
</section>
<section class="home body-content">
    <div class="page-layout">
        <div class="pt-4 pb-4 text-center">
            <button class="btn btn-outline-info" onclick="window.location='/agent/sites/${site.siteid}/banner/album.html'">Banners here</button>
        </div>
    </div>
    <c:if test="${not empty sections}">
        <c:forEach var="sitepage" items="${sections}" varStatus="theCount">
            <div class="mt-4 page-layout sitepageid-${sitepage.sitepageid}" data-sitepageid="${sitepage.sitepageid}" data-bgcolor="${sitepage.bgcolor}" data-bgimage="${sitepage.image}">
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
            <a href="javascript:void(0);" class="add-pape-layout" data-nameurl="index_home/${nexturlnum}" data-nextpagenum="${nextpagenum}"><i class="bi bi-plus-circle
" aria-hidden="false"></i>Add new content</a>

            <a href="javascript:void(0);" class="config-products-layout" data-nameurl="index_home/${nexturlnum}" data-nextpagenum="${nextpagenum}"><i class="bi bi-plus-circle
" aria-hidden="false"></i>Add products section</a>

            <a href="/agent/design/footerPlugin.html" ><i class="bi bi-pencil" aria-hidden="false"></i>Config plugin footer</a>

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
<div class="modal fade" id="layoutsModal" tabindex="-1" role="dialog" aria-labelledby="layoutsModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="layoutsModalLabel">Select layout</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div class="d-flex align-items-center justify-content-center layout-filter">
                    <div class="mx-n1 d-flex align-items-center scrollable-x">
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q active" href="javascript:void(0);">Hero</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">Feature</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">CTA</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">FAQ</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">Pricing</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">Team</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">Blog</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">Gallery</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">Logos</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">Process</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">Milestone</a>
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q" href="javascript:void(0);">E-Products</a>
                    </div>
                </div>
                <div id="layouts-container" class="layouts-container">
                    <div class="d-none" id="currentsitepageid"></div>
                    <div class="d-none" id="currentnameurl"></div>
                    <div class="layout-items d-flex flex-wrap justify-content-between">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
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
                <div class="d-flex align-items-center justify-content-center footer-layout-filter">
                    <div class="mx-n1 d-flex align-items-center scrollable-x">
                        <a class="btn btn-sm rounded-pill mx-1 my-2 btn-q active" href="javascript:void(0);">Footer</a>
                    </div>
                </div>
                <div class="footer-layouts-container">
                    <div class="d-none currentsitepageid"></div>
                    <div class="d-none currentnameurl"></div>
                    <div class="layout-items d-flex flex-wrap justify-content-between">
                    </div>
                </div>

                <div id="footer-layouts-container">

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
                            <label>Title</label>
                            <input type="text" class="form-control " name="title"/>
                        </div>
                        <div class="form-group col">
                            <label>titleCssClass</label>
                            <input type="text" class="form-control " name="titleCssClass"/>
                        </div>
                        <div class="form-group col">
                            <label>Background color</label>
                            <input type="color" class="form-control form-control-color " name="bgcolor"/>
                        </div>
                    </div>
                    <div class="row">
                            <div class="form-group col">
                                <label>Show price: true | false</label>
                                <input type="input" class="form-control" name="showprice" placeholder="true | false" value="">
                            </div>
                            <div class="form-group col">
                                <label>Show cart: true | false</label>
                                <input type="input" class="form-control" name="showcart" placeholder="true | false" value="">
                            </div>
                            <div class="form-group col">
                                <label>Show feature: true | false</label>
                                <input type="input" class="form-control" name="showfeature" placeholder="true | false" value="">
                            </div>
                            <div class="form-group col">
                                <label>Show rate</label>
                                <input type="input" class="form-control" name="showrate" placeholder="true | false" value="">
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
                            <label>Layout Item: product-box | product-box-land</label>
                            <input type='text' name="layoutitem" class="form-control"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Category</label>
                            <select class="form-select select2-catIdList" name="catIds" multiple="multiple"></select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Keyword</label>
                            <input type="text" class="form-control" name="query" ></input>
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
                    <div class="row">
                        <div class="form-group col">
                            <label>Swiper</label>
                            <br>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="swiper" id="flexCheckDefault">
                                <label class="form-check-label" for="flexCheckDefault">
                                    Add Swiper
                                </label>
                            </div>
                        </div>
                        <div class="form-group col">
                            <label>row</label>
                            <input type='number' name="row" class="form-control" value=""/>
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

<div class="modal fade" id="ajaxEnetDynamicLayoutModal" tabindex="-1" role="dialog" aria-labelledby="ajaxEnetDynamicLayoutModal">
    <div class="modal-dialog" role="document" style="max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="ajaxEnetDynamicLayoutModalLabel">Change layout</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="/agent/design/ajax-products-layout-form.html" method="post" id="ajaxEnetDynamicLayoutForm" class="form-horizontal" role="form">
                    <input type='hidden' id="sitepageid" name="sitepageid" class="form-control" value=""/>
                    <input type='hidden' name="nameurl" class="form-control" value=""/>
                    <input type='hidden' name="layout" class="form-control" value=""/>
                    <div class="container enet-list-attributes">
                        <div class="row">
                            <div class="col-4">
                                <label>Title</label>
                            </div>
                            <div class="col-8">
                                <input type="text" class="form-control " name="title"/>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" onclick="saveEnetDynamicLayout()"><fmt:message key="label.save"/></button>
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
<div class="d-none" id="load-mode">design</div>
