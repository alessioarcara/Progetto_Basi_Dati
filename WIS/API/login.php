<?php 

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

$email = $request['email'];
$password = $request['password'];

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
    http_response_code(200);
  } else {
    throw new Exception('Invalid email or password');
  }
} catch (Exception $e) {
  http_response_code(400);
  echo 'Er: '.$e->getMessage();
}