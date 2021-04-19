<?php
// Gestione schermata iniziale per ogni user
$nome = $user['nome'];
$ruolo = $user['ruolo'];
echo
"     <!--
      <div class='flex-column box-head colorContainerHeader'> -->
        <div class='flex user-menu'>
            <!--
            <button id='btn-menu' class='new-button'>Menù <i class='fas fa-caret-down'></i></button>
            <div id='myDropdown' class='dropdown-content'>
            -->";

if ($user['ruolo'] === 'utilizzatore') {
    echo
    '<a class="user-menu__item" id="visualizza-prenotazioni-utente" href="#scroll">Visualizza prenotazioni</a>
                <a class="user-menu__item" id="visualizza-consegne" href="#scroll">Visualizza consegne</a>';
}
else if ($user['ruolo'] === 'volontario') {
    echo
    '<a class="user-menu__item" id="visualizza-prenotazioni" href="#scroll">Visualizza le prenotazioni</a>
                <a class="user-menu__item" id="inserisci-consegna" href="#scroll">Inserisci evento consegna</a>
                <a class="user-menu__item" id="aggiorna-consegna" id="#scroll">Aggiorna evento di consegna</a>';
} else {
    echo
    '
                <a class="user-menu__item" id="visualizza-prenotazioni-admin" href="#scroll">Visualizza prenotazioni</a>
                <a class="user-menu__item" id="inserisci-libro-cartaceo" href="#scroll">Inserisci libro</a>
                <a class="user-menu__item" id="inserisci-ebook" href="#scroll">Inserisci EBook</a>
                <a class="user-menu__item" id="aggiorna-libro" href="#scroll">Aggiorna libro</a>
                <a class="user-menu__item" id="rimuovi-libro" href="#scroll">Rimuovi libro</a>
                <a class="user-menu__item" id="invia-messaggio" href="#scroll">Invia messaggio</a>
                <a class="user-menu__item" id="invia-segnalazione" href="#scroll">Invia segnalazione</a>
                <a class="user-menu__item" id="rimuovi-segnalazioni" href="#scroll">Rimuovi segnalazione</a>
                <a class="user-menu__item" id="visualizza-cluster-utilizzatore" href="#scroll">Visualizza cluster</a>';
}

echo "
            <!--
            </div> -->
        <!--  
        </div> -->
      </div>
      ";
?>

