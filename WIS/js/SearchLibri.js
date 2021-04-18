/* ---------------- */
/* -- Variabili -- */
/* -------------- */

// var libri;

/* --------------- */
/* -- Funzioni -- */
/* ------------- */

/* GET GetStatoLibri */
// function getStatoLibri() {
//     $.get("./API/GetStatoLibri.php", function (data) {
//         libri = JSON.parse(JSON.parse(data).getstatolibri);
//     }).fail(function () {
//         alert("error");
//     });
// }
//
// function updateStatoLibri() {
//     $.each(libri, function(i, item) {
//         let iterator = $(".contenuto-card-risultato[data-code='" + libri[i].codicelibrocartaceo + "']").find('.circle')
//         if (libri[i].statoprestito != 'DISPONIBILE')
//             iterator.addClass('red')
//     });
// }

/* POST InserisciPrenotazione */
if ($('.prenota-post'))
    $('.prenota-post').on('click', function ( ) {
        let codice = $(this).parent().parent().find('.contenuto-card-risultato').data()['code']

        $.post( "./API/inserisciPrenotazione.php", { codice: codice })
            .done(function() {
                alert( "Prenotazione libro riuscita!" );
            })
            .fail(function() {
                alert( "Prenotazione libro non riuscita, ritentare..." );
            });
        $(this).parent().parent().find('.circle').addClass('red')
        $(this).prop('disabled', true)
        $(this).removeClass('has-hover')
    })

$('.visualizza-post').on('click', function ( ) {
})

// $(document).ready(function() {
//     getStatoLibri()
// });