/* ---------------- */
/* -- Variabili -- */
/* -------------- */

const searchLineEdit =
    "<input class=\"searchLineEdit noBlueLine\" " +
    "type=\"text\" " +
    "placeholder=\"Tutte le informazioni...\">",

    menuBiblioteche = $('.search-dropdown');

var chk_btn_changed;

/* --------------- */
/* -- Funzioni -- */
/* ------------- */

/* --  Checkbox buttons -- */
$('.chk-btn').on('click', function(){
    $('.chk-btn').removeClass('selected');
    $(this).addClass('selected');
    chk_btn_changed = $(this).text().replace(/\s+/g, '').toLowerCase();
});

/* -- Manipolaggio Barra di Ricerca -- */
/* -- Click event su chk-buttons delete and append constant variable -- */
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

/* -- Al click di un riquadro del menù a tendina immette il testo nel riquadro principale -- */
$('.search-dropdown-content a').click(function (){
    $(this).addClass('selected');
    $('.search-dropdown-button').text($(this).text());
});

/* GET Request ricerca biblioteche, postilettura, libri */
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

$(document).ready(function(){

    $('#chk-biblioteche').click();

});
