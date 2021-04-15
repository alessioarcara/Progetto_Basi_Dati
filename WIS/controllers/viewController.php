<?php
//require_once('./core/Controller.php');
require_once('./core/Application.php');

//Hereditates all methods which are in common between every controllers
class viewController {

  public function home() {

    $sql = 'SELECT * FROM classificaBibliotecaPostiLettura LIMIT 5';

    $results = Application::$pdo->query($sql);
    $classifica = [];
    while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
      $classifica[] = [
        'PercentualeOccupazione' => $row['percentuale_occupazione'],
        'Nome' => $row['nome']
      ];
    };

    $params = [
      'classifica' => $classifica
    ]; 
    
    return Application::$app->router->renderView('home', $params);
  }
}