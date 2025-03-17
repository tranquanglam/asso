var lang = 'en';
function showLoadingMessage(messge,spinner,second) {
    if (spinner) {
        messge = messge + ' <div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div>';
    }
    $('.sending-loader-content').html(messge);
    $('.sending-loader').addClass('show');
    if (second > 0) {
        setTimeout(function() {
            hideLoadingMessage();
        }, second);
    }
}
function hideLoadingMessage() {
    $('.sending-loader-content').html('');
    $('.sending-loader').removeClass('show');
}
function generatePageLayout(msitepage) {
    var pageLayout = $('#page-layout-template').html();
    pageLayout = pageLayout.replace(/{sitepageid}/g,msitepage.sitepageid).replace('{layout}',msitepage.layout).replace('{nameurl}',msitepage.nameurl);
    return pageLayout.replace('{content}',msitepage.content);
}
function reloadlayouts() {

    var layoutTemp = '<div class="layout-item border border-primary mt-4 d-flex align-items-center" data-layout="{layout}"><img src="{image}" alt="{layout}" height="100px"></div>';
    var layoutUrl = 'https://dolaenet.io/1001/layout-templates.json';
    if ($('.layout-filter .btn-q.active').length) {
        var q = $('.layout-filter .btn-q.active').html();
        layoutUrl += '?q=' + encodeURIComponent(q);
    }
    $.ajax({
        url: layoutUrl,
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            $('.layouts-container .layout-items').html('');
            if (result.layouts != null && result.layouts.length > 0) {
                for (var i=0;i<result.layouts.length;i++) {
                    var layouti = result.layouts[i];
                    var hlayout = layoutTemp.replace('{layout}',layouti.nameurl).replace('{image}',layouti.image).replace('{layout}',layouti.nameurl);
                    $('.layouts-container .layout-items').append(hlayout);
                }
                $('.layouts-container .layout-items .layout-item').on('click',function(){
                    $('#layoutsModal').modal('hide');
                    var nextnameurl = $('.add-pape-layout').data('nameurl');
                    var nextpagenum = parseInt($('.add-pape-layout').data('nextpagenum'));
                    var currentnameurl = $('#currentnameurl').html();
                    var layout = $(this).data('layout');
                    var html = $(this).html();
                    var mSitePage = {};
                    mSitePage.layout = layout;
                    mSitePage.nameurl = currentnameurl;
                    if (nextnameurl == currentnameurl) {
                        mSitePage.ordernumber = nextpagenum;
                    }
                    $.ajax({
                        url: '/agent/design/save-layout.json',
                        type: 'POST',
                        data: JSON.stringify(mSitePage),
                        contentType: "application/json",
                        success: function(result) {
                            if (result.sitepageid != null && result.sitepageid > 0) {
                                window.location.reload();
                            }
                        }
                    });
                });
            }
        }
    });
}

function reloadFooterlayouts() {
    var layoutTemp = '<div class="layout-item border border-primary mt-4 d-flex align-items-center" data-layout="{layout}"><img src="{image}" alt="{layout}" height="100px"></div>';
    var layoutUrl = 'https://dolaenet.io/1002/layout-templates.json';
    if ($('.footer-layout-filter .btn-q.active').length) {
        var q = $('.footer-layout-filter .btn-q.active').html();
        layoutUrl += '?q=' + encodeURIComponent(q);
    }
    $.ajax({
        url: layoutUrl,
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            $('.footer-layouts-container .layout-items').html('');
            if (result.layouts != null && result.layouts.length > 0) {
                for (var i=0;i<result.layouts.length;i++) {
                    var layouti = result.layouts[i];
                    var hlayout = layoutTemp.replace('{layout}',layouti.nameurl).replace('{image}',layouti.image).replace('{layout}',layouti.nameurl);
                    $('.footer-layouts-container .layout-items').append(hlayout);
                }
                $('.footer-layouts-container .layout-items .layout-item').on('click',function(){
                    $('#footerLayoutsModal').modal('hide');
                    var layout = $(this).data('layout');
                    var mSitePage = {};
                    mSitePage.layout = layout;
                    $.ajax({
                        url: '/agent/design/save-footer-layout.json',
                        type: 'POST',
                        data: JSON.stringify(mSitePage),
                        contentType: "application/json",
                        success: function(result) {
                            if (result.sitepageid != null && result.sitepageid > 0) {
                                window.location.reload();
                            }
                        }
                    });
                });
            }
        }
    });
}
function changePageLayout(ele) {
    var sitepageid = $(ele).data('sitepageid');
    $('#currentsitepageid').html(sitepageid);
    var nameurl = $(ele).data('nameurl');
    $('#currentnameurl').html(nameurl);
    $('#layoutsModal').modal('show');
}
function deletePageLayout(ele) {
    var sitepageid = $(ele).data('sitepageid');
    bootbox.confirm("Are you sure you want to delete this item ?", function (result) {
        if (result) {
            $.ajax({
                url: '/agent/design/'+sitepageid+'/delete-page.json',
                type: 'POST',
                contentType: "application/json",
                success: function(result) {
                    $('.page-layout.sitepageid-'+sitepageid).remove();
                }
            });
        }
    });
}
function editablePageLayout(ele) {
    var sitepageid = $(ele).data('sitepageid');
    if ($('.page-layout.sitepageid-'+sitepageid+' .content-to-be-editable').length) {
        var contentid = 'sitepageid-'+sitepageid+'-content-to-be-editable';
        $('.page-layout.sitepageid-'+sitepageid+' .content-to-be-editable').attr('contenteditable','true');
        $('.page-layout.sitepageid-'+sitepageid+' .content-to-be-editable').attr('id',contentid);
        CKEDITOR.inline(contentid);
    } else {
        alert('content is wrong');
        return;
    }
    $('.page-layout.sitepageid-'+sitepageid +' .layout-config-content-save').removeClass('d-none');
    $(ele).addClass('d-none');
}

