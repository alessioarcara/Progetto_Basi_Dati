<?php

// $uri = &$_SERVER['REQUEST_URI'];

// echo $uri;

// // Include router class
// include('Route.php');

// // Add base route (startpage)
// Route::add('/',function(){
//   echo 'index.html';
// });
// Route::add('/test',function(){
//   echo 'index.html'; 
// });

// Route::run('/');



require_once('router.php');

route('/', function() {
  return 'index.html';
});

route('/user', function() {
  echo 'index.html';
});

$action = $_SERVER['REQUEST_URI'];
dispatch($action);
