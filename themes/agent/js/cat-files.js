function deleteItem(itemID){
    bootbox.confirm('Are you sure you want to delete this item ?', function(r){
        if(r){
            var deleteAlbumItemUrl = '/view3d/agent/ajax/delete-album-item.html?itemID=' + itemID;
            $.ajax({
                cache: false,
                type: "GET",
                dataType: 'json',
                url:  deleteAlbumItemUrl,
                success: function(res){
                    $('.albumItem-'+itemID).remove();
                }
            });
        }
    });
}
function editCaption(itemID) {
    $("#captionForm").find('input[name="albumitemid"]').val(itemID);
    var ordernumber = $('#item_'+itemID +' .item_ordernumber').html();
    $("#captionForm").find('input[name="ordernumber"]').val(ordernumber);
    var name = $('#item_'+itemID +' .item_name').html();
    $("#captionForm").find('input[name="name"]').val(name);
    var tag = $('#item_'+itemID +' .item_tag').html();
    $("#captionForm").find('input[name="tag"]').val(tag);
    var url = $('#item_'+itemID +' .item_url').html();
    $("#captionForm").find('input[name="url"]').val(url);
    $("#captionModal").modal("show");
}
function initDropzone(){
    var cat = $('.cat-files').html();
    var myDropzone = new Dropzone("#my-dropzone",{
        url: "/view3d/agent/"+cat+"/upload-file",
        paramName: "file", // The name that will be used to transfer the file
        maxFilesize: 60, // MB
        acceptedFiles:"image/*,application/pdf,.psd,.mp3,.mp4,.ifc,.zip,.glb,.hdr,.obj"
    });
    myDropzone.on("complete", function(file) {
        myDropzone.removeFile(file);
        window.location.reload();
    });
    $('#my-dropzone').addClass('dropzone');
}
function generateView3dLayout(){
    var contentHTML = [];
    contentHTML.push('<div class="modal fade" id="view3d_modal" tabindex="-1" aria-labelledby="view3d_modalLabel" aria-hidden="true">');
    contentHTML.push(' <div class="modal-dialog modal-xl">');
    contentHTML.push('  <div class="modal-content">');
    contentHTML.push('      <div class="modal-header">');
    contentHTML.push('        <h5 class="modal-title" id="view3d_modalLabel">3D view</h5>');
    contentHTML.push('        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>');
    contentHTML.push('      </div>');
    contentHTML.push('      <div class="modal-body">');
    contentHTML.push('          <iframe id="modal-iframe-content" class="w-100" height="600"></iframe>');
    contentHTML.push('      </div>');
    contentHTML.push('  </div>');
    contentHTML.push(' </div>');
    contentHTML.push('</div>');
    return contentHTML.join("")
}
function showView3d(itemid) {
    if (!$('#view3d_modal').length) {
        $('body').append(generateView3dLayout());
    }
    var url = window.location.protocol + '//' + window.location.hostname;
    if (url == 'http://localhost') {
        url += ':' + window.location.port;
    }
    url += '/view3d/'+itemid+'/view-item.html';
    $('#modal-iframe-content').attr('src',url);
    $("#view3d_modal").modal('show');
}
function generateSourceCodeView3dLayout(url){
    var contentHTML = [];
    contentHTML.push('<div class="modal fade" id="sourceCodeView3d_modal" tabindex="-1" aria-labelledby="sourcecodeview3d_modalLabel" aria-hidden="true">');
    contentHTML.push(' <div class="modal-dialog modal-xl">');
    contentHTML.push('  <div class="modal-content">');
    contentHTML.push('      <div class="modal-header">');
    contentHTML.push('        <h5 class="modal-title" id="sourcecodeview3d_modalLabel">Source code 3D view</h5>');
    contentHTML.push('        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>');
    contentHTML.push('      </div>');
    contentHTML.push('      <div class="modal-body">');
    contentHTML.push('          &lt;iframe src="'+url+'" class="w-100" height="600"&gt;&lt;/iframe&gt;');
    contentHTML.push('      </div>');
    contentHTML.push('  </div>');
    contentHTML.push(' </div>');
    contentHTML.push('</div>');
    return contentHTML.join("")
}
function showSourceCodeView3d(itemid) {
    if (!$('#sourceCodeView3d_modal').length) {
        $('#sourceCodeView3d_modal').remove();
    }
    var url = window.location.protocol + '//' + window.location.hostname;
    if (url == 'http://localhost') {
        url += ':' + window.location.port;
    }
    url += '/view3d/'+itemid+'/view-item.html';
    $('body').append(generateSourceCodeView3dLayout(url));
    $("#sourceCodeView3d_modal").modal('show');
}
$(document).ready(function() {
    $('.btn-view-item').on('click',function(){
        var itemid = $(this).attr('itemid');
        showView3d(itemid);
    });
    $('.btn-show-source-code-item').on('click',function(){
        var itemid = $(this).attr('itemid');
        showSourceCodeView3d(itemid);
    });
    $('.btn-edit-caption-item').on('click',function(){
        var itemid = $(this).attr('itemid');
        editCaption(itemid);
    });
    $('.btn-delete-item').on('click',function(){
        var itemid = $(this).attr('itemid');
        deleteItem(itemid);
    });
    $("#captionSave").on('click',function() {
        $("#captionForm").submit();
    });
    initDropzone();
});

