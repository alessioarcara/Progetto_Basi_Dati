<?php

class Request {
  public function getPath() {
    //if REQUEST_URI is not defined, it means that path is the same as '/'
    $path = $_SERVER['REQUEST_URI'] ?? '/';
    //search for '?' in the request and save its position, if it's not there it returns false
    $position_questionMark = strpos($path, '?');
    //if there is an '?' we return only the path before it
    if ($position_questionMark === false) {
      return $path;
    }
    return substr($path, 0, $position_questionMark);
  }

  public function getMethod() {
    // return the lowercase of req method
    return strtolower( $_SERVER['REQUEST_METHOD'] );
  }

  public function getBody() {
    $body = [];

    if ($this->getMethod() === 'get') {
      //sanitization datas
      foreach ($_GET as $key => $value) {
        $body[$key] = filter_input(INPUT_GET, $key, FILTER_SANITIZE_SPECIAL_CHARS);
      }
    }
    if ($this->getMethod() === 'post') {
      //sanitization datas
      foreach ($_POST as $key => $value) {
        $body[$key] = filter_input(INPUT_POST, $key, FILTER_SANITIZE_SPECIAL_CHARS);
      }
    }

    return $body;
  }
}