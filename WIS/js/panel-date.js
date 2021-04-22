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

    $( "#new-birth-date" ).datepicker({
        changeMonth: true,
        changeYear: true,
        scrollYear: true,
        yearRange: '1900:2021'
    });
});
