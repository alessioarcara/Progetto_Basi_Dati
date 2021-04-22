<?php 

// require_once('./../core/Application.php');
include('../Log/Log.php');
$log = new Log(); //Creazione oggetto per i log in MongoDB

function generateRandomString($length = 10) {
  return substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
};

//connect to db
$host='argonauta.synology.me';
$db = 'unibo';
$username = 'postgres';
$password = 'postgres';
$dsn = "pgsql:host=$host; port=5444; dbname=$db; user=$username; password=$password";
$pdo = new PDO($dsn);

$request = [];
foreach ($_POST as $key => $value) {
  $request[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
};
$codiceConsegna = generateRandomString();
$note = $request['note'];
$data = $request['data'];
$data = str_replace('-', '/', $data);
$tipo = $request['tipo'];
$codicePrenotazione = $request['prenotazione'];
$emailVolontario = $_COOKIE['email'];

$sql = 
  "SELECT inserimentoConsegna(
    '$codiceConsegna',
    '$note',
    '$data',
    '$tipo',
    '$codicePrenotazione',
    '$emailVolontario'
  )";

try {
  $result = $pdo->query($sql);
  $status = $result->fetch(\PDO::FETCH_ASSOC);
  if ($status['inserimentoconsegna']) {

    // Invio dati a MongoDB
    $log -> writeLog($_COOKIE['email'], 'Inserimento consegna effettuato!');

    http_response_code(200);
  } else {
    throw new Exception('Invalid data');
  }
} catch (Exception $e) {

  // Invio dati a MongoDB
  $log -> writeLog($_COOKIE['email'], 'Inserimento consegna fallito!');

  http_response_code(400);
  echo 'Er: '.$e->getMessage();
}
echo true;
?>