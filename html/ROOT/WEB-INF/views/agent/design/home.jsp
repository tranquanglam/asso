<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="d-none" id="lang">${lang}</div>
<section class="header-content">
    <div class="header-config">
        <a href="/agent/design/header.html"><i class="fa fa-cog" aria-hidden="false"></i></a>
        <a href="/" class="pl-2 border-left"><i class="fa fa-home" aria-hidden="false"></i></a>
    </div>
    <c:choose>
        <c:when test="${headerSitePage.sitepageid gt 0}">
            <div class="header-page-content-container">
            ${headerSitePage.content}
            </div>
        </c:when>
        <c:otherwise>
            <nav class="navbar navbar-inverse navbar-expand-md" id="mainNav">
        <div class="container">
            <button class="navbar-toggler mt-3" type="button" data-toggle="collapse" data-target="#navbarCollapse">
                <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
            </button>
            <c:choose>
                <c:when test="${not empty site.desktopLogo}">
                    <div class="d-inline logo-bd"><a class="navbar-brand logo" href="#"><img src="${site.desktopLogo}" alt="logo"/></a></div>
                </c:when>
                <c:otherwise>
                    <div class="d-inline logo-bd"><a class="navbar-brand logo" href="#"><i class="fa fa-2x fa-database text-white" aria-hidden="true"></i></a></div>
                </c:otherwise>
            </c:choose>
            <div class="collapse navbar-collapse" id="navbarCollapse">

                <ul class="navbar-nav flex-row menu-second ml-auto">
                    <c:set var="ordernum" value="1"/>
                    <c:if test="${not empty headerMenu}">
                        <c:forEach items="${headerMenu}" var="menu">
                            <c:set var="menuname" value="${menu.name}"/>
                            <c:choose>
                                <c:when test="${empty menu.subList}">
                                    <c:set var="ordernum" value="${menu.ordernumber}"/>
                                    <li class="nav-item">
                                        <a class="nav-link cat-item" data-categoryid="${menu.categoryid}" data-dropdownlink="dropdownlink" href="#">${menuname}</a>
                                        <c:if test="${menu.link eq 'dropdown'}">
                                            <a class="cat-item pl-0" data-categoryid="0" data-code="${menu.nameurl}/menu-${lang}-${1 + ordernum}" data-dropdownlink="link" data-ordernumber="${1 + ordernum}"><i class="fa fa-chevron-circle-down" aria-hidden="true"></i></a>
                                        </c:if>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item dropdown">
                                        <a class="cat-item" data-categoryid="${menu.categoryid}" data-dropdownlink="dropdown">${menuname}</a>
                                        <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                        <ul class="dropdown-menu">
                                            <c:forEach items="${menu.subList}" var="sub">
                                                <c:set var="ordernum" value="${sub.ordernumber}"/>
                                                <c:set var="menuname" value="${sub.name}"/>
                                                <li class="cat-item" data-categoryid="${sub.categoryid}" data-dropdownlink="link"><a href="#">${menuname}</a></li>
                                            </c:forEach>
                                            <li class="nav-item cat-item" data-categoryid="0" data-code="${menu.nameurl}/menu-${lang}-${1 + ordernum}" data-dropdownlink="link" data-ordernumber="${1 + ordernum}"><a class="nav-link" href="#"><i class="fa fa-plus-circle" aria-hidden="true"></i></a></li>
                                        </ul>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                    <li class="nav-item cat-item" data-categoryid="0" data-code="menu-${lang}-${100 + ordernum}" data-dropdownlink="dropdownlink" data-ordernumber="${100 + ordernum}">
                        <a class="nav-link" href="#">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-uppercase font-weight-light" href="#"><i class="fa fa-language" aria-hidden="true"></i> ${lang}</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
        </c:otherwise>
    </c:choose>
