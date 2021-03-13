<div class="topOne">
    <div class="flex-container leftFlex padding05">
        <input type="button" id="showTableA" value="Top Cartacei" class="btnGenerico noBlueLine">
        <input type="button" id="showTableB" value="Top Librerie" class="btnGenerico noBlueLine dimLeft">
    </div>
    <div class="card border-dark mb-3" style="max-width: 50rem;" id="tableA">
        <div class="card-body text-dark">
            <table>
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
        </div>
    </div>

    <div class="card border-dark mb-3" style="max-width: 50rem;" id="tableB">
        <div class="card-body text-dark">
            <table>
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
    </div>
    
    <script> 
        var tableA = document.getElementById("tableA");
        var tableB = document.getElementById("tableB");

        tableB.style.display = "none";

        var btnTabA = document.getElementById("showTableA");
        var btnTabB = document.getElementById("showTableB");

        btnTabA.onclick = function () {
            tableA.style.display = "table";
            tableB.style.display = "none";
        }
        btnTabB.onclick = function () {
            tableA.style.display = "none";
            tableB.style.display = "table";
        }
    </script>
</div>

<div class="topTwo">
    <div class="dropdown">
        <button class="dropbtn">Classifiche TOP</button>
        <div class="dropdown-content">
            <a href=#>Top libri</a>
            <a href=#>Top utilizzatori</a>
            <a href=#>Top amministratori</a>
        </div>
    </div>

    <div class="card border-dark mb-3" style="max-width: 50rem;">
        <div class="card-body text-dark">
            <?php

                foreach ($classificaEbook as $ebook) {
                    $cod = $ebook['CodiceEbook'];
                    $number = $ebook['NumAccessi'];
                    echo "<p class='card-text'> $cod - $number </p>";
                }

            ?>
        </div>
    </div>
</div>