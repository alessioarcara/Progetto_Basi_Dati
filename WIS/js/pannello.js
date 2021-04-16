var btn_logout = document.getElementById("btn-out");
var btn_pannello = document.getElementById("pannello");

btn_logout.onclick = function () {
    document.cookie = 'email' +'=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
    /* Ricarico la pagina per eliminare la possibilità all'utente di visualizzare il proprio pannello */
    window.location.reload();
    /* Mi sposto sulla home */
    window.location.assign ("/home");
}

btn_pannello.onclick = function () {
    window.location.assign ("/user");
}