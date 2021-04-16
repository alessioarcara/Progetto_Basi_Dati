<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Fogli di stile interni -->
    <link rel="stylesheet" href="css/Style.css">
    <link rel="stylesheet" href="css/StyleUser.css">
    <link rel="stylesheet" href="css/StyleSearchBar.css">

    <!-- Fogli di stile esterni -->
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- Mappa leaflet -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
          integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
          crossorigin=""/>
    <!-- jQuery ui, timepicker -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Indie+Flower&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css"rel="nofollow" integrity="sha384-r4NyP46KrjDleawBgD5tp8Y7UzmLA05oM1iAEQ17CSuDqnUK2+k9luXQOfXJCJ4I" crossorigin="anonymous">

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EBIBLIO</title>

<!-- Navbar -->
    <div class="statusBar">
        <?php
        /* Gestione header-bar iniziale per ogni user */
        if ($user) { //Solo se il cookie è presente usiamo questa visualizzazione
            $nome = $user['nome'];
            $ruolo = $user['ruolo'];
            echo
            "
                    <div class='flex-row padding-05'>
                        <div>
                            <i class='margin-top fa fa-user-circle'></i> <b>Area Utente:</b> <u>$nome</u><br>
                            <i class='margin-top fa fa-address-card'></i> <b>Ruolo:</b> <u>$ruolo</u>
                        </div>
                        <button class='new-button' id='pannello'>Pannello</a></button>
                        <button class='btn-logout' id='btn-out'><i class='fas fa-sign-out-alt'></i> Logout</button>
                    </div>
                ";
        } else {
            echo
            "
                <div class='flex-row padding-05'>
                    <div><i class='fa fa-user-circle'></i> <b>Area Utente:</b> Ospite</div>
                    <button id='btn-login' class='new-button'><i class='fas fa-sign-in-alt'></i> Sign-in</button>
                </div>
                <div id='sign-in-form' class='modal'>
                    <form id='login-form' class='modal-content animate' method='post'>
                        <div class='right'><span id='close-sign-in' class='close'><i class='fas fa-times'></i></span></div>
                        <div class='container'>
                            <label for='uname'><b>Username</b></label>
                            <input class='dim-text' type='text' placeholder='Inserisci username' name='uname' id='email' required>
                            <label for='passwd'><b>Password</b></label>
                            <input class='dim-password' type='password' placeholder='Inserisci password' name='passwd' id='password' required>
                                
                            <button class='btn-login login-color' type='submit'><i class='fas fa-sign-in-alt'></i> Login</button>
                        </div>
                    <p>Non ti sei ancora registrato? <a href='#' id='sign-up' class='set-register'>Registrati</a></p>
                    </form>
                </div>
                <div id='sign-up-form' class='modal'>
                    <div class='layout animate'>
                        <div class='right'><span id='back-sign-in' class='close'><i class='fas fa-arrow-left'></i></span></div>
                            <form id='sign-up-form-form' class='meta-layout'>
                                <!-- Dati utente -->
                                <div class='item-text-utente'>
                                    <h3>Dati utente:</h3>
                                </div>
                                <div>
                                    <label for='name'><b>Nome<sup>*</sup></b></label>
                                    <input type='text' placeholder='Inserisci nome' name='name' id='new-name' required>
                                </div>
                                <div>
                                    <label for='last-name'><b>Cognome<sup>*</sup></b></label>
                                    <input type='text' placeholder='Inserisci cognome' name='last-name' id='new-last-name' required>
                                </div>
                                <div>
                                    <label for='birth-date'><b>Data<sup>*</sup></b></label>
                                    <input type='date' placeholder='Inserisci data di nascita' name='birth-date' id='new-birth-date' required>
                                </div>
                                <div>
                                    <label for='birth-place'><b>Luogo<sup>*</sup></b></label>
                                    <input type='text' placeholder='Inserisci data di nascita' name='birth-place' id='new-birth-place' required>
                                </div>
                                <div>
                                    <label for='telephone-number'><b>Cellulare<sup>*</sup></b></label>
                                    <input type='number' placeholder='Inserisci cellulare' name='telephone-number' id='new-birth place' required>
                                </div>
                                <div>
                                    <label for='user-email'><b>Email<sup>*</sup></b></label>
                                    <input type='email' placeholder='Inserisci email' name='user-email' id='new-user-email' required>
                                </div>
                                <div class='item-user-password'>
                                    <label for='user-password'><b>Password<sup>*</sup></b></label>
                                    <input type='password' placeholder='Inserisci password' name='user-password' id='new-user-password' required>
                                </div>
                                <!-- Dati utilizzatore -->
                                <div class='item-text-utilizzatore'>
                                    <h3>Dati utilizzatore:</h3>
                                </div>
                                <div class='item-user-creation'>
                                    <label for='user-creation'><b>Creazione account<sup>*</sup></b></label>
                                    <input type='date' placeholder='Inserisci data di creazione' name='user-creation' id='new-user-creation' required>
                                </div>
                                <div class='item-account-state'>
                                    <label for='account-state'><b>Stato account<sup>*</sup></b></label>
                                    <select name='account-state' id='new-user-creation'>
                                        <option selected>--</option>
                                        <option value='Attivo'>Attivo</option>
                                        <option value='Sospeso'>Sospeso</option>
                                    </select>
                                </div>
                                <div class='item-user-job'>
                                    <label for='user-job'><b>Professione<sup>*</sup></b></label>
                                    <input type='text' placeholder='Inserisci professione' name='user-job' id='new-user-job' required>
                                </div>
                                <button class='btn-login sign-up-color item-button-register' type='submit'><i class='fa fa-user-plus'></i> Registrati</button>
                            </form>
                        </div>
                    </div>
                </div>
                ";
        }
        ?>
    </div>
