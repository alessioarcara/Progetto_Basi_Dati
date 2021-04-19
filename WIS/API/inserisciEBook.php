<?php
include_once('../db_conn/db.php');
$pdo = db::getInstance();

function generateRandomString($length = 10) {
  return substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
};
// convert PHP array to Postgres array
function to_pg_array($set) {
  settype($set, 'array'); // can be called with a scalar or array
  $result = array();
  foreach ($set as $t) {
      if (is_array($t)) {
          $result[] = to_pg_array($t);
      } else {
          $t = str_replace('"', '\\"', $t); // escape double quote
          if (! is_numeric($t)) {// quote only non-numeric values
              $t = '"' . $t . '"';
          }
          $result[] = $t;
      }
  }
  return '{' . implode(",", $result) . '}'; // format
}

$request = [];
foreach ($_POST as $key => $value) {
  $request[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
};

$nomiAutori = to_pg_array(explode(',', $request['nomiAutori']));
$cognomiAutori = to_pg_array(explode(',', $request['cognomiAutori']));


$titolo = $request['titolo'];
$edizione = $request['edizione'];
$anno = $request['anno'];
$genere = $request['genere'];
$emailAdmin = $_COOKIE['email'];
$dimensione = $request['dimensione'];

// In your "php.ini" file, search for the file_uploads directive, and set it to On:
$target_dir = "../Risorse/Pdf/";
$target_file = $target_dir . basename("$titolo.pdf");
move_uploaded_file($_FILES["pdf"]["tmp_name"], $target_file);

$path = "Risorse/Pdf/$titolo.pdf";

$sql = 
  "SELECT inserimentoEBook(
    '$emailAdmin',
    '$titolo',
    '$edizione',
    '$anno',
    '$genere',
    '$dimensione',
    '$path',
    '$nomiAutori',
    '$cognomiAutori'
  )";

try {
  $result = $pdo->query($sql);
  $status = $result->fetch(\PDO::FETCH_ASSOC);
  // file_put_contents('php://stderr', print_r($status, TRUE));
  if ($status['inserimentoebook']) {
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