<link rel="stylesheet" href="/Users/michaelcarchesio/Documents/Progetto_Basi_Dati/WIS/StyleAndre.css">

<div class="flex main-container">

  <div class="flex-column user-menu">
    <?php
    if ($user['ruolo'] === 'utilizzatore') {
      echo 
      '<div class="user-menu__item" id="visualizza-prenotazioni-utente">
        <p>Visualizza prenotazioni</p>
      </div>
      <div class="user-menu__item" id="visualizza-consegne">
        <p>Visualizza eventi di consegna</p>
      </div>';
    } 
    else if ($user['ruolo'] === 'volontario') {
      echo 
      '<div class="user-menu__item" id="visualizza-prenotazioni">
        <p>Visualizza tutte le prenotazioni</p>
      </div>
      <div class="user-menu__item" id="inserisci-consegna">
        <p>Inserisci evento di consegna</p>
      </div>
      <div class="user-menu__item" id="aggiorna-consegna">
        <p>Aggiorna evento di consegna</p>
      </div>';
    } else {
      echo
      '
      <div class="user-menu__item" id="visualizza-prenotazioni-admin">
        <p>Visualizza prenotazioni</p>
      </div>
      <div class="user-menu__item" id="inserisci-libro">
        <p>Inserisci libro</p>
      </div>
      <div class="user-menu__item" id="aggiorna-libro">
        <p>Aggiorna libro</p>
      </div>
      <div class="user-menu__item" id="rimuovi-libro">
        <p>Rimuovi libro</p>
      </div>
      <div class="user-menu__item" id="invia-messaggio">
        <p>Invia messaggio</p>
      </div>
      <div class="user-menu__item" id="invia-segnalazione">
        <p>Invia segnalazione</p>
      </div>
      <div class="user-menu__item" id="rimuovi-segnalazioni">
        <p>Rimuovi segnalazioni</p>
      </div>';
    }
    ?>
  </div>
  
  <div class='main-box flex-centered flex-column'>
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
          <table><tr>";
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

    // costruisco schermata iniziale
    $nome = $user['nome'];
    $ruolo = $user['ruolo'];
    echo 
      "
      <div id='title-and-role'>
        <h2>Area Utente di $nome</h2>
        <h3>Ruolo: $ruolo</h3>
      </div>
      ";
    
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
          <h1>Inserisci una nuova consegna</h1>
          <form class='main-box__form' id='inserisci-consegna-form'>
            <input type='text' name='note' id='new-note' placeholder='Note'>
            <input type='date' name='data' id='new-data'>  
            <select name='tipo' id='new-tipo'>
              <option value='Affidamento'>Affidamento</option>
              <option value='Restituzione'>Restituzione</option>
            </select>
            <input type='text' name='codice-prenotazione' id='new-codice-prenotazione' placeholder='Codice prenotazione'>
            <button>Inserisci</button>
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
            <button>Inserisci</button>
          </form>
        </div>
        ";
    } else {
      // visualizza prenotazioni biblioteca dell'amministratore specifico
      loadTable('visualizza-prenotazioni-admin', $prenotazioni, 'Prenotazioni');
      // inserisci libro
      echo 
        "
        <div class='display-none' id='inserisci-libro-box'>
          <h1>Inserisci libro</h1>
          <form class='main-box__form' id='inserisci-libro-form'>
            <input type='text' name='codice-libro' id='new-codice-libro' placeholder='Codice libro'>
            <input type='text' name='titolo' id='new-titolo' placeholder='titolo'>
            <input type='text' name='edizione' id='new-edizione' placeholder='edizione'>  
            <input type='number' name='anno' id='new-anno' placeholder='anno'>  
            <input type='text' name='genere' id='new-genere' placeholder='genere'>  
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

<script src="/js/user.js"></script>



<?php 


?>