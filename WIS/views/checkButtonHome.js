$('#showTableA').addClass('selectd');

$('.btnGenerico').on('click', function(){
    $('.btnGenerico').removeClass('selected');
    $(this).addClass('selected');
});