</section>
<section class="home body-content">
    <div class="page-layout">
        <div class="pt-4 pb-4 text-center">
            <a href="/agent/sites/${site.siteid}/banner/album.html">Banners here</a>
        </div>
    </div>
    <c:if test="${not empty sections}">
        <c:forEach var="sitepage" items="${sections}" varStatus="theCount">
            <div class="mt-4 page-layout sitepageid-${sitepage.sitepageid}" data-bgcolor="${sitepage.bgcolor}" data-bgimage="${sitepage.image}">
            <c:choose>
                <c:when test="${sitepage.type eq 0}">
                    <div class="layout-config">
                        <c:if test="${theCount.count gt 1}">
                        <a href="/agent/design/${sitepage.sitepageid}/move-up.html" class="pr-2 border-right"><i class="fa fa-arrow-up" aria-hidden="false"></i></a>
                        </c:if>
                        <c:if test="${theCount.count lt fn:length(sections)}">
                        <a href="/agent/design/${sitepage.sitepageid}/move-down.html" class="pr-2 border-right"><i class="fa fa-arrow-down" aria-hidden="false"></i></a>
                        </c:if>
                        <a href="javascript:void(0);" onclick="changePageLayout(this)" class="layout-config-change pr-2 border-right" data-sitepageid="${sitepage.sitepageid}" data-layout="${sitepage.layout}" data-nameurl="${sitepage.nameurl}"><i class="fa fa-cog" aria-hidden="false"></i></a>
                        <a href="javascript:void(0);" onclick="deletePageLayout(this)" class="layout-config-delete pr-2 border-right text-danger" data-sitepageid="${sitepage.sitepageid}"><i class="fa fa-trash" aria-hidden="false"></i></a>
                        <a href="javascript:void(0);" onclick="editablePageLayout(this)" class="layout-config-contenteditable" data-sitepageid="${sitepage.sitepageid}"><i class="fa fa-edit" aria-hidden="false"></i></a>
                        <a href="javascript:void(0);" onclick="saveContentPageLayout(this)" class="layout-config-content-save d-none" data-sitepageid="${sitepage.sitepageid}"><i class="fa fa-save" aria-hidden="false"></i></a>
                    </div>
                    <div class="content1 content-to-be-editable">
                            ${sitepage.content}
                    </div>
                </c:when>
                <c:when test="${sitepage.type eq 2000}">
                    <div class="layout-config">
                        <c:if test="${theCount.count gt 1}">
                            <a href="/agent/design/${sitepage.sitepageid}/move-up.html" class="pr-2 border-right"><i class="fa fa-arrow-up" aria-hidden="false"></i></a>
                        </c:if>
                        <c:if test="${theCount.count lt fn:length(sections)}">
                            <a href="/agent/design/${sitepage.sitepageid}/move-down.html" class="pr-2 border-right"><i class="fa fa-arrow-down" aria-hidden="false"></i></a>
                        </c:if>
                        <a href="javascript:void(0);" class="config-products-layout pr-2 border-right"><i class="fa fa-cog" aria-hidden="false"></i></a>
                        <a href="javascript:void(0);" onclick="deletePageLayout(this)" class="layout-config-delete text-danger" data-sitepageid="${sitepage.sitepageid}"><i class="fa fa-trash" aria-hidden="false"></i></a>
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
            <a href="javascript:void(0);" class="add-pape-layout" data-nameurl="index_home/${nextpagenum}" data-nextpagenum="${nextpagenum}"><i class="fa fa-plus-circle" aria-hidden="false"></i> click here to add new content</a>
        </div>
    </div>
</section>
<section class="footer-content">
    <div class="footer-config">
        <a href="javascript:void(0);" class="footer-config-change pr-2 border-right"><i class="fa fa-cog" aria-hidden="false"></i></a>
        <c:if test="${footer.sitepageid gt 0}">
            <a href="javascript:void(0);" class="footer-config-content-edit" onclick="editFooterContent()"><i class="fa fa-edit" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" class="footer-config-content-save d-none" onclick="saveFooterContent()"><i class="fa fa-save" aria-hidden="false"></i></a>
        </c:if>
    </div>
    <div id="footer-layout-content-container" data-footerpageid="${footer.sitepageid}" data-bgcolor="${footer.bgcolor}" >
        ${footer.content}
    </div>
</section>
<div class="d-none" id="page-layout-template">
    <div class="mt-4 page-layout sitepageid-{sitepageid}">
        <div class="layout-config">
            <a href="javascript:void(0);" onclick="changePageLayout(this)" class="layout-config-change pr-2 border-right" data-sitepageid="{sitepageid}" data-layout="{layout}" data-nameurl="{nameurl}"><i class="fa fa-cog" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" onclick="deletePageLayout(this)" class="layout-config-delete pr-2 border-right text-danger" data-sitepageid="{sitepageid}"><i class="fa fa-trash" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" onclick="editablePageLayout(this)" class="layout-config-contenteditable" data-sitepageid="{sitepageid}"><i class="fa fa-edit" aria-hidden="false"></i></a>
            <a href="javascript:void(0);" onclick="saveContentPageLayout(this)" class="layout-config-content-save d-none" data-sitepageid="{sitepageid}"><i class="fa fa-save" aria-hidden="false"></i></a>
        </div>
        {content}
    </div>
</div>
<div class="modal fade" id="menuItemFormModal" tabindex="-1" role="dialog" aria-labelledby="menuItemFormModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="menuItemFormModalLabel">Item</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="uploadLogoModal" tabindex="-1" role="dialog" aria-labelledby="uploadLogoModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="uploadLogoModalLabel">Upload Logo</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="headerLayoutsModal" tabindex="-1" role="dialog" aria-labelledby="headerLayoutsLabel">
    <div class="modal-dialog" role="document" style="width:98%;max-width: 1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="headerLayoutsLabel">Change Header: click one to replace the current header</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="aheaderModal" tabindex="-1" role="dialog" aria-labelledby="aheaderModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="aheaderModalLabel">Link</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="footerLayoutsModal" tabindex="-1" role="dialog" aria-labelledby="footerLayoutsLabel">
    <div class="modal-dialog" role="document" style="max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="footerLayoutsLabel">Change Footer: click one to replace the current footer</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="afooterModal" tabindex="-1" role="dialog" aria-labelledby="afooterModalLabel">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="afooterModalLabel">Link</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="productsLayoutModal" tabindex="-1" role="dialog" aria-labelledby="productsLayoutLabel">
    <div class="modal-dialog" role="document" style="max-width: 900px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="productsLayoutLabel">Change layout of products</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
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
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="d-none" id="base64_encoded_path">${base64_encoded_path}</div>
