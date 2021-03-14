/* --  Checkbox buttons -- */
$('.chk-btn').on('click', function(){
    $('.chk-btn').removeClass('selected');
    $(this).addClass('selected');
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