<?php
require_once('./Application.php');

class Controller {

  public function render($view, $params = []) {
    // return Application::$app->router->renderView($view, $params);
    return 'Hello';
  }

}