function clearContentBeforeSave() {
    $('.sform-container').empty();
    $('.enet-ajax-load-blogs').html('Blogs here');
    $('.enet-ajax-load-sitepages').html('Sitepage here');
}

function saveContentPageLayout(ele) {
    var sitepageid = $(ele).data('sitepageid');
    clearContentBeforeSave();
    var jcontent = {};
    jcontent.contents = [];
    var contenti;
    var contentid = 'sitepageid-'+sitepageid+'-content-to-be-editable';
    if (CKEDITOR.instances[contentid]) {
        contenti = CKEDITOR.instances[contentid].getData();
    } else {
        contenti = $('.page-layout.sitepageid-'+sitepageid+' .content-to-be-editable').html();
    }
    jcontent.contents.push(contenti);
    $.ajax({
        url: '/agent/design/'+sitepageid+'/save-page-content.json',
        type: 'POST',
        data: JSON.stringify(jcontent),
        contentType: "application/json",
        success: function(result) {
            window.location.reload();
        }
    });
}
function generateFooterLayout(footerpage) {
    var content = (lang == 'en') ? footerpage.content : footerpage.contentvn;
    $('#footer-layout-content-container').html(content);
}
function updateFooterBgcolor() {
    var bgcolor = $('#footer-layout-content-container').data('bgcolor');
    if (bgcolor != '') {
        $('#footer-layout-content-container').css("background-color", bgcolor);
        $("#footer-bg-color").spectrum("set",bgcolor);
    }
}
function editFooterContent() {
    $('#footer-layout-content-container').attr('contenteditable','true');
    CKEDITOR.inline('footer-layout-content-container');
    $('.footer-config-content-edit').addClass('d-none');
    $('.footer-config-content-save').removeClass('d-none');
}
function saveAfooter() {
    $('#afooterModal').modal('hide');
    var atext = $('#afooterForm').find('input[name="atext"]').val();
    var atextold = $('#afooterForm').find('input[name="atextold"]').val();
    var alink = $('#afooterForm').find('input[name="alink"]').val();
    var alinkold = $('#afooterForm').find('input[name="alinkold"]').val();
    $('#footer-layout-content-container').find('a').each(function(){
        var link = $(this).attr('link');
        var text = $(this).html();
        if (link == alinkold && text == atextold) {
            $(this).attr('link',alink);
            $(this).html(atext);
        }
    });
}
function saveFooterContent() {
    $('#footer-layout-content-container').attr('contenteditable','false');
    $('.footer-config-content-save').addClass('d-none');
    clearContentBeforeSave();
    var jcontent = {};
    jcontent.contents = [];
    if (CKEDITOR.instances['footer-layout-content-container']) {
        jcontent.contents.push(CKEDITOR.instances['footer-layout-content-container'].getData());
    } else {
        jcontent.contents.push($('#footer-layout-content-container').html());
    }
    $.ajax({
        url: '/agent/design/save-footer-content.json',
        type: 'POST',
        data: JSON.stringify(jcontent),
        contentType: "application/json",
        success: function(result) {
            $('.footer-config-content-edit').removeClass('d-none');
        }
    });
}
function addFooterLi(ele){
    var newLi = '<li><a href="#" contenteditable="true">edit me</a></li>';
    $(newLi).insertBefore($(ele).parent());
}
function saveLayoutProducts() {
    if ($('.product-item-layout.active').length) {
        var t = $("#products-bg-color").spectrum("get");
        $('#productsLayoutForm').find('input[name="bgcolor"]').val(t.toHexString());
        $('#productsLayoutForm').submit();
    }
}
function saveLayoutAjaxProducts() {
    if ($('.product-item-layout.active').length) {
        var t = $("#products-bg-color").spectrum("get");
        $('#productsLayoutForm').find('input[name="bgcolor"]').val(t.toHexString());
        $('#productsLayoutForm').submit();
    }
}

