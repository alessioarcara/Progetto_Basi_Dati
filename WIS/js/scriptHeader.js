$(document).ready(function(){
    var chk_btn_changed;
    /* --  Checkbox buttons -- */
    $('.chk-btn').on('click', function(){
        $('.chk-btn').removeClass('selected');
        $(this).addClass('selected');
        chk_btn_changed = $(this).text().replace(/\s+/g, '').toLowerCase();
    });

    /* -- Manipolaggio Barra di Ricerca -- */
    const searchLineEdit =
        "<input class=\"searchLineEdit noBlueLine\" " +
        "type=\"text\" " +
        "placeholder=\"Tutte le informazioni...\">",

        menuBiblioteche = $('.search-dropdown');

    function changeSearchBar(isSearchable) {
        $('.searchLineEdit').remove();
        $('.search-dropdown').remove();
        if (isSearchable) {
            $('.searchBarForm').prepend(searchLineEdit);
        }
        else if (!isSearchable) {
            $('.searchBarForm').prepend(menuBiblioteche);
            $('.search-dropdown-content a').click(function (){
                $('.search-dropdown-button').text($(this).text());
            });
        }
    }

    $('#chk-biblioteche, #chk-postilettura').click(function (){ changeSearchBar(false)});
    $('#chk-libri').click(function (){ changeSearchBar(true)});

    $('#chk-biblioteche').click();

    $('.search-dropdown-content a').click(function (){
        $(this).addClass('selected');
        $('.search-dropdown-button').text($(this).text());
    });

    /* GET request Ricerca */
    $('.search-button').click(function(){
        url = `./${chk_btn_changed}`
        if ($('.search-dropdown-button').length) {
            if ($('.search-dropdown-button').text() !== "Tutte le biblioteche")
                url += "?n=" + $('.search-dropdown-button').text().replace(/\s+/g, '');
        }
        else if ($('.searchLineEdit').length) {
            /* filtrering words length <= 3 */
            /* tokenizer unigram */
            if ($('.searchLineEdit').val() !== "") {
                let words = $('.searchLineEdit').val().split(" ");
                for (let i=0; i<words.length; i++) {
                    if (words[i].length <= 3){
                        words.splice(i,1)
                    }
                }
                url += "?n=" + words.join("&");
            }
        }
        window.location.assign(url);
    });


    /* Ricerca Biblioteche */
    $('details').on('click', function (){
        $('div[id^="map"]').each(function( index ) {
            map.invalidateSize();
        });
    })

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

    /* ricerca posti lettura */

    /* Posti lettura clickable div */
    $(".card-posto").click(function(){
        $('.card-posto').removeClass('selected');
        $(this).addClass('selected');
    });

    $('.registrazione-datepicker').datepicker({
        changeYear: false,
        changeMonth: false,
        minDate: "+1",
        maxDate: "+1M",

        onSelect: function(date) {
            date = new Date(date).toISOString().split('T')[0]
            let posto = ($('.card-posto.selected > h5').text()).substring(6, 8).trim();
            let biblioteca = $(this).closest('.card-risultato').children('h3').text();
            let timepicker = $(this).closest('#inserisci-registrazione').children(':nth-child(2)');

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

    var posti;
    if ($('.registrazione-datepicker').length) {
        $.get( "./API/GetRegistrazioni.php", function( data ) {
            posti = JSON.parse(JSON.parse(data).getregistrazioni);
            }).fail(function () {
                alert( "error" );
            });
    };
});

/* Javascript */
