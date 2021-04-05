<?php

// PDO?
// è si un API, ma è accessibile solo se si hanno i requisiti per farlo.
// ovvero Account, Password Utilizzatore.

//connect to db
$host='argonauta.synology.me';
$db = 'unibo';
$username = 'postgres';
$password = 'postgres';
$dsn = "pgsql:host=$host; port=5444; dbname=$db; user=$username; password=$password";
$pdo = new PDO($dsn);

$sql = 'SELECT * FROM getregistrazioni()';

try {
    $results = $pdo->query($sql);
    $registrazioni = $results->fetch(\PDO::FETCH_ASSOC);

    if ($registrazioni['getregistrazioni']) {
        http_response_code(200);
        echo json_encode($registrazioni);
    } else {
        http_response_code(404);
        echo 'nessuna biblioteca trovata';
    }
} catch (Exception $e) {
    http_response_code(400);
    echo 'Er: '.$e->getMessage();
}
?>