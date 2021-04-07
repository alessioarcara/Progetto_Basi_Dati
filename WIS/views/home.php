<link rel="stylesheet" href="StyleHome.css">

<div class="set-btn-login margin-bottom">
    <div><i class='align-left fa fa-user-circle'></i> <b>Area Utente:</b> Ospite</div>
    <button id="btn-login" class="new-button"><i class="fas fa-sign-in-alt"></i> Sign-in</button>
</div>

<div id="sign-in-form" class="modal">
    <form id="login-form" class="modal-content animate" method="post">
    <span id="close-sign-in" class="close">&times;</span>
        <div class="container">
            <label for="uname"><b>Username</b></label>
            <input class="dim-text" type="text" placeholder="Inserisci username" name="uname" id="email" required>

            <label for="passwd"><b>Password</b></label>
            <input class="dim-password" type="password" placeholder="Inserisci password" name="passwd" id="password" required>
                
            <button class="btn-login login-color" type="submit"><i class="fas fa-sign-in-alt"></i> Login</button>
        </div>

        <p>Non ti sei ancora registrato? <a id="sign-up" class="set-register">Registrati</a></p>
    </form>
</div>

<div id="sign-up-form" class="modal">
    <form id="sign-up-form" class="modal-content animate" method="post">
    <span id="back-sign-in" class="close">&larr;</span>
        <div class="container">
            <label for="usname"><b>Username<sup>*</sup></b></label>
            <input class="dim-text" type="text" placeholder="Inserisci username" name="usname" id="new-email" required>

            <label for="pass"><b>Password<sup>*</sup></b></label>
            <input class="dim-password" type="password" placeholder="Inserisci password" name="pass" id="new-password" required>

            <label for="c-pass"><b>Conferma password<sup>*</sup></b></label>
            <input class="dim-password" type="password" placeholder="Inserisci password" name="c-pass" id="confirm-password" required>
                
            <button class="btn-login sign-up-color" type="submit"><i class="fa fa-user-plus"></i> Registrati</button>
        </div>

        <p>Sta per entrare nella community di Ebiblio! La ringraziamo per la registrazione.</p>
    </form>
</div>


<div class="topOne card-home set-card-home">
    <div class="flex-container leftFlex padding05">
        <button id="showTableA" class="new-button width150"><i class="fas fa-book-open"></i> Top cartacei</button>
        <button id="showTableB" class="new-button width150 dimLeft"><i class="fa fa-building"></i> Top librerie</button>
    </div>
    <table id="tableA">
        <tr>
            <th>Libro cartaceo</th>
            <th>Edizione</th>
            <th>Prenotazioni</th>
        </tr>
            <?php
                foreach ($classificaCartacei as $cartaceo) {
                    $nomeCartaceo = $cartaceo['TitoloCartaceo'];
                    $edizione = $cartaceo['Edizione'];
                    $accessi = $cartaceo['NumeroPrenotazioni'];
                    echo "  <tr>
                                <td> $nomeCartaceo </td>
                                <td> $edizione </td>
                                <td> $accessi </td>
                            </tr>";
                }
            ?>
    </table>

    <table id="tableB">
        <tr>
            <th>Nome libreria</th>
            <th>Percentuale</th>
        </tr>
            <?php
                foreach ($classifica as $libreria) {
                    $nome = $libreria['Nome'];
                    $percentuale = $libreria['PercentualeOccupazione'];
                    echo "  <tr> 
                                <td> $nome </td>
                                <td> $percentuale % </td>
                            </tr>";
                }
            ?>
    </table>
</div>


<div class="topTwo card-home set-card-home margin-top margin-bottom">
    <div class="flex-container leftFlex padding05">
        <button id="showTableC" class="new-button width200"><i class="fas fa-door-open"></i> Top accessi</button>
        <button id="showTableD" class="new-button width150 dimLeft"><i class="fa fa-users"></i> Top volontari</button>
    </div>
    <table id="tableC">
        <tr class="trTopTwo">
            <th>Codice</th>
            <th>Nome</th>
            <th>Accessi</th>
        </tr>
        <?php
            foreach ($classificaEbook as $ebook) {
                $cod = $ebook['CodiceEbook'];
                $titolo = $ebook['TitoloEbook'];
                $accessi = $ebook['NumAccessi'];
                echo "  <tr> 
                            <td> $cod </td>
                            <td> $titolo </td>
                            <td> $accessi </td>
                        </tr>";
            }
        ?>
    </table>

    <table id="tableD">
        <tr class="trTopTwo">
            <th>Email</th>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Numero consegne</th>
        </tr>
        <?php
            foreach ($classificaVolontari as $volontario) {
                $email = $volontario['EmailVolontario'];
                $nome = $volontario['NomeVolontario'];
                $cognome = $volontario['CognomeVolontario'];
                $consegne = $volontario['Consegne'];
                echo "  <tr> 
                            <td> $email </td>
                            <td> $nome </td>
                            <td> $cognome </td>
                            <td> $consegne </td>
                        </tr>";
            }
        ?>
    </table>
</div>