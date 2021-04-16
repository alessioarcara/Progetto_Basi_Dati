/* ---------------- */
/* -- Variabili -- */
/* -------------- */

var posti;

/* --------------- */
/* -- Funzioni -- */
/* ------------- */

/* ricerca Biblioteche */
$('details').on('click', function (){
    $('div[id^="map"]').each(function( index ) {
        map.invalidateSize();
    });
})

/* ricerca Posti lettura */
$(".card-posto").click(function(){
    $('.card-posto').removeClass('selected');
    $(this).addClass('selected');
});

$(document).ready(function() {

    /* Setting Mappa per ogni div */
    $('div[id^="map"]').each(function( index ) {
        var res = $(this).text().split("@");
        var map = L.map($(this).attr('id'), {
            center: res,
            zoom: 15
        });
        var marker = L.marker(res).addTo(map);

        L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
            foo: 'bar',
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
            id: 'mapbox/streets-v11',
            tileSize: 512,
            zoomOffset: -1,
            accessToken: 'pk.eyJ1IjoiZGlhY2xvIiwiYSI6ImNrbWplZGtxNDA2ZWMyeGxoNnoyN3kxancifQ.1TT3rARq-a6LlQ1sn-XvGQ'
        }).addTo(map);

        setInterval(function () {
            map.invalidateSize();
        }, 100);
    });

    /* Setting Datepicker */
    $('.registrazione-datepicker').datepicker({
        changeYear: false,
        changeMonth: false,
        minDate: "+1",
        maxDate: "+1M",

        onSelect: function(date) {
            date = new Date(date).toISOString().split('T')[0]
            let posto = ($('.card-posto.selected > h5').text()).substring(6, 8).trim();
            let biblioteca = $(this).closest('.card-risultato').children('h3').text();
            let timepicker = $(this).closest('#registrazione-form').children(':nth-child(2)');

            var orario = [];
            //bisogna aggiungere anche la data
            for (var i=0; i<posti.length; i++){
                console.log(new Date(date).toISOString().split('T')[0])
                if ((posti[i].nomebiblioteca == biblioteca) && (posti[i].numeropostolettura == posto) && (posti[i].data == date)){
                    let a = [posti[i].orainizio, posti[i].orafine];
                    orario.push(a)

                }
            };
            timepicker.timepicker('remove');
            console.log(orario)
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
            });
            console.log(orario)
        }
    });
    // $('.registrazione-timepicker').timepicker({
    //     show2400: true,
    //     timeFormat: 'H:i',
    //     minTime: '9:00am',
    //     maxTime: '18:00pm',
    //     step: 60,
    //     // disableTimeRanges: [
    //     //     ['10:00am', '11:00am'],
    //     //     ['3:00pm', '5:00pm']
    //     // ],
    // });

    if ($('.registrazione-datepicker').length) {
        $.get( "./API/GetRegistrazioni.php", function( data ) {
            posti = JSON.parse(JSON.parse(data).getregistrazioni);
        }).fail(function () {
            alert( "error" );
        });
    };
});