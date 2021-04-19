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

    $results = Application::$pdo->query($sql);
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
}