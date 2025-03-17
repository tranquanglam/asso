CKEDITOR.dtd.$removeEmpty.i = 0;
if (l == 'vi') {
    CKEDITOR.replace( 'contentvn', {
        filebrowserBrowseUrl: '/ckeditor/browse/'+base64_encoded_path,
        filebrowserUploadUrl: '/ckeditor/upload/'+base64_encoded_path,
        height: 700,
        allowedContent: true,
        autoParagraph: false,
        extraAllowedContent: 'span;*(*);*{*}'
    });
} else if(l == 'it'){
    CKEDITOR.replace( 'contentit', {
        filebrowserBrowseUrl: '/ckeditor/browse/'+base64_encoded_path,
        filebrowserUploadUrl: '/ckeditor/upload/'+base64_encoded_path,
        height: 700,
        allowedContent: true,
        autoParagraph: false,
        extraAllowedContent: 'span;*(*);*{*}'
    });
} else {
    CKEDITOR.replace( 'content', {
        filebrowserBrowseUrl: '/ckeditor/browse/'+base64_encoded_path,
        filebrowserUploadUrl: '/ckeditor/upload/'+base64_encoded_path,
        height: 700,
        allowedContent: true,
        autoParagraph: false,
        extraAllowedContent: 'span;*(*);*{*}'
    });
}
function deleteSitePage(id) {
    if (confirm('are you sure you delete this item ?')) {
        $("#sitePageForm").append('<input type="hidden" name="deleteid" value="'+id+'">');
        $("#sitePageForm").submit();
    }
}
