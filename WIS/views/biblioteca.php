<?php

foreach ($libraries as $library) {
    $name = $library['nome'];
    // $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name)));
    $via = $library['via'];
    $civico = $library['civico'];
    echo "<a href='biblioteca?n=$name'>$name - $via $civico</a><br/><br/>";
}

?>