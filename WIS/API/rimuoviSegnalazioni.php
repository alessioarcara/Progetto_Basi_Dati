<?php
include_once('../db_conn/db.php');
include('../Log/Log.php');
$log = new Log(); //Creazione oggetto per i log in MongoDB

$pdo = db::getInstance();

$request = [];
foreach ($_POST as $key => $value) {
  $request[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
}

$emailUtilizzatore = $request['email-utente'];
$emailAdmin = $_COOKIE['email'];

$sql = 
  "SELECT rimozioneSegnalazioni(
    '$emailAdmin',
    '$emailUtilizzatore'
  )";

try {
  $result = $pdo->query($sql);
  $status = $result->fetch(\PDO::FETCH_ASSOC);
  // file_put_contents('php://stderr', print_r($status, TRUE));
  if ($status['rimozionesegnalazioni']) {

    // Invio dati a MongoDB
    $log -> writeLog($_COOKIE['email'], 'Rimozione segnalazioni effettuata!');

    http_response_code(200);
  } else {
    throw new Exception('Invalid data');
  }
} catch (Exception $e) {

  // Invio dati a MongoDB
  $log -> writeLog($_COOKIE['email'], 'Rimozione segnalazioni effettuata!');

  http_response_code(400);
  file_put_contents('php://stderr', print_r($e, TRUE));
  echo 'Er: '.$e->getMessage();
}
echo true;
?>