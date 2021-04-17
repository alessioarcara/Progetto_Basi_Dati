var btns_login = document.querySelectorAll('#btn-login');
var btn_close = document.getElementById("close-sign-in");
var btn_reg = document.getElementById("sign-up");
var btn_back_sign_in = document.getElementById("back-sign-in");

var sign_in = document.getElementById("sign-in-form");
var sign_up = document.getElementById("sign-up-form");

btns_login.forEach(btn_login => {
    btn_login.onclick = function () {
        sign_in.style.display = "block";
    }
})

btn_close.onclick = function () {
    sign_in.style.display = "none";
}

btn_reg.onclick = function() {
    sign_in.style.display = "none";
    sign_up.style.display = "block";
}

btn_back_sign_in.onclick = function () {
    sign_in.style.display = "block";
    sign_up.style.display = "none";
}