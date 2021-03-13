var topCartacei = document.getElementById("tableA");
var topLibrerie = document.getElementById("tableB");
var topEbook = document.getElementById("tableC");
var topVolontari = document.getElementById("tableD");

// Settaggio tabelle iniziali
topLibrerie.style.display = "none";
topVolontari.style.display = "none";

var btnTabA = document.getElementById("showTableA");
var btnTabB = document.getElementById("showTableB");
var btnTabC = document.getElementById("showTableC");
var btnTabD = document.getElementById("showTableD");

btnTabA.onclick = function () {
    topCartacei.style.display = "table";
    topLibrerie.style.display = "none";
}
btnTabB.onclick = function () {
    topCartacei.style.display = "none";
    topLibrerie.style.display = "table";
}
btnTabC.onclick = function () {
    topEbook.style.display = "table";
    topVolontari.style.display = "none";
}
btnTabD.onclick = function () {
    topEbook.style.display = "none";
    topVolontari.style.display = "table";
}