function saveLayoutAjaxProducts() {
    let sitepageid = $('#ajaxProductsLayoutModal input[name="sitepageid"]').val();
    let maxn = $('#ajaxProductsLayoutModal input[name="maxn"]').val();
    let col = $('#ajaxProductsLayoutModal input[name="col"]').val();
    let row = $('#ajaxProductsLayoutModal input[name="row"]').val();
    let colmd = $('#ajaxProductsLayoutModal input[name="colmd"]').val();
    let layout = $('#ajaxProductsLayoutModal input[name="layout"]').val();
    let layoutitem = $('#ajaxProductsLayoutModal input[name="layoutitem"]').val();
    let showprice = $('#ajaxProductsLayoutModal input[name="showprice"]').val();
    let showcart = $('#ajaxProductsLayoutModal input[name="showcart"]').val();
    let showrate = $('#ajaxProductsLayoutModal input[name="showrate"]').val();
    let showfeature = $('#ajaxProductsLayoutModal input[name="showfeature"]').val();
    let bgcolor = $('#ajaxProductsLayoutModal input[name="bgcolor"]').val();
    let title = $('#ajaxProductsLayoutModal input[name="title"]').val();
    let titleCssClass = $('#ajaxProductsLayoutModal input[name="titleCssClass"]').val();
    let query = $('#ajaxProductsLayoutModal input[name="query"]').val();
    let catids = $('#ajaxProductsLayoutModal select[name="catIds"]').val();
    let swiper = $('#ajaxProductsLayoutModal input[name="swiper"]').prop('checked');
    //let t = $("#ajax-products-bg-color").spectrum("get");
    //let bgcolor = t.toHexString();

    let $elementAjaxProducts = $($(`#page-content-${sitepageid}`).find('.ajax-products-for-view')[0]);
    $elementAjaxProducts.attr('maxn', maxn);
    $elementAjaxProducts.attr('col', col);
    $elementAjaxProducts.attr('row', row);
    $elementAjaxProducts.attr('colxs', col);
    $elementAjaxProducts.attr('colmd', colmd);
    $elementAjaxProducts.attr('bgcolor', bgcolor);
    $elementAjaxProducts.attr('layout', layout);
    $elementAjaxProducts.attr('layoutitem', layoutitem);
    $elementAjaxProducts.attr('showprice', showprice);
    $elementAjaxProducts.attr('showcart', showcart);
    $elementAjaxProducts.attr('showfeature', showfeature);
    $elementAjaxProducts.attr('showrate', showrate);
    $elementAjaxProducts.attr('title', title);
    $elementAjaxProducts.attr('titleCssClass', titleCssClass);
    $elementAjaxProducts.attr('catids', catids.toString() || '');
    $elementAjaxProducts.attr('swiper', swiper);
    $elementAjaxProducts.attr('query', query);

    var nextnameurl = $('.add-pape-layout').data('nameurl');
    var nextpagenum = parseInt($('.add-pape-layout').data('nextpagenum'));
    var currentnameurl = $('#ajaxProductsLayoutModal input[name="nameurl"]').val();
    var mSitePage = {};
    if (sitepageid != "") {
        mSitePage.sitepageid = sitepageid;
    }
    if (currentnameurl == "") {
        mSitePage.nameurl = nextnameurl;
        mSitePage.ordernumber = nextpagenum;
    } else {
        mSitePage.nameurl = currentnameurl;
    }
    if (nextnameurl == currentnameurl ) {
        mSitePage.ordernumber = nextpagenum;
    }
    mSitePage.content = $(`#page-content-${sitepageid}`).html().trim();

    $.ajax({
        url: '/agent/design/ajax-products-layout-form.json',
        type: 'POST',
        data: JSON.stringify(mSitePage),
        contentType: "application/json",
        success: function(result) {
            window.location.reload();
        }
    });
}

