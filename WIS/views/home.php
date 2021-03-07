<div class="topOne">
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

                    foreach( $classifica as $libreria ) {
                        $nome = $libreria['Nome'];
                        $percentuale = $libreria['PercentualeOccupazione'];
                        echo "<p class='card-text'> $nome - $percentuale </p>";
                    }

                ?>
            </div>
        </div>
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

                    foreach( $classificaEbook as $ebook ) {
                        $cod = $ebook['CodiceEbook'];
                        $number = $ebook['NumAccessi'];
                        echo "<p class='card-text'> $cod - $number </p>";
                    }

                ?>
            </div>
        </div>
    </div>