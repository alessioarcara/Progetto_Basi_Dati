var table = [
    document.getElementById("tableA"),
    document.getElementById("tableB"),
    document.getElementById("tableC"),
    document.getElementById("tableD")
];

var button = [
    document.getElementById("showTableA"),
    document.getElementById("showTableB"),
    document.getElementById("showTableC"),
    document.getElementById("showTableD")
];

// Settaggio tabelle iniziali
table[1].style.display = "none";
table[3].style.display = "none";

// Settaggio btn
button[0].style.color = "white";
button[0].style.backgroundColor = "#6c757d";
button[0].style.borderColor = "#6c757d";

button[2].style.color = "white";
button[2].style.backgroundColor = "#6c757d";
button[2].style.borderColor = "#6c757d";

// Function
function refreshTopOne (element) {
    button[0].style.color = "#6c757d";
    button[0].style.backgroundColor = "white";
    button[0].style = ":hover";

    button[1].style.color = "#6c757d";
    button[1].style.backgroundColor = "white";
    button[1].style = ":hover";

    element.style.color = "white";
    element.style.backgroundColor = "#6c757d";
    element.style.borderColor = "#6c757d";
}

function refreshTopTwo (element) {
    button[2].style.color = "#6c757d";
    button[2].style.backgroundColor = "white";
    button[2].style = ":hover";

    button[3].style.color = "#6c757d";
    button[3].style.backgroundColor = "white";
    button[3].style = ":hover";

    element.style.color = "white";
    element.style.backgroundColor = "#6c757d";
    element.style.borderColor = "#6c757d";
}

button[0].onclick = function () {
    table[0].style.display = "table";
    table[1].style.display = "none";

    refreshTopOne(button[0]);
}

button[1].onclick = function () {
    table[0].style.display = "none";
    table[1].style.display = "table";

    refreshTopOne(button[1]);
}

button[2].onclick = function () {
    table[2].style.display = "table";
    table[3].style.display = "none";

    refreshTopTwo(button[2]);
}

button[3].onclick = function () {
    table[2].style.display = "none";
    table[3].style.display = "table";

    refreshTopTwo(button[3]);
}