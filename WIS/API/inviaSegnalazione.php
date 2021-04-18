<?php
include_once('../db_conn/db.php');
$pdo = db::getInstance();

function generateRandomString($length = 10) {
  return substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
}

$request = [];
foreach ($_POST as $key => $value) {
  $request[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
};
$codiceSegnalazione = generateRandomString();
$emailUtilizzatore = $request['email-utente'];
$testo = $request['testo'];
$data = date("Y/m/d");
$emailAdmin = $_COOKIE['email'];

$sql = 
  "SELECT inserimentoSegnalazione(
    '$codiceSegnalazione',
    '$testo',
    '$data',
    '$emailAdmin',
    '$emailUtilizzatore'
  )";

try {
  $result = $pdo->query($sql);
  $status = $result->fetch(\PDO::FETCH_ASSOC);
  // file_put_contents('php://stderr', print_r($status, TRUE));
  if ($status['inserimentosegnalazione']) {
    http_response_code(200);
  } else {
    throw new Exception('Invalid data');
  }
} catch (Exception $e) {
  http_response_code(400);
  file_put_contents('php://stderr', print_r($e, TRUE));
  echo 'Er: '.$e->getMessage();
}
echo true;
?>