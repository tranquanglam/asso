function blogSearch(keyword) {
    window.location.href = '/blog/tag/' + keyword;
}

function replyComment(id) {
    if (id != null) {
        $("#parentid").val(id);
    }
    $('html, body').animate({
        scrollTop: $("#replyForm").offset().top + 'px'
    }, 'fast');
}
