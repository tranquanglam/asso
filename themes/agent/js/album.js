var siteid;
function deleteItem(itemID){
    bootbox.confirm('Are you sure you want to delete this item ?', function(r){
        if(r){
            var deleteAlbumItemUrl = '/agent/sites/'+siteid+'/ajax/deleteAlbumItem.html?itemID=' + itemID;
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
        url: "/agent/sites/"+siteid +"/" +cat+"/album.html",
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
$(document).ready(function() {
    siteid = $('.siteid').html();
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

