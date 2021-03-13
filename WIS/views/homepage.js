var tableA = document.getElementById("tableA");
var tableB = document.getElementById("tableB");

tableB.style.display = "none";

var btnTabA = document.getElementById("showTableA");
var btnTabB = document.getElementById("showTableB");

btnTabA.onclick = function () {
    tableA.style.display = "table";
    tableB.style.display = "none";
}
btnTabB.onclick = function () {
    tableA.style.display = "none";
    tableB.style.display = "table";
}