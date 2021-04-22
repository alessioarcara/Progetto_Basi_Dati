$( function() {
    $( "#new-data" ).datepicker({
        changeYear: false,
        changeMonth: false,
        minDate: "+1",
        maxDate: "+1M"
    });
    $( "#update-data" ).datepicker({
        changeYear: false,
        changeMonth: false,
        minDate: "+1",
        maxDate: "+1M"
    });
});