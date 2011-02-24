/*
 * Handle the moment commenting interface.
 */

$(document).ready(function (v) {
    $("#comment").submit(function () {
        // We need to remove the subpoint from the time because the django model doesn't handle it
        var t = wikiplayer.gettime();
        var tv = /([0-9]+)(\.[0-9]+)*/.exec(t)[0];
        // Set the value in the form
        jQuery("input[name='time']").attr("value", tv) 
        // Now serialize the form and send it...
        var form_data = jQuery("#comment").serialize();
        jQuery.ajax({
            url: document.location.href,
            type: "POST",
            dataType: "html",
            data: form_data,
            processData: false,
            success: function () {
                /* Want to embed the html returned here */
            }
        });
        return false;
    });
});

// End
