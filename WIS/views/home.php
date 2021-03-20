<link rel="stylesheet" href="StyleHome.css">

<div class="topOne">
    <div class="flex-container leftFlex padding05">
        <input type="button" id="showTableA" value="Top Cartacei" class="btnGenerico width150 noBlueLine">
        <input type="button" id="showTableB" value="Top Librerie" class="btnGenerico width150 noBlueLine dimLeft">
    </div>
    <!-- <div class="card border-dark mb-3" style="max-width: 50rem;" id="tableA">
        <div class="card-body text-dark"> -->
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
        <!-- </div>
    </div> -->

    <!-- <div class="card border-dark mb-3" style="max-width: 50rem;" id="tableB">
        <div class="card-body text-dark"> -->
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
    <!-- </div>
</div> -->

<div class="topTwo">
    <div class="flex-container leftFlex padding05">
        <input type="button" id="showTableC" value="Top Accessi Ebook" class="btnGenerico width200 noBlueLine">
        <input type="button" id="showTableD" value="Top Volontari" class="btnGenerico width150 noBlueLine dimLeft">
    </div>
    <!-- <div class="card border-dark mb-3" style="max-width: 50rem;" id="tableC">
        <div class="card-body text-dark"> -->
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
        <!-- </div>
    </div> -->

    <!-- <div class="card border-dark mb-3" style="max-width: 50rem;" id="tableD">
        <div class="card-body text-dark"> -->
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
        <!-- </div>
    </div> -->
</div>