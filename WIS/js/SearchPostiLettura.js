/* ---------------- */
/* -- Variabili -- */
/* -------------- */

var posti,
    selectedDate = "",
    selectedTime = "";

/* --------------- */
/* -- Funzioni -- */
/* ------------- */

function inputDisable(){
    $('.post-search-btn, .registrazione-datepicker, .registrazione-timepicker').prop('disabled', true)
    $('.registrazione-timepicker, .registrazione-datepicker').val("")
    $('.post-search-btn').removeClass('has-hover')
}

if($('.registrazione-form')){
    inputDisable()
}

$(".card-posto").click(function(){
    inputDisable();
    $(this).parent().parent().find('.registrazione-datepicker').prop('disabled', false)
    $('.card-posto').removeClass('selected');
    $(this).addClass('selected');
});

/* GET GetRegistrazioni */
function getRegistrazioni() {(
    $.get( "./API/GetRegistrazioni.php", function( data ) {
        posti = JSON.parse(JSON.parse(data).getregistrazioni);
    }).fail(function () {
        alert( "error" );
    })
)};

/* POST InserisciRegistrazione */
if ($('.registrazione-post'))
    $('.registrazione-post').click(function () {

        /* \SCELTA IMPLEMENTATIVA\ endTime +1H from selectedTime */
        let endTime = (parseInt(selectedTime.substr(0, 2))+1) + selectedTime.substring(2),
            posto = ($('.card-posto.selected > h5').text()).substring(6, 8).trim(),
            biblioteca = $(this).closest('.card-risultato').children('h3').text();

        $.ajax({
            method: "POST",
            url: "./API/inserisciRegistrazione.php",
            data: {
                posto: posto,
                date: selectedDate,
                biblioteca: biblioteca,
                startTime: selectedTime,
                endTime: endTime
            }
        })
            .done(function() {
                alert( "Registrazione inserita con successo" )
                getRegistrazioni()
                $('.card-posto').removeClass('selected');
                inputDisable()
            })
            .fail(function() {
                alert( "Registrazione non riuscita, ritentare..." );
            });
    })

$(document).ready(function() {

    /* Setting Datepicker */
    $('.registrazione-datepicker').datepicker({
        changeYear: false,
        changeMonth: false,
        minDate: "+1",
        maxDate: "+1M",

        onSelect: function(date) {
            $(this).parent().parent().find('.registrazione-timepicker').prop('disabled', false)

            var nextDayDate = $(this).parent().parent().find('.registrazione-datepicker').datepicker('getDate', '+1d');
            nextDayDate.setDate(nextDayDate.getDate() + 1);

            selectedDate = new Date(nextDayDate).toISOString().split('T')[0]
            let posto = ($('.card-posto.selected > h5').text()).substring(6, 8).trim(),
                biblioteca = $(this).closest('.card-risultato').children('h3').text(),
                timepicker = $(this).closest('.registrazione-form').children(':nth-child(2)'),
                orario = [];

            for (var i=0; i<posti.length; i++){
                if ((posti[i].nomebiblioteca == biblioteca) && (posti[i].numeropostolettura == posto) && (posti[i].data == selectedDate)){
                    let a = [posti[i].orainizio, posti[i].orafine];
                    orario.push(a)
                }
            };
            timepicker.timepicker('remove');
            timepicker.val('');
            // Disable selection of certain time ranges.
            // Input is an array of time pairs, like [['3:00am', '4:30am'], ['5:00pm', '8:00pm']].
            // The start of the interval will be disabled but the end won't. default: []
            timepicker.timepicker({
                show2400: true,
                timeFormat: 'H:i',
                minTime: '9:00am',
                maxTime: '18:00pm',
                step: 60,
                disableTimeRanges: orario
            })
            timepicker.on('changeTime', function (){
                selectedTime = $(this).val();
                $(this).parent().parent().find('.post-search-btn').prop('disabled', false);
                $(this).parent().parent().find('.post-search-btn').addClass('has-hover')
            });
        }
    });

    if ($('.registrazione-datepicker').length) {
        getRegistrazioni();
    };
});