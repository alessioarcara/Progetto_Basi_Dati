<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <link rel="stylesheet" href="css/Style.css">
    <link rel="stylesheet" href="css/Style2.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Indie+Flower&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css"rel="nofollow" integrity="sha384-r4NyP46KrjDleawBgD5tp8Y7UzmLA05oM1iAEQ17CSuDqnUK2+k9luXQOfXJCJ4I" crossorigin="anonymous">

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <div class="statusBar">
        <button class="btn btn-dark" type="button">Mappa Biblioteche</button>
        <div class="dropdown">
            <button class="btn btn-dark dimLeft">Accedi</button>
            <div class="dropdown-content">
                <label class="margin-bottom-5">Utente: </label><br>
                <input class="margin-bottom-5" type="text" placeholder="utente"><br>
                <label class="margin-bottom-5">Password: </label><br>
                <input class="margin-bottom-5" type="password" placeholder="password"><br><br>
                <input class="margin-bottom-5" type="submit" value="E Ora?"><br>
                <br>
                <a href="#">Non sei ancora registrato?</a>
            </div>
        </div>
    </div>
    <div class="flex-container colorContainerHeader logo">
        <a href="/home"><img  id="logo" src="Logo.png" alt="Logo"></a>
    </div>
    <div class="flex-container colorContainerHeader searchBar">
        <form class="searchBarForm" action="/ricerca" method="post">
            <div class="search-dropdown">
                <button type="button" class="search-dropdown-button">Scegli una biblioteca... <i class="fa fa-caret-down"></i></button>
                <div class="search-dropdown-content">
                    <a href='#' class="search-dropdown-content-element">Tutte le biblioteche</a>
                    <?php
                    foreach( $biblioteche as $biblioteca ) {
                        $nome = $biblioteca['Nome'];
                        echo "<a href='#' class='search-dropdown-content-element'> $nome </a>";
                    }
                    ?>
                    </div>
            </div>
            <input class="searchLineEdit noBlueLine" type="text" placeholder="Tutte le informazioni...">
            <button class="search-button" type="submit"><i class="fa fa-search"></i></button>
        </form>
    </div>
    <div class="flex-container colorContainerSearch chk-buttons">
        <div class="chk-buttons-row_1">
            <button type="button" id='chk-biblioteche' class='chk-btn'><i class="fa fa-archive"></i> Biblioteche</button>
            <button type="button" id='chk-postilettura' class='chk-btn'><i class="fa fa-user-o"></i> Posti Lettura</button>
        </div>
        <div class="chk-buttons-row_2">
            <button type="button" id='chk-libricartacei' class='chk-btn'><i class="fa fa-book"></i> Libri Cartacei</button>
            <button type="button" id='chk-ebooks' class='chk-btn'><i class="fa fa-file-pdf-o"></i> Ebooks</button>
        </div>
    </div>
</head>
<body>


{{content}}


<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="js/scriptHeader.js"></script>
</body>
</html>