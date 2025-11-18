$(document).ready(function() {
    $('#deleteUser').on('click', function () {
        bootbox.confirm("Are you sure you want to delete this staff ?", function (result) {
            if (result) {
                $('#formAction').val('delete');
                $('#formBean').submit();
            }
        });
    });
});