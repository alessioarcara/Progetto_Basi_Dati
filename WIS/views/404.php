<div class="listarisultati-corpo">
    <?php
        echo "<div class='card-risultato' id='nessun-risultato'>
                <h3>Nessun risultato</h3>
                <div>
                    <p>Nessun risultato per <strong>";
                    $output = "";
                    foreach ($parolecercate as $parola){
                        $output = $output."$parola, ";
                    }
                    echo substr($output, 0, -2);
                    echo"</strong>.</p>
                    <p>Prova a controllare l'ortografia o utilizza termini più generici.</p>  
                </div> 
              </div>";
    ?>
</div>
