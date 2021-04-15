<div class="listarisultati-corpo">
<?php

    $linkname = function($name) { return(str_replace(' ', '', $name)); };

    foreach ($libricartacei as $libro) {
        $codicelibrocartaceo = $libro['codicelibrocartaceo'];
        $titolocartaceo = $libro['titolocartaceo'];
        $nomeedizionecartaceo = $libro['nomeedizionecartaceo'];
        $annopubblicazionecartaceo = $libro['annopubblicazionecartaceo'];
        $generecartaceo = $libro['generecartaceo'];
        $nomebibliotecacartaceo = $libro['nomebibliotecacartaceo'];
        $statoprestito = $libro['statoprestito'];
        $nomeautore = $libro['nomeautore'];
        $cognomeautore = $libro['cognomeautore'];
        $statoconservazione = $libro['statoconservazione'];
        $numpagine = $libro['numpagine'];
        $numscaffale = $libro['numscaffale'];

        echo "<div class='card-risultato' id='card-libro'>
                    <h3 class='titolo-lista-risultati'>$titolocartaceo</h3>
                    <div class='contenuto-card-risultato' data-code='$codicelibrocartaceo'>
                        <div id='immagine-libro'>
                            <img src = './images/icone/j-3.svg' alt='immagine libro' width='120' height='140'/>
                        </div>
                        <div class='decorator-riga'>
                            <div class='vl'></div>
                            <div id='informazioni-libro'>
                                <p><strong>Autore</strong>: ";
                                if ($nomeautore[0]) {
                                    $output = "";
                                    for ($i = 0; $i < sizeof($nomeautore); ++$i){
                                         $output = $output."$nomeautore[$i] $cognomeautore[$i], ";
                                    }
                                    echo substr($output, 0, -2);
                                } else {
                                    echo "Non presente";
                                }
                                echo "</p>
                                <p><strong>Edizione</strong>: $nomeedizionecartaceo</p>
                                <p><strong>Anno Pubblicazione</strong>: $annopubblicazionecartaceo</p>
                                <p><strong>Genere</strong>: $generecartaceo</p>
                                <p><strong>Numero pagine</strong>: $numpagine</p>
                            </div>
                        </div>
                        <div class='decorator-riga'>
                            <div class='vl'></div>
                            <div id='stato-libro'>
                                <p><strong>Si trova</strong>: 
                                    <a href='/biblioteche?n=";
                                    echo $linkname($nomebibliotecacartaceo);
                                    echo"'>$nomebibliotecacartaceo
                                    </a>
                                </p>
                                <p><strong>Stato conservazione</strong>: $statoconservazione</p>
                                <p><strong>Numero scaffale</strong>: $numscaffale</p>
                                <p><strong>Disponibilità</strong>: ";
                                echo $statoprestito == 'DISPONIBILE' ?
                                    "<span class='circle'></span>" :
                                    "<span class='circle red'></span>";
                                echo"</p>
                            </div>
                        </div>
                    </div>";
                    if($statoprestito == 'DISPONIBILE') {
                        echo "<div id='prenota-libro'>
                                    <button class='post-search-btn' id='prenota-btn'>Prenota</button>
                              </div>";
                    }
                    echo "
              </div>";
    }

    foreach ($ebooks as $ebook) {
        $codiceebook = $ebook['codiceebook'];
        $titoloebook = $ebook['titoloebook'];
        $nomeedizioneebook = $ebook['nomeedizioneebook'];
        $annopubblicazioneebook = $ebook['annopubblicazioneebook'];
        $genereebook = $ebook['genereebook'];
        $pdf = $ebook['pdf'];
        $nomeautore = $ebook['nomeautore'];
        $cognomeautore = $ebook['cognomeautore'];

        echo "<div class='card-risultato' id='card-ebook'>
                    <h3 class='titolo-lista-risultati'>$titoloebook</h3>
                    <div class='contenuto-card-risultato' data-code='$codiceebook'>
                        <div id='immagine-libro'>
                            <img src = './images/icone/j-6.svg' alt='immagine libro' width='120' height='140'/>
                        </div>
                        <div class='decorator-riga'>
                            <div class='vl'></div>
                            <div id='informazioni-libro'>
                                <p><strong>Autore</strong>: ";
                                if ($nomeautore[0]) {
                                    $output = "";
                                    for ($i = 0; $i < sizeof($nomeautore); ++$i){
                                        $output = $output."$nomeautore[$i] $cognomeautore[$i], ";
                                    }
                                    echo substr($output, 0, -2);
                                } else {
                                    echo "Non presente";
                                }
                                echo "</p>
                                <p><strong>Edizione</strong>: $nomeedizioneebook</p>
                                <p><strong>Anno Pubblicazione</strong>: $annopubblicazioneebook</p>
                                <p><strong>Genere</strong>: $genereebook</p>
                            </div>
                        </div>
                        <div class='decorator-riga'>
                            <button class='post-search-btn' id='visualizza-btn'>Visualizza</button>
                        </div>
                    </div>
              </div>";
    }
?>
</div>
