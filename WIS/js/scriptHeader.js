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
    $('#chk-libricartacei, #chk-ebooks').click(function (){ changeSearchBar(true)});

    $('#chk-biblioteche').click();

    $('.search-dropdown-content a').click(function (){
        $('.search-dropdown-button').text($(this).text());
    });

    /* GET request Ricerca */
    $('.search-button').click(function(){
        if ($('.search-dropdown-button').length) {
            parameter_search = $('.search-dropdown-button').text().replace(/\s+/g, '');
        }
        else if ($('.searchLineEdit').length){
            if ($('.searchLineEdit').val() === ""){
                parameter_search = "tutto"
            } else {
                parameter_search = $('.searchLineEdit').val().replace(/\s+/g, '')
            }
        }
        url = "./" + chk_btn_changed + "?n=" + parameter_search;
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

});


/* Javascript */
