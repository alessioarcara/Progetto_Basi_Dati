<?php
include_once('../db_conn/db.php');
include('Log.php');
$log = new Log(); //Creazione oggetto per i log in MongoDB

$pdo = db::getInstance();

$request = [];
foreach ($_POST as $key => $value) {
  $request[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
}

$email = $request['email'];
$password = md5($request['password']);

$sql = 
  "SELECT Authentication(
    '$email',
    '$password'
  )";


try {
  $result = $pdo->query($sql);
  $status = $result->fetch(\PDO::FETCH_ASSOC);
  //file_put_contents('php://stderr', print_r($status, TRUE));
  if ($status['authentication']) {

    // Invio dati a MongoDB
    $log -> writeLog($request['email'], 'Login effettuato con successo!');

    http_response_code(200);
  } else {
    throw new Exception('Invalid email or password');
  }
} catch (Exception $e) {

  // Invio dati a MongoDB
  $log -> writeLog($request['email'], 'Login fallito!');

  http_response_code(400);
  echo 'Er: '.$e->getMessage();
}