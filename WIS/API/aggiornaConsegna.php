<?php
include_once('../db_conn/db.php');
include('../Log/Log.php');
$log = new Log(); //Creazione oggetto per i log in MongoDB

$pdo = db::getInstance();

$request = [];
foreach ($_POST as $key => $value) {
  $request[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
};
$codiceConsegna = $request['consegna'];
$note = $request['note'];
$data = $request['data'];
$data = str_replace('-', '/', $data);
$tipo = $request['tipo'];
$codicePrenotazione = $request['prenotazione'];

$sql = 
  "SELECT aggiornamentoConsegna(
    '$codiceConsegna',
    '$note',
    '$data',
    '$tipo',
    '$codicePrenotazione'
  )";

try {
  $result = $pdo->query($sql);
  $status = $result->fetch(\PDO::FETCH_ASSOC);
  //file_put_contents('php://stderr', print_r($status, TRUE));
  if ($status['aggiornamentoconsegna']) {

    // Invio dati a MongoDB
    $log -> writeLog($_COOKIE['email'], 'Aggiornamento consegna effettuato!');

    http_response_code(200);
  } else {
    throw new Exception('Invalid data');
  }
} catch (Exception $e) {

  // Invio dati a MongoDB
  $log -> writeLog($_COOKIE['email'], 'Aggiornamento consegna fallito!');

  http_response_code(400);
  echo 'Er: '.$e->getMessage();
}
echo true;

?>