function saveEnetDynamicLayout() {

    let sitepageid = $('#ajaxEnetDynamicLayoutModal input[name="sitepageid"]').val();
    let layout = $('#ajaxEnetDynamicLayoutModal input[name="layout"]').val();

    let $elementAjaxProducts = $($(`#page-content-${sitepageid}`).find('.enet-layout')[0]);
    let $enetLayout = $($(`#page-content-${sitepageid} .enet-layout`)[0]);

    $enetLayout.each(function() {
        $.each(this.attributes, function() {
            if(this.specified) {
                if (this.name == 'data-enet-catids' && $('#ajaxEnetDynamicLayoutForm select[name="' + this.name + '"]').length > 0) {
                    let valueList = $('#ajaxEnetDynamicLayoutForm select[name="' + this.name + '"]').val();
                    $elementAjaxProducts.attr(this.name, valueList.join(','));
                } else {
                    let value = $('#ajaxEnetDynamicLayoutForm input[name="' + this.name + '"]').val();
                    $elementAjaxProducts.attr(this.name, value);
                }
            }
        });
    });

    var nextnameurl = $('.add-pape-layout').data('nameurl');
    var nextpagenum = parseInt($('.add-pape-layout').data('nextpagenum'));
    var currentnameurl = $('#ajaxEnetDynamicLayoutModal input[name="nameurl"]').val();
    var mSitePage = {};
    if (sitepageid != "") {
        mSitePage.sitepageid = sitepageid;
    }
    if (currentnameurl == "") {
        mSitePage.nameurl = nextnameurl;
        mSitePage.ordernumber = nextpagenum;
    } else {
        mSitePage.nameurl = currentnameurl;
    }
    if (nextnameurl == currentnameurl ) {
        mSitePage.ordernumber = nextpagenum;
    }
    mSitePage.content = $(`#page-content-${sitepageid}`).html().trim();

    $.ajax({
        url: '/agent/design/ajax-products-layout-form.json',
        type: 'POST',
        data: JSON.stringify(mSitePage),
        contentType: "application/json",
        success: function(result) {
            window.location.reload();
        }
    });
}

