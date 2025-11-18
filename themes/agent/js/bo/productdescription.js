$(document).ready(function() {
    var base64_encoded_path = $('#base64_encoded_path').html();
    var obj = {
        filebrowserBrowseUrl: '/ckeditor/browse/'+base64_encoded_path,
        filebrowserUploadUrl: '/ckeditor/upload/'+base64_encoded_path,
        height: 700,
        allowedContent: true,
        autoParagraph: false,
        extraAllowedContent: 'span;*(*);*{*}'
    }
    if ($('#contentvn').length) {
        CKEDITOR.replace( 'contentvn', obj);
    }
    if ($('#content').length) {
        CKEDITOR.replace( 'content', obj);
    }
    if ($('#videoContent').length) {
        CKEDITOR.replace( 'videoContent', obj);
    }
    if ($('#videoContentvn').length) {
        CKEDITOR.replace( 'videoContentvn', obj);
    }
    if ($('#faqContent').length) {
        CKEDITOR.replace( 'faqContent', obj);
    }
    if ($('#faqContentvn').length) {
        CKEDITOR.replace( 'faqContentvn', obj);
    }
    if ($('#locationContent').length) {
        CKEDITOR.replace( 'locationContent', obj);
    }
    if ($('#locationContentvn').length) {
        CKEDITOR.replace( 'locationContentvn', obj);
    }
    if ($('#featureContent').length) {
        CKEDITOR.replace( 'featureContent', obj);
    }
    if ($('#featureContentvn').length) {
        CKEDITOR.replace( 'featureContentvn', obj);
    }

    $('#isComment').on('change', function () {
        if(this.checked) {
            $('#sitePageLink').val('commentable');
        } else {
            $('#sitePageLink').val('');
        }
    });
});
