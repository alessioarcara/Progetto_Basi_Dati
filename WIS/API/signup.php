<?php
include_once('../db_conn/db.php');
$pdo = db::getInstance();

$request = [];
foreach ($_POST as $key => $value) {
  $request[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
};

$email = $request['email'];
$password = $request['password'];
$nome = $request['nome'];
$cognome = $request['cognome'];
$datadinascita = $request['datadinascita'];
$luogodinascita = $request['luogodinascita'];
$telefono = $request['telefono'];
$professione = $request['professione'];

$sql = 
  "SELECT RegistrazioneUtente(
    '$email',
    '$password',
    '$nome',
    '$cognome',
    '$datadinascita',
    '$luogodinascita',
    '$telefono',
    '$professione'
  )";


try {
  $result = $pdo->query($sql);
  $status = $result->fetch(\PDO::FETCH_ASSOC);
  //file_put_contents('php://stderr', print_r($status, TRUE));
  if ($status['registrazioneutente']) {
    http_response_code(200);
  } else {
    throw new Exception('Invalid email or password');
  }
} catch (Exception $e) {
  http_response_code(400);
  echo 'Er: '.$e->getMessage();
}