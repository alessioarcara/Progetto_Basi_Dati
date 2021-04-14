<div class="listarisultati-corpo">
<?php
    foreach ($libricartacei as $libro) {
        $codicelibrocartaceo = $libro['codicelibrocartaceo'];
        $titolocartaceo = $libro['titolocartaceo'];
        $nomeedizionecartaceo = $libro['nomeedizionecartaceo'];
        $annopubblicazionecartaceo = $libro['annopubblicazionecartaceo'];
        $generecartaceo = $libro['generecartaceo'];
//        $nomebibliotecacartaceo = $libro['nomebibliotecacartaceo'];
        $statoprestito = $libro['statoprestito'];
        $nomeautore = $libro['nomeautore'];
        $cognomeautore = $libro['cognomeautore'];
//        $statoconservazione = $libro['statoconservazione'];
//        $numpagine = $libro['numpagine'];
//        $numscaffale = $libro['numscaffale'];
//    }
//
        echo "<div class='card-risultato'>
                    <h3 class='titolo-lista-risultati'>$titolocartaceo</h3>
                    <div class='contenuto-card-risultato'>
                        <div id='immagine-libro'>
                            <img src = './images/icone/j-3.svg' alt='immagine libro' width='120' height='140'/>
                            <div class='vl'></div>
                        </div>
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
                            <p><strong>Disponibilità</strong>: ";
                                                                echo $statoprestito == 'DISPONIBILE' ?
                                                                    "<span class='circle'></span>" :
                                                                    "<span class='circle red'></span>";
                            echo"</p>
                        </div>
                    </div>
              </div>";
    }
?>
</div>
