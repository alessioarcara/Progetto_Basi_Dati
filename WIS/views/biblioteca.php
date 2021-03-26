<div class="listarisultati-corpo">

    <?php

    $counter = 1;
    foreach ($libraries as $library) {
        $name = $library['nome'];
        // $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name)));
        $via = $library['via'];
        $civico = $library['civico'];
        $cap = $library['cap'];
        $citta = $library['citta'];
        $email = $library['email'];
        $sitoweb = $library['sitoweb'];
        $notestoriche = $library['notestoriche'];
        $lat = $library['lat'];
        $long = $library['long'];

        echo "<div class='card-risultato'>
                  <h3 class='titolo-lista-risultati'>$name</h3>
                  <details>
                  <summary class='noBlueLine'>Informazioni</summary>
                        <div class='dettagli-lista-risultati'>
                            <div class='dettagli-lista-risultati note'>                    
                                <p><strong>Email</strong>: $email</p>
                                <p><strong>Sito Web</strong>: <a href='$sitoweb'>$sitoweb</a></p>
                                <p><strong>Recapito Telefonico</strong>:</p>
                                <br>
                                <p><strong>Note storiche</strong>:</p>
                                <p>$notestoriche</p>
                            </div>
                            <div class='dettagli-lista-risultati indirizzo'>
                                <p><strong>Indirizzo</strong></p>
                                <p>$via, $civico, $citta, $cap</p>
                                <div id='mapid$counter' class='map'>$lat@$long</div>         
                            </div>
                        </div>
                  </details>
              </div>";

        $counter++;
    }

    ?>
</div>