$(document).ready(function() {
    lang = $('#lang').html();
    var base64_encoded_path = $('#base64_encoded_path').html();
    CKEDITOR.disableAutoInline = true;
    CKEDITOR.config.filebrowserBrowseUrl = '/ckeditor/browse/'+base64_encoded_path;
    CKEDITOR.config.filebrowserUploadUrl = '/ckeditor/upload/'+base64_encoded_path;
    CKEDITOR.config.allowedContent = true;
    CKEDITOR.config.extraAllowedContent = 'span;*(*);*{*}';
    CKEDITOR.dtd.$removeEmpty.i = 0;
    CKEDITOR.dtd['a']['div'] = 1;
    CKEDITOR.dtd['a']['p'] = 1;
    CKEDITOR.dtd['a']['i'] = 1;
    CKEDITOR.dtd['a']['span'] = 1;
    CKEDITOR.config.autoParagraph = false;
    CKEDITOR.config.extraPlugins = 'sourcedialog,youtube';
    CKEDITOR.config.toolbar = [
        { name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo' ] },
        { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike' ] },
        { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent','JustifyLeft','JustifyCenter','JustifyRight','CreateDiv' ] },
        { name: 'styles', groups: [ 'styles' ],items : ['Styles','Format','FontSize' ]},
        { name: 'colors', items : [ 'TextColor','BGColor' ] },
        { name: 'links', groups: [ 'links' ],items: [ 'Link','Unlink','Anchor' ] },
        { name: 'insert', groups: [ 'insert' ], items : [ 'Image', 'Youtube'] },
        { name: 'document', groups: [ 'mode' ], items : [ 'Sourcedialog'] }
    ];
    CKEDITOR.stylesSet.add( 'my_styles', [
        { name: 'min-height-300 flex', element: 'div', attributes: { 'class': 'minh-300 d-flex' } },
        { name: 'min-height-500 flex', element: 'div', attributes: { 'class': 'minh-500 d-flex' } },
        { name: 'min-height-700 flex', element: 'div', attributes: { 'class': 'minh-700 d-flex' } },
        { name: 'min-height-900 flex', element: 'div', attributes: { 'class': 'minh-900 d-flex' } },
        { name: 'Content center', element: 'div', attributes: { 'class': 'align-self-center ml-auto mr-auto' } },
        { name: 'd-flex', element: 'div', attributes: { 'class': 'd-flex' } },
        { name: 'float-left', element: 'div', attributes: { 'class': 'float-left' } },
        { name: 'float-right', element: 'div', attributes: { 'class': 'float-right' } },
        { name: 'text-center', element: 'div', attributes: { 'class': 'text-center' } },
        { name: 'vh-100', element: 'div', attributes: { 'class': 'vh-100' } },
        { name: 'card', element: 'div', attributes: { 'class': 'card' } },
        { name: 'card-img-top', element: 'div', attributes: { 'class': 'card-img-top' } },
        { name: 'card-body', element: 'div', attributes: { 'class': 'card-body' } },
        { name: 'card-title', element: 'div', attributes: { 'class': 'card-title' } },
        { name: 'card-text', element: 'div', attributes: { 'class': 'card-text' } }
    ]);
    CKEDITOR.config.stylesSet = 'my_styles';
    $('.add-pape-layout').on('click',function(){
        var nameurl = $(this).data('nameurl');
        $('#currentnameurl').html(nameurl);
        $('#layoutsModal').modal('show');
        reloadlayouts();
    });
    $('.config-products-layout').on('click',function(){
        $('#ajaxProductsLayoutModal').modal('show');
    });
    $('.layout-filter .btn-q').on('click',function(){
        $('.layout-filter .btn-q.active').removeClass('active');
        $(this).addClass('active');
        reloadlayouts();
    });
    $('.footer-layout-filter .btn-q').on('click',function(){
        $('.footer-layout-filter .btn-q.active').removeClass('active');
        $(this).addClass('active');
        reloadFooterlayouts();
    });
    $('.footer-config-change').on('click',function(){
        $('#footerLayoutsModal').modal('show');
        reloadFooterlayouts();
    });
    $('.footer-layout-item').on('click',function(){
        $('#footerLayoutsModal').modal('hide');
        var layout = $(this).data('layout');
        var mSitePage = {};
        mSitePage.layout = layout;
        $.ajax({
            url: '/agent/design/save-footer-layout.json',
            type: 'POST',
            data: JSON.stringify(mSitePage),
            contentType: "application/json",
            success: function(result) {
                if (result.sitepageid != null && result.sitepageid > 0) {
                    window.location.reload();
                }
            }
        });
    });
    $("#footer-bg-color").spectrum({
        color: "#fff",
        preferredFormat: "hex",
        showInitial: true,
        showInput: true,
        appendTo: "#footerLayoutsModal"
    });
    updateFooterBgcolor();
    $('.btn-footer-change-bgcolor').on('click',function(){
        $('#footerLayoutsModal').modal('hide');
        var mSitePage = {};
        var t = $("#footer-bg-color").spectrum("get");
        mSitePage.bgcolor = t.toHexString();
        mSitePage.sitepageid = $('#footer-layout-content-container').data('footerpageid');
        $.ajax({
            url: '/agent/design/save-bgcolor.json',
            type: 'POST',
            data: JSON.stringify(mSitePage),
            contentType: "application/json",
            success: function(result) {
                $('#footer-layout-content-container').css("background-color", result.bgcolor);
            }
        });
    });
    $('.product-item-layout').each(function(){
       var tempalte = $(this).html().replace('${image}','/themes/mega/images/ins-01.png');
        $(this).html(tempalte);
    });
    $('.product-item-layout').on('click',function(){
        var layout = $(this).data('layout');
        $('#productsLayoutForm').find('input[name="layoutProductItem.layout"]').val(layout);
        $('.product-item-layout').removeClass('active');
        $(this).addClass('active');
    });
    $("#products-bg-color").spectrum({
        color: $('#productsLayoutForm').find('input[name="bgcolor"]').val(),
        preferredFormat: "hex",
        showInitial: true,
        showInput: true,
        appendTo: "#productsLayoutModal"
    });

    /*$("#ajax-products-bg-color").spectrum({
        color: $('#ajaxProductsLayoutForm').find('input[name="bgcolor"]').val(),
        preferredFormat: "hex",
        showInitial: true,
        showInput: true,
        appendTo: "#ajaxProductsLayoutModal"
    });*/
});
