<?php
require_once('./core/Application.php');

class searchController {

    public function ricerca()
    {
        $parsed_url = parse_url($_SERVER['REQUEST_URI']);
        $category = substr($parsed_url['path'],1);
        $query_parameters = explode('&', substr($parsed_url['query'], 2));

        return $this -> $category($query_parameters);
    }

    private function bibliotecheQuery($sql){
        $results = Application::$pdo->query($sql);
        $libraries = [];
        while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
            if (isset($libraries[$row['nome']])) {
                array_push($libraries[$row['nome']]['numeri'], $row['numero']);
            }
            else {
                $libraries[$row['nome']] =
                    [
                        'nome' => $row['nome'],
                        'via' => $row['via'],
                        'civico' => $row['civico'],
                        'cap' => $row['cap'],
                        'citta' => $row['citta'],
                        'email' => $row['email'],
                        'sitoweb' => $row['sitoweb'],
                        'lat' => $row['lat'],
                        'long' => $row['long'],
                        'notestoriche' => $row['notestoriche'],
                        'numeri' => [$row['numero']]
                    ];
            }
        }
        return $params = ['libraries' => $libraries ];
    }

    private function biblioteche($query_parameters){

        if ($query_parameters[0] === "") {
            $sql = 'SELECT * FROM GetBiblioteche()';
        } else {
            $query = '';
            foreach ($query_parameters as $parameter) {
                $query = $query."'$parameter', ";
            };
            $sql = "SELECT * FROM GetBiblioteche(".substr($query, 0, -2).")";
        }
        $params = $this->bibliotecheQuery($sql);

        if (empty($params['libraries'])){
            Application::$app->response->setStatusCode(404);
            return Application::$app->router->renderContent("404 - Invalid url query!");
        }
            return Application::$app->router->renderView('biblioteca', $params);;
    }

    private function postilettura($query_parameters){
        $sql = 'SELECT * FROM PostiLetturaBiblioteca()';
    }

    private function libricartacei($query_parameters){

    }

    private function ebooks($query_parameters){

    }
}