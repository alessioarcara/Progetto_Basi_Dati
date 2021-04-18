<?php
include_once('../db_conn/db.php');
$pdo = db::getInstance();

$request = [];
foreach ($_POST as $key => $value) {
  $request[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
};
$codiceLibro = $request['codice'];
$emailAdmin = $_COOKIE['email'];
$sql = "SELECT nomebiblioteca FROM AMMINISTRATORE 
        WHERE emailamministratore='$emailAdmin'";
$result = $pdo->query($sql);
$biblioteca = $result->fetch(\PDO::FETCH_ASSOC)['nomebiblioteca'];

$sql = 
  "SELECT cancellazioneLibroAmministratore(
    '$emailAdmin',
    '$codiceLibro',
    '$biblioteca'
  )";

try {
  $result = $pdo->query($sql);
  $status = $result->fetch(\PDO::FETCH_ASSOC);
  // file_put_contents('php://stderr', print_r($status, TRUE));
  if ($status['cancellazionelibroamministratore']) {
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