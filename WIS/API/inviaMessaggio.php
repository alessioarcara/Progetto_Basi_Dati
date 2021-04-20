<?php
include_once('../db_conn/db.php');
include('Log.php');
$log = new Log(); //Creazione oggetto per i log in MongoDB

$pdo = db::getInstance();

function generateRandomString($length = 10) {
  return substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
}

$request = [];
foreach ($_POST as $key => $value) {
  $request[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
};
$codiceMessaggio = generateRandomString();
$emailUtilizzatore = $request['email-utente'];
$titolo = $request['titolo'];
$testo = $request['testo'];
$data = date("Y/m/d");
$emailAdmin = $_COOKIE['email'];

$sql = 
  "SELECT inserimentoMessaggio(
    '$codiceMessaggio',
    '$titolo',
    '$testo',
    '$data',
    '$emailAdmin',
    '$emailUtilizzatore'
  )";

try {
  $result = $pdo->query($sql);
  $status = $result->fetch(\PDO::FETCH_ASSOC);
  // file_put_contents('php://stderr', print_r($status, TRUE));
  if ($status['inserimentomessaggio']) {

    // Invio dati a MongoDB
    $log -> writeLog($_COOKIE['email'], 'Invio messaggio effettuato!');

    http_response_code(200);
  } else {
    throw new Exception('Invalid data');
  }
} catch (Exception $e) {

  // Invio dati a MongoDB
  $log -> writeLog($_COOKIE['email'], 'Invio messaggio fallito!');

  http_response_code(400);
  file_put_contents('php://stderr', print_r($e, TRUE));
  echo 'Er: '.$e->getMessage();
}
echo true;
?>