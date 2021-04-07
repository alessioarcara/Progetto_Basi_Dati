<!DOCTYPE html>
<html lang="en">
<head>

    <link rel="stylesheet" href="StyleMain.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css"rel="nofollow" integrity="sha384-r4NyP46KrjDleawBgD5tp8Y7UzmLA05oM1iAEQ17CSuDqnUK2+k9luXQOfXJCJ4I" crossorigin="anonymous">
    <script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" data-auto-replace-svg></script>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EBIBLIO</title>
</head>
<body>
    <div class="flex-container logo">
        <a href="/home"><img  id="logo" src="logo.png" alt="Logo"></a>
    </div>

    <div class="ricerca">

        <div class="flex-container">
            <input type="text" class="form-control" placeholder="Tutte le informazioni">
            
            <input type="checkbox" class="btn-check" id="btn-check-1-outlined" checked autocomplete="off">
            <label class="btn btn-outline-secondary dimLeft2" for="btn-check-1-outlined">Biblioteche</label>
            
            <a href="Page2.html"><button type="button" class="btn btn-secondary dimLeft"><i class="fa fa-search"></i></button></a>
        </div>
        <br>
        <div class="flex-container">
            <input type="checkbox" class="btn-check" id="btn-check-2-outlined" autocomplete="off">
            <label class="btn btn-outline-dark" for="btn-check-2-outlined"><i class="far fa-user"></i> Posto lettura</label>

            <input type="checkbox" class="btn-check" id="btn-check-3-outlined" autocomplete="off">
            <label class="btn btn-outline-primary dimLeft" for="btn-check-3-outlined"><i class="fa fa-archive"></i> Biblioteca</label>

            <input type="checkbox" class="btn-check" id="btn-check-4-outlined" autocomplete="off">
            <label class="btn btn-outline-danger dimLeft" for="btn-check-4-outlined"><i class="fa fa-book"></i> Libro cartaceo</label>

            <input type="checkbox" class="btn-check" id="btn-check-5-outlined" autocomplete="off">
            <label class="btn btn-outline-success dimLeft" for="btn-check-5-outlined"><i class="far fa-file-pdf"></i> Ebook</label>
        </div>
    </div>

    {{content}}

    <script type="text/javascript" src="views/js/topHomepage.js"></script>
    <script src="views/js/login.js"></script>
    <script src="views/js/sign-in-up.js"></script>

</body>
</html>