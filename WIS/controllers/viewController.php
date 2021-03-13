<?php
//require_once('./core/Controller.php');
require_once('./core/Application.php');

//Hereditates all methods which are in common between every controllers
class viewController {

  public function home () {
    // top classifica delle biblioteche con posti lettura meno utilizzati
    $sql = 'SELECT * FROM classificaBibliotecaPostiLettura LIMIT 5';

    $results = Application::$pdo->query($sql);
    $classifica = [];
    while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
      $classifica[] = [
        'PercentualeOccupazione' => $row['percentuale_occupazione'],
        'Nome' => $row['nome']
      ];
    };

    // classifica degli ebook più acceduti
    $sql = 'SELECT * 
            FROM classificaEbookAcceduti JOIN LIBRO ON (codicee = codicelibro) LIMIT 5';

    $results = Application::$pdo -> query($sql);
    $classificaEbook = [];
    while ($row = $results -> fetch(\PDO::FETCH_ASSOC)) {
      $classificaEbook[] = [
        'CodiceEbook' => $row['codicee'],
        'TitoloEbook' => $row['titolo'],
        'NumAccessi' => $row['accessi']
      ];
    };

    // classifica libri cartacei più prenotati
    $sql = 'SELECT *
            FROM LIBRO JOIN classificaLibriCartacei ON (codicelibro = codicelibrocartaceo) LIMIT 5';

    $results = Application::$pdo -> query($sql);
    $classificaCartacei = [];
    while ($row = $results -> fetch(\PDO::FETCH_ASSOC)) {
      $classificaCartacei[] = [
        'TitoloCartaceo' => $row['titolo'],
        'Edizione' => $row['nomeedizione'],
        'NumeroPrenotazioni' => $row['numprenotazioni']
      ];
    };

    // classifica dei volontari che hanno effettuato più consegne
    $sql = 'SELECT *
            FROM classificaVolontari JOIN UTENTE ON (emailvolontario = emailutente) LIMIT 5';
    
    $results = Application::$pdo -> query($sql);
    $classificaVolontari = [];
    while ($row = $results -> fetch(\PDO::FETCH_ASSOC)) {
      $classificaVolontari[] = [
        'EmailVolontario' => $row['emailvolontario'],
        'NomeVolontario' => $row['nome'],
        'CognomeVolontario' => $row['cognome'],
        'Consegne' => $row['numconsegne']
      ];
    };

    $params = [
      'classifica' => $classifica,
      'classificaEbook' => $classificaEbook,
      'classificaCartacei' => $classificaCartacei,
      'classificaVolontari' => $classificaVolontari
    ];
    
    return Application::$app->router->renderView('home', $params);
  }

  // public function biblioteca() {
  //   $parsed_url = parse_url($_SERVER['REQUEST_URI']);

  //   $parameters = explode('&', $parsed_url['query']);

  //   if ($parameters[0] === "") {

  //     $sql = 'SELECT * FROM BIBLIOTECA';

  //     $results = Application::$pdo->query($sql);
  //     $libraries = [];
  //     while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
  //       $libraries[] = [
  //           'nome' => $row['nome'],
  //           'via' => $row['via'],
  //           'civico' => $row['civico'],
  //           'cap' => $row['cap'],
  //           'citta' => $row['citta'],
  //           'email' => $row['email'],
  //           'sitoweb' => $row['sitoweb'],
  //           'lat' => $row['lat'],
  //           'nome' => $row['nome'],
  //           'notestoriche' => $row['notestoriche']
  //       ];
  //     };

  //     $params = [
  //       'libraries' => $libraries
  //     ];

  //     return Application::$app->router->renderView('home', $params);
  //   }

  //   $params = [];
  //   foreach ($parameters as $parameter) {
  //     [$key, $value] = explode('=', $parameter);
  //     $params[$key] = $value;
  //   };

  //   //se nella query è specificato il nome della biblioteca
  //   //allora si ottengono le informazioni della biblioteca specifica
  //   if ($params['n']) {
  //     //ottieni il nome biblioteca originale dall'url
  //     $nomeBiblioteca = $params['n'];
  //     $nomeBiblioteca = str_replace('%20', ' ', $nomeBiblioteca);
  //     $nomeBiblioteca = str_replace('%22', '"', $nomeBiblioteca);

  //     //se è presente 'section' nella query significa che vogliamo vedere
  //     //o i posti lettura o i libri della biblioteca specifica
  //     if ($params['section']) {

  //       if ($params['section'] === 'libri') {
  //         $sql = "SELECT * FROM LibriBiblioteca( ' ".$nomeBiblioteca. " ')";

  //         $result = Application::$pdo->query($sql);
  //         $books = [];
  //         while ($row = $result->fetch(\PDO::FETCH_ASSOC)) {
  //           $books[] = [
  //             "codice" => $row['codice'],
  //             "titolo" => $row['titololibro'],
  //             "edizione" => $row['edizione'],
  //             "anno" => $row['anno'],
  //             "genere" => $row['generelibro']
  //           ];
  //         };

  //         $params = [
  //           'libraryName' => $nomeBiblioteca,
  //           'books' => $books
  //         ];

  //         return Application::$app->router->renderView('results', $params);

  //       }

  //     }

  //     //se non è presente la 'section' nella query allora
  //     //si restituiscono tutti i valori della specifica biblioteca

  //     $sql = "SELECT * FROM BIBLIOTECA WHERE Nome = '".$nomeBiblioteca."'";

  //     $result = Application::$pdo->query($sql);
  //     $library = [];
  //     while ($row = $result->fetch(\PDO::FETCH_ASSOC)) {
  //       $library = [
  //           'nome' => $row['nome'],
  //           'indirizzo' => $row['indirizzo'],
  //           'email' => $row['email'],
  //           'sitoweb' => $row['sitoweb'],
  //           'lat' => $row['lat'],
  //           'long' => $row['long']
  //       ];
  //     };

  //     $params = [
  //       'library' => $library
  //     ];

  //     return Application::$app->router->renderView('results', $params);
  //   }

  //   Application::$app->response->setStatusCode(404);
  //   return Application::$router->renderContent("404 - Invalid url query!");

  // }

}