<!-- Logo -->
    <div class="flex-container colorContainerHeader logo">
        <a href="/home"><img  id="logo" src="./images/logo.svg" alt="Logo"></a>
    </div>
<!-- Barra di ricerca -->
    <div class="flex-container colorContainerHeader searchBar">
        <div class="searchBarForm">
            <div class="search-dropdown">
                <button type="button" class="search-dropdown-button">Tutte le biblioteche<i class="fa fa-caret-down"></i></button>
                <div class="search-dropdown-content">
                    <a href='#' class="search-dropdown-content-element">Tutte le biblioteche</a>
                    <?php
                    foreach( $biblioteche as $biblioteca ) {
                        $nome = $biblioteca['Nome'];
                        echo "<a href='#' class='search-dropdown-content-element'> $nome </a>";
                    }
                    ?>
                </div>
            </div>
            <input class="searchLineEdit noBlueLine" type="text" placeholder="Tutte le informazioni..." style="display: none">
            <button class="search-button" type="button"><i class="fa fa-search"></i></button>
        </div>
    </div>
<!-- Bottoni per la Ricerca -->
    <div class="flex-container colorContainerSearch chk-buttons">
        <button type="button" id='chk-biblioteche' class='chk-btn'><i class="fa fa-archive"></i> Biblioteche</button>
        <button type="button" id='chk-postilettura' class='chk-btn'><i class="fa fa-user-o"></i> Posti Lettura</button>
        <button type="button" id='chk-libri' class='chk-btn'><i class="fa fa-book"></i> Libri</button>
    </div>
</head>
<body>


    {{content}}


<!-- Script esterni -->
<!-- FontAwesome -->
<script src="https://kit.fontawesome.com/45d9bf0dbf.js" crossorigin="anonymous"></script>
<!-- Mappa leaflet -->
<script   src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
          integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
          crossorigin=""></script>
<!-- jQuery core, ui, timepicker -->
<script   src="https://code.jquery.com/jquery-3.6.0.js"
          integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
          crossorigin="anonymous"></script>
<script   src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
          integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
          crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.10.0/jquery.timepicker.min.js"></script>
<!-- Script interni -->
<script src="js/scriptSearchBar.js"></script>
<script src="js/scriptSearchResponse.js"></script>
<script src="js/login.js"></script>
<script src="js/topHomepage.js"></script>
<script src="js/sign-in-up.js"></script>
<script src="js/pannello.js"></script>

</body>
</html>