var lang = 'en';
function editContent(ele) {
    //alert('ok todo edit');
}
function generatePageLayout(msitepage) {
    var pageLayout = $('#page-layout-template').html();
    pageLayout = pageLayout.replace(/{sitepageid}/g,msitepage.sitepageid).replace('{layout}',msitepage.layout).replace('{nameurl}',msitepage.nameurl);
    return pageLayout.replace('{content}',msitepage.content);
}
function changePageLayout(ele) {
    var sitepageid = $(ele).data('sitepageid');
    $('#currentsitepageid').html(sitepageid);
    var nameurl = $(ele).data('nameurl');
    $('#currentnameurl').html(nameurl);
    $('#background-container').removeClass('d-none');
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
function saveContentPageLayout(ele) {
    var sitepageid = $(ele).data('sitepageid');
    var jcontent = {};
    jcontent.contents = [];
    var contenti;
    var contentid = 'sitepageid-'+sitepageid+'-content-to-be-editable';
    //clear sform content
    $('.sform-container').empty();
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

$(document).ready(function() {
    lang = $('#lang').html();
    var base64_encoded_path = $('#base64_encoded_path').html();
    CKEDITOR.disableAutoInline = false;
    CKEDITOR.config.filebrowserBrowseUrl = '/ckeditor/browse/'+base64_encoded_path;
    CKEDITOR.config.filebrowserUploadUrl = '/ckeditor/upload/'+base64_encoded_path;
    CKEDITOR.config.allowedContent = true;
    CKEDITOR.config.extraAllowedContent = '*(*);*{*}';
    CKEDITOR.dtd.$removeEmpty.i = 0;
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
    for (var i=1; i<=4; i++) {
        var si = '<div onclick="editContent(this)" data-ordernumber="'+i+'">content here</div>';
        $('.layout-item .content'+i).html(si);
    }
    $('.add-pape-layout').on('click',function(){
        var nameurl = $(this).data('nameurl');
        $('#currentnameurl').html(nameurl);
        $('#background-container').addClass('d-none');
        $('#layoutsModal').modal('show');
    });
    $('.layout-item').on('click',function(){
        $('#layoutsModal').modal('hide');
        var nextnameurl = $('.add-pape-layout').data('nameurl');
        var nextpagenum = parseInt($('.add-pape-layout').data('nextpagenum'));
        var currentnameurl = $('#currentnameurl').html();
        var layout = $(this).data('layout');
        var html = $(this).html();
        var mSitePage = {};
        mSitePage.caturl = $('#caturl').html();
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
    $("#layout-bg-color").spectrum({
        color: "#f00",
        preferredFormat: "hex",
        showInitial: true,
        showInput: true,
        appendTo: "#layoutsModal"
    });
    $('.btn-change-bgcolor').on('click',function(){
        $('#layoutsModal').modal('hide');
        var mSitePage = {};
        var t = $("#layout-bg-color").spectrum("get");
        mSitePage.bgcolor = t.toHexString();
        mSitePage.sitepageid = $('#currentsitepageid').html();
        $.ajax({
            url: '/agent/design/save-bgcolor.json',
            type: 'POST',
            data: JSON.stringify(mSitePage),
            contentType: "application/json",
            success: function(result) {
                $('.page-layout.sitepageid-'+result.sitepageid).css("background-color", result.bgcolor);
            }
        });
    });
    $('.btn-change-bgimage').on('click',function(){
        $('#layoutsModal').modal('hide');
        var currentsitepageid = $('#currentsitepageid').html();
        if (currentsitepageid != '') {
            $('#uploadImageForm').attr('action','/agent/design/'+currentsitepageid+'/upload-image.html');
            $('#uploadImageForm').submit();
        }
    });
    $('.category.body-content').find('.mt-4.page-layout').each(function(){
        var bgcolor = $(this).data('bgcolor');
        if (bgcolor != '') {
            $(this).css("background-color", bgcolor);
        }
        var bgimage = $(this).data('bgimage');
        if (bgimage != '') {
            $(this).css('background-image', 'url(' + bgimage + ')');
        }
    });

});