<div class="flex main-container">
    <div class='main-box flex-centered flex-column' id="scroll">
        <?php

        function loadTable($id, $datas, $title) {
            // check datas
            if (empty($datas)) {
                echo "<h2 id='$id-box' class='display-none flex-centered'>No data</h2>";
                return;
            };
            // building table
            echo
            "<div id='$id-box' class='display-none flex-centered'>
          <h1 class='main-box__title'> $title </h1>
          <table id='tableAll'><tr>";
            foreach(array_keys($datas[0]) as $key) {
                echo "<th> $key </th>";
            };
            echo
            "</tr>";

            foreach( $datas as $data ) {
                echo "<tr>";
                foreach( $data as $el) {
                    echo "<td> $el </td>";
                }
                echo "</tr>";
            };
            echo
            '</table></div>';
        };


        if ($user['ruolo'] === 'utilizzatore') {
            // costruisco tabella PRENOTAZIONI
            loadTable('visualizza-prenotazioni-utente', $prenotazioni, 'Prenotazioni');
            // costruisco tabella CONSEGNA
            loadTable('visualizza-consegne', $consegne, 'Consegne');

            // // costruisco tabella PRENOTAZIONI
            // echo
            // '<div id="visualizza-prenotazioni-box" class="display-none flex-centered">
            // <table>
            //   <tr>
            //     <th> Codice </th>
            //     <th> Data Avvio </th>
            //     <th> Data Fine </th>
            //     <th> Codice Libro Cartaceo </th>
            //   </tr>';
            // foreach( $prenotazioni as $prenotazione ) {
            //   $codice = $prenotazione['Codice'];
            //   $avvio = $prenotazione['DataAvvio'];
            //   $fine = $prenotazione['DataFine'];
            //   $codiceLibro = $prenotazione['CodiceLibro'];
            //   echo
            //   "
            //     <tr>
            //       <td> $codice </td>
            //       <td> $avvio </td>
            //       <td> $fine </td>
            //       <td> $codiceLibro </td>
            //     </tr>
            //   ";
            // };
            // echo
            // '
            // </table>
            // </div>';
        }
        else if ($user['ruolo'] === 'volontario') {
            // costruisco tabella PRENOTAZIONI
            loadTable('visualizza-prenotazioni', $prenotazioni, 'Prenotazioni');
            // form aggiungi consegna
            echo
            "
        <div class='display-none' id='inserisci-consegna-box'>
          <h2>Inserisci una nuova consegna</h2>
          <form class='main-box__form' id='inserisci-consegna-form'>
            <input type='text' name='note' id='new-note' placeholder='Note'>
            <input type='date' name='data' id='new-data'>  
            <select class='noBlueLine' name='tipo' id='new-tipo'>
              <option selected value='Affidamento'>Affidamento</option>
              <option value='Restituzione'>Restituzione</option>
            </select>
            <input type='text' name='codice-prenotazione' id='new-codice-prenotazione' placeholder='Codice prenotazione'>
            <input type='submit' class='btnGenerico noBlueLine' value='Inserisci'>
          </form>
        </div>
        ";
            // form modifica consegna
            echo
            "
        <div class='display-none' id='aggiorna-consegna-box'>
          <h1>Aggiorna evento consegna</h1>
          <form class='main-box__form' id='aggiorna-consegna-form'>
            <input type='text' name='codice-consegna' id='update-codice-consegna' placeholder='Codice consegna'>
            <input type='text' name='note' id='update-note' placeholder='Note'>
            <input type='date' name='data' id='update-data'>  
            <select name='tipo' id='update-tipo'>
              <option value='Affidamento'>Affidamento</option>
              <option value='Restituzione'>Restituzione</option>
            </select>
            <input type='text' name='codice-prenotazione' id='update-codice-prenotazione' placeholder='Codice prenotazione'>
            <input type='submit' class='btnGenerico noBlueLine' value='Inserisci'>
          </form>
        </div>
        ";
        } else {
            // visualizza prenotazioni biblioteca dell'amministratore specifico
            loadTable('visualizza-prenotazioni-admin', $prenotazioni, 'Prenotazioni');
            // visualizza cluster utilizzatori
            loadTable('visualizza-cluster-utilizzatore', $clusters, 'Cluster');
            // inserisci libro
            echo
            "
        <div class='display-none' id='inserisci-libro-cartaceo-box'>
          <h1>Inserisci libro cartaceo</h1>
          <form class='main-box__form' id='inserisci-libro-cartaceo-form'>
            <input type='text' name='titolo' id='new-titolo' placeholder='Titolo'>
            <input type='text' name='edizione' id='new-edizione' placeholder='Edizione'>  
            <input type='number' name='anno' id='new-anno' placeholder='Anno'>  
            <input type='text' name='genere' id='new-genere' placeholder='Genere'> 
            <select id='new-stato'>
              <option value='ottimo'>Ottimo</option>
              <option value='buono'>Buono</option>
              <option value='non buono'>Non buono</option>
              <option value='scadente'>Scadente</option>
            </select>
            <input type='number' name='pagine' id='new-pagine' placeholder='Pagine'>  
            <input type='number' name='num-scaffale' id='new-num-scaffale' placeholder='Numero scaffale'>  
            <div class='' id='box-autori'>
              <input type='text' name='nome-autore' id='new-nome-autore' placeholder='Nome autore'>  
              <input type='text' name='cognome-autore' id='new-cognome-autore' placeholder='Cognome autore'> 
              <a class='btn btn-primary' id='new-autore-btn'>Nuovo autore</a>
            </div>
            <button>Inserisci</button>
          </form>
        </div>
        ";
        // inserisci ebook
        echo
        "
    <div class='display-none' id='inserisci-ebook-box'>
      <h1>Inserisci EBook</h1>
      <form class='main-box__form' id='inserisci-ebook-form'>
        <input type='text' name='titolo' id='ebook-titolo' placeholder='Titolo'>
        <input type='text' name='edizione' id='ebook-edizione' placeholder='Edizione'>  
        <input type='number' name='anno' id='ebook-anno' placeholder='Anno'>  
        <input type='text' name='genere' id='ebook-genere' placeholder='Genere'> 
        <!--  <input type='number' name='dimensione' id='ebook-dimensione' placeholder='Dimensione'>  
              <input type='text' name='pdf' id='ebook-pdf' placeholder='Pdf'> -->
        <input type='file' id='ebook-pdf' name='pdf'>
        <div class='' id='box-autori-ebook'>
          <input type='text' name='nome-autore' id='ebook-nome-autore' placeholder='Nome autore'>  
          <input type='text' name='cognome-autore' id='ebook-cognome-autore' placeholder='Cognome autore'> 
          <a class='btn btn-primary' id='ebook-autore-btn'>Nuovo autore</a>
        </div>
        <button>Inserisci</button>
      </form>
    </div>
    ";
            // aggiorna libro
            echo
            "
        <div class='display-none' id='aggiorna-libro-box'>
          <h1>Aggiorna libro</h1>
          <form class='main-box__form' id='aggiorna-libro-form'>
            <input type='text' name='codice-libro' id='update-codice-libro' placeholder='Codice libro'>
            <input type='text' name='titolo' id='update-titolo' placeholder='titolo'>
            <input type='text' name='edizione' id='update-edizione' placeholder='edizione'>  
            <input type='number' name='anno' id='update-anno' placeholder='anno'>  
            <input type='text' name='genere' id='update-genere' placeholder='genere'>  
            <button>Aggiorna</button>
          </form>
        </div>
        ";
            // elimina libro
            echo
            "
        <div class='display-none' id='rimuovi-libro-box'>
          <h1>Elimina libro</h1>
          <form class='main-box__form' id='rimuovi-libro-form'>
            <input type='text' name='codice-libro' id='del-codice-libro' placeholder='Codice libro'>
            <button>Elimina</button>
          </form>
        </div>
        ";
            // invia messaggio
            echo
            "
        <div class='display-none' id='invia-messaggio-box'>
          <h1>Invia messaggio</h1>
          <form class='main-box__form' id='invia-messaggio-form'>
            <input type='text' name='msg-email' id='msg-email' placeholder='Email destinatario'>
            <input type='text' name='msg-titolo' id='msg-titolo' placeholder='Titolo messaggio'>
            <input type='text' name='msg-testo' id='msg-testo' placeholder='Testo messaggio'>
            <button>Invia</button>
          </form>
        </div>
        ";
            // invia segnalazione
            echo
            "
        <div class='display-none' id='invia-segnalazione-box'>
          <h1>Invia segnalazione</h1>
          <form class='main-box__form' id='invia-segnalazione-form'>
            <input type='text' name='segn-email-dest' id='segn-email-dest' placeholder='Email destinatario'>
            <input type='text' name='segn-testo' id='segn-testo' placeholder='Testo segnalazione'>
            <button>Segnala</button>
          </form>
        </div>
        ";
            // rimuovi segnalazioni
            echo
            "
        <div class='display-none' id='rimuovi-segnalazioni-box'>
          <h1>Elimina segnalazioni</h1>
          <form class='main-box__form' id='rimuovi-segnalazioni-form'>
            <input type='text' name='email-utilizzatore' id='email-utilizzatore' placeholder='Email utilizzatore'>
            <button>Rimuovi</button>
          </form>
        </div>
        ";
        }
        ?>
    </div>
</div>

<script src="js/user.js"></script>
<script src="js/user-menu.js"></script>