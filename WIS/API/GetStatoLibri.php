<?php
include_once('../db_conn/db.php');
$pdo = db::getInstance();
$sql = 'SELECT * FROM GetStatoLibri();';

try {
    $results = $pdo->query($sql);
    $statolibri = $results->fetch(\PDO::FETCH_ASSOC);

    if ($statolibri['getstatolibri']) {
        http_response_code(200);
        echo json_encode($statolibri);
    } else {
        http_response_code(404);
        echo 'nessun libro trovato';
    }
} catch (Exception $e) {
    http_response_code(400);
    echo 'Er: '.$e->getMessage();
}