$(document).on('click', "tr[data-link]", function() {
    window.location = $(this).data("link")
})