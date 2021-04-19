<link rel="stylesheet" href="css/StyleHome.css">
<div class="listarisultati-corpo">
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
                <th>Posti Occupati</th>
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
</div>