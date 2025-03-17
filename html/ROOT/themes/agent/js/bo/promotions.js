function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}
$(document).ready(function () {
    $('.datepicker').flatpickr({
        enableTime: false,
        dateFormat: "m/d/Y"
    });
});