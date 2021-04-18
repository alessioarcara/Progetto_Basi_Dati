/* --------------- */
/* -- Funzioni -- */
/* ------------- */

/* Section Biblioteche */
$('details').on('click', function (){
    $('div[id^="map"]').each(function( index ) {
        map.invalidateSize();
    });
})

$(document).ready(function() {
    /* Setting Mappa per ogni div */
    $('div[id^="map"]').each(function( index ) {
        let res = $(this).text().split("@"),
            map = L.map($(this).attr('id'), {
                center: res,
                zoom: 15
            }),
            marker = L.marker(res).addTo(map);

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